Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C0C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48334206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48334206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeI3ESW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51551 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbeI3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000Gy-F3; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006pJ-A4; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.443344729@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 006/131] x86/bugs: Expose /sys/../spec_store_bypass
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit c456442cd3a59eeb1d60293c26cbe2ff2c4e42cf upstream.

Add the sysfs file for the new vulerability. It does not do much except
show the words 'Vulnerable' for recent x86 cores.

Intel cores prior to family 6 are known not to be vulnerable, and so are
some Atoms and some Xeon Phi.

It assumes that older Cyrix, Centaur, etc. cores are immune.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - Renumber X86_BUG_SPEC_STORE_BYPASS
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  1 +
 arch/x86/include/asm/cpufeature.h             |  1 +
 arch/x86/kernel/cpu/bugs.c                    |  5 ++++
 arch/x86/kernel/cpu/common.c                  | 23 +++++++++++++++++++
 drivers/base/cpu.c                            |  8 +++++++
 include/linux/cpu.h                           |  2 ++
 6 files changed, 40 insertions(+)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -229,6 +229,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
+		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -260,6 +260,7 @@
 #define X86_BUG_CPU_MELTDOWN	X86_BUG(5) /* CPU is affected by meltdown attack and needs kernel page table isolation */
 #define X86_BUG_SPECTRE_V1	X86_BUG(6) /* CPU is affected by Spectre variant 1 attack with conditional branches */
 #define X86_BUG_SPECTRE_V2	X86_BUG(7) /* CPU is affected by Spectre variant 2 attack with indirect branches */
+#define X86_BUG_SPEC_STORE_BYPASS X86_BUG(8) /* CPU is affected by speculative store bypass attack */
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -442,4 +442,9 @@ ssize_t cpu_show_spectre_v2(struct devic
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SPECTRE_V2);
 }
+
+ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_SPEC_STORE_BYPASS);
+}
 #endif
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -803,10 +803,33 @@ static const __initconst struct x86_cpu_
 	{}
 };
 
+static const __initconst struct x86_cpu_id cpu_no_spec_store_bypass[] = {
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PINEVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_LINCROFT	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PENWELL		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CLOVERVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CEDARVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT1	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT2	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MERRIFIELD	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_CORE_YONAH		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNL		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNM		},
+	{ X86_VENDOR_CENTAUR,	5,					},
+	{ X86_VENDOR_INTEL,	5,					},
+	{ X86_VENDOR_NSC,	5,					},
+	{ X86_VENDOR_ANY,	4,					},
+	{}
+};
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = 0;
 
+	if (!x86_match_cpu(cpu_no_spec_store_bypass))
+		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
+
 	if (x86_match_cpu(cpu_no_speculation))
 		return;
 
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -438,14 +438,22 @@ ssize_t __weak cpu_show_spectre_v2(struc
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
+					  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
+static DEVICE_ATTR(spec_store_bypass, 0444, cpu_show_spec_store_bypass, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
 	&dev_attr_spectre_v1.attr,
 	&dev_attr_spectre_v2.attr,
+	&dev_attr_spec_store_bypass.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -45,6 +45,8 @@ extern ssize_t cpu_show_spectre_v1(struc
 				   struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_spec_store_bypass(struct device *dev,
+					  struct device_attribute *attr, char *buf);
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);

