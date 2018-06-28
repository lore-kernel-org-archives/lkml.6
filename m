Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8690AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CDE20693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DcaBzbCh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c9JKT1JZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CDE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030471AbeF1S2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:28:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966340AbeF1S2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:28:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F308F60452; Thu, 28 Jun 2018 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530210513;
        bh=9qqbSAIvrLOXm1sGLNbwJ6hRHLI01Kdz2ijL3hAIYng=;
        h=From:To:Cc:Subject:Date:From;
        b=DcaBzbChcWNTfTwdP5MSkDFUIiElA/qfS49ZH4EQ3cuKJvyaOd+kyDqFrFNpgYYQ2
         dKRAs5SZM6ivpbH7IAK7fS+n7L1z19OuJSd78+v8bIPQhLoeqMvqISzIiP77lf110z
         OdbTOgaezbMKiouRjStbjtlukvTmz167auNfCn0g=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 792CB605A5;
        Thu, 28 Jun 2018 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530210512;
        bh=9qqbSAIvrLOXm1sGLNbwJ6hRHLI01Kdz2ijL3hAIYng=;
        h=From:To:Cc:Subject:Date:From;
        b=c9JKT1JZlwo9wCNcXL36vqf9npI69959AQ4Cn+7db4IttCsHfy9PkV62x3A21yXx6
         w3/LVYTolrFbvRXrbwebD4B4zSkUC3qkC0M3SOryGL9DfNEnKPZU3iYSYgTRGRAHei
         8DRKVxwsedv5dxYfSUGZyPB2klfAYwsx2PxbOz3g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 792CB605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 1/6] IB/hfi1: Use pci_try_reset_bus() for initiating pci secondary bus reset
Date:   Thu, 28 Jun 2018 14:28:21 -0400
Message-Id: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to hide pci_reset_bridge_secondary_bus() from the drivers.
pci_reset_bridge_secondary_bus() should only be used internally by the
PCI code itself.

Other drivers should rely on higher level pci_try_reset_bus() API.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 4d4371b..4570c4d 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -905,9 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	pci_reset_bridge_secondary_bus(dev->bus->self);
-
-	return 0;
+	return pci_try_reset_bus(dev->bus);
 }
 
 /*
-- 
2.7.4

