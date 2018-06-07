Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wuO9JElHGVvFPAAAmS7hNA
	; Thu, 07 Jun 2018 14:55:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6DDDF607E7; Thu,  7 Jun 2018 14:55:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EDC0E601C3;
	Thu,  7 Jun 2018 14:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDC0E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964796AbeFGOzZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:55:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41049 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935431AbeFGOzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:55:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005Zi-AJ; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00037F-JO; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.767618631@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 280/410] lock_parent() needs to recheck if dentry got
 __dentry_kill'ed under it
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 3b821409632ab778d46e807516b457dfa72736ed upstream.

In case when dentry passed to lock_parent() is protected from freeing only
by the fact that it's on a shrink list and trylock of parent fails, we
could get hit by __dentry_kill() (and subsequent dentry_kill(parent))
between unlocking dentry and locking presumed parent.  We need to recheck
that dentry is alive once we lock both it and parent *and* postpone
rcu_read_unlock() until after that point.  Otherwise we could return
a pointer to struct dentry that already is rcu-scheduled for freeing, with
->d_lock held on it; caller's subsequent attempt to unlock it can end
up with memory corruption.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/dcache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -590,11 +590,16 @@ again:
 		spin_unlock(&parent->d_lock);
 		goto again;
 	}
-	rcu_read_unlock();
-	if (parent != dentry)
+	if (parent != dentry) {
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	else
+		if (unlikely(dentry->d_lockref.count < 0)) {
+			spin_unlock(&parent->d_lock);
+			parent = NULL;
+		}
+	} else {
 		parent = NULL;
+	}
+	rcu_read_unlock();
 	return parent;
 }
 
