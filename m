Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A89C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52F621872
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/D6A6tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfAEAti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:49:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39321 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEAtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:49:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so18149632pgl.6;
        Fri, 04 Jan 2019 16:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wop6KpWlwvxvZAv7XAUU5J2ClAasEuR4THaU6YiR25E=;
        b=k/D6A6tZWQxfzmM9RQBAEJ4C3b/S32PTn0oQLNpSmuo+1hFAe1hPSqqTyDd0/KPH7P
         fVOkeGxVYD6rL6n3nD7mYGzQZ5u1nalhir6OVhbqjY5h1uNzJqZWfWW99dbVuwzy4DR8
         SpXRI2wQsCMOy78U2JNoz7413UBLOgYALm0pS7Ht/ilvxDtjKgPimgnf86kpZGPnAi06
         /OtXT9C6LElYNYwDlkYbTx+pdte2ezN5cSM8nqG5f2mkSCO/ZxpRL1iz1ibw9yaPOx0y
         pNT7m6VAllC8JsvRInVUkwJbsLee3eymOsQsvDVG0BskMN+Yd9Nc3wpFrrolrpDVvS9A
         Ruxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wop6KpWlwvxvZAv7XAUU5J2ClAasEuR4THaU6YiR25E=;
        b=jQNSyoQGtiUBPRmpAwxZjkaT6wFF68t0HsYAAj7k4rLV+c4AH2M+NXRnnkl6Gnr7K6
         Rs8rUhwIJN6fSSzeEub98Y4zWH1scjgAhj2Pe2VLKr/ovNJhASR9TohEmUrizxUGOV/6
         3Tj8eFm7DRXgZn7PH1Kt7on/MZ/VqP/Yd2ykUhiij3G/Q6DVNVIlbXD72m9zsf51bDNg
         jRfgfFcWCkf/eOnStyFdqUnm83UD2YEg6l+CqiMfpl506DJKtlEqKe/6l0j4HUcq7Q9z
         u665R/7nto6ZiAmkaB+tRo7GPw+mRqvMe4bfpCizAyyDFayJTYW6PqwxocWYDW5IonvG
         41JQ==
X-Gm-Message-State: AJcUukfLBv2uW+CZnVlhBS9F3Tu+h7482CD9IBrh0UrPnR0m90Fj5RQ4
        IU1znJCFlFVhR4d8NJ4uGZY=
X-Google-Smtp-Source: ALg8bN5lyM141jGQC8TUDMElJZmSrtVaCu9ZMtlDkas7wb5CoaXQ41Mkrjbf6bnJZ+EPvafQRlnHtg==
X-Received: by 2002:a63:4002:: with SMTP id n2mr3379513pga.137.1546649375694;
        Fri, 04 Jan 2019 16:49:35 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n68sm101525495pfb.62.2019.01.04.16.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 16:49:35 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: hwmon: ina3221: Add ti,single-shot property
Date:   Fri,  4 Jan 2019 16:49:03 -0800
Message-Id: <20190105004904.17947-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105004904.17947-1-nicoleotsuka@gmail.com>
References: <20190105004904.17947-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, ina3221, as a hardware monitor, continuously measures
the inputs and generates corresponding data. However, for battery
powered devices, this mode might be power consuming.

This patch adds a "ti,single-shot" property to allow changing the
default continuous mode to single-shot operating mode.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/ina3221.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
index a7b25caa2b8e..fa63b6171407 100644
--- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -6,6 +6,16 @@ Texas Instruments INA3221 Device Tree Bindings
   - reg: I2C address
 
   Optional properties:
+  - ti,single-shot: This chip has two power modes: single-shot (chip takes one
+                    measurement and then shuts itself down) and continuous (
+                    chip takes continuous measurements). The continuous mode is
+                    more reliable and suitable for hardware monitor type device,
+                    but the single-shot mode is more power-friendly and useful
+                    for battery-powered device which cares power consumptions
+                    while still needs some measurements occasionally.
+                    If this property is present, the single-shot mode will be
+                    used, instead of the default continuous one for monitoring.
+
   = The node contains optional child nodes for three channels =
   = Each child node describes the information of input source =
 
-- 
2.17.1

