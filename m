Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D4C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F3020835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="bwNzomrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F3020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJMPqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:46:07 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:44398 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeJMPpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:45:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 5BB4D1F99A;
        Sat, 13 Oct 2018 10:09:36 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539418175; x=
        1542010176; bh=RDLMb/zCp3FWggHEX2Z0jTQ4Z/KHaPoFVBQtwQaF15s=; b=b
        wNzomrJ5xPpdsSODYm02IylMPMhrrBXXQo7mNWbB5gsdaVNmGZwFruW6BMQt0swL
        x+e1toU5R2Xd5HIHWFHdnu6v1Yf9KRJIE6sXqOvoVGg135CP9aQc1lG5jnulnQBh
        OJWgXRJc2cfrZZCwJcqhdMNl9toXxgqyQQ99EhgMLtDOHHSlxB4L5yEXQjKsE1DQ
        RTQeg9ON35FfW8IpptIR/R/seVR4kg74ofsMOjxjzIpq1UUqtq3KoX/gZy+Unzev
        LJq1DLLsn91O0KzLnzXyGLeMCo74rZKNxAxuLfWSTT8oh8GYO13mvCGxBciJ/JHs
        kpoS87+8aUrrsLaVoVpZ6tjgwthvPBijkNabv1EFbiHoeNSaC9sZkEiXzUutV93A
        gFZyFq84ewMvWyd+ntd8MQ0wlzdfF8FYFhZjp/Y4H4rEaS0brRrB57AX1Xgpt7VC
        71wPAXzSozaykqgdVo/Ob9eOJi9ats8FSNHw5Y9F1UNR5ZCbkTkRUHwXPW3jNT5m
        haLGJSCtxdOYsviMIvPFXD0qmsCBV/gSL1B0QKGD7s6SqtncBoiDN4+6vmFfIymG
        YyzCgKymJt3YukWsgxCwPmsk8qEpb7PRozp+0XbIQNgJBE6SBCi4Y9B0hJatcHeZ
        lySxT/DQas9QL0+TjT6x23iAWSYzUO3ywNJYrb1sdU=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id s92H13R-iaDY; Sat, 13 Oct 2018 10:09:35 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 974F52092A;
        Sat, 13 Oct 2018 10:09:34 +0200 (CEST)
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
Subject: [PATCH v4 6/7] mfd: axp20x: Add AC power supply cell for AXP813
Date:   Sat, 13 Oct 2018 11:08:47 +0300
Message-Id: <20181013080848.29894-7-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As axp20x-ac-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
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

