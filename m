Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B9420854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1i/rdYJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B9420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJYWri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbeJYWrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:37 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BE22085B;
        Thu, 25 Oct 2018 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476881;
        bh=kD/hfytCsonVGxGi4Fi26bd6ZsMy+oKQ/bllW0mDqKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1i/rdYJ5WBJy5Q+HyqfwWtbYOhD52be2gCeqquOJ2eTpXhwUlE0lCLhB26xpATP+L
         G0W1AFXWK91p7WV0kxsOZWdpDRUeLZWqJfjXFjCVb7ZhVSKJBYOVUF9IrNZHmNTR9V
         lLdBMu1a7u6JjLBD1JJqC9OS6wxXiSjnSYJStbhg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 09/98] PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode
Date:   Thu, 25 Oct 2018 10:12:54 -0400
Message-Id: <20181025141423.213774-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongdong Liu <liudongdong3@huawei.com>

[ Upstream commit deb86999323661c019ef2740eb9d479d1e526b5c ]

HiSilicon Hip06/Hip07 can operate as either a Root Port or an Endpoint.  It
always advertises an MSI capability, but it can only generate MSIs when in
Endpoint mode.

The device has the same Vendor and Device IDs in both modes, so check the
Class Code and disable MSI only when operating as a Root Port.

[bhelgaas: changelog]
Fixes: 72f2ff0deb87 ("PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports")
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Cc: stable@vger.kernel.org	# v4.11+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c7a695c2303a..2250f0d33481 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1634,8 +1634,8 @@ static void quirk_pcie_mch(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	0x1610,	quirk_pcie_mch);
 
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
 
 /*
  * It's possible for the MSI to get corrupted if shpc and acpi
-- 
2.17.1

