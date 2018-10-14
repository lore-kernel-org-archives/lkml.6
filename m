Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F2C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DB320835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DB320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeJNXQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:16:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36600 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbeJNXQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:16:13 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMC-0004cd-26; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000EF-K8; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "PrasannaKumar Muralidharan" <prasannatsmkumar@gmail.com>,
        "Davidlohr Bueso" <dbueso@suse.de>,
        "Philip Semanchuk" <linux_kernel.20.ick@spamgourmet.com>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        "Manfred Spraul" <manfred@colorfullife.com>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.146842026@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 070/366] ipc/sem: make semctl setting sempid consistent
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit a5f4db877177d2a3d7ae62a7bac3a5a27e083d7f upstream.

As indicated by bug#112271, Linux sets the sempid value upon semctl, and
not only for semop calls.  However, within semctl we only do this for
SETVAL, leaving SETALL without updating the field, and therefore rather
inconsistent behavior when compared to other Unices.

There is really no documentation regarding this and therefore users
should not make assumptions.  With this patch, along with updating
semctl.2 manpages, this scenario should become less ambiguous As such,
set sempid on SETALL cmd.

Also update some in-code documentation, specifying where the sempid is
set.

Passes ltp and custom testcase where a child (fork) does SETALL to the
set.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Philip Semanchuk <linux_kernel.20.ick@spamgourmet.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Herton R. Krzesinski <herton@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 ipc/sem.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -92,7 +92,14 @@
 /* One semaphore structure for each semaphore in the system. */
 struct sem {
 	int	semval;		/* current value */
-	int	sempid;		/* pid of last operation */
+	/*
+	 * PID of the process that last modified the semaphore. For
+	 * Linux, specifically these are:
+	 *  - semop
+	 *  - semctl, via SETVAL and SETALL.
+	 *  - at task exit when performing undo adjustments (see exit_sem).
+	 */
+	int	sempid;
 	spinlock_t	lock;	/* spinlock for fine-grained semtimedop */
 	struct list_head pending_alter; /* pending single-sop operations */
 					/* that alter the semaphore */
@@ -1469,8 +1476,10 @@ static int semctl_main(struct ipc_namesp
 			goto out_unlock;
 		}
 
-		for (i = 0; i < nsems; i++)
+		for (i = 0; i < nsems; i++) {
 			sma->sem_base[i].semval = sem_io[i];
+			sma->sem_base[i].sempid = task_tgid_vnr(current);
+		}
 
 		ipc_assert_locked_object(&sma->sem_perm);
 		list_for_each_entry(un, &sma->list_id, list_id) {

