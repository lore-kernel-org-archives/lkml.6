Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE701C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B295222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IhlLw0Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437774AbfBNR54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:57:56 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39202 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437748AbfBNR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:57:53 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so3675159iti.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qd5kI+SJawXscvy5gQFO6CdGhw4ESxIavmw5z4kZ0JE=;
        b=IhlLw0Jf9Ut/A90TYhXhoRD+hkewG/boZsw/12RupQo+z5Z0IcUcQ6SvcCS5o0M4fU
         3a/A3P61va0qcZohzWHF/mb6bHmZj71/KwYLFpsATu/igCw410WnKmbBImRzWOAuUzyP
         wkWOeMfjI0nf2SO5efto6SnXCdzcpoBOE5EJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qd5kI+SJawXscvy5gQFO6CdGhw4ESxIavmw5z4kZ0JE=;
        b=Fi4oT8l4yQbucsWJu/0G6KZ5z/eRBJpQVjFr5N2wJYouSJUYM3s+70E4R0Xjxr0kBI
         e8hrroaQNUJ4VUU1535isdYj+fxqoL36Em1oIwa9ltCoaA68DjCAsFnn8bEWfX/3P/0Z
         9uNmxeliCeSAJWmuv+lTAFJIuPQGP+YLWoumyrD/heMFerSWkuqG3XI+Ai+hoqKCbIxj
         GLQsiKK8drx+KB7kjaVSTuwoZ0waH4JKqxq+Bs79GxHf++OCOYTOESzZ74C8HzqUyubG
         W06oUV+T3hpiKKxqrO8BoF9NNgyAcV2DrNhheJSqBptdHdq42K/nESysQKahzGDVsOvk
         pNFw==
X-Gm-Message-State: AHQUAuYmgCevoj4H8oV5cSfd/b0qmPye8ljH95Ah6JafH5wbCiNEoSF1
        irVS8I3PepWH9HgnvbDq9rvUMA==
X-Google-Smtp-Source: AHgI3IYC8QBY5QAdgIeyfE2U1qAUURc9s9naP+Q4N8K1ULjptwjVPqo1znC2pqepovVwCFVkNkiplw==
X-Received: by 2002:a02:9c16:: with SMTP id q22mr2884177jak.49.1550167072510;
        Thu, 14 Feb 2019 09:57:52 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:57:51 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
Date:   Thu, 14 Feb 2019 09:57:20 -0800
Message-Id: <20190214175725.60462-4-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the binding document to make the 'interrupts' property optional.
For certain revisions of the I2C controller (e.g., iProc NIC I2C), I2C
interrupt is unwired to the interrupt controller. In such case, this
'interrupts' property should be left unspecified, and driver will fall
back to polling mode

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 81f982ccca31..7a32bf81bfa9 100644
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
 
@@ -21,6 +18,14 @@ Required properties:
 - #size-cells:
     Always 0
 
+Optional properties:
+
+- interrupts:
+    Should contain the I2C interrupt. For certain revisions of the I2C
+    controller, I2C interrupt is unwired to the interrupt controller. In such
+    case, this property should be left unspecified, and driver will fall back
+    to polling mode
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1

