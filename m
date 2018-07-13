Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48503ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000362087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AegatfjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000362087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeGMRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:45:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40210 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbeGMRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:45:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id e13-v6so9638360pff.7;
        Fri, 13 Jul 2018 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMwf/iRAXQeXiQYwou7re9WKXqDNodIAVXvANEVeNaM=;
        b=AegatfjZnYsRGXZPdFjK4uLI+l6je3L3AaRYFfmddi7VMJkII2vYUBrHHdMzRyN5du
         tJZSYdfk01cn8ATukixjJ/oZzuPaDV2dkKTRwWsltRp1mUmTm/2mcKrkMY7xouXCX6wZ
         AUGK9bsbos35KZNqP9FGiWVA+p2ErJhUix+W0+17to+2GkVQPLHRR8EX6gUgynci7Gol
         BDU4HTmmtR6EmyZa/nu3dOIG6DgwIfdnldcLkfadFRZ10sokJsHaaHvgZVwsLFMHjcu1
         sa989PeQMi8ZCpZFtcLLiFSFBqEd+sebHcTjJel8k3O/mhgesIkzyKJGx9Esu0jGO0FO
         bpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMwf/iRAXQeXiQYwou7re9WKXqDNodIAVXvANEVeNaM=;
        b=Bix+6OF67u0P0aRWxxy/54dOcTiBT71AWfG0dsj7uKBLYvznJ/NZrtX/SAmV+U7vgS
         rWZwnyw6+jHX4vsblisyuDEXId9WY7QWigS6qk0q47Zw32D2to0DB9e4S3S4UhSg/wjJ
         Ow/6UENcl9y+zJd4MqFILJQhJUBImNKfV5MMv9wVDWRcI1aDoZDPaX2T4Hw362xVM4yo
         xZigAOMpMLeN9+AsbE+yjfI2tGtG90NXCxKgPYsQP09t5xqx/SD28X0HeXo9J/ZMiqNr
         SvBygzt0zmcsE6QiUGVhf6+Z1MANwPyZCAo9Uc8ARRsEAZqPe3xMK4haW63QO+FnaMZu
         +n0A==
X-Gm-Message-State: AOUpUlFfzfGw6bJJWIjO/CTHgQbd/vippTflvDYEwvKQmhkr6Ir2zHPL
        dBg1kYL0U/AoovBwRvvVdZE=
X-Google-Smtp-Source: AAOMgpfBnWyameoIM+XwJ7iTt9XwDrl/m1/icSJCor4x9oC/vPV9ckXDpoUCNwBuYgSrc/wiCSO9IQ==
X-Received: by 2002:a62:fb05:: with SMTP id x5-v6mr8085427pfm.210.1531503024122;
        Fri, 13 Jul 2018 10:30:24 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s12-v6sm38371547pfm.41.2018.07.13.10.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 10:30:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
Date:   Fri, 13 Jul 2018 10:30:04 -0700
Message-Id: <20180713173005.19552-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180713173005.19552-1-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on default values, configure PAD_AUD3_BB_CK to be a
GPIO explicitly. While at, it change the pad configuration to enable
a 100K pull-down (the pin is used as IRQ_TYPE_LEVEL_HIGH).

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 2941a92d40f1..0bb42c00d72b 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -221,6 +221,8 @@
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_switch>;
 
 			ports {
 				#address-cells = <1>;
@@ -426,6 +428,12 @@
 		>;
 	};
 
+	pinctrl_switch: switchgrp {
+		fsl,pins = <
+			MX51_PAD_AUD3_BB_CK__GPIO4_20		0xc5
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
-- 
2.17.1

