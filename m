Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B56C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6AC20836
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6AC20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeHSTXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:23:11 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:48528 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbeHSTXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:23:10 -0400
Received: from localhost.localdomain (unknown [110.184.154.248])
        by APP-10 (Coremail) with SMTP id tACowAAHDsaSlnlbwZiwAg--.2S2;
        Mon, 20 Aug 2018 00:11:03 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 07/16] x86/pci: add Hygon PCI vendor and northbridge support
Date:   Mon, 20 Aug 2018 00:10:50 +0800
Message-Id: <1d82940cdf78f1318ccf4d30eb768039511bc9ee.1534599097.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
X-CM-TRANSID: tACowAAHDsaSlnlbwZiwAg--.2S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyfKry5Gr4UJry3GF4DJwb_yoW7tr1xpr
        W3Ar4kXr4rW347Wa98trWUZrZ8ZF1vkayfCrW7Gw4SvF1Du3WrXFn2vr1ay3W2ya1DJay8
        Ja95W3WrJw4UtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUD-B_UUUUU=
X-Originating-IP: [110.184.154.248]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Hygon register its PCI Vendor ID as a new one "0x1d94", so add a new
definition PCI_VENDOR_ID_HYGON in include/linux/pci_ids.h.

Also Hygon PCI Device ID(0x1450/0x1463/0x1464) for Host bridge is added
to amd_nb.c. And it need to define new arrays for Hygon:
hygon_root_ids[], hygon_nb_misc_ids[], hygon_nb_link_ids[].

To enable Hygon north bridge support, add new variable root_ids, and
assign its value based on whether CPU vendor is AMD or Hygon. Modify
the CONFIG_AMD_NB to depends on either AMD or Hygon.

Add Hygon support in amd_postcore_init(), early_root_info_init().

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/Kconfig         |  2 +-
 arch/x86/kernel/amd_nb.c | 51 ++++++++++++++++++++++++++++++++++++++++++------
 arch/x86/pci/amd_bus.c   |  6 ++++--
 include/linux/pci_ids.h  |  2 ++
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6b8065d..34d05cd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2823,7 +2823,7 @@ endif # X86_32
 
 config AMD_NB
 	def_bool y
-	depends on CPU_SUP_AMD && PCI
+	depends on (CPU_SUP_AMD || CPU_SUP_HYGON) && PCI
 
 source "drivers/pcmcia/Kconfig"
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b481b95..d9867b2 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -20,6 +20,10 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 
+#define PCI_DEVICE_ID_HYGON_18H_ROOT     0x1450
+#define PCI_DEVICE_ID_HYGON_18H_DF_F3    0x1463
+#define PCI_DEVICE_ID_HYGON_18H_DF_F4    0x1464
+
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -61,6 +65,21 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{}
 };
 
+static const struct pci_device_id hygon_root_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_ROOT) },
+	{}
+};
+
+const struct pci_device_id hygon_nb_misc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_DF_F3) },
+	{}
+};
+
+static const struct pci_device_id hygon_nb_link_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_DF_F4) },
+	{}
+};
+
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -197,12 +216,25 @@ int amd_cache_northbridges(void)
 	u16 i = 0;
 	struct amd_northbridge *nb;
 	struct pci_dev *root, *misc, *link;
+	const struct pci_device_id *root_ids = NULL;
+	const struct pci_device_id *misc_ids = NULL;
+	const struct pci_device_id *link_ids = NULL;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		root_ids = amd_root_ids;
+		misc_ids = amd_nb_misc_ids;
+		link_ids = amd_nb_link_ids;
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		root_ids = hygon_root_ids;
+		misc_ids = hygon_nb_misc_ids;
+		link_ids = hygon_nb_link_ids;
+	}
 
 	if (amd_northbridges.num)
 		return 0;
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, amd_nb_misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
 		i++;
 
 	if (!i)
@@ -218,11 +250,11 @@ int amd_cache_northbridges(void)
 	link = misc = root = NULL;
 	for (i = 0; i != amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, amd_root_ids);
+			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
-			next_northbridge(misc, amd_nb_misc_ids);
+			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, amd_nb_link_ids);
+			next_northbridge(link, link_ids);
 	}
 
 	if (amd_gart_present())
@@ -263,9 +295,15 @@ bool __init early_is_amd_nb(u32 device)
 {
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
+	const struct pci_device_id *misc_ids = NULL;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		misc_ids = amd_nb_misc_ids;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		misc_ids = hygon_nb_misc_ids;
 
 	device >>= 16;
-	for (id = amd_nb_misc_ids; id->vendor; id++)
+	for (id = misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;
@@ -277,7 +315,8 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
 	/* assume all cpus from fam10h have mmconfig */
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 649bdde..bfa50e6 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -93,7 +93,8 @@ static int __init early_root_info_init(void)
 		vendor = id & 0xffff;
 		device = (id>>16) & 0xffff;
 
-		if (vendor != PCI_VENDOR_ID_AMD)
+		if (vendor != PCI_VENDOR_ID_AMD &&
+		    vendor != PCI_VENDOR_ID_HYGON)
 			continue;
 
 		if (hb_probes[i].device == device) {
@@ -390,7 +391,8 @@ static int __init pci_io_ecs_init(void)
 
 static int __init amd_postcore_init(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 
 	early_root_info_init();
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2950223..87883cf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2559,6 +2559,8 @@
 
 #define PCI_VENDOR_ID_AMAZON		0x1d0f
 
+#define PCI_VENDOR_ID_HYGON		0x1d94
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
-- 
2.7.4

