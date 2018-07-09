Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5921C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB74208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Pd119mJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB74208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeGIRow (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:44:52 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:56707 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933800AbeGIRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:42:58 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C31A310C1B11;
        Mon,  9 Jul 2018 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531158177; bh=W20p2o9rztSoy4c/asUzVmF0OpbORizZSgTD8uF3fYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Pd119mJB6UcywPR7LNlOOa7Qu/hOvbZRQkN906JpEhvjvRx71T/PaorRSVXbsZ7Tp
         leJVnsZDVyU1WuKrSKP+Tz2pHloLQimY30cPJOAYVQmdv37QD6WuktZTPbwr7cWFdY
         nbKyRC6+BLMW3sfd/CO+FkgvXO0V84hNKFvSi1rnmZrdhI+Yh5enxQL5gHBZIOEfFc
         gLNOYbSoQ8CmfiE4Tn3WMBg2rUJymhy/JLAWhkEQSIglgF+wJXrgrwERl0X7Gl/4Uu
         PcuFBFvlfNwHEH+J50QVTri46AORg9DJuUTIPHwuNM4yo60wFieBUJF21MHJBaSiiT
         LTKJmO6uuTjrw==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 76CF83727;
        Mon,  9 Jul 2018 10:42:57 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 12F3F3EDAF;
        Mon,  9 Jul 2018 18:42:56 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v9 12/12] PCI: endpoint: Add MSI set maximum restriction
Date:   Mon,  9 Jul 2018 18:42:50 +0100
Message-Id: <62cd7313fad048e1f20f7e3c7cc0380c88dd3c4e.1531155252.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci_epc_set_msi() maximum 32 interrupts validation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index c72e656..094dcc3 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -201,7 +201,8 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	u8 encode_int;
 	unsigned long flags;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
+	    interrupts > 32)
 		return -EINVAL;
 
 	if (!epc->ops->set_msi)
-- 
2.7.4


