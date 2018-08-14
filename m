Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D3C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3C621728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3C621728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeHNUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbeHNUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:38 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F12ABCEA;
        Tue, 14 Aug 2018 17:26:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.18 53/79] cpu/hotplug: Expose SMT control init function
Date:   Tue, 14 Aug 2018 19:17:12 +0200
Message-Id: <20180814171339.797141844@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

The L1TF mitigation will gain a commend line parameter which allows to set
a combination of hypervisor mitigation and SMT control.

Expose cpu_smt_disable() so the command line parser can tweak SMT settings.

[ tglx: Split out of larger patch and made it preserve an already existing
  	force off state ]

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142323.039715135@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cpu.h |    2 ++
 kernel/cpu.c        |   16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -177,8 +177,10 @@ enum cpuhp_smt_control {
 
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 extern enum cpuhp_smt_control cpu_smt_control;
+extern void cpu_smt_disable(bool force);
 #else
 # define cpu_smt_control		(CPU_SMT_ENABLED)
+static inline void cpu_smt_disable(bool force) { }
 #endif
 
 #endif /* _LINUX_CPU_H_ */
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -347,13 +347,23 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
 
-static int __init smt_cmdline_disable(char *str)
+void __init cpu_smt_disable(bool force)
 {
-	cpu_smt_control = CPU_SMT_DISABLED;
-	if (str && !strcmp(str, "force")) {
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
+		cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return;
+
+	if (force) {
 		pr_info("SMT: Force disabled\n");
 		cpu_smt_control = CPU_SMT_FORCE_DISABLED;
+	} else {
+		cpu_smt_control = CPU_SMT_DISABLED;
 	}
+}
+
+static int __init smt_cmdline_disable(char *str)
+{
+	cpu_smt_disable(str && !strcmp(str, "force"));
 	return 0;
 }
 early_param("nosmt", smt_cmdline_disable);


