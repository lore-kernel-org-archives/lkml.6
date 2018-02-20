Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x225B5IPN4/B/qjsVb1Zp23MFier5wZLRvo1/uLuBMTXbXybCiwHhgQDFjhKczbhCQttSiNmD
ARC-Seal: i=1; a=rsa-sha256; t=1519093501; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWzfMLWQ5Yr+TrFK1zHffq2WDrkFwcgbw8odadSD1qbc7VscGsHXPeyQi9AlFL61s9
         mGDPcrXuFTA8drp7cKUtlWYfYxi2PjMjnsYKya20xxT47XyFcdTZd0kdb3qlyVTLNqM4
         umoqrkrUUKn5sx2eNsbpvrTAczt1D8U+ScC5IGNXCGfprkJopudr69stI4nnD/kv7Dd/
         KULTzIyVzEQurchJj/OxPqzb4xyjH3hrCA18Gw5WBOeox8eL83OhFlVisb45PZE5JW2c
         UJSdmbuDzo4ZxHy1dwmOXay1Nr80+NuNB2s1nnA1Pg5HKRqXX2LIZ45R6MIJj4me9aFQ
         x9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=WJxS11a2Bv+/8KH0aFeMyylCPmoBIqeF8HiGDx+pViE=;
        b=B1TV6IWNn2t6l4G52+g+LzkFTUM2s1K1n6OC+cHlHeHwSWTvCwJtbU+1/ELgoqd/WC
         yJvaJN/hCwfN8QYtTVyr9f/xEKLRxYGl8sXITCZdaLXNArg00KkFRf3isxBWLnLR8bMl
         OBhLRwq1IJnxU7lrGUo4+AQytxjTuAryeeFUbcaQNhtRrVS4iPJpjRu/rT0UmtuBGHHP
         armDaibaVfi3gZSkwHWEJiB54wOAZwnLcIjFv7Tsh4odHdlsmp5MLq1SBVskuCymk7sT
         DhUWarZPe/oMGgoYQK79rWXNQ161162gXX5EJK89L0CzlNk6DLa2xj5yGmTd5/pgufnL
         WUIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:37 +1100
Subject: [PATCH 06/21] staging: lustre: simplify linux-prim.c
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341773.25814.3960998744576050714.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592884987828999966?=
X-GMAIL-MSGID: =?utf-8?q?1592884987828999966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cfs_block_sigs() is never used.
cfs_clear_sigpending() is never used.
cfs_block_allsigs() is no longer used.

So those three functions can go.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    3 -
 .../staging/lustre/lnet/libcfs/linux/linux-prim.c  |   41 --------------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index ca3472cc952f..7f06b0118154 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -67,11 +67,8 @@
 /*
  * Defined by platform
  */
-sigset_t cfs_block_allsigs(void);
-sigset_t cfs_block_sigs(unsigned long sigs);
 sigset_t cfs_block_sigsinv(unsigned long sigs);
 void cfs_restore_sigs(sigset_t sigset);
-void cfs_clear_sigpending(void);
 
 struct libcfs_ioctl_handler {
 	struct list_head item;
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c
index 6f92ea272186..6b73b9845e3f 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c
@@ -43,36 +43,6 @@
 #include <linux/kgdb.h>
 #endif
 
-sigset_t
-cfs_block_allsigs(void)
-{
-	unsigned long flags;
-	sigset_t old;
-
-	spin_lock_irqsave(&current->sighand->siglock, flags);
-	old = current->blocked;
-	sigfillset(&current->blocked);
-	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
-
-	return old;
-}
-EXPORT_SYMBOL(cfs_block_allsigs);
-
-sigset_t cfs_block_sigs(unsigned long sigs)
-{
-	unsigned long flags;
-	sigset_t old;
-
-	spin_lock_irqsave(&current->sighand->siglock, flags);
-	old = current->blocked;
-	sigaddsetmask(&current->blocked, sigs);
-	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
-	return old;
-}
-EXPORT_SYMBOL(cfs_block_sigs);
-
 /* Block all signals except for the @sigs */
 sigset_t cfs_block_sigsinv(unsigned long sigs)
 {
@@ -100,14 +70,3 @@ cfs_restore_sigs(sigset_t old)
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 }
 EXPORT_SYMBOL(cfs_restore_sigs);
-
-void
-cfs_clear_sigpending(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&current->sighand->siglock, flags);
-	clear_tsk_thread_flag(current, TIF_SIGPENDING);
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
-}
-EXPORT_SYMBOL(cfs_clear_sigpending);
