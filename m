Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF7C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225E82083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZxFA/wvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225E82083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeFTQbY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:31:24 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:52406 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeFTQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:28:46 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A98A31E16D0;
        Wed, 20 Jun 2018 18:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529512123; bh=FPazd6NBJuE0E+SDaYRbbPhDJdPQwua79CdcnIQ1Nro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZxFA/wvC+wUiU5VSpW6cCD8dd/X5luUnJh/gYd3uwCJdfCpVxFGqyiGFFuAfgIT2r
         PLFfnzeIkHkJcy6AFbFnktA05O8Pe/jfmmk2prNt67lP+uR6lVsk6iZnS13ssba6qY
         whge0PK6kVh+4CFJqs+eseY4l3I3dYpbAJKVHwpNfEkT2zUj1a3MRnuvgc5L26/nIc
         e7QkHu+llrf6WS7IRku4VYTlJ70J/Pw00HekfhFQLBShCvSp0rFo/IxZwHgrkXGLjI
         LmOqo9U6jNvuKxt85Q/GX9c4dGJlTthAPKdMHa/FIJLnBu6xC7a6DEXt75Ac/ILhq2
         H4B7rZDRKb7Aw==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id D4D305CB5;
        Wed, 20 Jun 2018 09:28:42 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 782853D50D;
        Wed, 20 Jun 2018 17:28:41 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com, sboyd@codeaurora.org
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v5 11/11] PCI: endpoint: Add MSI set maximum restriction.
Date:   Wed, 20 Jun 2018 17:28:33 +0100
Message-Id: <ffa6a3a2877337dab158d19004317b6ae1a0d6da.1529507416.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci_epc_set_msi() maximum 32 interrupts validation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v4->v5:
 - New patch file.

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


