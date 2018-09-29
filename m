Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813EEC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B8720880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B8720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeI3EcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:32:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51538 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbeI3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000HA-Qf; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006qI-LG; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Kees Cook" <keescook@chromium.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.451981028@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 018/131] proc: Provide details on speculation flaw
 mitigations
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit fae1fa0fc6cca8beee3ab8ed71d54f9a78fa3f64 upstream.

As done with seccomp and no_new_privs, also show speculation flaw
mitigation state in /proc/$pid/status.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/proc/array.c | 23 +++++++++++++++++++++++
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
 #include <linux/user_namespace.h>
@@ -326,6 +327,28 @@ static inline void task_seccomp(struct s
 #ifdef CONFIG_SECCOMP
 	seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);
 #endif
+	seq_printf(m, "Speculation Store Bypass:\t");
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

