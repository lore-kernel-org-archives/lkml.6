Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A0C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2066A20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XoMH87jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2066A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeLFXcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:32:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45818 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeLFXcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:32:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so929152pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5WFZ6x2NfK4hZhzgs788kv2kC4aW2Hcvw6YMW1dFIYI=;
        b=XoMH87jBd8kvQ+fCIzEKKbz/eKQyXn8fst4fqJHfDT5i9JGdqo3lCcTInYTipZ5LcX
         RJ5DICeoKKS1N+CrMcUF48LE5t+b/sN+jBT724xVRjSdovkJlxiQMNGA33SpYt5SfYum
         wcgm+8H4uOwYe6ltaBe3h6sDqILfr/6j9O+s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5WFZ6x2NfK4hZhzgs788kv2kC4aW2Hcvw6YMW1dFIYI=;
        b=FUv4QSTco6BnuXjq7wnVM6BKbV0ly/3eLP2ghkK+2G0kHssikoPB9+rPbFRDE519RM
         yxkVLkv3WcM5hNJWtJTM42MzbwVtBvY6qSKtDCa/D45vnDJw0M1nGX7qAE2MmD7cMdRP
         Eo3odiMaDWvVJIqM4Z2kyBLtaIPLD0PieQDrJXrYm7t0A5yX3kg9xMA86M6MxtowQsWl
         eEbHzffRNdijaHt0QHcjYcVYaDT2xCEGYOPjMWx/HwRqZynlVYpFr/s+l0fXjRpAy7e2
         CPgI1/gc9gpGL3lj8etjyt+xVvmATUuB0mnyQpYKkYH7aHGs3jpqAhMx9rSksXx8US2d
         D0qw==
X-Gm-Message-State: AA+aEWbw2U3NrKll9K+X0znFfZeHAoZe2v3WG3FmITbm0hqYcyRNE/h3
        tG3gUb4AH/vHYdZYXukVlrazFg==
X-Google-Smtp-Source: AFSGD/UqWnGDGcPm1Pzvr+Wc9Fx2mn4l8Iat0l1gSmoXfEWrtVbS0cLyT9WfwQuQ9CFycsYi2EOiJg==
X-Received: by 2002:a62:6f49:: with SMTP id k70mr30305543pfc.7.1544139152832;
        Thu, 06 Dec 2018 15:32:32 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id s190sm2100875pfb.103.2018.12.06.15.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 15:32:32 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
Date:   Thu,  6 Dec 2018 15:32:04 -0800
Message-Id: <20181206233205.193244-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181206233205.193244-1-evgreen@chromium.org>
References: <20181206233205.193244-1-evgreen@chromium.org>
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

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
 - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9e4ad805d2936..e2256953dac4c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1193,10 +1193,12 @@
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

