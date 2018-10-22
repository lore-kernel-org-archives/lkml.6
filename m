Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E668C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081942083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAalhCiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081942083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJVQBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:01:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44026 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeJVQBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:01:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id q1-v6so2164979pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HxdXYZYCNB4J2ZC97d1xBOZ7FLXQWXjI38HmOhTVoSw=;
        b=aAalhCiNgB6Ioh/26yzv9I2bf+ho9BQ0HndWKi9+/y6mH4s5S3mgWxyPWC8/XR41pH
         Fpr/gDjLzNtBOtaNha6DaWAucPNzAV4TsgmJfJ/A8rcpgTBoCNDkCLVdV1IMxwuducJE
         LTk6UH4tZiIYYFVkBXeinvoKn54TUnb4o+trU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HxdXYZYCNB4J2ZC97d1xBOZ7FLXQWXjI38HmOhTVoSw=;
        b=NwJgQhwL9yVStxGqVd/ODu8Uqx6XrxmQzEnDD0JUnbUpG2zTE8yTphNRmyVk0ng+e2
         bU6+SVHAeQPEtweBVd0McMe1tQxKz1wBNqcjtrzQF+Z0xmS4HPyfCa6d+sacCJQ1Cgv0
         iQ/2ZWnQzi8sTLbXk/JCMoveo3svFj6rFSMZFrJ0k6BsGiK7pGMkhPRE5UQ2jQ+l1cjU
         RXPv4CJceovio+mnWxwwz6+baAwVITgzJepK1fVvRKe5mrzbJPzUHKcE6yge2HfRro8y
         II1NyWP5Rvx7pIYaHPINj1YnIfLbhPluqwC7ElSfwD56P/B8m0Z/iP7Wr+scPV1M5R1V
         AoJw==
X-Gm-Message-State: ABuFfohCzSFjmX2Y5yTdpulBF6xl4ioU+11hBdcu39fD0TM0UyL0U02b
        AnDLYdhcdVHOxLZaKElfbM+vqw==
X-Google-Smtp-Source: ACcGV61qQwccnnYBuF93ETCBSHjAyephXYMAmNCo/bb2TElmQ+ioPw2WzIQ6XYXRkaMNChB3wGxdKQ==
X-Received: by 2002:a62:f909:: with SMTP id o9-v6mr44870245pfh.160.1540194268355;
        Mon, 22 Oct 2018 00:44:28 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d186-v6sm43704253pfg.173.2018.10.22.00.44.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 00:44:27 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v6 1/6] dt-bindings: power: Introduce one property to present the battery internal resistance
Date:   Mon, 22 Oct 2018 15:43:57 +0800
Message-Id: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
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
Changes from v5:
 - None.

Changes from v4:
 - None.

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

