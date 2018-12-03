Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE2DC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E772087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CdtOUgRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E772087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLCKQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLCKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so11509528wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O05pEMsjPvSm8OsI4DmhPRSk9+B31/RzfWZxO3ZP0hs=;
        b=CdtOUgRd7fKTLnNnApGPpwX5/e1tQjDrTcncF5Me4HkjmwfnmkhMlrZz1HqvJjLXT/
         sEKv6G9X5uUdL8V81quIJdVbM+WUzBKgHM2fX36kdItiuq3OjQSXyS/ZIa/MhVCGCYmw
         TRFqlCEAcpVWwiiaFbpcWaf9KYTT3yQtsdKXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O05pEMsjPvSm8OsI4DmhPRSk9+B31/RzfWZxO3ZP0hs=;
        b=ILfBtJA56VLRMDwtmUVTOGaOh2sHQ2H+yrGeeIJ+S9rsz2i1FVwVgwZVMztECHkU31
         Daw73uhoRr86eg+SAUS7hvlAF1c+xtG7rDobglkueTxW6Ti/M/TeCRj7Up6Lty98eY0o
         gcFdPlW5lOYxtSOSMdrz/8RT0IWbERw1uh/sksCCsFNGeEeNPyzxg66splRiQTbXwldy
         TQl0M9UlUP0lXlUeCKT4fJFnLwYWkJJsdeMa3lBOX0U8qj39mosMMDplVw5cKh6IFfAI
         PrwOYPkLiIPY7Hbn4t7NDU0AtpUHJ8sj+q3TGV9ix/AEqBqQxVWPZ3qq1v6CumccLImp
         PGhA==
X-Gm-Message-State: AA+aEWbYOQVY12Rvwpcm4YP2JA6FuXrtKBvoilhzN692VO2/agzn8uPW
        69yntoFjdTH8GfBfU3imeKfjcg==
X-Google-Smtp-Source: AFSGD/Uxa3NMQLBGsOsZ0LU5sErOBIuU/IbCycZtoat/FVE7R+MSb+HMM6jhcqw7T7YHjI2wwMe62A==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr12893016wrc.0.1543832158090;
        Mon, 03 Dec 2018 02:15:58 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:15:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/9] arm64: allwinner: dts: axp803: Add GPIO DT node
Date:   Mon,  3 Dec 2018 15:45:41 +0530
Message-Id: <20181203101547.16835-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO/pinctrl node for AXP803 PMIC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..c6b95980d476 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,13 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp_gpio: axp-gpio {
+		compatible = "x-powers,axp803-gpio",
+			     "x-powers,axp813-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.18.0.321.gffc6fa0e3

