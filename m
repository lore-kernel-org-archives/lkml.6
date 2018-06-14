Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BB800C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6962C208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApXqCx3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6962C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeFNVzX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:55:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52011 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964896AbeFNVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:55:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so418819wmc.1;
        Thu, 14 Jun 2018 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B+9hJIOntoopMRMlewah1xuD/HbzMQXRpd4Wq4AxtJA=;
        b=ApXqCx3/xeOEtSIDGDH5pL+lA642fQnpbD8m6rs+d9Af7+aIG6zb9J2o4sGNR/6UyW
         EulmLR5PUnQ9Cx7x0MYmaWBQC8RG1AYOYbB17vmfbmAXL9j7aQDjDUJhYAYYhI+gmCea
         wAn21IDDrSG8kRi8a2wpXT5rtSd3jX9YwBTSdE1nphtqdJvuccxrl709gRRcS82p7oTf
         E41xtiZJAqFg0InZLdk/b/1oCZkxeINLsDK0IdDhgFQqA+Ej0KuStkOauPKJOvKzZ/zY
         FAMVV0Igi0QU7sl1WYEtUgEHK0cI25pyKkRKFUBz8IoN/C+KdrdzgbtB0eUBa5wGhszL
         HmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B+9hJIOntoopMRMlewah1xuD/HbzMQXRpd4Wq4AxtJA=;
        b=GKKKDOErPBwRVCLDYfvAQxLCXQl4+IesmebweviHlyC1/XkA08V+0umYJjfzeAavOa
         aMg0ddjhIdIr6u52uqaCHkwNOaGur8M0q06fwQ9zSL3tJStca9Ts2u47GYLw0t2TVlYR
         nOcHKbWgZXQowerDSOj+auckfCmfsO/L877rvjpCmx9JEUnJPhp/dLb6b2bTdG038OV1
         hcdkNKwjJaSkPn0K7Cdr/m6Sz1pxANZX/E9wv2PWxa6Rk7Skmx6+cplMsnf6SHEVbdbz
         Hx2FTmaQtr4nW7V8vMa6qBuDKSPbAjbggstJOJkL3OiHxubWMUrbuIcy0Z1S2YJolUB0
         cOpQ==
X-Gm-Message-State: APt69E3TaDPdYKpktFnGvXXeCrLxUWMB25zQZch5IQYCAvYP7rXrzeg5
        mUY3NjV274+HpD0syKIVBzM=
X-Google-Smtp-Source: ADUXVKJwU0RKgZE+RLThqLpgRIrshLVz9S2waXeCUmRWeIIMXXgD8/EVXL9mo1emDMM0QRqFW6rfEg==
X-Received: by 2002:a1c:4252:: with SMTP id p79-v6mr3047455wma.119.1529013315380;
        Thu, 14 Jun 2018 14:55:15 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id i76-v6sm285367wmd.20.2018.06.14.14.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:55:14 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 2/8] clk: qcom: Make clk_alpha_pll_configure available to modules
Date:   Thu, 14 Jun 2018 23:53:49 +0200
Message-Id: <20180614215358.11264-3-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614215358.11264-1-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Allow clk_alpha_pll_configure to be called from loadable
kernel modules.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 3c49a60072f1..a43f80ac94a4 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -228,6 +228,7 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 	if (pll->flags & SUPPORTS_FSM_MODE)
 		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
 }
+EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
 
 static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
 {
-- 
2.11.0

