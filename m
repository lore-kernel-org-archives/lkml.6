Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE7C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF29223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0gSJF/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF29223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbeKNSZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:25:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43568 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbeKNSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:25:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so7013880pgv.10;
        Wed, 14 Nov 2018 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SwesKq7poU3m2w5kED5bCS/WxtggZRtfZFpLrKKme4E=;
        b=b0gSJF/oMiTzNdVKeEg10156vbpq9DTGLPF76kRVff50kCqWqWm8kWTtzy/P98WCYC
         uM05c6HBkv7QqijnfJxuhYf3SwU/cQGWOIEpgPa+zy0JrovTJSJOmdTK7lsM1I9e9Dtv
         30AmzhGxxJFLEaoOE7+uXZ+Z64CDIZD/43S9tH4srVqJVGh291JyVN/58dYO8XVyDvQ4
         iSIpjL///NmiDKeJoE4gZv4yv9P4/px3v5ck92a6ItcSueV1qMstCiwLG630x2zk5F6P
         GqqTZDZ029omHnHmvEJyy0139pusCmK3lpMYlXBogkN0FFzyn5UzHaFD5yq3KA3cUQ7d
         ZE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SwesKq7poU3m2w5kED5bCS/WxtggZRtfZFpLrKKme4E=;
        b=tFT5yF9HfA2kKCRWnoIT1OURr9r++BFmXp0OZGYorwQ2CNi2209SCeujz7/JmTFY7/
         ALrINbo0LMSon1Ras8AK9w+Fs5LcC+pDrNNnvz9WpsbEhKxQdrotdfU3tFPvDJkRK8Jr
         K03obPUePSSyqL9X/dLWnAfRl1nSmN+r2811ZfI6yxL+0ZXPeuu9ESAx3cucw2+Gtl1o
         WPu9h5r87QUKLHG90pXxwuoQvQnNmEtEVcb4Rnq4iK6izNLMp0xPY7tzoWyZOz++9o7+
         mmfLu5BWx527E6Jw6oaKOO308LLoqVevqjwDPx/CHvCW83aZn8ta4SDhP2GnGsESKro4
         /dkg==
X-Gm-Message-State: AGRZ1gK90HVdyFvNa7BH3+/gTQHY4c8loI6I5z6liTMukguS8OJsAWYz
        G71dQyELw/sGHGaowZMVKww=
X-Google-Smtp-Source: AJdET5dtsDgp2p6jp9XcAcPwnJ5LT4Qzogx33U6xBSljT6/Rdx72kJ4QYcIem+piHHzzIvvpd0HuOg==
X-Received: by 2002:a63:2bc9:: with SMTP id r192mr916634pgr.172.1542183780480;
        Wed, 14 Nov 2018 00:23:00 -0800 (PST)
Received: from arx-s1 ([114.95.230.67])
        by smtp.gmail.com with ESMTPSA id v12sm22423218pgg.41.2018.11.14.00.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 00:22:59 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:22:53 +0800
From:   hao_zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, maxime.ripard@free-electrons.com,
        wens@csie.org, linus.walleij@linaro.org
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io
Subject: [PATCH v0 2/2] Documentation: ARM: sunxi: Add Allwinner SoC T3.
Message-ID: <20181114082253.GA21081@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Allwinner SoC T3 document and fix format.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..94b9c12 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -14,7 +14,8 @@ using one of the following compatible strings:
   allwinner,sun8i-a83t
   allwinner,sun8i-h2-plus
   allwinner,sun8i-h3
-  allwinner-sun8i-r40
+  allwinner,sun8i-r40
+  allwinner,sun8i-t3
   allwinner,sun8i-v3s
   allwinner,sun9i-a80
   allwinner,sun50i-a64
-- 
2.7.4

