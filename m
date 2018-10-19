Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE1ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E3F214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCj+8VG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E3F214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJSS7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:59:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42224 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJSS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:59:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so16315716pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IZj3v1SW4CS/dfK2+z6yc+Dtbx1/tbGykpj1YfOFLRk=;
        b=jCj+8VG6l9AH69XTMJY6zE7PAKm5zlf0reQKiCaZ1hl8Kp4Sl3zhyQsCny4/2NKwsF
         59hmweq5vwTIziFMfW91uNvtuCab873/lRepjzYeUa/pntNEwmTl9/tikYDXei/M7t7L
         NFyFyVlnShPTMsEZ2j0W/ySwz+0OT558UEFrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IZj3v1SW4CS/dfK2+z6yc+Dtbx1/tbGykpj1YfOFLRk=;
        b=P8sfV0awqJuRhzL4O3EraZKp0vMCRnj16OTsPzEl1U7+s/bqebOpo7oEFRJV+41VBV
         jemmOKchVdnCyi9uXCaSxNo8ON2nCPZGqZGwoeN1bWnSOZ1gQXySg/VWRq7Iu/mQedy+
         JbIVx0O7yLplEspDERSRNoqZW7As14BB5thlF2l+we7rAKCqqQbJwJFm/e0ckTRUQmTw
         gCFnrlOtT2qbCCzczFQpwikqkpHYzUFuy2irG0D9Cxe7ksykGSmQGt7UHud5AuRJ8XbK
         QjTS3FOMmG8oBukweUmNbu8YruvO07ptO/dFrkOy04YesqkLEBsAXPvC3fl2PMVR3ZS2
         978w==
X-Gm-Message-State: ABuFfoji1MUr7QFxqAHBgmjcd/or04Is5bTz+NOVKRXKIdzihdMxQ3oG
        3z/yCepDXA8Asm1tPFgUaqt0vQ==
X-Google-Smtp-Source: ACcGV61tMCkRgEcT5aSyJ8UrybeW3M7ookoRIUjQoeeWW+T+3Cs1c1LR3/Sq4JUGNwVQmhD8lDXdYg==
X-Received: by 2002:a63:cc:: with SMTP id 195-v6mr31477894pga.44.1539946420740;
        Fri, 19 Oct 2018 03:53:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m67-v6sm54918pfm.13.2018.10.19.03.53.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 03:53:39 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v5 3/6] dt-bindings: power: Introduce properties to present the battery OCV capacity table
Date:   Fri, 19 Oct 2018 18:53:12 +0800
Message-Id: <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1539915051.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some battery driver will use the open circuit voltage (OCV) value to look
up the corresponding battery capacity percent in one certain degree Celsius.
Thus this patch provides some battery properties to present the OCV table
temperatures and OCV capacity table values.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v4:
 - Improve the description of ocv-capacity-table-n to make the order clear.

Changes from v3:
 - Split binding into one separate patch.
 - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
 - Add some words to specify the OCV's unit.

Changes from v2:
 - Use type __be32 to calculate the table length.
 - Update error messages.
 - Add some helper functions.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 938d027..89871ab 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -23,6 +23,17 @@ Optional Properties:
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
  - factory-internal-resistance-micro-ohms: battery factory internal resistance
+ - ocv-capacity-table-0: An array providing the open circuit voltage (OCV)
+   of the battery and corresponding battery capacity percent, which is used
+   to look up battery capacity according to current OCV value. And the open
+   circuit voltage unit is microvolt.
+ - ocv-capacity-table-1: Same as ocv-capacity-table-0
+ ......
+ - ocv-capacity-table-n: Same as ocv-capacity-table-0
+ - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
+   for each of the battery capacity lookup table. The first temperature value
+   specifies the OCV table 0, and the second temperature value specifies the
+   OCV table 1, and so on.
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -44,6 +55,10 @@ Example:
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
 		factory-internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-celsius = <(-10) 0 10>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
+		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
+		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

