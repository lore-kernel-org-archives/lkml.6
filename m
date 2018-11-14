Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C86C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE6422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeKOHdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:33:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeKOHdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:33:50 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dceVK37xzPzB; Wed, 14 Nov 2018 22:28:53 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9759E1EC00EB;
        Wed, 14 Nov 2018 22:28:53 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/3] x86/cpuid: Make cpuinfo_x86.x86_model_id global
Date:   Wed, 14 Nov 2018 22:28:43 +0100
Message-Id: <20181114212843.16954-4-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114212843.16954-1-bp@alien8.de>
References: <20181114212843.16954-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... and __ro_after_init. Since the brand string is being read earlier
now, in early_identify_cpu(), get_model_name() needs to read out the
extended CPUID level for the brand string. This is temporary only, until
the full CPUID read out has been added.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-pm@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
---
 arch/x86/include/asm/processor.h     |  2 +-
 arch/x86/kernel/cpu/amd.c            |  4 ++--
 arch/x86/kernel/cpu/centaur.c        |  2 +-
 arch/x86/kernel/cpu/common.c         | 28 ++++++++++++++--------------
 arch/x86/kernel/cpu/cyrix.c          |  5 ++---
 arch/x86/kernel/cpu/intel.c          |  2 +-
 arch/x86/kernel/cpu/proc.c           |  2 +-
 arch/x86/kernel/setup.c              |  2 ++
 drivers/cpufreq/powernow-k8.c        |  2 +-
 drivers/cpufreq/speedstep-centrino.c |  6 +++---
 drivers/cpufreq/speedstep-lib.c      |  2 +-
 drivers/edac/e752x_edac.c            |  3 +--
 drivers/hwmon/coretemp.c             |  2 +-
 drivers/hwmon/k10temp.c              |  2 +-
 drivers/platform/x86/intel_ips.c     |  6 +++---
 15 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2f6f7939dfe0..ace1f364fb0c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -70,6 +70,7 @@ extern u16 __read_mostly tlb_lld_4m[NR_INFO];
 extern u16 __read_mostly tlb_lld_1g[NR_INFO];
 
 extern char x86_vendor_id[16];
+extern char x86_model_id[64];
 
 /*
  *  CPU type and hardware bug flags. Kept separately for each CPU.
@@ -95,7 +96,6 @@ struct cpuinfo_x86 {
 	/* Maximum supported CPUID level, -1=no CPUID: */
 	int			cpuid_level;
 	__u32			x86_capability[NCAPINTS + NBUGINTS];
-	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index eeea634bee0a..47aedc1240a2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -737,8 +737,8 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 		}
 	}
 
-	if (!c->x86_model_id[0])
-		strcpy(c->x86_model_id, "Hammer");
+	if (!x86_model_id[0])
+		strcpy(x86_model_id, "Hammer");
 
 #ifdef CONFIG_SMP
 	/*
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 14433ff5b828..bab43a1588bc 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -239,7 +239,7 @@ static void init_centaur(struct cpuinfo_x86 *c)
 			/* Add L1 data and code cache sizes. */
 			c->x86_cache_size = (cc>>24)+(dd>>24);
 		}
-		sprintf(c->x86_model_id, "WinChip %s", name);
+		sprintf(x86_model_id, "WinChip %s", name);
 		break;
 #endif
 	case 6:
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f77ca116fba7..0a96b6d56f13 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -95,9 +95,9 @@ static void default_init(struct cpuinfo_x86 *c)
 	if (c->cpuid_level == -1) {
 		/* No cpuid. It must be an ancient CPU */
 		if (c->x86 == 4)
-			strcpy(c->x86_model_id, "486");
+			strcpy(x86_model_id, "486");
 		else if (c->x86 == 3)
-			strcpy(c->x86_model_id, "386");
+			strcpy(x86_model_id, "386");
 	}
 #endif
 }
@@ -561,17 +561,18 @@ static void get_model_name(struct cpuinfo_x86 *c)
 	unsigned int *v;
 	char *p, *q, *s;
 
+	c->extended_cpuid_level = cpuid_eax(0x80000000);
 	if (c->extended_cpuid_level < 0x80000004)
 		return;
 
