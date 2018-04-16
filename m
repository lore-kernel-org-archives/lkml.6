Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx4+9pjaZSSGwUvi9Xiv1cwp5jCEJtSO5iSHENb6cTXc5HdYYbz6uNYROaX52SsOU3IRKPSi5
ARC-Seal: i=1; a=rsa-sha256; t=1523870830; cv=none;
        d=google.com; s=arc-20160816;
        b=NGRB4z/kqkmN3ikzQNvELDc0SXEFYuSahclXe82VuR0rmi6c82zRRxxzy+Lns9CS50
         d2v8OzHGJleS6xYjIHiIaL0SanKX2sUMuzjoCeOBPokYUSyW4ZWnXlWptfnDGGAY3D6N
         U6IEsB1LRVn5goGcJSDU9jCPsehJiHNz1bYvxT+5QoYekODCvuBwyHZ+ydMhMoZ1XAQP
         TFJt46tn1Aw7zrjrofPE2Pn+avuhKp6fKvlCtXeHiJGVDlZ9kLFDIMD1p4ttnMEBf241
         xQ8dvl/MIgIqIy2RhVU6CpjmyoSL9iaDVgqk1ZRwIkAFXr7fideVavuy3rgWHR+cZ7F8
         01eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=AFrBNc4W0uiI0UJ1AnypIeVK9e6FCVWJWCUN1hNu7tQ=;
        b=Y5rPrgHRtZgkBIjvhTXU3H4lA3Les/GkZWwuQsvfVsKWZwInDoB+GgIrGdJMaoGjFa
         +tetR+iWctSt+m7jeapgpznoChSuoPABid4KsECelNBWkrYXwLfw2Nz7Uuzjz8VU+cRQ
         CTYzSrD/rA1tP6Dw3EbpVeSzNn6tjZPHvhXFRqx9cN++JM2Ofo9EodXp86R2ft050QwB
         M2jW112B/8E485pCzGWLLcYJhZNiCMmdo5/30EDX4FQiWvEiJUr30aObBiOXKThgFRZQ
         PmrhChGhvYSWKX91RYqFlWfuWGpoBrP6eCB8YDr2ba9U9CfMNcEG/hB1Y4WGp8P8YsdC
         khFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH] x86/dma-mapping: override via_no_dac for new VIA PCI bridges
Date: Mon, 16 Apr 2018 17:26:56 +0800
Message-ID: <1523870816-6214-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894379144798679?=
X-GMAIL-MSGID: =?utf-8?q?1597894379144798679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PCI bridges integrated in new VIA chipset/SoC have no DAC issue.
Enable DAC for the platforms with these chipset/SoC can improve DMA performance about
20% when DRAM size > 4GB.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/pci-dma.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index cb9c1fa..6e37b0e 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -47,6 +47,10 @@
 
 extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
 
+#ifdef CONFIG_PCI
+static int override_via_dac __read_mostly;
+#endif
+
 /* Dummy device used for NULL arguments (normally ISA). */
 struct device x86_dma_fallback_dev = {
 	.init_name = "fallback device",
@@ -279,6 +283,9 @@ static int __init pci_iommu_init(void)
 
 static void via_no_dac(struct pci_dev *dev)
 {
+	if (override_via_dac)
+		return;
+
 	if (forbid_dac == 0) {
 		dev_info(&dev->dev, "disabling DAC on VIA PCI bridge\n");
 		forbid_dac = 1;
@@ -286,4 +293,19 @@ static void via_no_dac(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_PCI, 8, via_no_dac);
+
+static void via_can_dac(struct pci_dev *dev)
+{
+	/*
+	 * New VIA bridges have no issues for DAC.
+	 * Disable the "via_no_dac" fixup code for these new VIA bridges.
+	 */
+	override_via_dac = 1;
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, 0x345B,
+				PCI_CLASS_BRIDGE_ISA, 8, via_can_dac);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, 0x1001,
+				PCI_CLASS_BRIDGE_ISA, 8, via_can_dac);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, 0x300A,
+				PCI_CLASS_BRIDGE_ISA, 8, via_can_dac);
 #endif
-- 
1.9.1
