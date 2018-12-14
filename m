Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F9C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31D4214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789356;
	bh=6Ynuk/ccUYp6zB2S3VBa3c/eE5mcj+9a+0VM6OvXMFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jGFVRr8GoTuChm1UJDBI24ysjwOITV5hIzfyWR3KU7z6O5TmRJSlmJqgfYXrbOg8e
	 W36P1JHAw6hsVn5sEoSvpYVvnBHGLS+2WUiqF2fP3DzMkVsG8224N0G5oXUP2U64ha
	 aUcATFAxwALleAD7JGq3fmXhuh30eYVy1LqOITDc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31D4214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbeLNMJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731406AbeLNMJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA62214DB;
        Fri, 14 Dec 2018 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789351;
        bh=6Ynuk/ccUYp6zB2S3VBa3c/eE5mcj+9a+0VM6OvXMFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh180wAJ9PvHp3CTDJe9P1Shl4/LFLbgw+USozWyHJTSJX7M98psECMuY+jsvL49S
         DsE84CMzwBrShLAQ1B0DjmQaxO65FUY5lRhu47nMg48vP/+LVSsevKTy1xU2DSlZW6
         UHPKzrTsRfttqg7+7aT61RigQ0UdAIdpBhwy0FoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 49/89] USB: omap_udc: fix omap_udc_start() on 15xx machines
Date:   Fri, 14 Dec 2018 13:00:02 +0100
Message-Id: <20181214115732.086206553@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



