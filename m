Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D518C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3143A20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsxYutOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3143A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeK3JVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:21:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40984 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeK3JVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:21:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so1720736plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhUoWU/XFNYmICnRP1niIU3h9D8sxQXM+8ndQH93DLM=;
        b=jsxYutOGqIVn1t6ZlnX0/EhX98SOvWOoUD+mYKWItjt0p3eZhdftzw/oUTaJHxVIkm
         uSVf4ncqMNBy3QPA3WVmuT55vj8qhqmZ7fd1CCDjPMk1bTbeD4i3POyzY7OXdt8J6yHz
         1lg2I20qhM69shQa1HkzNZUxSS5AP1BAztl48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhUoWU/XFNYmICnRP1niIU3h9D8sxQXM+8ndQH93DLM=;
        b=SESndRTsNnR6CdGbUBp493WoCxuy5kSOgmxZIh7RUsbZGdxqT/biI7/dBIwOMnEkzG
         kU5sziRYkBZpXo1cBlAeoTY4yiCxt3BntafOmgkRP3CRuz0btBqpgsBLRv7lqMrRoUCj
         BAJ4Qt54gb/Fdo79Lvylq6EyicPtXRcURknwIG6XfaG/uhMZwTmof4gj4fBb/wMj7TIh
         ExJikDj7q7XAlxd7O1UgfbL/ruCu+Aw6nENXkgkxLeUDDhG0UQwH+aYqogc9MHZBZPlm
         W2QlxsUXYEi+LHkZx4+IimX78Xs2nQ2qCu41mvcmZ09Fn+pFzJBK4OiV6FeNW/qFf1+b
         6rAA==
X-Gm-Message-State: AA+aEWZ0r5o8QYRUu6MXwypXmYJrP6Gq7BwSivEeZbE703kfwcxsV6Mp
        EUHuOgVyATBKW8CsMCOLkzSvBg==
X-Google-Smtp-Source: AFSGD/WvdpO4CB5Cw1snzQetslyciXfl7J5bCEbqgbfI4I+zdo6E/gAEaX+nzjZOzbOePQmwL+prxw==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr3185964plq.77.1543529682809;
        Thu, 29 Nov 2018 14:14:42 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id c67sm4697690pfg.170.2018.11.29.14.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 14:14:42 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v1 2/4] arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
Date:   Thu, 29 Nov 2018 14:13:55 -0800
Message-Id: <20181129221357.67417-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181129221357.67417-1-evgreen@chromium.org>
References: <20181129221357.67417-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move #clock-cells into the child node and set it to 0 to conform to the
proper binding specification.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 13bb96444df00..4af740ca0880f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -767,7 +767,6 @@
 		phy@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
 			reg = <0x34000 0x488>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -790,6 +789,7 @@
 				reg = <0x035000 0x130>,
 					<0x035200 0x200>,
 					<0x035400 0x1dc>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_0_pipe_clk_src";
@@ -803,6 +803,7 @@
 				reg = <0x036000 0x130>,
 					<0x036200 0x200>,
 					<0x036400 0x1dc>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_1_pipe_clk_src";
@@ -816,6 +817,7 @@
 				reg = <0x037000 0x130>,
 					<0x037200 0x200>,
 					<0x037400 0x1dc>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_2_pipe_clk_src";
@@ -829,7 +831,6 @@
 		phy@7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
 			reg = <0x7410000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -851,6 +852,7 @@
 				reg = <0x7410200 0x200>,
 					<0x7410400 0x130>,
 					<0x7410600 0x1a8>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "usb3_phy_pipe_clk_src";
-- 
2.18.1

