Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7DAECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E4A208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="gsumN2vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E4A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJGEZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:25:00 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:53266 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbeJGEY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:24:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 76E7220657;
        Sat,  6 Oct 2018 23:20:07 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538860806; x=
        1541452807; bh=7GDl1ndnwqGbv+2YOjStm1fcMbJsyDoNyj9lXt0BCQs=; b=g
        sumN2vn53XFB7eerOA3q4WXsrsiVbN+kpuLw9vfp6iotOl9UoHnQZdtJt7kKkDDG
        p5XbCbbqt01V3KBPa8NtyWJwiohP2kMs2Njj7JYxt1CCbrUe2OBs4DWHz7UgnBub
        KeX7m2YqQj6Wq7pZjDxq5ihTmtjOYZNfIN86KDmACqFosorgA24g4djwKhzLApDJ
        I9wiLv4KQmtbd0WaJtJuZ7xpdel3MBn1+c7ssA5so/RX53PhEMJGowqKSzBXG9og
        JULJkkSPdXv+qD5YedOdEqgGoxxqWZTRnimPQbcWP3pcbO42MgCD6gcxH5d3iCCW
        0NedhJrJRJqWPZAmb3oDuqtOYK2KNmPqBj3grdbO28/YQyyCIp0mchn2CmX7YJRk
        kLeckB3b9hXUrY4xImMO4mBfVWwoJ+LSdQXHvZbU0owdD/x94qSOhaBb9d9hoWGt
        ZeiS3nPSnvRogqNmxgsDVKt7xA1DWhuuSia6SQC8zkdSnaG4GIJ81yPWrrrUFCfO
        FMl+YcnRxMW13hzTJbakzRj7A4yc1UjOA8x2jNPq5J25dmZqiEzvqs9giGFD5OAM
        0c8PbJV/L92PSAUhJ2wYkPkEoxJtE3wqF/YC+2lejPBjNp9jb+PLVr7ASkVe418Q
        FuwYGCvIEaZzWBXjHlNkZYdAWBThe9Ru0Do4eWwGbg=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zoTz0Z-o9c_a; Sat,  6 Oct 2018 23:20:06 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 23AE61F99C;
        Sat,  6 Oct 2018 23:20:06 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
Date:   Sun,  7 Oct 2018 00:18:31 +0300
Message-Id: <20181006211836.28253-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803/AXP813 AC power supply can limit input current and voltage.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
index 826e8a879121..7a1fb532abe5 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible: One of:
 			"x-powers,axp202-ac-power-supply"
 			"x-powers,axp221-ac-power-supply"
+			"x-powers,axp813-ac-power-supply"
 
 This node is a subnode of the axp20x PMIC.
 
@@ -13,6 +14,8 @@ reading ADC channels from the AXP20X ADC.
 The AXP22X is only able to tell if an AC power supply is present and
 usable.
 
+AXP813/AXP803 are able to limit current and supply voltage
+
 Example:
 
 &axp209 {
-- 
2.17.1

