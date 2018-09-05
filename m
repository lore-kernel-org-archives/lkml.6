Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC8C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJi3t0BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC8C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIEXGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:06:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36764 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbeIEXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:06:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id x207-v6so6864874lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bK27RH9b6f9NUO97wMB98Bq88WFRj9LdktCy2xwE1lc=;
        b=QJi3t0BYpS0mpglEMOTzT1U+bjumGfwWVKtyAIWR6tVV66KEWjdjWxgmQzmg7lOgWC
         uTd1U3+Wuj3s1q+0qgBvEoNm1iv2LMqnCvc8dA+Hod24x0jzotR6YutI6p/P2bSXAmzs
         WTzywWYOYGo1vkoJqs2IvT21nksxttpkTy9hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bK27RH9b6f9NUO97wMB98Bq88WFRj9LdktCy2xwE1lc=;
        b=TuWCqyRFhGlaB3l4XPywrlYEGI+Cn1+JszxbHRrNL7pMwTG9wMOT4a+O0Uz11OpFDF
         B9jUQk3wEjeYYmGTX+sJF3MNys4mCjDrLGNMP/bDJCWyN6TZ7khY0RYP7acLXoZSo3bb
         xQ0w8AARZGq/cbSNMUI1Q14RaAnpDLHP6pez6G4YAw4DUIY63ohS2kTio1OvgHxpYwBd
         M3J1kwaaz+ugb60+t7eNBd6ILP+CNvKVyW7f5Kw26A4PmzlEeeRZnezk522uRBiHylKq
         GId64iL3vtwVIUflFo+M/YH/ZgsPor+YsqOf0KzcV3a8KZy8JDN2KdmS6jVWGKLDBLBF
         iNdA==
X-Gm-Message-State: APzg51AcGi/N5OR6zI++1pIjVGNM/PMzPaDg1n0DNAPDNTishU7KixKi
        w02JILB7cLFxIWJjmFwI13KY6g==
X-Google-Smtp-Source: ANB0VdaRWHQW3Zj6xOpIobrhBKyu/+7ElBhx4bs4OV0WIJnMUgqozI1m59f3Y01UbWA+agjVzj+AsA==
X-Received: by 2002:a19:73c5:: with SMTP id h66-v6mr24391530lfk.22.1536172526313;
        Wed, 05 Sep 2018 11:35:26 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id r1-v6sm433169ljr.81.2018.09.05.11.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 11:35:25 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: db820c: Add qcom,apq8096 to compatible string
Date:   Wed,  5 Sep 2018 20:35:15 +0200
Message-Id: <20180905183517.9390-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905183517.9390-1-niklas.cassel@linaro.org>
References: <20180905183517.9390-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,apq8096 to compatible string.
This compatible is defined in Documentation/devicetree/bindings/arm/qcom.txt
and is needed for e.g. drivers/cpufreq/qcom-cpufreq-kryo.c to be probed
correctly (and for drivers/cpufreq/cpufreq-dt-platdev.c to work properly).

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 230e9c8484ac..da23bdafbd33 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -17,5 +17,5 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
-	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
+	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
 };
-- 
2.17.1

