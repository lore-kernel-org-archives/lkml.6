Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FCECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6566B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFUiHg+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6566B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJYB51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:57:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35874 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeJYB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:57:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id l81-v6so2768932pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MOs1PgdS5H9q0FAb1qUHlqZCKbJVaxUDKd+GMQ+2Utc=;
        b=dFUiHg+zXsfuJrqdhhUkcNNjqw8MB5JYpyACPc0UaMX7IX6/Kx/vs7rb+ZyGGqwtfX
         2bZfY/Nf3K3cIeTtfaW+QQws8/C5V0A+Wxjzj1US+mW5hncpPxDT3eedzi6FJzFHrQ/i
         8s15RKWYIonk1j1OQo7n6if2FBvRuRwmqX7mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MOs1PgdS5H9q0FAb1qUHlqZCKbJVaxUDKd+GMQ+2Utc=;
        b=Mpbi/TbwdbDL9GnMH5Km0FyBvkjexVSxcjDNC2HNWDdiwITLuPD1SXHEJWZRARMAEP
         78n9ywN2sFFbfX65tJt5EQJ0W0h57W4LZbbWjkTTCQ7I3amO7J5HTX3aqWMYMcYJ5bA+
         aC1FdO6T3eU/ZH9NwyOPRkIpznWvHUmPHx8XAbCw9OX677sZqNOKhZ0mH8mkXBoTgDpS
         ccEeoROOGLTb42r5GTlQKvzo7Nld8kapamzfmjmJsSGXgUPIL0MRrxAicmQ8eemVMYB1
         L13noo7BjMI04KBct0K5vKgsRheu0u1p8+GNsZga3BO3axPj2TVURgp96imdnkdlJSBZ
         Nnbw==
X-Gm-Message-State: AGRZ1gJ9/q8nxRN9+SGJKYWrDmor4lU+sKFJZNQ+loTCn63i+eYK4lZT
        d1DqjtI6sYt+ePceXSYvgIKgqw==
X-Google-Smtp-Source: AJdET5ccL8QnMBqSYCCnJCbtls0EfuKj8d66Wq+/iTIUtURaKCBYwPBVBscIebMGWSo5KcJDj/ZCNQ==
X-Received: by 2002:a63:2315:: with SMTP id j21mr2057357pgj.297.1540402113061;
        Wed, 24 Oct 2018 10:28:33 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id v185-v6sm5674265pfv.48.2018.10.24.10.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 10:28:32 -0700 (PDT)
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
Subject: [PATCH v4 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
Date:   Wed, 24 Oct 2018 10:27:35 -0700
Message-Id: <20181024172735.154304-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181024172735.154304-1-evgreen@chromium.org>
References: <20181024172735.154304-1-evgreen@chromium.org>
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

