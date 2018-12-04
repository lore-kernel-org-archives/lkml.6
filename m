Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD7EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AEA214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3IJsRgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AEA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeLDK5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeLDK5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D82214DB;
        Tue,  4 Dec 2018 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921034;
        bh=geR1AF6GiEwi8hVn0yZTcuDcHhlQJEi0LT6ZmNYDxKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3IJsRghcqPDmcnRDKUu0oUrxPksBMD4SFQ7jUjYqcH1oo80TYmcp2czftUCoZZ+C
         GO2ZoPePu3+amVo5GTyzs6xta9OKuUk65scO9Pig7+ht4gZQJ5Xh1BxuCOBHziW7FH
         zQ2efqaBonnsn3A22V4Pu7Obn/eMdHNLJQW7p1Xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.19 055/139] x86/speculation: Split out TIF update
Date:   Tue,  4 Dec 2018 11:48:56 +0100
Message-Id: <20181204103652.238238402@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit e6da8bb6f9abb2628381904b24163c770e630bac upstream

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -700,10 +700,29 @@ static void ssb_select_mitigation(void)
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
@@ -714,28 +733,20 @@ static int ssb_prctl_set(struct task_str
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
 


