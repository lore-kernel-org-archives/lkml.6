Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92428C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573782081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544372;
	bh=4jgAfCUNjKEpfgooFoVg5UA2/5saZFnAS5xSD9WzsqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i9HbpjCNXMUX36man6Brm9KfMDuMMOXJxg0dBo49zEdtzFNtAxP+4Z2CpEyrezhsQ
	 HZZDLDPlblnU2P83Iy2U7nVjHWpUBFRYGdxq+IP9YC+bql4fTAOddGfc7KidmmZgrs
	 FjArNEZovkCzZHdZd+fxaNbWSajDvHUgLM5/TaoM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573782081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeLKPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbeLKPyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779CA20855;
        Tue, 11 Dec 2018 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543680;
        bh=4jgAfCUNjKEpfgooFoVg5UA2/5saZFnAS5xSD9WzsqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1V0gH0VZhWaVSLfhAEcHjZ4v7VayV8ef4b1rIXe/c+0Fb0P5JUFmbDX55cVgQZHP
         2oezn/0uD2ZSondbfuQ9KHHqMl6qxHPo3caGgKyPslhgkzFo9O7lIP/+iHwknmjhhJ
         yhxCRDfOcjWxcEGtBDWWA3o0vAfqeGeintbH074o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/118] usb: dwc2: pci: Fix an error code in probe
Date:   Tue, 11 Dec 2018 16:40:41 +0100
Message-Id: <20181211151645.137169734@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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
2.19.1



