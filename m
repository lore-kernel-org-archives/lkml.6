Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7AAECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C7D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZTo3Q8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C7D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbeGRUYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbeGRUYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:24:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E74A20850;
        Wed, 18 Jul 2018 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531943079;
        bh=Q9wDDbmMkKzgk35C9SEgDdC5qklVgwEr2qsRAGKyaXg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hZTo3Q8/nhGM+AFdYJwxZGbbRJ0b8HvcjuuusnNrgAvDWipsvnDUmqat+vePewtu2
         2TOu2q1RyJEWO2Ke/1ia+8aYL79ycUhnVT+aO9Ga6zHJ+rjMqGB2kckKzy4gT0Jrk3
         Ji4G10/TRbJnrZxMB7IcnDzkdqLQFFfH3PDHwkYg=
Subject: [PATCH v3 3/7] PCI/AER: Factor out ERR_NONFATAL status bit clearing
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oza Pawandeep <poza@codeaurora.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 Jul 2018 14:44:38 -0500
Message-ID: <153194307824.191586.2110241671895539992.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oza Pawandeep <poza@codeaurora.org>

aer_error_resume() clears all ERR_NONFATAL error status bits.  This is
exactly what pci_cleanup_aer_uncorrect_error_status(), so use that instead
of duplicating the code.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: split to separate patch]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6f0f131b5e6a..b8972fe85043 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1356,20 +1356,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	int pos;
-	u32 status, mask;
 	u16 reg16;
 
 	/* Clean up Root device status */
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
 
-	/* Clean AER Root Error Status */
-	pos = dev->aer_cap;
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
-	status &= ~mask; /* Clear corresponding nonfatal bits */
-	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+	pci_cleanup_aer_uncorrect_error_status(dev);
 }
 
 static struct pcie_port_service_driver aerdriver = {

