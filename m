Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84DE20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByFteA/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84DE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbeKAIJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbeKAIJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B869B2081B;
        Wed, 31 Oct 2018 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027366;
        bh=F3HpubOcYNPNMapyXwlA/Yc8C8eC9mDgmj7KXkIT62w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByFteA/LBa9byZTi3QXcq+yIhtI3786d3Kkf4dbUKSBr34Q5Bw0y2Ti523SwP1pgA
         kQ0jp5LUbwTQPjtt8/Wtcz4p/JEizTZb7zTmYqhgnPmhE1u3qKhsET8GFg+kSad+AK
         uy8gsRExefZWoFTtbmMWGQ6fxD9yqL3I9f7U0NFI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 101/126] usb: gadget: udc: atmel: handle at91sam9rl PMC
Date:   Wed, 31 Oct 2018 19:07:29 -0400
Message-Id: <20181031230754.29029-101-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit bb80e4fa57eb75ebd64ae9be4155da6d12c1a997 ]

The at91sam9rl PMC is not quite the same as the at91sam9g45 one and now has
its own compatible string. Add support for that.

Fixes: 217bace8e548 ("ARM: dts: fix PMC compatible")
Acked-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 17147b8c771e..8f267be1745d 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2017,6 +2017,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc->errata = match->data;
 	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
+	if (IS_ERR(udc->pmc))
+		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9rl-pmc");
 	if (IS_ERR(udc->pmc))
 		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9x5-pmc");
 	if (udc->errata && IS_ERR(udc->pmc))
-- 
2.17.1

