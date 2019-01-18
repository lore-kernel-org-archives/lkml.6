Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CCE2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IVslo9x0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfARKes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:34:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45304 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfARKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:34:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so14361129wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx5kHS4kmd+hNzvZDxwBBsz8nNk2fnwFetGiR9GhdQA=;
        b=IVslo9x0IqXExyg8jC62O3Uv52+uI2i8twr+lPmhlFgnpm4e2n8Ki21cPmGIWDDP8W
         ZzgfS+bF/Magm0/l7xxW3QEYQvwNDI8xb6ioqY0E0ZFQqfsbr9I2EAYopHycSgGJFYaH
         nBaiT2eJV9nFkHjj8rfBSqrhQwQKzZzMSJJsf+Zm42OFJyksd3AQl9zdMIPaZY4mGG/k
         k/5QbjKyC0WWgUOh3KvXhVBJmGI8owGt5dw4lh4J9GQTDR5TQK9NqSSds7uGTxMLKUWd
         3zs6T80vJH0kJ5aJmKtI+HBOQnsz0c1g7ApxBxSzjeQJGLC0loEA49A2lhuDJlyvWfUZ
         77NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx5kHS4kmd+hNzvZDxwBBsz8nNk2fnwFetGiR9GhdQA=;
        b=bUJAW6f78Lnm7BbMBkoMi4mMFR0StK0nUc9Cv1FiVx9P16gUOTEU2xg24xwvClLozM
         8MSKGN7+l8GjfF3XnvNWd+2kmqAMNy8nAeXlsP3djFvlfA/xczvOiAHkuWyK0ZGrtgVj
         bKzZb4Vpoj/fvSzyMHoHlfYBw7fwDZCz1R7qhkNO6Qkr/pNM+Ehkw/TaKBufR0oRPOh+
         Sem19YXfUp19WAf6r973uacOpI80acAZ+p2gVOjVVIUFkoyetN09w1bB+IsXnnwJ/tMX
         jtWI2hgWN1Og1oiLlTO3UFRVr8TTtsvl5U4sj4OOyC/2mWVonWVMJJJgBuoUdBBHmmA/
         /Uqw==
X-Gm-Message-State: AJcUukf1j10vt8/fYJMamDJuZJyBiAE7Cv7iWNDxafq0IzKDk7bYpSPx
        yMeIUxVMkdlfaLoIVyqwauJzwQ==
X-Google-Smtp-Source: ALg8bN4WK9cZ7OjNrnCox9XA80HNJql1WjqaFEasKqEqa7gD+Ouc90U1UEU87dwPhCvKBeCxHDXd9g==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr15671977wrq.260.1547807681752;
        Fri, 18 Jan 2019 02:34:41 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s16sm67066247wrt.77.2019.01.18.02.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 02:34:41 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 4/4] arm64: dts: meson: g12a: add clk measure support
Date:   Fri, 18 Jan 2019 11:34:23 +0100
Message-Id: <20190118103423.15075-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118103423.15075-1-jbrunet@baylibre.com>
References: <20190118103423.15075-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock measure device to the g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index bd24de947a5b..59900ddb7b43 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -193,6 +193,11 @@
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 		};
+
+		clk_msr: clock-measure@ffd18000 {
+			compatible = "amlogic,meson-g12a-clk-measure";
+			reg = <0x0 0xffd18000 0x0 0x10>;
+		};
 	};
 
 	timer {
-- 
2.20.1

