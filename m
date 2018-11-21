Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35692C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068A5223C6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068A5223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389436AbeKVGyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45369 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389399AbeKVGyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:14 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYx6-0000JR-So; Wed, 21 Nov 2018 21:18:25 +0100
Message-Id: <20181121201724.227260385@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:50 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 20/24] x86/speculation: Split out TIF update
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation--Split-out-TIF-update.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update of the TIF_SSBD flag and the conditional speculation control MSR
update is done in the ssb_prctl_set() function directly. The upcoming prctl
support for controlling indirect branch speculation via STIBP needs the
same mechanism.

Split the code out and make it reusable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/bugs.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -703,10 +703,25 @@ static void ssb_select_mitigation(void)
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
+	 * If being set on non-current task, delay setting the CPU
+	 * mitigation until it is scheduled next.
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
@@ -717,28 +732,20 @@ static int ssb_prctl_set(struct task_str
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
 


