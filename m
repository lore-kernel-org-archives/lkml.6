Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F104C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CA220817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Npohg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CA220817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeKLJAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390181AbeKLIWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:00 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7484208A3;
        Sun, 11 Nov 2018 22:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975523;
        bh=0GkAcPLrrrbnbcSHzs/LtyUHMzoYQuwbPvxpveqQr0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9Npohg07fToaMbA+6dbekZzbnXWHqQ0ikenbqoLwzc4iBGiJFMds3tDYCH1y3GOQ
         BLXkg7dwI31V7Lerp9XrxHW7DyhVDrwzYHXwkjKWRpR5hjV7uKkuxPzKLwG7rlhAPK
         3CkFfxMDNuiXrJ6UoV7kv6nWNuKAwt6hjj+DR55c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "WoodhouseDavid" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "SchauflerCasey" <casey.schaufler@intel.com>
Subject: [PATCH 4.14 019/222] x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation
Date:   Sun, 11 Nov 2018 14:21:56 -0800
Message-Id: <20181111221649.847240700@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit 53c613fe6349994f023245519265999eed75957f upstream.

STIBP is a feature provided by certain Intel ucodes / CPUs. This feature
(once enabled) prevents cross-hyperthread control of decisions made by
indirect branch predictors.

Enable this feature if

- the CPU is vulnerable to spectre v2
- the CPU supports SMT and has SMT siblings online
- spectre_v2 mitigation autoselection is enabled (default)

After some previous discussion, this leaves STIBP on all the time, as wrmsr
on crossing kernel boundary is a no-no. This could perhaps later be a bit
more optimized (like disabling it in NOHZ, experiment with disabling it in
idle, etc) if needed.

Note that the synchronization of the mask manipulation via newly added
spec_ctrl_mutex is currently not strictly needed, as the only updater is
already being serialized by cpu_add_remove_lock, but let's make this a
little bit more future-proof.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc:  "WoodhouseDavid" <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc:  "SchauflerCasey" <casey.schaufler@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1809251438240.15880@cbobk.fhfr.pm
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |   57 ++++++++++++++++++++++++++++++++++++++++-----
 kernel/cpu.c               |   11 +++++++-
 2 files changed, 61 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -34,12 +34,10 @@ static void __init spectre_v2_select_mit
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 
-/*
- * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
- * writes to SPEC_CTRL contain whatever reserved bits have been set.
- */
-u64 __ro_after_init x86_spec_ctrl_base;
+/* The base value of the SPEC_CTRL MSR that always has to be preserved. */
+u64 x86_spec_ctrl_base;
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
+static DEFINE_MUTEX(spec_ctrl_mutex);
 
 /*
  * The vendor and possibly platform specific bits which can be modified in
@@ -322,6 +320,46 @@ static enum spectre_v2_mitigation_cmd __
 	return cmd;
 }
 
+static bool stibp_needed(void)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_NONE)
+		return false;
+
+	if (!boot_cpu_has(X86_FEATURE_STIBP))
+		return false;
+
+	return true;
+}
+
+static void update_stibp_msr(void *info)
+{
+	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+}
+
+void arch_smt_update(void)
+{
+	u64 mask;
+
+	if (!stibp_needed())
+		return;
+
+	mutex_lock(&spec_ctrl_mutex);
+	mask = x86_spec_ctrl_base;
+	if (cpu_smt_control == CPU_SMT_ENABLED)
+		mask |= SPEC_CTRL_STIBP;
+	else
+		mask &= ~SPEC_CTRL_STIBP;
+
+	if (mask != x86_spec_ctrl_base) {
+		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
+				cpu_smt_control == CPU_SMT_ENABLED ?
+				"Enabling" : "Disabling");
+		x86_spec_ctrl_base = mask;
+		on_each_cpu(update_stibp_msr, NULL, 1);
+	}
+	mutex_unlock(&spec_ctrl_mutex);
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -406,6 +444,9 @@ retpoline_auto:
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
+
+	/* Enable STIBP if appropriate */
+	arch_smt_update();
 }
 
 #undef pr_fmt
@@ -798,6 +839,8 @@ static ssize_t l1tf_show_state(char *buf
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
+	int ret;
+
 	if (!boot_cpu_has_bug(bug))
 		return sprintf(buf, "Not affected\n");
 
@@ -812,10 +855,12 @@ static ssize_t cpu_show_common(struct de
 		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 
 	case X86_BUG_SPECTRE_V2:
-		return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		ret = sprintf(buf, "%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
 			       spectre_v2_module_string());
+		return ret;
 
 	case X86_BUG_SPEC_STORE_BYPASS:
 		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2045,6 +2045,12 @@ static void cpuhp_online_cpu_device(unsi
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
 
+/*
+ * Architectures that need SMT-specific errata handling during SMT hotplug
+ * should override this.
+ */
+void __weak arch_smt_update(void) { };
+
 static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
 	int cpu, ret = 0;
@@ -2071,8 +2077,10 @@ static int cpuhp_smt_disable(enum cpuhp_
 		 */
 		cpuhp_offline_cpu_device(cpu);
 	}
-	if (!ret)
+	if (!ret) {
 		cpu_smt_control = ctrlval;
+		arch_smt_update();
+	}
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2083,6 +2091,7 @@ static int cpuhp_smt_enable(void)
 
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
+	arch_smt_update();
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))


