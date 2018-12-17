Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141AF20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="djAqVDeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbeLQJrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50272 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbeLQJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so11665426wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kTA3U9ScqlvZ998ocosntNRdd+QbUhit3GNzARqwjzg=;
        b=djAqVDeH7UHgLmI/fEsam8Ncl44t1Emw5MTX1v5R5vyJdCn07rwL9uuPBLz+HB6Wqg
         qxG6HOhDt7GadmSwpB2vkA9Js6rjuMHApzlPoEUr6bvbLhYSM87tUx6EX4uqJZEbwr6D
         RW6V68mmJyEp0GDqut9HT34xRxetOCvR/G6eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kTA3U9ScqlvZ998ocosntNRdd+QbUhit3GNzARqwjzg=;
        b=k/CemJbaGdKeBSVXNBUuvjsXSxL5VrZZJWqYlwrnxQ+bnGXqscRKEr6AKkxhwNN2ou
         hC+jzSX6Wx9HcTySE+RJP0/McXPNR+YfbvoDioHEv4n8fuf0VBhVsRDMpI1//NnpsK3v
         resEJMPgBLq8qEuJQu1YNxE1X+Cccxej6aa2zVTTaiyVr1Wp8UpP0V8hH9jmOLFtHlKZ
         kanMqzqhnJJL7/+FhcJxRBQkdzsxAFNz/8yHJSsba9K3Tk7N8NnUvVXUxrzcNJA87qV2
         wt2vnqRTAej30VL7xH0AyeTgBOh8FB7E8QrgODsyz2ZGTVSDBBK89nI2qswHg18x1kFu
         asyg==
X-Gm-Message-State: AA+aEWZKJumJC63HXoACKRPTyQrw6YXD7LrseVPwlEiDWEFg+wVEACKs
        KxuU7XMTKzJYEncxRyXVvfzqaw==
X-Google-Smtp-Source: AFSGD/V4BGQMKM78e8WXM5uLM1kGzoHYfpgHOemT72KntElTnAau5TXeSCLqPSjtmv+oX5csPxZ9WQ==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr11715639wme.114.1545040017092;
        Mon, 17 Dec 2018 01:46:57 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:56 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 11/13] arm64: dts: qcom: qcs404: Add the clocks for APCS mux/divider
Date:   Mon, 17 Dec 2018 10:46:28 +0100
Message-Id: <1545039990-19984-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ec3f6c7..2d9e70e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -373,6 +373,9 @@
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
+			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+			clock-names = "aux", "pll";
+			#clock-cells = <0>;
 		};
 
 		apcs_hfpll: clock-controller@0b016000 {
-- 
2.7.4

