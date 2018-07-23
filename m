Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754A1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABF020685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABF020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbeGWNsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389783AbeGWNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:35 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D53EC19;
        Mon, 23 Jul 2018 12:47:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 069/107] proc: Provide details on speculation flaw mitigations
Date:   Mon, 23 Jul 2018 14:42:03 +0200
Message-Id: <20180723122416.842361818@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit fae1fa0fc6cca8beee3ab8ed71d54f9a78fa3f64 upstream

As done with seccomp and no_new_privs, also show speculation flaw
mitigation state in /proc/$pid/status.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 fs/proc/array.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -79,6 +79,7 @@
 #include <linux/delayacct.h>
 #include <linux/seq_file.h>
 #include <linux/pid_namespace.h>
+#include <linux/prctl.h>
 #include <linux/ptrace.h>
 #include <linux/tracehook.h>
 #include <linux/string_helpers.h>
@@ -332,6 +333,28 @@ static inline void task_seccomp(struct s
 #ifdef CONFIG_SECCOMP
 	seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);
 #endif
+	seq_printf(m, "\nSpeculation Store Bypass:\t");
+	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
+	case -EINVAL:
+		seq_printf(m, "unknown");
+		break;
+	case PR_SPEC_NOT_AFFECTED:
+		seq_printf(m, "not vulnerable");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
+		seq_printf(m, "thread mitigated");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_ENABLE:
+		seq_printf(m, "thread vulnerable");
+		break;
+	case PR_SPEC_DISABLE:
+		seq_printf(m, "globally mitigated");
+		break;
+	default:
+		seq_printf(m, "vulnerable");
+		break;
+	}
+	seq_putc(m, '\n');
 }
 
 static inline void task_context_switch_counts(struct seq_file *m,


