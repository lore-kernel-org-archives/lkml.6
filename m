Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FCC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDF82087E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570312;
	bh=OlUEew7ILBfVn6lWP4cq7qnod613allZ2T/d3JHjwB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWcME/458znbAiCkQoE03/Kj5o8gNvQLWC+/kc37GSMhLzJOprT3lV6NVddHomNuY
	 NFRPaeEQ1MeUSELqvfkfL4qnxUGtTcikkzAQciih8RUKjxmfxY9DArgyq/KIy0V1xc
	 CvvmgNjseH8Ec264KSXCg3RmCX+GSbskdEIWA6WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfAOQia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732066AbfAOQi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1DC2087E;
        Tue, 15 Jan 2019 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570307;
        bh=OlUEew7ILBfVn6lWP4cq7qnod613allZ2T/d3JHjwB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egePWub5lchoL+tiXRPd5TQJ4cmRz9jQ7c1zhxPAo+KEDD8Zmu4MBRYFm+biy+5bM
         EtTABT8QB+2K/s/6hF2/Nx33Hc2/wYPh2gTT+hOCnCXieWGSN+LhR9OXVb+9fZMHzb
         b2k3upFFGdXse0pCpCXQPDo2N+hZh+IkDDYp327s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claudius Heine <claudius.heine.ext@siemens.com>
Subject: [PATCH 4.4 44/51] PCI: altera: Poll for link training status after retraining the link
Date:   Tue, 15 Jan 2019 17:35:40 +0100
Message-Id: <20190115154853.486522240@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ley Foon Tan <lftan@altera.com>

commit 411dc32d8810e0a204c799ce5c97cb56990de1cb upstream.

Poll for link training status is cleared before poll for link up status.
This can help to get the reliable link up status, especially when PCIe is
in Gen 3 speed.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudius Heine <claudius.heine.ext@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-altera.c |   45 +++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -61,7 +61,8 @@
 #define TLP_LOOP			500
 #define RP_DEVFN			0
 
-#define LINK_UP_TIMEOUT			5000
+#define LINK_UP_TIMEOUT			HZ
+#define LINK_RETRAIN_TIMEOUT		HZ
 
 #define INTX_NUM			4
 
@@ -99,11 +100,44 @@ static bool altera_pcie_link_is_up(struc
 	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
 
+static void altera_wait_link_retrain(struct pci_dev *dev)
+{
+	u16 reg16;
+	unsigned long start_jiffies;
+	struct altera_pcie *pcie = dev->bus->sysdata;
+
+	/* Wait for link training end. */
+	start_jiffies = jiffies;
+	for (;;) {
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			break;
+
+		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
+			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
+			break;
+		}
+		udelay(100);
+	}
+
+	/* Wait for link is up */
+	start_jiffies = jiffies;
+	for (;;) {
+		if (altera_pcie_link_is_up(pcie))
+			break;
+
+		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
+			dev_err(&pcie->pdev->dev, "link up timeout\n");
+			break;
+		}
+		udelay(100);
+	}
+}
+
 static void altera_pcie_retrain(struct pci_dev *dev)
 {
 	u16 linkcap, linkstat;
 	struct altera_pcie *pcie = dev->bus->sysdata;
-	int timeout =  0;
 
 	if (!altera_pcie_link_is_up(pcie))
 		return;
@@ -121,12 +155,7 @@ static void altera_pcie_retrain(struct p
 	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
 		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
 					 PCI_EXP_LNKCTL_RL);
-		while (!altera_pcie_link_is_up(pcie)) {
-			timeout++;
-			if (timeout > LINK_UP_TIMEOUT)
-				break;
-			udelay(5);
-		}
+		altera_wait_link_retrain(dev);
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(0x1172, PCI_ANY_ID, altera_pcie_retrain);


