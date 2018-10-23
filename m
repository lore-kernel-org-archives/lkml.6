Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7AC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D397204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4uPFj9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D397204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeJXDcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:32:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbeJXDcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:32:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so1056223plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YvdLCjfcxNQPFXjmHk/hA4deTnj67ZOPaaX9raZnvIs=;
        b=Y4uPFj9iAo++m+2LHJuondSEk/5glnNJy8e7JJIxpMv+blxrDhNQWc1Q/eebV2Zktw
         PnzWDnIhDkMXdMhBSOt0oQHumPbUYNj2psGM6VU/jKuQEZ3CAzsDoma/keR4YPGEHYPh
         T3PsuFVP9rTrUZyp8uVjSGZH9Oldyd0v0ldsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YvdLCjfcxNQPFXjmHk/hA4deTnj67ZOPaaX9raZnvIs=;
        b=CSB5NwERBv280/BVLhAeVWKx1XqIXr8/kk4oaxEcoos/0uILDkt/vQenLNG3nS2HaL
         BadYZF2TwCfcQSxTTIFyfT8nIPC/lw+xM7Ao0CLAaJWZHU04NbHHLaaLaltR7cp/0vf0
         0oX+aP++qf4hZA1dboZ1Iwq24JugaIyFE/FInXD9kdrjQJlSpFHWuSYjEmvBAduECsDf
         5Sdy9Q3LWQYiUR3XPzZuBoTyyLg/hd2il6ttIG5XT2NBGLfNOYTekiFj+Q6YK6r1q4h8
         Iq79Ww5/cUxRonN6cdgMPOJGKCLZ4XZuyNsTQbxs+ctBQERqvoysHtYdM2fhkvg+LyJ9
         IvCg==
X-Gm-Message-State: ABuFfohOw/oOrbBeK6R38WkPuxfbC6ZIQvpg2ETZSQEVMC99S0jFX8UN
        5AVm4KglgAizyacmygeMEZai
X-Google-Smtp-Source: ACcGV61QEscqRf2t6+L3i7OqKepkuA1tBZW0fqB/VvXKWWWGRTxsI5F0el6wmbxbbp/6PzMVNsaWUw==
X-Received: by 2002:a17:902:b198:: with SMTP id s24-v6mr47452527plr.70.1540321655912;
        Tue, 23 Oct 2018 12:07:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:744c:7bc5:17c:5f65:76c4:d542])
        by smtp.gmail.com with ESMTPSA id v189-v6sm4897075pfb.54.2018.10.23.12.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:07:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] arm64: boot: dts: hisilicon: hikey970: Enable on-board UARTs
Date:   Wed, 24 Oct 2018 00:36:54 +0530
Message-Id: <20181023190655.12004-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable on-board UARTs on HiSilicon HiKey970 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 8fdc1dfcb06c..fc851a3177e7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -17,6 +17,12 @@
 	compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
 
 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
 		serial6 = &uart6;       /* console UART */
 	};
 
@@ -31,6 +37,20 @@
 	};
 };
 
+&uart0 {
+	/* On High speed expansion header */
+	label = "HS-UART0";
+	status = "okay";
+};
+
+&uart2 {
+	/* On Low speed expansion header */
+	label = "LS-UART0";
+	status = "okay";
+};
+
 &uart6 {
+	/* On Low speed expansion header */
+	label = "LS-UART1";
 	status = "okay";
 };
-- 
2.17.1

