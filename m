Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DD7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8102145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6wKYd4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8102145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeKPP2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:28:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35185 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeKPP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:28:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so10073123pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 21:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKCQ2LhOod7auS2N0/OhpTf2BbiplFOUaBzThPWZZTs=;
        b=a6wKYd4KRW/5de7Keh6DS2Z2cHLNxAolPnAa6mDxK5lP5j9MDCcu6vn3aj97lW3hP1
         tkykFwDbJw1aTJVAFrTm/plny9xrQRURTKdFtQs1UMuUMIqszFhd+dLkeGv4Lqmn7JUa
         SOL9iYp5K/DeWZXWLGOq3m3wtu4YodU2S5h+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKCQ2LhOod7auS2N0/OhpTf2BbiplFOUaBzThPWZZTs=;
        b=IZIVZqNXrSe7B0pZqtgb73NNGpLAa2lCVqvg1q7luQza5bflyBsJyqi6jECqXNpqEg
         HhbI2r85LueQlDLjc1Eh2nD7a8ObQ5SSQoD6dZcwNnh0LXx9lH2cPMtW5nrPNbh91OwB
         EITGcbWyhez5uG3vh6LESapY+VEsyBCZiB1PmwG8N/C/NSjwkMHL/Kk9QMF4z54/ukKh
         TDZtxUfqE6jzl6/zDS8yBVetkBgXB7YW8rRO1hsVrBo50sAiOm6e/k5ULq/yak2N4StM
         SRrxjTIx4VHnq3Ljwk83ZjN4lxIjzdQH1GW7jz5xHbJWq6xmVok59+7HY8OwYyZ7f871
         8WTA==
X-Gm-Message-State: AGRZ1gK46JzIPH/mOlOqNDIDYOiHJfoIvLmeqLxPsCPs2IMzjzFskRH0
        Ak4P5iIIrMuarCmnh2AVhYBeRY9vmX8=
X-Google-Smtp-Source: AJdET5cbw1MjNC1CG1QMl7+LpB7RgbSJNeGt6R4MSB1+MkyvBoZZNDIDFFAnt2vJo8J7j0QhdnEt8w==
X-Received: by 2002:a62:2a04:: with SMTP id q4-v6mr9452670pfq.61.1542345444360;
        Thu, 15 Nov 2018 21:17:24 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id k129sm34511106pgk.29.2018.11.15.21.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 21:17:23 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        tony.xie@rock-chips.com, zyw@rock-chips.com, ayaka@soulik.info,
        nickey.yang@rock-chips.com, zhengsq@rock-chips.com,
        klaus.goger@theobroma-systems.com, dianders@chromium.org,
        briannorris@chromium.org, enric.balletbo@collabora.com,
        heiko@sntech.de, mark.rutland@arm.com, robh+dt@kernel.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
Date:   Thu, 15 Nov 2018 21:17:19 -0800
Message-Id: <20181116051719.23376-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the xin32k clock to the RK3399 CPU. Even though it's not
directly used, muxes will end up traversing the entire clk tree on
calls to determine_rate if it doesn't exist.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 99e7f65c1779..3d09472978f8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -191,6 +191,13 @@
 		#clock-cells = <0>;
 	};
 
+	ap_rtc_clk: ap-rtc-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+
 	amba {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.19.1.1215.g8438c0b245-goog

