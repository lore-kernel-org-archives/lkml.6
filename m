Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10489C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2487E20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="aI+tVJXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487E20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbeKUEWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:55 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34426 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbeKUEWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id A241C20929;
        Tue, 20 Nov 2018 18:52:29 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1542736348; x=
        1545328349; bh=2Ufa8g2X6gl38LQeXSxK1nafFVhKZ/h1m5RVhJnwc00=; b=a
        I+tVJXWnzsw9cb8oAZ7TmrOjO/iPJBLyHH9Y/lJ5eJmsMi9sfrS6RrQOib0/lE0w
        mvWiIUm86pg8WrRNcaN8JVfwY8hcLqQD5g1fjwFSUbyOuDcGP6FHWzHYiK/CqNSD
        VFSoVytKDJw8b/IayLbixVwPj0nGYLKXBkknU0aP0HOgqkGBNIKN8tFFU25CpN94
        PTS7HxEIZX9316+KROFkltfDZGJOcVRnux2BKFOsQKku9V986J6IhHxF0WL6TkdT
        emOjxuqHYuze8Z/tA/HIu6pbq0v2NfIOJ2r8A9c9fTQd7fs/G1KgURCtwUX3irLL
        aS/l8oqIL2ELFQFmKNEyxvHIYrVumtPIhlsTgeE/Pf891QdIjqLnogeI9nlJ9aNb
        3LUoP3KTCg+s75StFGQHAIQE9Xz1c8LNPjQV7g2+diExrBKrtV099q7FvfEbiavv
        rkzBUZXg9VJyew0J9A7fXcOIpwvQ+DcLgBVfiPG3FTyBzQFov9un0KhLp4YCe7Zt
        0yahpjyi7X7agxigZZqxnAgrpg4ok+YaTfcll2iFR3X7I5/pI20HS2VAlklR57In
        yFtHsgeRkTin51USwQnLVQD0yHCX5UQVhhydInMuZIO4g9SHne9wJYUuCo0lRkSI
        XsCaw+31m6UnVuYjr57FJT3BO8N6sCEu43bAwzr/tQ=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OpzGnfHXYq_h; Tue, 20 Nov 2018 18:52:28 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id DAF9E1F943;
        Tue, 20 Nov 2018 18:52:27 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v6 4/8] arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
Date:   Tue, 20 Nov 2018 19:52:07 +0200
Message-Id: <20181120175211.3913-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 ACIN pins are routed from SOM to the DC jack on the baseboard.
AXP803 charger pins BATSENSE, LOADSENSE, N_BATDRV, LX_CHG, VIN_CHG
and IPSOUT are connected via PMOS driver to SOM VBAT pins. VBAT and
AXP803 TS pins are routed to the baseboard 3-pin battery connector.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 53fcc9098df3..4695b0d407b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -80,6 +80,14 @@
 	};
 };
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
-- 
2.17.1

