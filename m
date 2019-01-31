Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC1CC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD24C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igbR74Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfAaUnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:43:52 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:42067 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfAaUnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:43:49 -0500
Received: by mail-pf1-f182.google.com with SMTP id 64so2012943pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
        b=igbR74Ll36k9hJapneY4x8GEdbfRiQz/SgNPlTPin0BM8B4KPeU4+5li02utMqkIu3
         oSkp2ATgj25O0CLjNf2GQDCQw/DCi+yrM2PlzvmLLqKrdA3V/zDAh0X6Lu2frXTwTcgD
         JyLsk551YXDfuQt3aPYps5AVL2djnE92JJIjLzGKfEXBiqstz3tTs4NADRMj813iGw6z
         AZ6WRZaM05x7RndUrQFugB5db7qjSD9KvJn+fvJ7KJsOezBWWZqSX75AgEA+qmq4cuqu
         k1mkL29AKryUdjT6X7evFF2jFjy7ddkTdMT3gSEwI5ewxJvQToOhkPhGiCUSmftuuzc9
         fOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
        b=sqPGvSXWJ5Hi2DGL9As9/lpDOM943EjFPf1/C4g5BU8554uWinL+Cn32VXsP5xhDld
         v15LCcDtzqLqkswe43RNNZrmJxECuHo88ELa5sR773n4GPQsQ1lDu/PbxQVuFDqVAGMT
         NOa53TXp+vhw051ewfjaHh4McOFLfW9LLrjl4/j8PYpxjbFF6oCmKaGo8zF9E4wKtlzR
         FXr+In9wZg3zEwmnrTXw/uWFllz1ouYD6qWbdZxZ8iHB44vdVpqVKCA1MmCh1IC+OML+
         4LCBvUO6LQhcv4TxltH8L96W+tvfR1/iahwQmXUEj3kFKZfK/+HUitNdWWGyIDGfbCzY
         Eq0A==
X-Gm-Message-State: AJcUukfxif/og4zQFBPBi6oFMtbifcTTgXiMRUDxx3X0EIEaX3x3Lefn
        iH3It4yhIJkTEK+bJMF2o1E=
X-Google-Smtp-Source: ALg8bN5MsescGrlFVDgGDTpMCby83jwkb6jQgJzD2FiRB92MrDd89QABo9XsUhx3Eg/LLfPcQVuO5A==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr32576932pgr.432.1548967428444;
        Thu, 31 Jan 2019 12:43:48 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:43:47 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
Date:   Thu, 31 Jan 2019 12:43:29 -0800
Message-Id: <20190131204333.31846-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..f6c37bf9cbce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -230,7 +230,7 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.20.1

