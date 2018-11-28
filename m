Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4142081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4142081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeK2Bfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:35:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54071 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2Bfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:35:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEX5bL2324011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:33:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEX5sl2324008;
        Wed, 28 Nov 2018 06:33:05 -0800
Date:   Wed, 28 Nov 2018 06:33:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e6da8bb6f9abb2628381904b24163c770e630bac@git.kernel.org>
Cc:     aarcange@redhat.com, asit.k.mallick@intel.com, luto@kernel.org,
        dwmw@amazon.co.uk, tglx@linutronix.de, david.c.stewart@intel.com,
        peterz@infradead.org, ak@linux.intel.com, dave.hansen@intel.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        hpa@zytor.com, arjan@linux.intel.com, longman9394@gmail.com,
        jpoimboe@redhat.com, mingo@kernel.org, jcm@redhat.com,
        gregkh@linuxfoundation.org, tim.c.chen@linux.intel.com,
        jkosina@suse.cz, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org, casey.schaufler@intel.com
Reply-To: jpoimboe@redhat.com, mingo@kernel.org, longman9394@gmail.com,
          tim.c.chen@linux.intel.com, jkosina@suse.cz, jcm@redhat.com,
          gregkh@linuxfoundation.org, casey.schaufler@intel.com,
          thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, hpa@zytor.com,
          torvalds@linux-foundation.org, keescook@chromium.org,
          arjan@linux.intel.com, ak@linux.intel.com, aarcange@redhat.com,
          dwmw@amazon.co.uk, luto@kernel.org, asit.k.mallick@intel.com,
          tglx@linutronix.de, peterz@infradead.org,
          david.c.stewart@intel.com
In-Reply-To: <20181125185005.652305076@linutronix.de>
References: <20181125185005.652305076@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Split out TIF update
Git-Commit-ID: e6da8bb6f9abb2628381904b24163c770e630bac
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

Commit-ID:  e6da8bb6f9abb2628381904b24163c770e630bac
Gitweb:     https://git.kernel.org/tip/e6da8bb6f9abb2628381904b24163c770e630bac
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:51 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:12 +0100

x86/speculation: Split out TIF update

The update of the TIF_SSBD flag and the conditional speculation control MSR
update is done in the ssb_prctl_set() function directly. The upcoming prctl
support for controlling indirect branch speculation via STIBP needs the
same mechanism.

Split the code out and make it reusable. Reword the comment about updates
for other tasks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185005.652305076@linutronix.de

---
 arch/x86/kernel/cpu/bugs.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7c946a9af947..3b65a53d2c33 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -702,10 +702,29 @@ static void ssb_select_mitigation(void)
 #undef pr_fmt
 #define pr_fmt(fmt)     "Speculation prctl: " fmt
 
-static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
+static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
 {
 	bool update;
 
+	if (on)
+		update = !test_and_set_tsk_thread_flag(tsk, tifbit);
+	else
+		update = test_and_clear_tsk_thread_flag(tsk, tifbit);
+
+	/*
+	 * Immediately update the speculation control MSRs for the current
+	 * task, but for a non-current task delay setting the CPU
+	 * mitigation until it is scheduled next.
+	 *
+	 * This can only happen for SECCOMP mitigation. For PRCTL it's
+	 * always the current task.
+	 */
+	if (tsk == current && update)
+		speculation_ctrl_update_current();
+}
+
+static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
 	    ssb_mode != SPEC_STORE_BYPASS_SECCOMP)
 		return -ENXIO;
@@ -716,28 +735,20 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (task_spec_ssb_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ssb_disable(task);
-		update = test_and_clear_tsk_thread_flag(task, TIF_SSBD);
+		task_update_spec_tif(task, TIF_SSBD, false);
 		break;
 	case PR_SPEC_DISABLE:
 		task_set_spec_ssb_disable(task);
-		update = !test_and_set_tsk_thread_flag(task, TIF_SSBD);
+		task_update_spec_tif(task, TIF_SSBD, true);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
 		task_set_spec_ssb_disable(task);
 		task_set_spec_ssb_force_disable(task);
-		update = !test_and_set_tsk_thread_flag(task, TIF_SSBD);
+		task_update_spec_tif(task, TIF_SSBD, true);
 		break;
 	default:
 		return -ERANGE;
 	}
-
-	/*
-	 * If being set on non-current task, delay setting the CPU
-	 * mitigation until it is next scheduled.
-	 */
-	if (task == current && update)
-		speculation_ctrl_update_current();
-
 	return 0;
 }
 
