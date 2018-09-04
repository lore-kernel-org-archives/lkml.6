Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF41C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1678E2086E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1678E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIDTIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:08:32 -0400
Received: from twin.jikos.cz ([91.219.245.39]:36349 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeIDTIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:08:31 -0400
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id w84Egfbk029283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 4 Sep 2018 16:42:42 +0200
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id w84EgfeX029098;
        Tue, 4 Sep 2018 16:42:41 +0200
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Tue, 4 Sep 2018 16:42:41 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 3/3] x86/speculation: Enable cross-hyperthread spectre v2
 STIBP mitigation
In-Reply-To: <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
Message-ID: <alpine.LRH.2.00.1809041642070.14475@gjva.wvxbf.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

STIBP is a feature provided by certain Intel ucodes / CPUs. This feature 
(once enabled) prevents cross-hyperthread control of decisions made by 
indirect branch predictors.

Enable this feature if

- the CPU is vulnerable to spectre v2
- the CPU supports SMT and has SMT siblings online
- spectre_v2 mitigation autoselection is enabled (default)

After some previous discussion, this patch leaves STIBP on all the time, 
as wrmsr on crossing kernel boundary is a no-no. This could perhaps later 
be a bit more optimized (like disabling it in NOHZ, experiment with 
disabling it in idle, etc) if needed.

Note: the code could be made less awkward if it'd be guaranteed that STIBP 
could be kept on on a primary thread with SMT sibling being offline, 
without potentially imposing performance penalty. This doesn't seem to be 
defined anywhere though, so let's better be safe then sorry and always 
flip STIBP both on primary and sibling threads on hotplug transitions.

Cc: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Sorry for the resend, my pine is buggered and broke threading.

 arch/x86/kernel/cpu/bugs.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/cpu.c               | 13 +++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 40bdaea97fe7..ba3df0a49a2e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -325,6 +325,56 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	return cmd;
 }
 
+static bool stibp_needed(void)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_NONE)
+		return false;
+
+	if (cpu_smt_control != CPU_SMT_ENABLED)
+		return false;
+
+	if (!boot_cpu_has(X86_FEATURE_STIBP))
+		return false;
+
+	return true;
+}
+
+/*
+ * The read-modify-write of the MSR doesn't need any race protection here,
+ * as we're running in atomic context.
+ */
+static void enable_stibp(void *info)
+{
+	u64 mask;
+	rdmsrl(MSR_IA32_SPEC_CTRL, mask);
+	mask |= SPEC_CTRL_STIBP;
+	wrmsrl(MSR_IA32_SPEC_CTRL, mask);
+}
+
+static void disable_stibp(void *info)
+{
+	u64 mask;
+	rdmsrl(MSR_IA32_SPEC_CTRL, mask);
+	mask &= ~SPEC_CTRL_STIBP;
+	wrmsrl(MSR_IA32_SPEC_CTRL, mask);
+}
+
+void arch_smt_enable_errata(void)
+{
+	if (stibp_needed()) {
+		pr_info("Spectre v2 cross-process SMT mitigation: Enabling STIBP\n");
+		on_each_cpu(enable_stibp, NULL, 1);
+	}
+}
+
+void arch_smt_disable_errata(void)
+{
+	if (stibp_needed()) {
+		pr_info("Spectre v2 cross-process SMT mitigation: Disabling STIBP\n");
+		on_each_cpu(disable_stibp, NULL, 1);
+	}
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -424,6 +474,9 @@ static void __init spectre_v2_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
+
+	/* Enable STIBP on BP if needed */
+	arch_smt_enable_errata();
 }
 
 #undef pr_fmt
@@ -655,6 +708,16 @@ void x86_spec_ctrl_setup_ap(void)
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
 		x86_amd_ssb_disable();
+
+	/*
+	 * If we are here during system bootup, enable STIBP.
+	 *
+	 * If we are here because of SMT hotplug, STIBP will be enabled by the
+	 * SMT control code (enabling here would not be sufficient, as it
+	 * needs to happen on primary threads as well).
+	 */
+	if (stibp_needed() && system_state < SYSTEM_RUNNING)
+		enable_stibp(NULL);
 }
 
 #undef pr_fmt
diff --git a/kernel/cpu.c b/kernel/cpu.c
index aa7fe85ad62e..d3613d546829 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2025,17 +2025,27 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
 
+/*
+ * Architectures that need SMT-specific errata handling during SMT hotplug
+ * should override these.
+ */
+void __weak arch_smt_enable_errata(void) { };
+void __weak arch_smt_disable_errata(void) { };
+
 static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	arch_smt_disable_errata();
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
 		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
-		if (ret)
+		if (ret) {
+			arch_smt_enable_errata();
 			break;
+		}
 		/*
 		 * As this needs to hold the cpu maps lock it's impossible
 		 * to call device_offline() because that ends up calling
@@ -2073,6 +2083,7 @@ static int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	arch_smt_enable_errata();
 	cpu_maps_update_done();
 	return ret;
 }

-- 
Jiri Kosina
SUSE Labs
