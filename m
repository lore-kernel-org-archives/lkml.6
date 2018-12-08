Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C85C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AAD2081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hR2o5iC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AAD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeLHRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:02:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33159 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLHRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:02:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so3453616wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
        b=hR2o5iC4aEhsnkIzPj4OIYjU9LTPsVxuLVQpifnK1slHocCHFkPJoQYyhmDXiJN/WO
         DDUCxy4uwTWPTq0Pif7GpdgFp9IvhS5tdKk4aBvyet7YuRVtnxpgA0c1ZLk2R6Wk4Drx
         eU2iuOUnSXw/jy29fLH6NNdWO3VLMTJ2dbODs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
        b=kHi+k4EUNeWtBTaennxpH9PGvXXrkaSCzIo9tfCYywVSIWPv1STDyanpesnZEGxf2E
         NdhmW+zXDqL1EK1DX1/gPw6NygM1+wn0P8urd7guYaeK6gCNOykCcPkHinEkJoM2fvBN
         1IOgPwyOX7wjvQFwVjYXvAN8815Zc4yN8Cy2z3fuSIPWClwBej/uPntg/oLmzePOs7TE
         Kwars22Ptu8RjHxDDJWTBShLbTGWakLtw4y/yg1NPAHqtyd6+Mlm3kGIZ/I6S2BwI//6
         rgW/a4dzTOuaxMoPHr4PiotwsOBg18JucR65yh851IC67uWbr9ZikBUhlqmi8hL/aq8u
         OkSg==
X-Gm-Message-State: AA+aEWYGVPLgcKeqAM0VuA6FP4tmbXIA/v/WrxzbP1fM/fy7mQebSUWb
        2tmN28UTIEzbGP5tSOY8Xi3/GQ==
X-Google-Smtp-Source: AFSGD/Xgi4xzic6oIrnwzfikvQQ+V4lq3KezNAbwgIju8yUtz8ERmC+RGnmrE9j5WWRhZVmJ59cqnw==
X-Received: by 2002:a1c:9803:: with SMTP id a3mr5822200wme.69.1544288552242;
        Sat, 08 Dec 2018 09:02:32 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Dec 2018 09:02:31 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
        arnd@arndb.de, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v12 6/7] arm64: dts: sdm845: Add interconnect provider DT nodes
Date:   Sat,  8 Dec 2018 19:02:15 +0200
Message-Id: <20181208170216.32555-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add RSC (Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..b3cd256a154e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1324,6 +1324,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rsc_hlos: interconnect {
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
