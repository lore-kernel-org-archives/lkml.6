Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6FEC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53E21527
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789657;
	bh=1qNghAYCQrQTKfQ5tdLyFJvs69pp3G6Th6ZBebhsw1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1TTWbCjl0L6D8Q0LcFW0AOfz5tYtBRpah/zQKIrJte6YQR3tTrwP7yWZXRoDne76
	 KR88K7l8Gxje3+rP40QRV6qolVdKrFHHkZlpAQwFp0hDl82O+hisnTddjWMaanLZ4R
	 oU91ps0Rrn5b49JXLEy2xJs5Uqw++TP/wA4rYyXU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B53E21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbeLNMOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732284AbeLNMOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF732133F;
        Fri, 14 Dec 2018 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789651;
        bh=1qNghAYCQrQTKfQ5tdLyFJvs69pp3G6Th6ZBebhsw1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYHPrehCcrMhMJtiZ0BvkR9GsRMSiiAeIExU43op5ComzxqUtIQSrmqzvJCnZdORl
         bBocaytViDHX+zw63Y593U4/BAU1mbJOdNpJ3bHHQStqfjzWunLf4QDqTGPpiIWhPw
         3ca4itFlW9WbURsaG6egoyCkPh6JYR58xnC13iUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 24/88] USB: omap_udc: fix omap_udc_start() on 15xx machines
Date:   Fri, 14 Dec 2018 12:59:58 +0100
Message-Id: <20181214115704.126693648@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index da1030f69145..653963459d78 100644
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



