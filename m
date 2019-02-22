Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB191C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887F12077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfnqGPOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBVAeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:34:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45173 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfBVAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:34:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so220736pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBVnoqXuO6HFOZ085kg+BDnfHXIhy9OmFMZxP4tCxpw=;
        b=EfnqGPOXB+Uhq1/DNgFMPxIVt3T3GMCie9YVOIrnCRIlVx3XOSiSvyj2HCPFtVOlQP
         1mh9XqgjQnMQTy3kMk4IR4CbmdabuKi3QUub2B4kB9rowmtLAYzKjXJLn8Oqx7b0AYyE
         yMntsAzKhhAdRDaEuFyxnJQ8w8oN/QDj0rXqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBVnoqXuO6HFOZ085kg+BDnfHXIhy9OmFMZxP4tCxpw=;
        b=P/oVd+WsB+I/KP5kl16uuWY6P2DTGOhG41HYF3JdnTgF/oKjnq3eBcIaalVVJML4rH
         YYK/wHV00KmRwm4jjJgq/8o7lXJFTIH5IzhaTEOy8fN1dNUq2hlBBYMb7+SRdHwHod8X
         3npjWYOqef7DKOC51YSkPoQfbaUnd0CNWedknP97FWrTsPD0a0GNuNnU1m1YYEyWpF1R
         dGFVjGj/qXpupUaEDEEKfNA3lVBVKFWPlqcvBpW2TCnI5ZPK+qu7FgjH3lfC1qgF9mYr
         rqAi+eC6Eb+8Xirs/j6BrljJ0RomktKFBb/t7eNfODe2PxCE6Pb6fvZFbvJ+xUoMTHNe
         HDRw==
X-Gm-Message-State: AHQUAuYfFxnqPQBEy5BfSgxPVcypfI4RMnr8edEJ/D5fUjGx4dJWeM3j
        3MLqDfG16AzBTDiqd47uo7WmWA==
X-Google-Smtp-Source: AHgI3IbGOJeo1tMct7+tFWXD7jLSXbSNtxVZdnkGfxrjSW81ok1QIOiXQPjcBYhWfdhBjDo0Ual3WA==
X-Received: by 2002:a62:7086:: with SMTP id l128mr1333899pfc.68.1550795652021;
        Thu, 21 Feb 2019 16:34:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id c3sm269830pfg.53.2019.02.21.16.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 16:34:11 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Date:   Thu, 21 Feb 2019 16:34:02 -0800
Message-Id: <20190222003403.128243-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222003403.128243-1-briannorris@chromium.org>
References: <20190222003403.128243-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two USB PID/VID variations I've seen for this chip, and I want
to utilize the 'interrupts' property defined here already.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/devicetree/bindings/net/btusb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index 37d67926dd6d..43c96c3380a6 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -9,6 +9,9 @@ Required properties:
 		 (more may be added later) are:
 
 		  "usb1286,204e" (Marvell 8997)
+		  "usb0cf3,e300" (Qualcomm QCA6174A)
+		  "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
+
 
 Also, vendors that use btusb may have device additional properties, e.g:
 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
-- 
2.21.0.rc0.258.g878e2cd30e-goog

