Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13520C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D658E222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egQS5MjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438726AbfBNNJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:09:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44485 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406993AbfBNNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:09:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4so3141372plq.11;
        Thu, 14 Feb 2019 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UVWqQXafZ/X9MCi3U1aPlSOSuzbIbsBPGV8F2Zf93Jg=;
        b=egQS5MjYIvfK2q+CxooRFAWh4AkS7EqSlpSl077t1wj+eNHqeCl5W+G1qt52k1RuG9
         zIaHx6kU0VSmisLZPUnMM4mIdhJniH7DuQQDd2AXTfYHf4mEm365kRXyD7/kgSxdCyoR
         Zq+1JXXDvjiNPCdXA42cI690M3kDIMeus+b47iTeWx2C8WJx6FvqS+4n5n/eCXPLaBxP
         rWz3Ta67hXhJ34lditXLRNdzj3uLUdNO2+5sBQJXFE5X1NAlU+1WYhMRO4GVOyjL4ONk
         bJv3V+cgvMMTpQM7lk/LY5wHOJPMEMt462PUolpf7d+IrYv3UHQWFtnQHKU/1IJWKkij
         H6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UVWqQXafZ/X9MCi3U1aPlSOSuzbIbsBPGV8F2Zf93Jg=;
        b=YjWj2gLcgfS2wjvh29Xd+bYaR4VKvEsneA9Gv+3xWol7NKJqukchY5E2Kw/V98+Pu5
         6DRsTv2s4x42UXbEwsqrchmbwmVTE0uQnz27nVdQ+CS5Nu4GnDZJMEcpaBoJfw4gGLXO
         cM0ncd42sPub3/9DYjcWFzTf5ZMqBBMfjDiJrCIKp3xRq8mBDQR2YWeqF2JSGFvSsM0X
         6JYqgawDkJW+h5HH3mXk4H+fEWv+UjGHy2XbVkGn/bg665VJ6XA67nbl+O29W8Vt0c9w
         Cv6Z/R5po0wvGLxbCHgK/Rtto3ugKb5fDYJNoQw+YCLv2skW4HBKZDl6T7WZzNrjR6pV
         5v8A==
X-Gm-Message-State: AHQUAuaf+R3EGU82B9uy6ETtN12i8DtH6gpIlkc9lc4DeeFxfS02lfWg
        MI3Q8s/fDKKaNmTUDo73lgk=
X-Google-Smtp-Source: AHgI3IYv1lJgJTzn3LOHLhTgDD5gjpgJxfjbqSReqnB4xq3OJyh24csatJtdeVjAszOfgb0OXEaCaw==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr3973292plr.273.1550149767468;
        Thu, 14 Feb 2019 05:09:27 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o16sm2517286pgv.41.2019.02.14.05.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:09:26 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/4] arm64: dts: allwinner: h6: pine: Add CPU supply regulator
Date:   Thu, 14 Feb 2019 08:09:08 -0500
Message-Id: <20190214130910.9201-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original pine use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

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

