Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70210C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494EF2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbeLSTKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:10:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbeLSTKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:10:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99D2F653C8;
        Wed, 19 Dec 2018 19:10:24 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 687979F77;
        Wed, 19 Dec 2018 19:10:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH] x86/speculation: Don't inherit TIF_SSBD on execve()
Date:   Wed, 19 Dec 2018 14:09:50 -0500
Message-Id: <1545246590-12704-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Dec 2018 19:10:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the default SPEC_STORE_BYPASS_SECCOMP/SPEC_STORE_BYPASS_PRCTL mode,
the TIF_SSBD bit will be inherited when a new task is fork'ed or cloned.

As only certain class of applications (like Java) requires disabling
speculative store bypass for security purpose, it may not make sense to
allow the TIF_SSBD bit to be inherited across execve() boundary where the
new application may not need SSBD at all and is probably not aware that
SSBD may have been turned on. This may cause an unnecessary performance
loss of up to 20% in some cases.

The arch_setup_new_exec() function is updated to clear the TIF_SSBD
bit unless it has been force-disabled.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/userspace-api/spec_ctrl.rst |  3 +++
 arch/x86/kernel/process.c                 | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index c4dbe6f..226aed5 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -55,6 +55,9 @@ is selected by arg2 of :manpage:`prctl(2)` per task. arg3 is used to hand
 in the control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE or
 PR_SPEC_FORCE_DISABLE.
 
+When mitigation is enabled, its state will not be inherited on
+:manpage:`execve(2)` unless it is force-disabled.
+
 Common error codes
 ------------------
 ======= =================================================================
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7d31192..f207f4d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -252,6 +252,16 @@ void arch_setup_new_exec(void)
 	/* If cpuid was previously disabled for this task, re-enable it. */
 	if (test_thread_flag(TIF_NOCPUID))
 		enable_cpuid();
+
+	/*
+	 * Don't inherit TIF_SSBD across exec boundary unless speculative
+	 * store bypass is force-disabled (e.g. seccomp on).
+	 */
+	if (test_thread_flag(TIF_SSBD) &&
+	   !task_spec_ssb_force_disable(current)) {
+		clear_thread_flag(TIF_SSBD);
+		task_clear_spec_ssb_disable(current);
+	}
 }
 
 static inline void switch_to_bitmap(struct thread_struct *prev,
-- 
1.8.3.1

