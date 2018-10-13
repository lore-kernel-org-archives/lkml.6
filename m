Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78413C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39754214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="CJ+/YpmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39754214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJMPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:45:50 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:44414 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeJMPpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:45:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id F24882092A;
        Sat, 13 Oct 2018 10:09:36 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539418176; x=
        1542010177; bh=hFIzlqPfogdACLNOPs3fOziaLQqmcreIg9gvUuXfZM8=; b=C
        J+/YpmC3PWF7gvtXWW53855gHZ5mSErB9ImCzsfm0YbDjunylsMDTkVag1QpzS9I
        WtNv75sNpZo4m6OMT7zzFzKGLtax+61eclGhoPMTzPoE7g+DO8J4KumkDlSjJWEd
        DfDvCcjsPvDYeR+mhFgXsu+CHke59ZwN5vVqZL7j5PiXMPw6Gg3gyVxXSFIVFDxt
        VSVSnuHTH5/T7Sl365QfebqOvsAbtMOXWMRd3hkKU3BwoluKIYGL8r1VOQ7yQmKk
        jynC0+fTzEfLjJy2wZdJdlDfAeo8W5kuK5P+We3lVIvXaI6PUA5QuBExP76lIwQ5
        MQ7WbzKAiwSGG7YdLJ117mo88MoBRpdW7182CIXFy+fr/9sG1m1NCeLkP6NyyhTk
        iSYwc/RiK0CHs0uL2KjdQwqr2ZcvWMkjLn47QrSpKMfeYnHNvOxOTuZUpEZ2l4Ym
        XSweLBj15C8mDuWXM5t8ArdTGK9i6jYx7TydzujNIYLe6W5w6/VFxTNC9P2VaZIF
        E9GfXrrx2Pu0F6zGThMY5DL1gsIsgiht/CapqdSjRmZqd537SqYeq1+6rIq7PacS
        JNSPIyiksBf9MqX1BWZwWqgjA19bLIytePWvblyNpEhuJebJ6MnfVJ+Y7Y3q6Vn5
        kAMa29pFLJVobkY3iIInOTVTnPq3eRQ3fQgan6l3Go=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id F34jGULZJGg4; Sat, 13 Oct 2018 10:09:36 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 35CB7202F8;
        Sat, 13 Oct 2018 10:09:35 +0200 (CEST)
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
Subject: [PATCH v4 7/7] mfd: axp20x: Add supported cells for AXP803
Date:   Sat, 13 Oct 2018 11:08:48 +0300
Message-Id: <20181013080848.29894-8-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 is compatible with AXP813.
Adding cells for GPIO, ADC, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/mfd/axp20x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dfc3cff1d08b..e415b967d38c 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -728,11 +728,26 @@ static const struct mfd_cell axp288_cells[] = {
 
 static const struct mfd_cell axp803_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp813-gpio",
+	}, {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
 	},
 	{	.name			= "axp20x-regulator" },
+	{
+		.name		= "axp813-adc",
+		.of_compatible	= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
+	},
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
-- 
2.17.1

