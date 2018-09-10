Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C5CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D58B20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfzyQZzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D58B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeIJMKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:10:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36750 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeIJMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:10:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so15694441edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=m410Ab5qIJFOWRYS/T4hMUHADOSTQIVxdyFktr4G/B4=;
        b=DfzyQZzPxxM4StAHDaFqMuV0KTAQRrY05MBPzXr9Xkru9zcUO/teWEJEmM6bSGVzGt
         +1yjjwUZrBTw+fc0ltdVtLSRqImjpZmnPJsSXMROPBu+fQcMx6ND7raczA6wNBqoJmYv
         f98lw/G2GYF9hzVyb+EvcPNraA5dnMnP3s+VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=m410Ab5qIJFOWRYS/T4hMUHADOSTQIVxdyFktr4G/B4=;
        b=VjLseVpTwjhSD8NwEaMiqyWWO9caMZ4MRX6nd8rehGhDeHVvvXXwZfOan2C1lHk5N0
         kiTA+jfdWmC5yk69rPjuaGL52shN1UEw/vVqKVeBEf1Bs674CG9HM5A5Q+QIh0YV1vuT
         d+JohNEgRaWURyzIjFqtCxb3HGxUc4Ccb378BCsoohl5zOmJsCgaCCcc6NvMump1BGvs
         dIw6E91XrCDjhBQi70X2T3kUMF9eRcVzUcv7SmfJCK9jey6IKjaVUtQbqWVu69uZDWfA
         aBbhxipjrpEjJquagEbjgS2SKsVrYenrgKzgZw4BzmVW4D5Mxp8gzTGwsMr3RBeSKARj
         VeTQ==
X-Gm-Message-State: APzg51AkPtiXN7MgADcnaotVcbdnO2csWXtv1Zat1j1eyHZ4UMkYRdGC
        HGlgOx2dFS61/XV7PF9tgXoLFI2KIGE=
X-Google-Smtp-Source: ANB0Vda2DacjWjp6PAbN7NCGCEoQ5H1JO1O0MDiTHHEI0PKaMZB2EB/TgAiUcddswI+QwofXvDKGrA==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr22055397edp.7.1536563854872;
        Mon, 10 Sep 2018 00:17:34 -0700 (PDT)
Received: from localhost ([49.248.190.103])
        by smtp.gmail.com with ESMTPSA id z56-v6sm16184530edz.54.2018.09.10.00.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 00:17:34 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: msm8916: Add camera thermal zone
Date:   Mon, 10 Sep 2018 12:47:15 +0530
Message-Id: <2eb1d8aeef707b3a49de273a14bc9910e29ae013.1536563656.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536563656.git.amit.kucheria@linaro.org>
References: <cover.1536563656.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536563656.git.amit.kucheria@linaro.org>
References: <cover.1536563656.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the camera thermal zone to export temperature to userspace.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index a494196a657e..d1cfda35b0cb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -257,6 +257,27 @@
 			};
 		};
 
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				cam_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cam_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+		};
+
 	};
 
 	cpu_opp_table: cpu_opp_table {
-- 
2.17.1

