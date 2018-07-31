Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCAAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A5D20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YIGhx81P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A5D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeGaUlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:41:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36219 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbeGaUl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:41:28 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so7570261plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76XyzsmzEYZUY9NhKGrjYdT4OLrEbkvqeBkWmOp81tA=;
        b=YIGhx81P/2phOt/nHVvSBH8lAIqeUugAMCkLpm9K3wf4j+LfT6LRqfwwNupLKJbsBA
         rC+W2T94o+qqBg7P784xIAYHTthBjujhSoAOrxNCnjvcGct+oRQfs7aNTElaTFzLTuxs
         MDjb9YTzoNStgVrY63KEsC6ieAHi+QXoY0u7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76XyzsmzEYZUY9NhKGrjYdT4OLrEbkvqeBkWmOp81tA=;
        b=ftpb8P4QIkrE/eqW9VDOAZp/0l7Jj6IpmqsYFF5trm3H19ERhrSpNAKJojf7n/TnU4
         2dT/hQvNoDEN3HLoxUVFPwOEVV6ZO4iaQPohTawq/skyuNrdAvPtkIL29mJHr0DSoJci
         XASeWlNRALJ3O8AlqwYZyu89aoPbdWMbyeRMLBjoSg6bQkUHExYidM1LuAyqJ11GKQdo
         1OxjeBBVQiIeSpmTsd13WObxTsWF3XzG+f/jS2dIgJeN6jpuhX5ZHQmloR8vGHgVrC9s
         FoVX/lY7LWqV152dWYvC6C3YViqoHvdR445uvow+K36ndK9Q+HMcOXWq9ARNGaDCu8Td
         sB/w==
X-Gm-Message-State: AOUpUlElR9+R6ji1GK6qUiunBNktHMNLdL89XpHLILhiZjSrd28xN+Bi
        52KPdRPpB5XsFe0+hYRFouNyFg==
X-Google-Smtp-Source: AAOMgpe/BvLtSVL6R09niZyDsp8FYv0+oMpussKWmcqvWK5kzxLt2peegWCQ9ISqpC4uTB7D3gb5sA==
X-Received: by 2002:a17:902:4203:: with SMTP id g3-v6mr14187523pld.30.1533063587830;
        Tue, 31 Jul 2018 11:59:47 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id e132-v6sm27797567pfc.49.2018.07.31.11.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:59:47 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 4/5] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date:   Tue, 31 Jul 2018 11:59:16 -0700
Message-Id: <20180731185917.176074-4-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731185917.176074-1-mka@chromium.org>
References: <20180731185917.176074-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- none

Changes in v5:
- added tag 'Reviewed-by: Douglas Anderson <dianders@chromium.org>'

Changes in v4:
- none

Changes in v3:
- changed node name from 'qcom,temp-alarm@2400' to 'temp-alarm@2400'
- removed controller register length value from 'reg'

Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..7eea94701b23 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -11,6 +11,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0.345.g5c9ce644c3-goog

