Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF3C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B972086C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb0QzSvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbfBOPyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:54:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38348 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBOPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:54:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so5143407plb.5;
        Fri, 15 Feb 2019 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
        b=cb0QzSvId+z25WhlzgfX5mIlvBFIAUsRQ0SctR9h2phfPj2w1odL1yoTdMbz62oOE1
         cqdjg1Kl255cn94fOlOjuKvZRDCHRRuKkRGoE0NeO/MClnP3bmGW4BqPwA3Ako4/LOlK
         mAIwfoJrPBBRuHeSOwkKGaMGslizuZWDcDZV0htArlTuFX5Id14T/+yRH6s64QTt23Aw
         k/0QeF9TvrPXNhoZcYZK3GgziLhcAOKYc29dmeXMLykwXXSrwbyM32+cEQyPsZcelU/q
         cmsf2ZYjEhzI9VzbLTy5eyiCt3mlCuKB3Dty74Gua3meRrhH7e+JFFPRFkgjH0eelQs2
         hCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
        b=lvb2oWyq4QGR27onBndWtr+penpyv0K9UOL/YbRyhB2DnstnvSFmX/xyLwG64bVPS+
         v+cSoLJJ+9rqbj7ZFAHP/dE+56bmkIEeQCw7qpYFGfvbAqqf1jYQ7JMlFywJ7zlbaQyg
         sbmTY9VpJBU5aHH7ZFAMCf5w5agPeQW+8G5i+59WR3Bx9YnATkD5WGBEvtOHJCYEXFta
         iuYOYNZBEwKd1OYw1FcGhW0jt3qCxCx+Z1FvZRVBTwixtG6UvJI/e/csEpeCsiJVQERC
         T8DdCJdDJGDq7Fo/B9LiIzfvklR6z+uzH7s45C6s1GYJMsl1KwvzuH9DUsXL90CmUYCt
         qpTA==
X-Gm-Message-State: AHQUAuaI8yvjGh8S3OzDQVvUxsqCvB8ZQ4lFW840O+D7kdK9mLol+KCu
        U/waYv/F+Krb03VPQ2uuMYY=
X-Google-Smtp-Source: AHgI3IaV+xJCF4+x5CO7mMHlTRM5Lh4YexFgYI8b++u1BnbiH7vz1DsuQQ9HSkIoW0uO+QBiv3WNRw==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9mr10731462plt.173.1550246044191;
        Fri, 15 Feb 2019 07:54:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b9sm5956952pgt.66.2019.02.15.07.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 07:54:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 2/4] arm64: dts: allwinner: h6: pine: Add CPU supply regulator
Date:   Fri, 15 Feb 2019 10:53:36 -0500
Message-Id: <20190215155338.10564-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215155338.10564-1-tiny.windzz@gmail.com>
References: <20190215155338.10564-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original pine use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller. For
some poor quality ic, the maximum voltage needs to be increased a
little.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index bdb8470fc8dc..95c81250c2b3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -213,8 +213,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -251,6 +251,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0

