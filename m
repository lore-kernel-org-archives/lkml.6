Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FBA208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlS25U64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FBA208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeK2RCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbeK2RCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:06 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5B5208E7;
        Thu, 29 Nov 2018 05:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471075;
        bh=4J+99dOlWLBxhySDJITTOZmm5WOJYtTN6vEFu9Evopw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlS25U64n5zzkF7MfC7Ly6u6bJvX44DhlGQXgiuuSsUDwJDsaSzbczdyeCbog3sqm
         5y9eojWZQ15YnfqUMjJGhQEmga6+HLKVJibU/Xd6EG9yS6m6Pd7BuaYIvAdO2jd2gQ
         rizpHoFMh71YHEAJY8YcpFYvMpuSdT87n+WQzp6w=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/68] usb: dwc2: pci: Fix an error code in probe
Date:   Thu, 29 Nov 2018 00:55:13 -0500
Message-Id: <20181129055559.159228-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3c135e8900199e3b9375c1eff808cceba2ee37de ]

We added some error handling to this function but forgot to set the
error code on this path.

Fixes: ecd29dabb2ba ("usb: dwc2: pci: Handle error cleanup in probe")
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
index d257c541e51b..7afc10872f1f 100644
--- a/drivers/usb/dwc2/pci.c
+++ b/drivers/usb/dwc2/pci.c
@@ -120,6 +120,7 @@ static int dwc2_pci_probe(struct pci_dev *pci,
 	dwc2 = platform_device_alloc("dwc2", PLATFORM_DEVID_AUTO);
 	if (!dwc2) {
 		dev_err(dev, "couldn't allocate dwc2 device\n");
+		ret = -ENOMEM;
 		goto err;
 	}
 
-- 
2.17.1

