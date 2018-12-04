Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3470C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7793520851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhYvNkdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7793520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLDK77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeLDK7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519C02087F;
        Tue,  4 Dec 2018 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921189;
        bh=xJmij/BOGdosJF+E91ArAPFKReycci6zNtRRW9AeNLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhYvNkdQg+b4ufvrg9ls4Ia0dBbzlq2d3Z2OZ9y9JOPzUBEFjYWJW4gxKdGy7PMH1
         PMhwcASVjm9fVHFii1ASwqw+ZV5ISTd8cY+h2XMVDjDEpIJnCCfJm04JDUeUK1qBIZ
         SYcRMunmarOacWjsSD+huxthBkeoUPkZuZ6721B8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.19 080/139] PCI: dwc: Fix MSI-X EP framework address calculation bug
Date:   Tue,  4 Dec 2018 11:49:21 +0100
Message-Id: <20181204103653.461182618@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

commit 15cb127e3c8f6232096d5dba6a5b4046bc292d70 upstream.

Fix an error caused by 3-bit right rotation on offset address
calculation of MSI-X table in dw_pcie_ep_raise_msix_irq().

The initial testing code was setting by default the offset address of
MSI-X table to zero, so that even with a 3-bit right rotation the
computed result would still be zero and valid, therefore this bug went
unnoticed.

Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-designware-ep.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -440,7 +440,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_
 	tbl_offset = dw_pcie_readl_dbi(pci, reg);
 	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
-	tbl_offset >>= 3;
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
 	bar_addr_upper = 0;


