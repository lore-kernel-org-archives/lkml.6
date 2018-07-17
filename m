Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8DAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80D520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MoDRlnLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80D520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbeGQK63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:58:29 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39973 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbeGQK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:58:27 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4CA1210C181F;
        Tue, 17 Jul 2018 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531823192; bh=VC7M+UlDg/s8RF5GwPm7dde7HzjulihKBMcB7fqRdR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MoDRlnLCjoW/dMMP444aUwutLT1rv24pNzgyKv5nOWxqIwzO4YjSneJoBuZ5Tv6kz
         2k9udGyM+jde8zst5D10f8XTHcZXEcLmblafyDYF35NXsEdtkGI0KTKQKIPqohLhX1
         2lrsq2yogbwNphWcp7dAcdVYjV3QzLLhUZyvsJJr1BOh5znM/URIANUPWxm0A/gg5o
         wx71R7bRRkMSOCm/JMno/tnB7eOI6YdY9j9B4A/Ub/LrcDRtChwgZM9ULkpmT9MM5P
         RVy1g6ey23hAtbeU5TdGFyKXO5KOy291iXI9vs1ClXsInNKOMjxiUXgDM2PDOPFpH1
         P1hNW9/mWaDJg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 03B6E3566;
        Tue, 17 Jul 2018 03:26:31 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id EBEC83C342;
        Tue, 17 Jul 2018 12:26:29 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v13 12/12] PCI: endpoint: Add MSI set maximum restriction
Date:   Tue, 17 Jul 2018 12:26:27 +0200
Message-Id: <c95cf75dedb3542b003570bc13bd5b0960c337e6.1531822532.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531822532.git.gustavo.pimentel@synopsys.com>
References: <cover.1531822532.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531822532.git.gustavo.pimentel@synopsys.com>
References: <cover.1531822532.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci_epc_set_msi() maximum 32 interrupts validation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v4->v5:
 - New patch file.
Change v5->v6:
 - Nothing changed, just to follow the patch set version.
Change v6->v7:
 - Nothing changed, just to follow the patch set version.
Change v7->v8:
 - Re-sending the patch series.
Change v8->v9:
 - Nothing changed, just to follow the patch set version.
Change v9->v10:
 - Nothing changed, just to follow the patch set version.
Change v10->v11:
 - Nothing changed, just to follow the patch set version.
Change v11->v12:
 - Nothing changed, just to follow the patch set version.
Change v12->v13:
 - Re-sending the patch series.

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

