Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54656ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E35D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KblY/6qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E35D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJ0COI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:14:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37041 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJ0COI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:14:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so896414pfi.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nso1UGGtqZnAVAiqPSjFOiMLbuNxXiI1CzmMG9sS2h8=;
        b=KblY/6qvOY93fIyaaxEOX+qfzpvLWsFF9739MUDPOsyAp5Ak0sZTG6FvW3sqK0bYZz
         kcZF0jZCRICopSHEW2PYOVgXsA2RHngtBn0tyXgPugUFGNeOdpoMqp6Ct2cIVXV6ze9u
         35EOcnA+kdYOFdCKcuEhyX+PmZh4FRcITYh8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nso1UGGtqZnAVAiqPSjFOiMLbuNxXiI1CzmMG9sS2h8=;
        b=fiJ2kROhGW876cNv5GnNlSuvQExEvK7A1C6VDFSldYqhW8V6BThh+0B6yLXgyGNFa5
         9lKqt0GqpFpTEAGQ/j6sFC8wFOht80cP9LP+qA1P1mxtAIP2Keo2ubMCFbE3OhYTjbNC
         17qSO/5t7FNw1AhTAnC/gYSMMzbk4EBtp4Ydn53UQgHLm1iSllaJmR36Q3W0Mm9GRMZG
         vgOXD1424mwopUvY4XwIZbSGcR/61BHr+Ymcbv6i9L45iJxl8n1duAvnb0mcxDDMfAxo
         sgDbqDJl90KPkRPXfVM8y+kLCcBDcGkxGQWsN2pCrm/j2oodPCqzZtSZrr+WVpw/n9jT
         N1Wg==
X-Gm-Message-State: AGRZ1gL36hO4XdLGODp9gZKoVhy4VZVoGbp9IdSMjlH9S6u/41irZYEk
        f4TfQKNEs+5rZ+syB4/1R1sOdg==
X-Google-Smtp-Source: AJdET5csAA282mpCW37K5lx03nklgm1ifgPfTup0Z5M3qocp7nOk3mOpHnXwsEuvXryItEqw6Mr8uQ==
X-Received: by 2002:a63:4658:: with SMTP id v24-v6mr4393868pgk.425.1540575374572;
        Fri, 26 Oct 2018 10:36:14 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id b29-v6sm20164448pfj.183.2018.10.26.10.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 10:36:13 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v5 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
Date:   Fri, 26 Oct 2018 10:35:44 -0700
Message-Id: <20181026173544.136037-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181026173544.136037-1-evgreen@chromium.org>
References: <20181026173544.136037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the second lane registers for the USB PHY, now that the
QMP phy bindings have been updated. This way the driver can stop
reaching beyond its register region to get at the second lane.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
 - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9c72edb678ec..ff2db36ec4fa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1188,10 +1188,12 @@
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
2.16.4

