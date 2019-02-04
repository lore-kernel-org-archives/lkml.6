Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F24C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F108C2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FHVJQ2pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfBDXQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:16:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44091 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfBDXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:16:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so633281plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+CqdFjUbPsFcXmKSPDmmDo194EYEoBLQtAS5/cHaV78=;
        b=FHVJQ2pABaLxUpn0N8klmC8ZSLpOloU2rvX6bShNOiqNIFCDcdFghxrkWw9ASWiQVm
         FYHKqZH7MkK5nFH/ibfcDrMQqxdQFCDWnf86Gj5IftY7CtRvWGsi+nQEOKI63jm8vE9a
         Zoy3My9xvdcZtUiy9GGsbjjyIjZ9l8WpPAvYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+CqdFjUbPsFcXmKSPDmmDo194EYEoBLQtAS5/cHaV78=;
        b=A1WA4gJuwVEWXRzXdwWYq9lbFQJ09qogXtlaX4sQtVXjpgGMB+xEAYo9UW9g25NUOC
         PS/nZebKgFbZk4rpZyXTrzTDzgIe2FaEalNLg1mHJt2HzYmddNUQ7lPVJm3Xo4w7JMUK
         G84XkQI0WbWGq1uqx6tQ7LXbgd8+/p/OI4LpmMfoGu0mpkoUsMaIpSmnPIo/PFkTuQMr
         lLmKovMNrbIhrkSwgeRzuDHY4Zg3ppNKZL8cUWwvdSDrdtPmKraxof7Q2orBEA8VxGZ5
         szx2NTsR+LPs6fdUEPD38pzhribzVfCEV8qpbWGwfoZsML9ZiLj0FETurGl2n5UBrgSj
         QvFg==
X-Gm-Message-State: AHQUAuayWR8mHlLy5MYSry16GdE9ohTRw0Zd6Y2OPlnwybAtbobCfkdM
        vbysCCBhWFyFy2X73ofQRcjang==
X-Google-Smtp-Source: AHgI3IY6t26oNneZecWK9LK0xxErUcIldANCTGKwUto6a/tOQEcRVc6vlnb04dcNM3K72pZBZae59w==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr1926546plr.15.1549322176854;
        Mon, 04 Feb 2019 15:16:16 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 15:16:15 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
Date:   Mon,  4 Feb 2019 15:15:49 -0800
Message-Id: <20190204231554.87666-4-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prep for the introduction of polling mode into the driver, update the
binding document to make the 'interrupts' property optional

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 81f982ccca31..d3a3620b1f06 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -9,9 +9,6 @@ Required properties:
     Define the base and range of the I/O address space that contain the iProc
     I2C controller registers
 
-- interrupts:
-    Should contain the I2C interrupt
-
 - clock-frequency:
     This is the I2C bus clock. Need to be either 100000 or 400000
 
@@ -21,6 +18,13 @@ Required properties:
 - #size-cells:
     Always 0
 
+Optional properties:
+
+- interrupts:
+    Should contain the I2C interrupt. If unspecified, driver will fall back to
+    polling mode
+
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1

