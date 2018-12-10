Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35634C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54A12081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VCpnFlH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54A12081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeLJT3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:29:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33773 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbeLJT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:29:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so5435323pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDpKJVPFIVctgingBaL+8pLspjfVJhTZ7MqaisuyuDE=;
        b=VCpnFlH4C1CnLladVa5VvpEjml578hiMborkF683xWusR3xapzDb3OUfI4s+DowuNH
         OIYq+YvWPMAhB2TaBFiJBrXoMyRadgDLGRsPGryBo1cDN2kZarzCN15Bqw1gXCzpk7w7
         LoI/XwWqbkPSNhn9JlJ2zogiOY4r4f9gB/lMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDpKJVPFIVctgingBaL+8pLspjfVJhTZ7MqaisuyuDE=;
        b=dNponEu1YSVO67iT3CwIuIkUXrTT2hoPohTqszLhGOOysZXykU3FJpPTUrrnN2nciU
         SqUPaRJ0MvFApsa/+YkZFRnUTCOLUR0vpb7F3zbnee3C0zl11UbSkL2WyB/9OQK7C811
         kEyNFg8xo7RugXgNgy2xxTC7pOt8AJ3irlZ+ozPcYiUxMZyOrsaPs3jPSMjjqiW2w3Kw
         Wb50PK0WLNVOYrjCJEXNkRCiZCQs7/SBJZ3tzk4FEKhuZf1e1Cso7ymtVcDYxLNHHMPb
         nVX0RixyvC8yedwqfRpVov/LwSJb86W2SMx01BppRGuduEstIGb0X8cjXhs5vQzs8KgI
         U6oQ==
X-Gm-Message-State: AA+aEWa+05DcOy+K8Jq9nH32QFQ3a4qGJRZScftwQ2HXPE4tISgpjIAJ
        RnZibOZGaVmAcxw5QzVLTdrSrg==
X-Google-Smtp-Source: AFSGD/XHItHnkkv7vn+uPeHL/fQZ3QWixmY7XvJEavjxJ3AeNmTj1OatAtJZuR1/x0Ds0YoC2dOcAA==
X-Received: by 2002:a62:1c06:: with SMTP id c6mr13224519pfc.157.1544470141072;
        Mon, 10 Dec 2018 11:29:01 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v12sm18318674pgg.41.2018.12.10.11.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:29:00 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v7 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
Date:   Mon, 10 Dec 2018 11:28:26 -0800
Message-Id: <20181210192826.241350-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210192826.241350-1-evgreen@chromium.org>
References: <20181210192826.241350-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the second lane registers for the USB PHY, now that the
QMP phy bindings have been updated. This way the driver can stop
reaching beyond its register region to get at the second lane.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v7:
 - Rebased on top of phy/next

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
 - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 4ad4eaf1d61ce..dcc362b6cf04d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1185,10 +1185,12 @@
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: lane@88e9200 {
+			usb_1_ssphy: lanes@88e9200 {
 				reg = <0x88e9200 0x128>,
 				      <0x88e9400 0x200>,
 				      <0x88e9c00 0x218>,
+				      <0x88e9600 0x128>,
+				      <0x88e9800 0x200>,
 				      <0x88e9a00 0x100>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-- 
2.18.1

