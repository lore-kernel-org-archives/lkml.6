Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpfRYZbj5p2OnZeFSm+qxXsQyYIQNEzb5v9qhOysV2Fjh5Uf9lVghWmj+IoJT7TR1ZjWXC8
ARC-Seal: i=1; a=rsa-sha256; t=1525116512; cv=none;
        d=google.com; s=arc-20160816;
        b=SXe8QT7452jo6oNsiYr/VGhV93Ajov1ePfCghvR7vNbWfAma8z/8BpXmUgRkaiY2cA
         SyKcEleE1T8EnTEHY+yJerawC0VAkEtylhIWw0ASlnkIA92g5m3LrBhbwnUgHbvA6rb1
         kNAmJFJ9vZjQ9ibHIeI0mSJkhGl/ywZm3A50BR64asVfs4YgUqCTEPc3NvVm3O6Y5Noi
         basNJRzQxScGum7+iApGosro8DVA4Ply8IHstnemkXG9/Ijn3UK36ANsA1b13pGBpBK7
         pIoC9eLYf5NGhOh198NlWj8YObPNEk5+rVonSw3A8MF777SBsKlT3sTQDXwVoQol8lVr
         Msvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=nhEl5FQ6Ij8Eh9BEVDf73vMreUOyxLKptr1oEOQb0YA=;
        b=rxYMyd6LbWonK2UZUv6+ovFEkztI3n9a0Lk1vtOF00WEgsFcWhhjU2mTAeAYKDa1Li
         MnIms18Lg7xqa2iOEydzJk1v00qs+HCZrFx6t7i6wa/+H0V6eqBzuFCNzy9sPlfGBoaz
         hnLYhU6azKMmjn7y8JI3eO15ExUtt5wc3m9A8hg+YEOAZza4Tia7Pd6U1LFxgVnZnGNh
         xE5GLgeUO/FjMMsRkizUVcxMgOkgW/cx00GymiBcJn6cv6eM4ZaI1pAo0ijc1dPKMt3J
         gXg0omLEWc+y9T+4bOSMuGNO3zQbWfNDmQTZa1vj8V8MQfbM884v6K8soct8plsNSNGo
         T1IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE7722DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Victor Gu <xigu@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Evan Wang <xswang@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>
Subject: [PATCH 4.16 071/113] PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode
Date: Mon, 30 Apr 2018 12:24:42 -0700
Message-Id: <20180430184018.218799432@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200505945887892?=
X-GMAIL-MSGID: =?utf-8?q?1599200572491611099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Gu <xigu@marvell.com>

commit 3430f924a62905891c8fa9a3b97ea52007795bc3 upstream.

The Aardvark has two interrupts sets:

 - first set is bit[23:16] of PCIe ISR 0 register(RD0074840h)

 - second set is bit[11:8] of PCIe ISR 1 register(RD0074848h)

Only one set should be used, while another set should be masked.

The second set, ISR1, is more advanced, the Legacy INT_X status bit is
asserted once Assert_INTX message is received, and de-asserted after
Deassert_INTX message is received which matches what the driver is
currently doing in the ->irq_mask() and ->irq_unmask() functions.

The ISR0 requires additional work to deassert the interrupt, which the
driver does not currently implement, therefore it needs fixing.

Update the driver to use ISR1 register set, fixing current
implementation.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196339
Signed-off-by: Victor Gu <xigu@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
[lorenzo.pieralisi@arm.com: updated the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-aardvark.c |   43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -100,7 +100,8 @@
 #define PCIE_ISR1_MASK_REG			(CONTROL_BASE_ADDR + 0x4C)
 #define     PCIE_ISR1_POWER_STATE_CHANGE	BIT(4)
 #define     PCIE_ISR1_FLUSH			BIT(5)
-#define     PCIE_ISR1_ALL_MASK			GENMASK(5, 4)
+#define     PCIE_ISR1_INTX_ASSERT(val)		BIT(8 + (val))
+#define     PCIE_ISR1_ALL_MASK			GENMASK(11, 4)
 #define PCIE_MSI_ADDR_LOW_REG			(CONTROL_BASE_ADDR + 0x50)
 #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
@@ -607,9 +608,9 @@ static void advk_pcie_irq_mask(struct ir
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 mask;
 
-	mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-	mask |= PCIE_ISR0_INTX_ASSERT(hwirq);
-	advk_writel(pcie, mask, PCIE_ISR0_MASK_REG);
+	mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
+	mask |= PCIE_ISR1_INTX_ASSERT(hwirq);
+	advk_writel(pcie, mask, PCIE_ISR1_MASK_REG);
 }
 
 static void advk_pcie_irq_unmask(struct irq_data *d)
@@ -618,9 +619,9 @@ static void advk_pcie_irq_unmask(struct
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 mask;
 
-	mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-	mask &= ~PCIE_ISR0_INTX_ASSERT(hwirq);
-	advk_writel(pcie, mask, PCIE_ISR0_MASK_REG);
+	mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
+	mask &= ~PCIE_ISR1_INTX_ASSERT(hwirq);
+	advk_writel(pcie, mask, PCIE_ISR1_MASK_REG);
 }
 
 static int advk_pcie_irq_map(struct irq_domain *h,
@@ -763,29 +764,35 @@ static void advk_pcie_handle_msi(struct
 
 static void advk_pcie_handle_int(struct advk_pcie *pcie)
 {
-	u32 val, mask, status;
+	u32 isr0_val, isr0_mask, isr0_status;
+	u32 isr1_val, isr1_mask, isr1_status;
 	int i, virq;
 
-	val = advk_readl(pcie, PCIE_ISR0_REG);
-	mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-	status = val & ((~mask) & PCIE_ISR0_ALL_MASK);
-
-	if (!status) {
-		advk_writel(pcie, val, PCIE_ISR0_REG);
+	isr0_val = advk_readl(pcie, PCIE_ISR0_REG);
+	isr0_mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	isr0_status = isr0_val & ((~isr0_mask) & PCIE_ISR0_ALL_MASK);
+
+	isr1_val = advk_readl(pcie, PCIE_ISR1_REG);
+	isr1_mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
+	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
+
+	if (!isr0_status && !isr1_status) {
+		advk_writel(pcie, isr0_val, PCIE_ISR0_REG);
+		advk_writel(pcie, isr1_val, PCIE_ISR1_REG);
 		return;
 	}
 
 	/* Process MSI interrupts */
-	if (status & PCIE_ISR0_MSI_INT_PENDING)
+	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
 		advk_pcie_handle_msi(pcie);
 
 	/* Process legacy interrupts */
 	for (i = 0; i < PCI_NUM_INTX; i++) {
-		if (!(status & PCIE_ISR0_INTX_ASSERT(i)))
+		if (!(isr1_status & PCIE_ISR1_INTX_ASSERT(i)))
 			continue;
 
-		advk_writel(pcie, PCIE_ISR0_INTX_ASSERT(i),
-			    PCIE_ISR0_REG);
+		advk_writel(pcie, PCIE_ISR1_INTX_ASSERT(i),
+			    PCIE_ISR1_REG);
 
 		virq = irq_find_mapping(pcie->irq_domain, i);
 		generic_handle_irq(virq);