-	v = (unsigned int *)c->x86_model_id;
+	v = (unsigned int *)x86_model_id;
 	cpuid(0x80000002, &v[0], &v[1], &v[2], &v[3]);
 	cpuid(0x80000003, &v[4], &v[5], &v[6], &v[7]);
 	cpuid(0x80000004, &v[8], &v[9], &v[10], &v[11]);
-	c->x86_model_id[48] = 0;
+	x86_model_id[48] = 0;
 
 	/* Trim whitespace */
-	p = q = s = &c->x86_model_id[0];
+	p = q = s = x86_model_id;
 
 	while (*p == ' ')
 		p++;
@@ -1089,6 +1090,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (have_cpuid_p()) {
 		cpu_get_vendor_name();
+		get_model_name(c);
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
@@ -1232,8 +1234,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 		c->phys_proc_id = c->initial_apicid;
 	}
 
-	get_model_name(c); /* Default name */
-
 	detect_null_seg_behavior(c);
 
 	/*
@@ -1308,7 +1308,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
-	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
 	c->x86_coreid_bits = 0;
 	c->cu_id = 0xff;
@@ -1367,14 +1366,15 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	filter_cpuid_features(c, true);
 
 	/* If the model name is still unset, do table lookup. */
-	if (!c->x86_model_id[0]) {
+	if (!x86_model_id[0]) {
 		const char *p;
+
 		p = table_lookup_model(c);
 		if (p)
-			strcpy(c->x86_model_id, p);
+			strcpy(x86_model_id, p);
 		else
 			/* Last resort... */
-			sprintf(c->x86_model_id, "%02x/%02x",
+			sprintf(x86_model_id, "%02x/%02x",
 				c->x86, c->x86_model);
 	}
 
@@ -1489,11 +1489,11 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 			vendor = x86_vendor_id;
 	}
 
-	if (vendor && !strstr(c->x86_model_id, vendor))
+	if (vendor && !strstr(x86_model_id, vendor))
 		pr_cont("%s ", vendor);
 
-	if (c->x86_model_id[0])
-		pr_cont("%s", c->x86_model_id);
+	if (x86_model_id[0])
+		pr_cont("%s", x86_model_id);
 	else
 		pr_cont("%d86", c->x86);
 
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 1f1f724dd4c3..e5394251175c 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -191,7 +191,6 @@ static void early_init_cyrix(struct cpuinfo_x86 *c)
 static void init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
-	char *buf = c->x86_model_id;
 	const char *p = NULL;
 
 	/*
@@ -351,9 +350,9 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		dir0_msn = 7;
 		break;
 	}
-	strcpy(buf, Cx86_model[dir0_msn & 7]);
+	strcpy(x86_model_id, Cx86_model[dir0_msn & 7]);
 	if (p)
-		strcat(buf, p);
+		strcat(x86_model_id, p);
 	return;
 }
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..f18115779e07 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -745,7 +745,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		}
 
 		if (p)
-			strcpy(c->x86_model_id, p);
+			strcpy(x86_model_id, p);
 	}
 
 	if (c->x86 == 15)
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 999371ddfedb..d048b22cb304 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -70,7 +70,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   x86_vendor_id[0] ? x86_vendor_id : "unknown",
 		   c->x86,
 		   c->x86_model,
-		   c->x86_model_id[0] ? c->x86_model_id : "unknown");
+		   x86_model_id[0] ? x86_model_id : "unknown");
 
 	if (c->x86_stepping || c->cpuid_level >= 0)
 		seq_printf(m, "stepping\t: %d\n", c->x86_stepping);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9f21f595f0de..21c372c66498 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -162,6 +162,8 @@ static struct resource bss_resource = {
 };
 
 char x86_vendor_id[16] __ro_after_init;
+char x86_model_id[64] __ro_after_init;
+EXPORT_SYMBOL_GPL(x86_model_id);
 
 #ifdef CONFIG_X86_32
 /* cpu data as detected by the assembly code in head_32.S */
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index fb77b39a4ce3..476bbca2fd43 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1204,7 +1204,7 @@ static int powernowk8_init(void)
 		return ret;
 
 	pr_info("Found %d %s (%d cpu cores) (" VERSION ")\n",
-		num_online_nodes(), boot_cpu_data.x86_model_id, supported_cpus);
+		num_online_nodes(), x86_model_id, supported_cpus);
 
 	return ret;
 }
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index a1fb735685db..c0385ffb2732 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -238,21 +238,21 @@ static int centrino_cpu_init_table(struct cpufreq_policy *policy)
 	for(model = models; model->cpu_id != NULL; model++)
 		if (centrino_verify_cpu_id(cpu, model->cpu_id) &&
 		    (model->model_name == NULL ||
-		     strcmp(cpu->x86_model_id, model->model_name) == 0))
+		     strcmp(x86_model_id, model->model_name) == 0))
 			break;
 
 	if (model->cpu_id == NULL) {
 		/* No match at all */
 		pr_debug("no support for CPU model \"%s\": "
 		       "send /proc/cpuinfo to " MAINTAINER "\n",
-		       cpu->x86_model_id);
+		       x86_model_id);
 		return -ENOENT;
 	}
 
 	if (model->op_points == NULL) {
 		/* Matched a non-match */
 		pr_debug("no table support for CPU model \"%s\"\n",
-		       cpu->x86_model_id);
+		       x86_model_id);
 		pr_debug("try using the acpi-cpufreq driver\n");
 		return -ENOENT;
 	}
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index cabb6f48eb77..aa83496f8734 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -312,7 +312,7 @@ enum speedstep_processor speedstep_detect_processor(void)
 			 * string
 			 */
 			if ((ebx == 0x0e) ||
-				(strstr(c->x86_model_id,
+				(strstr(x86_model_id,
 				    "Mobile Intel(R) Pentium(R) 4") != NULL))
 				return SPEEDSTEP_CPU_P4M;
 			break;
diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index b5de9a13ea3f..76304cbcd55d 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -1211,14 +1211,13 @@ static int e752x_get_devs(struct pci_dev *pdev, int dev_idx,
  */
 static void e752x_init_sysbus_parity_mask(struct e752x_pvt *pvt)
 {
-	char *cpu_id = cpu_data(0).x86_model_id;
 	struct pci_dev *dev = pvt->dev_d0f1;
 	int enable = 1;
 
 	/* Allow module parameter override, else see if CPU supports parity */
 	if (sysbus_parity != -1) {
 		enable = sysbus_parity;
-	} else if (cpu_id[0] && !strstr(cpu_id, "Xeon")) {
+	} else if (x86_model_id[0] && !strstr(x86_model_id, "Xeon")) {
 		e752x_printk(KERN_INFO, "System Bus Parity not "
 			     "supported by CPU, disabling\n");
 		enable = 0;
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 10645c9bb7be..b3e444975930 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -262,7 +262,7 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tjmax_table); i++) {
-		if (strstr(c->x86_model_id, tjmax_table[i].id))
+		if (strstr(x86_model_id, tjmax_table[i].id))
 			return tjmax_table[i].tjmax;
 	}
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 2cef0c37ff6f..1057c14b50c9 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -343,7 +343,7 @@ static int k10temp_probe(struct pci_dev *pdev,
 		const struct tctl_offset *entry = &tctl_offset_table[i];
 
 		if (boot_cpu_data.x86 == entry->model &&
-		    strstr(boot_cpu_data.x86_model_id, entry->id)) {
+		    strstr(x86_model_id, entry->id)) {
 			data->temp_offset = entry->offset;
 			break;
 		}
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 225638a1b09e..4309f198cbad 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1367,11 +1367,11 @@ static struct ips_mcp_limits *ips_detect_cpu(struct ips_driver *ips)
 	else
 		ips->turbo_toggle_allowed = false;
 
-	if (strstr(boot_cpu_data.x86_model_id, "CPU       M"))
+	if (strstr(x86_model_id, "CPU       M"))
 		limits = &ips_sv_limits;
-	else if (strstr(boot_cpu_data.x86_model_id, "CPU       L"))
+	else if (strstr(x86_model_id, "CPU       L"))
 		limits = &ips_lv_limits;
-	else if (strstr(boot_cpu_data.x86_model_id, "CPU       U"))
+	else if (strstr(x86_model_id, "CPU       U"))
 		limits = &ips_ulv_limits;
 	else {
 		dev_info(ips->dev, "No CPUID match found.\n");
-- 
2.19.1

