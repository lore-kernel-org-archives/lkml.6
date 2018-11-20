Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA5C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF198206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="cmvtkqQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF198206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeKUEW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:57 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34490 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeKUEWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id C405A20926;
        Tue, 20 Nov 2018 18:52:31 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1542736351; x=
        1545328352; bh=cfMh6AcbyeWrvCk50dMKmOhXsNrpnTzv4+nFyu7Nu5E=; b=c
        mvtkqQpzHlrpHu/zYaF3/aIyhUsdZUPnKctZwJ3ihutH/4m7ThlbYAnBFq8xhrW4
        I+K5Yki5PPV+Gl9RWZMR+1yX8Wf0UiMlpALoPCWeVChurJHBapnTfPQfKmdOik3H
        4Zv9hASyDwGpzldCQ//I+PSb/hMu58RwBHiKMW2/VRB6AIcicBwAJ2fBInkxbDxT
        Skndilb9UO5DbsNFwhnUFWy8F5+vnPkVfuRISnc7TL6w0000G8/co0+QNlCBMqmD
        998M/roye82baLOtLfe934JTX/Z0iLqGlqrqjP3cfzRIYw3fzwhMC/P1PFGYLy/F
        zM/0ZYQGr6TIK5ivaTP3TnzrQOjoa1tu4kDfcS4LlYu1qY9Ff/dWif4ZdBMgESXJ
        DdWYlCbqPsj+/u1XhRbbLAvIQiYqin559alv5+yk7yUqScMJe/sPc4/ebjj5Okye
        LOBstRV51+TYl6lxUR6b3qh8WWXhM9fnhXGjsLO77QH7VoNtSVxEZylRPdae9S2b
        9/GPFFHYp3CX1cBFriF3AZvf4FGMhI4DDawYJdrQWc5H7aE6PvexJtAvWW2LJc3C
        M5pXB8FUmZ/bru+UGWZyFrR+3qdHDsdDtZvVsSOqiR5IT8+Z8NxiS0+lEijH27Bq
        1iUntVya1iLEVhKrO3sO8e9x6gvq1N5ch+QtaFmD9g=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id SJ2k2z5qujiY; Tue, 20 Nov 2018 18:52:31 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id CD18C1F943;
        Tue, 20 Nov 2018 18:52:29 +0100 (CET)
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
Subject: [PATCH v6 7/8] mfd: axp20x: Add AC power supply cell for AXP813
Date:   Tue, 20 Nov 2018 19:52:10 +0200
Message-Id: <20181120175211.3913-8-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
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

