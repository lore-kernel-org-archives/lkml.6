Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44556C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A0521502
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="akrjTU7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A0521502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJIBdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:04 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:59476 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbeJIBdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id DF82220929;
        Mon,  8 Oct 2018 20:20:03 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539022803; x=
        1541614804; bh=YCvEZvi8r+B/iR11hwrDoTbiAvklCpnY5FxCAbplmOc=; b=a
        krjTU7reNlwqct45noygM6LBUEXmeJCyKex9AbLXZXUX9fKQ5YGXgRyg9t9hykDb
        MnoNRpvz/91DJvh0uvdDC5ZRjAV6PclthoXGRYkZijLoZGbNGNPo/+w0pWJj0//+
        X6YaKskECXU4hkvfa0g06h6LJozi68MO+MTqKhmlKxSzI3eqaL4uKVS3jKXPBVtZ
        p4kMr/rMrCpIKdcT9EpHonAzOqa8JjLvHuZMBmmwI8YI/NvNA1YVLWZPnB5egalp
        iJUDCmc+USecHOxx9wDbXeChxBwvyTgxPxYYP+XaAHlk4ozXI+Hc2cyAu6E462Nq
        ykSziBoWNnROowdh92EmfZbsm0dO0Tz4Fbj2B3E53EdRW/LjpC00NtxJhBZbIcDj
        tW3Coi08CEMDKTnTbLIWv/ngrTgWWNjJqz2MqnYDk0M+A+E+Dq3JGoWtHZvlxdGN
        rfQvszfomKIFEgQZxVw4Me47pE3GhTIBbVS8nGGaWa7Hvi4+Qpn7vxj2HJMbPwOx
        CkkACtwmysJXEiBwIcm/hJ/PNjt4PH995DiL5N2WSjZD6Ge/xXI9hk51sH/Bd2w4
        cLNGBb9uBl/IlcMfG5uhNhITjMK5dmgCZSTc1t/9IpY7dpSpTYI8mbD/qOQXQcnF
        3JN76pVNUEbSA1Wt5pGk6MfmSoqTeMK4wpV4+CWw5E=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id noG7XLmO-Ius; Mon,  8 Oct 2018 20:20:03 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id A482C20791;
        Mon,  8 Oct 2018 20:20:02 +0200 (CEST)
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
Subject: [PATCH v3 6/7] mfd: axp20x: Add AC power supply cell for AXP813
Date:   Mon,  8 Oct 2018 21:19:07 +0300
Message-Id: <20181008181908.9456-7-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As axp20x-ac-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/mfd/axp20x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..1508d9113126 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -778,6 +778,11 @@ static const struct mfd_cell axp813_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name           = "axp20x-ac-power-supply",
+		.of_compatible  = "x-powers,axp813-ac-power-supply",
+		.num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources      = axp20x_ac_power_supply_resources,
 	},
 };
 
-- 
2.17.1

