Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79364ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EC52147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehxFAg/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EC52147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbeIUCdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:33:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46743 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUCdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:33:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id q22-v6so9567460lfa.13;
        Thu, 20 Sep 2018 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VLIItdANeR2HXKjAG9ooHkEQ/2j2hSQ7yUwph6rZVTY=;
        b=ehxFAg/nRs2vO3r8LxUBTvZzzoGKo4l17ctNT4xNVczeUf3G13HCkYd/DE9mbFeWkS
         sOMOm5DmqqCOO7GbcPB6d0LCdIIGya8Z7daAJZ/6W6G1xvrciGPOvLcpjjNe1KqGu5q2
         /QB7cpT5J+B5TM9OosO2toyn2sxCmU6j9/HImjBJ7smLlOf6rHD8XOxGIp3urQarCDHZ
         5kXO6niPKM9HOZ1pxm74lx+3pKuMffsj/okTjyztpaFs28/jFxxs/Kv9ndgKKS+J+FWh
         N+mkly+LP11Pe2LO0dY5kgxNbAa+aeWRm6C+GGJ1FS4kcbJrXa5CMXZ92FtZYDhj/TC4
         L7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VLIItdANeR2HXKjAG9ooHkEQ/2j2hSQ7yUwph6rZVTY=;
        b=BJbZT7yLJhfLKdwpGFq5WwfprgSO1fOdLW277942EFFA5yOTGxqFRHThsS5amwyC9t
         OJGoQyFW/yjM74ZEE1A5nqaC/O1ClCIFm0nwwOKOCg6y0zIa2wGq2OoCUIj91mEVWawQ
         x+5ZSkWxxJs4GuNfmouLBZJVNpnMHTGUzk/pub/K9UhPqKL/+svGsmuOXyIhHIDtq5IE
         se43g353g67gB6N25mAlCkEUBg3Xy7hl24dRB8pFMq18Rkvb/EOcFpZIjgwDmPhUYuux
         8u63/X5eAJdIxvGEuyooS5g93NSx+tan8qr/QzfQlEgtOqHN/75KcaUwM7FDSSYWfg0D
         icrQ==
X-Gm-Message-State: APzg51Cvws1LFcAcNtfudAgUH+jJux3oOMB7H3DU4H7nh73YpAeewlgj
        uYd6yayDfczF87jN9yrbrj4=
X-Google-Smtp-Source: ANB0VdYFlqfWFZqNcJy0Dsad3saMV57bbtCvgTINeayMSqYgjuhlkQMLSYQPaYHfj+6+c/8FvdunpQ==
X-Received: by 2002:a19:dd0e:: with SMTP id u14-v6mr287875lfg.109.1537476477924;
        Thu, 20 Sep 2018 13:47:57 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p4-v6sm1821609lfj.49.2018.09.20.13.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:47:56 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/7] [media] ad5820: DT new optional field enable-gpios
Date:   Thu, 20 Sep 2018 22:47:47 +0200
Message-Id: <20180920204751.29117-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new enable-gpio field. It can be used to disable the part
without turning down its regulator.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index 5940ca11c021..9ccd96d3d5f0 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -8,6 +8,12 @@ Required Properties:
 
   - VANA-supply: supply of voltage for VANA pin
 
+Optional properties:
+
+   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity of
+the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
+GPIO deasserts the XSHUTDOWN signal and vice versa).
+
 Example:
 
        ad5820: coil@c {
@@ -15,5 +21,6 @@ Example:
                reg = <0x0c>;
 
                VANA-supply = <&vaux4>;
+               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
        };
 
-- 
2.18.0

