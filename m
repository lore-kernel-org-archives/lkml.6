Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BA7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B763B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QRyCQAUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B763B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbeKPKxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:53:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35193 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeKPKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:53:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so10518415pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 16:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XcTIPEPcy/kt5NEIDiSbTDj0WEZaK94xvCDei0fo8w=;
        b=QRyCQAUBkWd4jMcP2rAe+mg/iCCiiDKcdvgSiduCXZM/6Jy6tnHn1WpabNWaYvOSwH
         GP5MDqE6XtR1oGHNt/B+UTpb1dWjD3SPtDX9/GxWfS7ThwVTZUmTIJYZ84Ow93aq+1Sj
         WZOemveCgrPElxbbxIjNxyllj+W8Lzn/2LkYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XcTIPEPcy/kt5NEIDiSbTDj0WEZaK94xvCDei0fo8w=;
        b=VzusB0vR2JQ8gIHSD+4Y+s+nbrOi3WnB5Q1uJB0rpAKz17ZqzGKmXE2XVXBtgrr9bm
         oNSaf6TiyPdo74phut/HUq+nlYuaTjd+rhvbaIYhLfgDRaXAA3K0gOh1qDM3RmSmr41P
         sKOlDpVpazImlow6l/iKptdYWnuEB2kL4vipK4/DWOjbFMS4YdUbrIZcC1URA5FJ2P4+
         eZHHXaAs5kjBwJOYJZW/CbRx4YL53rS2S+tmiwyVlD+9stFOXDOSfTt94iyLtHbSVJz6
         CXXJ3OjqXc8tKYO/vGckoXrUByDb+eDSkPJdymus/SA4tf0XFL2/yQ97eafNYpOlYjDd
         8b7g==
X-Gm-Message-State: AGRZ1gJidzYqNCTE7UbxzxAWG0d45xw+5WkEDge7y9GXnYsk3pXVlWh4
        mVZQCed7h8OLOTArQc8+lRaAV4nX9Kk=
X-Google-Smtp-Source: AJdET5cWU4ZqKVXBAMPnnzn/+2fW3UF1TllL+sdfxgmP1Dq3um6CgTn+9aCukJmqLNVFXwN/bsr+SA==
X-Received: by 2002:a63:e615:: with SMTP id g21mr8054129pgh.290.1542328972402;
        Thu, 15 Nov 2018 16:42:52 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id a10sm11902945pfi.138.2018.11.15.16.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 16:42:51 -0800 (PST)
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
Date:   Thu, 15 Nov 2018 16:42:47 -0800
Message-Id: <20181116004247.172977-1-dbasehore@chromium.org>
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
index 99e7f65c1779..6a32293982d0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -191,6 +191,13 @@
 		#clock-cells = <0>;
 	};
 
+	xin32k: xin32k {
+		compatible = "fixed-clock";
+		clock-frequency = <32000>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+
 	amba {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.19.1.1215.g8438c0b245-goog

