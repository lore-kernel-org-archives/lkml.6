Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE93C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69034251BD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XjuI4aGz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VEdkraly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69034251BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeGBWxL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:53:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeGBWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:53:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B84FA60B3B; Mon,  2 Jul 2018 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530571987;
        bh=cghsNNqcVbuCBkI4WhSV76kRpbS6n544RnT2zRlX1Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjuI4aGzGtKXINKv29OgoJcCD9+MNnhaJ7iResJDmdVuCfIiU5A6miY6ggL7DeHgA
         kXZjVl2/dXuNqMpzgKHoGSVrdNJvJu20Mu3artKRpZOwnqofMi/4Z65HBz4ZLWT4mq
         RHxQa6+chcjMuHrhCM6SZKR5AO6DjdgvzNOp6Yx0=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1934607EB;
        Mon,  2 Jul 2018 22:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530571986;
        bh=cghsNNqcVbuCBkI4WhSV76kRpbS6n544RnT2zRlX1Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEdkralyPtDityh9M+kQYKT7s6lO/vjMqBWvaWJPtNSx0vQTyURdHkujqO9ouB9px
         mLGl95ax8jSPiOl5ridvf5b0L1RgD5I1BNNKNNNHrvaIdEPBl8YcNr6XUj6W0c0gm0
         ynOOt8OFNwWU/ublH4vPT01O+p0B6k0pRbjMjlk0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1934607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Kees Cook <keescook@chromium.org>,
        Lukas Wunner <lukas@wunner.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 2/3] PCI: pciehp: reuse pciehp_mask/unmask_irq() in reset_slot()
Date:   Mon,  2 Jul 2018 18:52:46 -0400
Message-Id: <1530571967-19099-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have individual functions to mask/unmask hotplug interrupts
avoid code duplication and reuse the new API in multiple places.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index d44e2c6..ebf9b3b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -726,34 +726,15 @@ static void pcie_disable_notification(struct controller *ctrl)
 int pciehp_reset_slot(struct slot *slot, int probe)
 {
 	struct controller *ctrl = slot->ctrl;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
 
 	if (probe)
 		return 0;
 
-	if (!ATTN_BUTTN(ctrl)) {
-		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
-		stat_mask |= PCI_EXP_SLTSTA_PDC;
-	}
-	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
-	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
-
-	pcie_write_cmd(ctrl, 0, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
-	if (pciehp_poll_mode)
-		del_timer_sync(&ctrl->poll_timer);
-
+	pciehp_mask_irq(slot);
 	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
+	pciehp_unmask_irq(slot);
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
-	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
-	if (pciehp_poll_mode)
-		int_poll_timeout(&ctrl->poll_timer);
 	return rc;
 }
 
-- 
2.7.4

