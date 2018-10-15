Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D96C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789E42087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftQgyFOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789E42087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJOPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:54:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45227 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeJOPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:54:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so9257591pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qHyP6TsbxwsK1CWpa8UGFv4TSz40JyDBtFelVTbFr7I=;
        b=ftQgyFOo5C0d/7+jFBQZD2G+oul+jXzsiTdvXYmVE6J5cWMwQfXS5Nz6LAxwF/Py9S
         GiGCyO+Zz6AJ9XK5tMyKt8AsMIgKGIxDZ5Xm9RilBApC8ABgjV6VvKcRfkmFKxKI7AFx
         xIz0N04MGPGvP4KfnDRMqCd3G74K2zamCMvBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qHyP6TsbxwsK1CWpa8UGFv4TSz40JyDBtFelVTbFr7I=;
        b=KdVgJE3F7ftwQLF2iuMhElKdC9SZ3vq7OTJ3aNZv2FfEbszgRFdXGqFYyq+VXbxluS
         BY7Ba0aZiimjyaQhTyMn0vNNQBxkSitOSyKfts2lr16ubpCX+1H+KZ9Ot7hwqjK0iBWC
         /l+wzHNqBQEGskk7855AbXK7syixL846sc8YSLcIwB8sILRfi4aEHznUnEFI7NcbYpgN
         iE6NdLLU4/L4mhrrWOK/NzoDg/sr1LPNha2irRL5a1gTLEc+HAW1vxKe8BiAIM+oTSRY
         Wo1naRIDHg7waLHKITu5OHS+8CvrecAyLZfVwY17gDQxLHbXyYK6UwlX5PAB/lxCG4LN
         zdAQ==
X-Gm-Message-State: ABuFfog9NVGz6ugzrCMhyUF1lg9CHAl3IRS67AiI6n78+0m0tAh/UtEN
        ZMGt783EDhB9osZFzWI0qy23EP6knhflmycg
X-Google-Smtp-Source: ACcGV60otx7WOlnyvvg+5g4QhYxTH+8sJeKtEMlL27ATsKoLXUNqbHzoDqP1eJ4fYO3okrI5mOU2JQ==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr15233801pgc.351.1539591037343;
        Mon, 15 Oct 2018 01:10:37 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m27-v6sm16375855pff.187.2018.10.15.01.10.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 01:10:36 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v4 1/6] dt-bindings: power: Introduce one property to present the battery internal resistance
Date:   Mon, 15 Oct 2018 16:09:20 +0800
Message-Id: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal resistance of a battery is not a constant in its life cycle,
this varies over the age of the battery or temperature and so on. But we
just want use one constant battery internal resistance to estimate the
battery capacity. Thus this patch introduces one property to present
the battery factory internal resistance for battery information.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v3:
 - Split binding into one separate patch.
 - Add LinusW reviewed tag.

Changes from v2:
 - Rename the property.
 - Improve the commit message.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index f4d3b4a..938d027 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -22,6 +22,7 @@ Optional Properties:
  - charge-term-current-microamp: current for charge termination phase
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
+ - factory-internal-resistance-micro-ohms: battery factory internal resistance
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -42,6 +43,7 @@ Example:
 		charge-term-current-microamp = <128000>;
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <250000>;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

