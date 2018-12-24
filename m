Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8EFC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558CF21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTI4+8cL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeLXWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeLXWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so12538787wrt.7;
        Mon, 24 Dec 2018 14:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
        b=GTI4+8cLB7EIkqORQRNJK2e+mWwLzHxqnjqdg0FW8/YPiWvdVUJgTgzL1tnRGWMahY
         +o4hpkP7VEra8b3sO/7aBg3Xms15b9MNIGsed5hecXpiJW4NHbCkxqQkNX3otMO2DYTi
         BZE9pYE0euHvXydo9qKoLxOhWbEXiMWkKowj/nRvXghj8j2U7XRpqmwyyRZcj51Qo0Oh
         btEg7bjWQyHUu1cbDnlkwG7gH9IWb+3IciEEoQc0I5T/Eg6sR4AIjyJPrpVbhlpgMxJq
         EktDWHNE3t3pMcod05Eck4smEAJiZ3cnYo9Ovy17HJeDm+WhnrilZBJ4h00XXCyPFO4o
         0TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
        b=JsYitz2J050tGyIAG/gCVIymkAvNL9Uac/Od00liBiQ3bxyMckcELBj7HoNf9mdf66
         sFIpgaXec2phqbnWS9kpKa6ZfgmqJwZzYWxLhMDV/tGoNUJTY8xJEh2NT+uDYgVThfjZ
         m44yEwuViR60GILxXjIHLiC7U63exhlvrClbM4qdJGfQHmKFWegSSsrRnAiuSjGJrgcv
         EiAC7g934/+yqXpIbK651OT8Kq8gJqoXItPRD5xIEef05XvMq0CHbjsnIT2r7Dka1DFw
         g1Ew8QZLvcUxz9jdYxr+oKryM1ohc1tcYtX98aKU+HSkC9YjHScbojg/uHJM9AiCw6SQ
         8b7A==
X-Gm-Message-State: AJcUukeV2nw+rt4ign4ue9IYjvHiQs12VYEaO/Vv1ZnlyPkJ/MimvyP6
        VQljeE+bODN3/Ixu58bHChU=
X-Google-Smtp-Source: ALg8bN42hV1R5my0GPnSzrQBulHiF/G7OSjmVP2ZkIj9Y7TxgAAyno+CS4h4zcAR6waf0Xg/0xY23A==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr13782754wrr.39.1545688875943;
        Mon, 24 Dec 2018 14:01:15 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:15 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 14/14] spi: stm32: add description about STM32F4 bindings
Date:   Mon, 24 Dec 2018 23:00:40 +0100
Message-Id: <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add description that STM32F4 can be used in compatible property.
Master Inter-Data Idleness optional property cannot be used in STM32F4.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 1b3fa2c1..d82755c 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,9 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32h7-spi".
+- compatible: Should be one of:
+  "st,stm32h7-spi"
+  "st,stm32f4-spi"
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -30,8 +32,9 @@ Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
 
 Optional properties:
-- st,spi-midi-ns: (Master Inter-Data Idleness) minimum time delay in
-		  nanoseconds inserted between two consecutive data frames.
+- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
+		  delay in nanoseconds inserted between two consecutive data
+		  frames.
 
 
 Example:
-- 
2.7.4

