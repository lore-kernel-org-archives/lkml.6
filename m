Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F190C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88825187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IsSZ/6GX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MK4WNXx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A88825187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeGBW7Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:59:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeGBW7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:59:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79BA160B23; Mon,  2 Jul 2018 22:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572360;
        bh=9qqbSAIvrLOXm1sGLNbwJ6hRHLI01Kdz2ijL3hAIYng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsSZ/6GXiMqOWXIhxhltjonJorTQPT78vVbyHdBEzfLhtQIxWmhcr2jwQlxBN/oDk
         4xuANQalfe8XUzjrxispe4VVNcMIDiNT3AKtOnJQ0thOG+ebDaNsT0ZFkQs+P/G9JF
         83ndOg9Z0TDzmY0SlXGo20yNT/CTznLK0ux3JKng=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE5C260B23;
        Mon,  2 Jul 2018 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572359;
        bh=9qqbSAIvrLOXm1sGLNbwJ6hRHLI01Kdz2ijL3hAIYng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MK4WNXx3NNG0vNcUd32qHH0jQHg7q4oG671RvMk6wGdLfZODrkgCBATzChTDAWp5L
         H2qymZ5bycJhjR+wH1BCX0MS762ZHtavFmQ9GSBN5Bh1U8ndH1R5sDgM8jwmfyAJOF
         6WJk7lehlp6KQNElSAie7jJnX+y3LVffdnN5O7JM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE5C260B23
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
Subject: [PATCH V5 2/6] IB/hfi1: Use pci_try_reset_bus() for initiating pci secondary bus reset
Date:   Mon,  2 Jul 2018 18:58:51 -0400
Message-Id: <1530572336-20296-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
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

