Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794AEC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3223C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3223C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIKUet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:34:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:34:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8BFYUlE2289498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Sep 2018 08:34:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8BFYT0S2289495;
        Tue, 11 Sep 2018 08:34:29 -0700
Date:   Tue, 11 Sep 2018 08:34:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-3637897b6c9bc2f12f38956d64724a6d0bbb56fd@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        bp@suse.de, bp@alien8.de, jgross@suse.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, jgross@suse.com, bp@alien8.de, bp@suse.de,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180911091510.GA12094@zn.tnic>
References: <20180911091510.GA12094@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Clean up native_patch()
Git-Commit-ID: 3637897b6c9bc2f12f38956d64724a6d0bbb56fd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3637897b6c9bc2f12f38956d64724a6d0bbb56fd
Gitweb:     https://git.kernel.org/tip/3637897b6c9bc2f12f38956d64724a6d0bbb56fd
Author:     Borislav Petkov <bp@alien8.de>
AuthorDate: Tue, 11 Sep 2018 11:15:10 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Sep 2018 12:45:14 +0200

x86/paravirt: Clean up native_patch()

When CONFIG_PARAVIRT_SPINLOCKS=n, it generates a warning:

  arch/x86/kernel/paravirt_patch_64.c: In function ‘native_patch’:
  arch/x86/kernel/paravirt_patch_64.c:89:1: warning: label ‘patch_site’ defined but not used [-Wunused-label]
   patch_site:

... but those labels can simply be removed by directly calling the
respective functions there.

Get rid of local variables too, while at it. Also, simplify function
flow for better readability.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180911091510.GA12094@zn.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/paravirt_patch_32.c | 44 +++++++++++++----------------------
 arch/x86/kernel/paravirt_patch_64.c | 46 ++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index d460cbcabcfe..6368c22fa1fa 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -34,14 +34,10 @@ extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
-	const unsigned char *start, *end;
-	unsigned ret;
-
 #define PATCH_SITE(ops, x)					\
-		case PARAVIRT_PATCH(ops.x):			\
-			start = start_##ops##_##x;		\
-			end = end_##ops##_##x;			\
-			goto patch_site
+	case PARAVIRT_PATCH(ops.x):				\
+		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
+
 	switch (type) {
 #ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, irq_disable);
@@ -54,32 +50,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(mmu, write_cr3);
 #endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-		case PARAVIRT_PATCH(lock.queued_spin_unlock):
-			if (pv_is_native_spin_unlock()) {
-				start = start_lock_queued_spin_unlock;
-				end   = end_lock_queued_spin_unlock;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.queued_spin_unlock):
+		if (pv_is_native_spin_unlock())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_queued_spin_unlock,
+						    end_lock_queued_spin_unlock);
+		break;
 
-		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
-			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_lock_vcpu_is_preempted;
-				end   = end_lock_vcpu_is_preempted;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
+		if (pv_is_native_vcpu_is_preempted())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_vcpu_is_preempted,
+						    end_lock_vcpu_is_preempted);
+		break;
 #endif
 
 	default:
-patch_default: __maybe_unused
-		ret = paravirt_patch_default(type, ibuf, addr, len);
-		break;
-
-patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
 		break;
 	}
 #undef PATCH_SITE
-	return ret;
+	return paravirt_patch_default(type, ibuf, addr, len);
 }
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 5ad5bcda9dc6..7ca9cb726f4d 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -42,15 +42,11 @@ extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
-	const unsigned char *start, *end;
-	unsigned ret;
-
 #define PATCH_SITE(ops, x)					\
-		case PARAVIRT_PATCH(ops.x):			\
-			start = start_##ops##_##x;		\
-			end = end_##ops##_##x;			\
-			goto patch_site
-	switch(type) {
+	case PARAVIRT_PATCH(ops.x):				\
+		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
+
+	switch (type) {
 #ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, restore_fl);
 		PATCH_SITE(irq, save_fl);
@@ -64,32 +60,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(mmu, write_cr3);
 #endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-		case PARAVIRT_PATCH(lock.queued_spin_unlock):
-			if (pv_is_native_spin_unlock()) {
-				start = start_lock_queued_spin_unlock;
-				end   = end_lock_queued_spin_unlock;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.queued_spin_unlock):
+		if (pv_is_native_spin_unlock())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_queued_spin_unlock,
+						    end_lock_queued_spin_unlock);
+		break;
 
-		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
-			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_lock_vcpu_is_preempted;
-				end   = end_lock_vcpu_is_preempted;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
+		if (pv_is_native_vcpu_is_preempted())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_vcpu_is_preempted,
+						    end_lock_vcpu_is_preempted);
+		break;
 #endif
 
 	default:
-patch_default: __maybe_unused
-		ret = paravirt_patch_default(type, ibuf, addr, len);
-		break;
-
-patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
 		break;
 	}
 #undef PATCH_SITE
-	return ret;
+	return paravirt_patch_default(type, ibuf, addr, len);
 }
