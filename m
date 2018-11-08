Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C95ECDE4D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87662081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMRrEuDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87662081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeKIHkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeKIHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0227B208E3;
        Thu,  8 Nov 2018 22:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714603;
        bh=8SaVQCYyGTBLgf2bwckgxS/HgkE57P+W9kLrJl+C9UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMRrEuDVgiMDMIj2ACPkBYtFqkWHtY+IUzeN5RZjnHvocT0GODQgbi8L21QgICR6k
         iiaw0eOKDStu+3hlwhdGmchf7APlXehb4mnk/3/9LS7UWf3AnhMcxNPeBf6p0wQ1x0
         Cnne4K5WJkjquPKOU4I7h74RS1R+rADjmicd9opc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 040/171] PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode
Date:   Thu,  8 Nov 2018 13:50:10 -0800
Message-Id: <20181108215130.357291687@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



