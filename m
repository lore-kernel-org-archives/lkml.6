Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28727C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30F5208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEE3GfAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30F5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeLEJp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbeLEJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:45:22 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE1D2146D;
        Wed,  5 Dec 2018 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003121;
        bh=Z4a7Hz5v/tOzYw//HZ2j39pe4jZGeF34YyiD0k285VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEE3GfAAoyQ4jBmOHtcmgMb0+ToWtj6+K52h+KeyZg+d2t/cXjgjyAevRbbVtVprY
         9sxv2sS/f47sMC/Ms0WazjyrAM5QQGZ01JgHwwlw4UoKeEA4FE1iKxxUGSTvR30CJ3
         D++76FrJXHO5GWSCm2BjsIDfnffReEuPS3y4srgw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 36/69] USB: omap_udc: fix omap_udc_start() on 15xx machines
Date:   Wed,  5 Dec 2018 04:42:14 -0500
Message-Id: <20181205094247.6556-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit 6ca6695f576b8453fe68865e84d25946d63b10ad ]

On OMAP 15xx machines there are no transceivers, and omap_udc_start()
always fails as it forgot to adjust the default return value.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/omap_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index d45dc14ef0a2..9060b3af27ff 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2045,7 +2045,7 @@ static inline int machine_without_vbus_sense(void)
 static int omap_udc_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
-	int		status = -ENODEV;
+	int		status;
 	struct omap_ep	*ep;
 	unsigned long	flags;
 
@@ -2083,6 +2083,7 @@ static int omap_udc_start(struct usb_gadget *g,
 			goto done;
 		}
 	} else {
+		status = 0;
 		if (can_pullup(udc))
 			pullup_enable(udc);
 		else
-- 
2.17.1

