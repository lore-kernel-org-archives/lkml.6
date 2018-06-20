Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94657C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D62B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aFVkgF80";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aFVkgF80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D62B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeFTENb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:13:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFTENW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:13:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D8164602B6; Wed, 20 Jun 2018 04:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529468001;
        bh=C94u/v8MusoLt7ZfsKFkoOg3CEkDT+oeWTqMz2XbsQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFVkgF80HlTA8it1oZixKCmQ2kna4brESY4Kg/5brClMBN8m3GaStmPXKgRoTixvz
         fo7GnXGzzZkPRHm1QPx2gXQcf9Dzh65ZZJiFfDDX83RVjObvDk6LmstpYnShce59of
         FC7WWO9r/dU58fSSIIg4Par9wYr7CcCYZ3d8xPEI=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D1EF6085F;
        Wed, 20 Jun 2018 04:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529468001;
        bh=C94u/v8MusoLt7ZfsKFkoOg3CEkDT+oeWTqMz2XbsQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFVkgF80HlTA8it1oZixKCmQ2kna4brESY4Kg/5brClMBN8m3GaStmPXKgRoTixvz
         fo7GnXGzzZkPRHm1QPx2gXQcf9Dzh65ZZJiFfDDX83RVjObvDk6LmstpYnShce59of
         FC7WWO9r/dU58fSSIIg4Par9wYr7CcCYZ3d8xPEI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D1EF6085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org, timur@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 2/5] IB/hfi1: use pci_reset_bus() for initiating pci secondary bus reset
Date:   Wed, 20 Jun 2018 00:12:55 -0400
Message-Id: <1529467995-28780-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
References: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to hide pci_reset_bridge_secondary_bus() from the drivers.
pci_reset_bridge_secondary_bus() should only be used internally by the
PCI code itself.

Other drivers should rely on higher level pci_reset_xxx() API.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 4d4371b..a6d695a 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -905,9 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	pci_reset_bridge_secondary_bus(dev->bus->self);
-
-	return 0;
+	return pci_reset_bus(dev->bus);
 }
 
 /*
-- 
2.7.4

