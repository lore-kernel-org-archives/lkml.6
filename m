Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D28620675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="et20Z1Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbeLQJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38586 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbeLQJq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so11530919wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=frYLNG9WBBqiLZuXMzbyk9zPbudi5BcqFSN9a29J878=;
        b=et20Z1Nvhy4cU7BaSDu0Rr0o8eprDB52wxTtNTCZZIeVJB+REqsCz5LohKL6+c4bHc
         BBu8BsOZf02tVrTWV/4iNqxH5Xrryxvc8gCF4HXIhoB0FggKGUUPonfUccV/BjaAqgJ8
         V3bJfXiHcaCkhPVmE/5R33wu/PxiebX04HaEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=frYLNG9WBBqiLZuXMzbyk9zPbudi5BcqFSN9a29J878=;
        b=fKQkhqM4ILBShFWpf/MTYW75CNCyaCCojRD6rWip9zR4bh3gncjadeuU9AvfoCMCiI
         bKxmkv7MRYOOReqicvthq0VO4AllRk3XtJPOwbrVoHlGntADJOJmdff1aX0E2zp2HdGg
         TlrJgkKqvvV20cJhSrXfCbNJU1wHZP3zm/inourQUa4PFyR2twN1qpWLNMUrqMfnkyYV
         ISGtX/sF/x8CKVU9p6n+NilWOblEIHGxgH82wGBFNsKiwTZxmjZM7i4wI34l0F999SjB
         DqhgCyKa7OPa5UtMWvZrroO71bEs5x0lLZ0KT9BfmKS3p++AL90fx/h3kj+P/++xXQuL
         z8Jg==
X-Gm-Message-State: AA+aEWbqs+3fS0SJ0DxNJ2D8i/c8Y9rZojUAlfsgU2nTaVVBlC69Tf6o
        0nm0taQNOYkLVPCyuQzlatbznQ==
X-Google-Smtp-Source: AFSGD/Wm89lY5AWabPhjL97+zfhBn8ec4Izasd9Vo+Ys9CWY1kITyl9TwTkkjUL9dy/zq4p2/3eK4w==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr10609352wrq.182.1545040015164;
        Mon, 17 Dec 2018 01:46:55 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:54 -0800 (PST)
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
Subject: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
Date:   Mon, 17 Dec 2018 10:46:27 +0100
Message-Id: <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll functionality is required to enable CPU
frequency scaling operation.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 4594fea7..ec3f6c7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -375,6 +375,15 @@
 			#mbox-cells = <1>;
 		};
 
+		apcs_hfpll: clock-controller@0b016000 {
+			compatible = "qcom,hfpll";
+			reg = <0x0b016000 0x30>;
+			#clock-cells = <0>;
+			clock-output-names = "apcs_hfpll";
+			clocks = <&xo_board>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4

