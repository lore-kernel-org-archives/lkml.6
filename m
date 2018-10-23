Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6FBC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4010920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="WCibitt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010920813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeJXDSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:52 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45942 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbeJXDSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id E31851FBEB;
        Tue, 23 Oct 2018 20:54:12 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320852; x=
        1542912853; bh=cfMh6AcbyeWrvCk50dMKmOhXsNrpnTzv4+nFyu7Nu5E=; b=W
        Cibitt6zlC4OB8+O9kddsX3fIZQn0ZkTW2hizSrpeCerh6u74dU3vgdk9pqU2RTz
        bYRyjZCyH6i4jD5xpn+KAAAAw1w/iDokfMizwIj6OeLzYJKPwYcaO9WYleCDqY6D
        KbQoiMdZTX9U9zKTcT28X64IbUqqWlCEu9BXEjAjOr8bteCLTBKN6P1cf/XUyQbg
        yLYnodQ0yrjM/V73fNft/neS9Fke35qe299EXkKFcOcpPbvUVUf7dmUgmQeZYWqQ
        /UFd4zTIEMDbcaZtcOq7YFOWmiItJN5mg88kEUdLVuvIyXO5zbPAvhtLpNrdVjpt
        DNvwcDNdUhYHbzbG1TqS2Al3i3oIYdWJkBvFEiY9MVGwzcVNjnHgfDuba5Xu76By
        nKfk1bd7ZDhXfALZCxX42zpK46WtBbQfAuWFNV90Jx5iw1LQZ8KNdbvZmmavjaE9
        d3C1AE6Av45hgGnpSxenE0E3ITBbV+Zz0eQAPzUd4wSBlmTi3ZZuu8miQ3VpxSrJ
        NWH+qUs4EyxgkTH7LCJW/WBjFyLwTseMokUujBc3rn1OmeQuGlJY3jCsTVB2nSQO
        aDFJc5zll+c3bAlHHSitM9p9/f4ywH9xNu7TV7ixCbbcxcFYeZWYCyglxdjtsZyS
        AV3az2tNJOuTASwsl6evEM0BLwVMPecdkezcy63j90=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id EC5jHfqoXKP7; Tue, 23 Oct 2018 20:54:12 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 49A881FBE9;
        Tue, 23 Oct 2018 20:54:11 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 10/11] mfd: axp20x: Add AC power supply cell for AXP813
Date:   Tue, 23 Oct 2018 21:53:29 +0300
Message-Id: <20181023185330.10472-11-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As axp20x-ac-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/mfd/axp20x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..dfc3cff1d08b 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -778,6 +778,11 @@ static const struct mfd_cell axp813_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
 };
 
-- 
2.17.1

