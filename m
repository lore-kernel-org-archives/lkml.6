Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393172089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQb9DU8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393172089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJHWh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeJHWh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93152214DC;
        Mon,  8 Oct 2018 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012343;
        bh=RVAmHk9Al6VFl9SGyDwm5XsP85W1t+yimPrHXXCCyuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQb9DU8ga+8MDFL106jIpENph9sV66d0UPUKUEwYMWQ/h9VyZ9rLriOQXOy9h240u
         WIW1Rm0uWehYVS6zzd06Zo9EmP8aRsDd+/fNG0QvJflub0nZ5n+r1xC6Br157V63pI
         lsvIfWgWRyrgwg8+lo3N5AkvrnIXtz8Xia1sQyRo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 17/58] clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs
Date:   Mon,  8 Oct 2018 11:24:42 -0400
Message-Id: <20181008152523.70705-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 3b7d96a0dbb6b630878597a1838fc39f808b761b ]

The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
add the flag for all the other SoCs.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clocksource/timer-ti-32k.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861ab3c8..713214d085e0 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -98,6 +98,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
+	if (!of_machine_is_compatible("ti,am43"))
+		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
+
 	ti_32k_timer.counter = ti_32k_timer.base;
 
 	/*
-- 
2.17.1

