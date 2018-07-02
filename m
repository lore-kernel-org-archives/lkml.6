Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8B1C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B857124993
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBzC830o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B857124993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeGBMp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:45:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44491 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeGBMpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:45:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so7471929pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=I/Cu+imGJLbvwzue17C4MFRuKRC0pB6hIVYE9HwvMj0=;
        b=kBzC830oj0qVC2xX3J/qCCnpjKYz5m/boYyHTlcwF+sOgnTwLztXfOsiqE/OroEto6
         fI6vPzQeagWSuNOP90KRPZdZBw4QS+CBFZERNpdg+AExGZSTlcUDc+U8esnuHSnBuAgD
         V1IFIMdiKZzZrh1zx88+WSGXOu0sxAcMjagGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=I/Cu+imGJLbvwzue17C4MFRuKRC0pB6hIVYE9HwvMj0=;
        b=OSi9W3quRSaX3HJrqf27kzxi/icHxq3y/eRpiZ/ouegathClUQURwqViMotL/ecBbV
         h92ibBwt9OyfBcBQ+/Z+kk6dza3+J9KIcOgt3JQR9dJyDpwcYWqfb6W+8kYHJNtR43nh
         LhcnvXKrYzKCoVN8ruXjCjR9kDqmprDS21IP4bM480X9WtBf8vsQEjEIwpdvUsShw0WN
         59Sefa1Im+OYAj7MK8kWvz4YA0Z/6ItkqZ6ELKNC626PgZnBPW+Q9QKZv3YSQHbwGmi/
         GYiSvFLfPThWwWeCcxGfrEjccJlCJnUtwX10c6eJE0ubmYuC3/TlKbCPmeJQi37YIgDk
         6PLg==
X-Gm-Message-State: APt69E3rjHGxWAZU9HGiiYAuAh6bzxLRDaaeoGwGuv478ty9emqMw0pB
        lOBzBDJ9Wj7DomfhyCZJTyUyWX5VXYM=
X-Google-Smtp-Source: AAOMgpfjVqzBDbhRarqqscx3rQdsTOnjfZ7nScX/BqCT9npkatcronX2LglUpScUuK0hxRWyO1UfaA==
X-Received: by 2002:a62:d544:: with SMTP id d65-v6mr4700264pfg.107.1530535505155;
        Mon, 02 Jul 2018 05:45:05 -0700 (PDT)
Received: from localhost ([49.248.63.129])
        by smtp.gmail.com with ESMTPSA id n5-v6sm31790071pgd.7.2018.07.02.05.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:45:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
Date:   Mon,  2 Jul 2018 18:14:09 +0530
Message-Id: <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has two tsens blocks, one with 13 sensors and the other with 8
sensors.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb..edf8505 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		tsens0: tsens@c222000 {
+			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
+			reg = <0xc263000 0x1ff>, /* TM */
+			      <0xc222000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: tsens@c223000 {
+			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
+			reg = <0xc265000 0x1ff>, /* TM */
+			      <0xc223000 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.7.4

