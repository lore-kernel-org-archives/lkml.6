Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DEC20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DEC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405502AbeHATH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:07:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404995AbeHATH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:07:29 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E1FBCC2;
        Wed,  1 Aug 2018 17:20:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jeff Layton <jlayton@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 179/246] fasync: Fix deadlock between task-context and interrupt-context kill_fasync()
Date:   Wed,  1 Aug 2018 18:51:29 +0200
Message-Id: <20180801165020.297656999@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit 7a107c0f55a3b4c6f84a4323df5610360bde1684 ]

I observed the following deadlock between them:

[task 1]                          [task 2]                         [task 3]
kill_fasync()                     mm_update_next_owner()           copy_process()
 spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
  send_sigio()                    <IRQ>                             ...
   read_lock(&fown->lock)         kill_fasync()                     ...
    read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...

Task 1 can't acquire read locked tasklist_lock, since there is
already task 3 expressed its wish to take the lock exclusive.
Task 2 holds the read locked lock, but it can't take the spin lock.

Also, there is possible another deadlock (which I haven't observed):

[task 1]                            [task 2]
f_getown()                          kill_fasync()
 read_lock(&f_own->lock)             spin_lock_irqsave(&fa->fa_lock,)
 <IRQ>                               send_sigio()                     write_lock_irq(&f_own->lock)
  kill_fasync()                       read_lock(&fown->lock)
   spin_lock_irqsave(&fa->fa_lock,)

Actually, we do not need exclusive fa->fa_lock in kill_fasync_rcu(),
as it guarantees fa->fa_file->f_owner integrity only. It may seem,
that it used to give a task a small possibility to receive two sequential
signals, if there are two parallel kill_fasync() callers, and task
handles the first signal fastly, but the behaviour won't become
different, since there is exclusive sighand lock in do_send_sig_info().

The patch converts fa_lock into rwlock_t, and this fixes two above
deadlocks, as rwlock is allowed to be taken from interrupt handler
by qrwlock design.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fcntl.c         |   15 +++++++--------
 include/linux/fs.h |    2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -864,9 +864,9 @@ int fasync_remove_entry(struct file *fil
 		if (fa->fa_file != filp)
 			continue;
 
-		spin_lock_irq(&fa->fa_lock);
+		write_lock_irq(&fa->fa_lock);
 		fa->fa_file = NULL;
-		spin_unlock_irq(&fa->fa_lock);
+		write_unlock_irq(&fa->fa_lock);
 
 		*fp = fa->fa_next;
 		call_rcu(&fa->fa_rcu, fasync_free_rcu);
@@ -911,13 +911,13 @@ struct fasync_struct *fasync_insert_entr
 		if (fa->fa_file != filp)
 			continue;
 
-		spin_lock_irq(&fa->fa_lock);
+		write_lock_irq(&fa->fa_lock);
 		fa->fa_fd = fd;
-		spin_unlock_irq(&fa->fa_lock);
+		write_unlock_irq(&fa->fa_lock);
 		goto out;
 	}
 
-	spin_lock_init(&new->fa_lock);
+	rwlock_init(&new->fa_lock);
 	new->magic = FASYNC_MAGIC;
 	new->fa_file = filp;
 	new->fa_fd = fd;
@@ -980,14 +980,13 @@ static void kill_fasync_rcu(struct fasyn
 {
 	while (fa) {
 		struct fown_struct *fown;
-		unsigned long flags;
 
 		if (fa->magic != FASYNC_MAGIC) {
 			printk(KERN_ERR "kill_fasync: bad magic number in "
 			       "fasync_struct!\n");
 			return;
 		}
-		spin_lock_irqsave(&fa->fa_lock, flags);
+		read_lock(&fa->fa_lock);
 		if (fa->fa_file) {
 			fown = &fa->fa_file->f_owner;
 			/* Don't send SIGURG to processes which have not set a
@@ -996,7 +995,7 @@ static void kill_fasync_rcu(struct fasyn
 			if (!(sig == SIGURG && fown->signum == 0))
 				send_sigio(fown, fa->fa_fd, band);
 		}
-		spin_unlock_irqrestore(&fa->fa_lock, flags);
+		read_unlock(&fa->fa_lock);
 		fa = rcu_dereference(fa->fa_next);
 	}
 }
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1245,7 +1245,7 @@ static inline int locks_lock_file_wait(s
 }
 
 struct fasync_struct {
-	spinlock_t		fa_lock;
+	rwlock_t		fa_lock;
 	int			magic;
 	int			fa_fd;
 	struct fasync_struct	*fa_next; /* singly linked list */


