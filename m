Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9914D214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9914D214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeIQTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:02:14 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:60737 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728178AbeIQTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:02:13 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowABnSO1hrZ9bIuGlCg--.359S2;
        Mon, 17 Sep 2018 21:34:38 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pm@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 14/16] cpufreq, x86: Add Hygon Dhyana support
Date:   Mon, 17 Sep 2018 21:33:53 +0800
Message-Id: <1e902adeba0182099112914ee832624778ddaeec.1537182523.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
X-CM-TRANSID: swCowABnSO1hrZ9bIuGlCg--.359S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4DKFyDCF1UCr4xJF18Xwb_yoW5Jw4kpF
        W5WFW8Ar18Ja9rW3sFvF4UXF98Zas7tay3Kr9rt3sY9F45uFy5XrWDAw13Wr90g3ykWFyI
        y3WDWw42qan0yrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbKLvtUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hygon Dhyana CPU supports ACPI P-States feature, and there is
SMBus device(PCI device ID 0x790b) on Hygon platform, so add Hygon
Dhyana support to the cpufreq driver by using the code path of AMD
family 17h.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c         | 5 +++++
 drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b61f4ec..d62fd37 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -61,6 +61,7 @@ enum {
 
 #define INTEL_MSR_RANGE		(0xffff)
 #define AMD_MSR_RANGE		(0x7)
+#define HYGON_MSR_RANGE		(0x7)
 
 #define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
 
@@ -95,6 +96,7 @@ static bool boost_state(unsigned int cpu)
 		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
 		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
@@ -113,6 +115,7 @@ static int boost_set_msr(bool enable)
 		msr_addr = MSR_IA32_MISC_ENABLE;
 		msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
 		break;
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		msr_addr = MSR_K7_HWCR;
 		msr_mask = MSR_K7_HWCR_CPB_DIS;
@@ -225,6 +228,8 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		msr &= AMD_MSR_RANGE;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		msr &= HYGON_MSR_RANGE;
 	else
 		msr &= INTEL_MSR_RANGE;
 
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index be926d9..4ac7c3c 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -111,11 +111,16 @@ static int __init amd_freq_sensitivity_init(void)
 {
 	u64 val;
 	struct pci_dev *pcidev;
+	unsigned int pci_vendor;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		pci_vendor = PCI_VENDOR_ID_AMD;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		pci_vendor = PCI_VENDOR_ID_HYGON;
+	else
 		return -ENODEV;
 
-	pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
+	pcidev = pci_get_device(pci_vendor,
 			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
 
 	if (!pcidev) {
-- 
2.7.4

