Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D256ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2C421480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/1h4Lig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2C421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeIXLvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 07:51:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36430 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIXLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 07:51:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id y13-v6so3920145wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fgMUOehphvZNmcYG2yU0po/x+iNAshQ5kx+eSduG4BU=;
        b=f/1h4LigAFtCEy0LGTqrxM9U9Gdd+B+8C1BrN6xCq1OKGsWQ6RNvw7H6YVYtRQsZoa
         9GvmyW32YMVq7eucpTmDr4eDcHlZ62bmF33fVarIT0Iy8ey6T090ar4Qw5I8PtlGaje9
         grtUMj/3tqszJSLHGOWfsVbKNUijTAti/0NnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fgMUOehphvZNmcYG2yU0po/x+iNAshQ5kx+eSduG4BU=;
        b=NkDtXaXdGJYLOne/y6Nx9ToU+fgJEj1E0ODQB8pRHgyfEDYFNzVrNswJSgMqK2BEXi
         ZUot6vyGPiMl02btlOKqhfPyaW3HLqDtUpaIgt9EJd2x4gO+4+ddyZx6WiQQT4WRRxiG
         KbvlKZ8k/fLXGhzD2pIkXuFnwZVtYxXLSY85XFgj8VuVu6L3gEBHXVujnjjINccoCgEM
         gMqcE/DXNCDdlI8O8tOdTrrm0A71Xiv+LXIv1wl9wMYDeC8kkC1waXow1xR68mMHsVvI
         OGD2UVNCE6VHE/lvCznoeiuVKfnFxnWOzQV9Er5fMWbY2eGM8j/m00JX0KSjSJigdRWx
         wHPA==
X-Gm-Message-State: ABuFfohyYBIqKdRMhawsY0EGJpFeQ0cBotn4BiKNyDh8yR7v0zfz/G1X
        rxQ0rjLRAx1kbHOFF9EdnWq6uA==
X-Google-Smtp-Source: ANB0VdZg7QESQQf/uAjwUfLlJLvgmKyI64FoQNWcuy1LI6wr/DCnLrbyKQgTZ8cd+dhlOk/ppZ0xBA==
X-Received: by 2002:a1c:4007:: with SMTP id n7-v6mr6045597wma.108.1537768244026;
        Sun, 23 Sep 2018 22:50:44 -0700 (PDT)
Received: from localhost.localdomain (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.gmail.com with ESMTPSA id w94-v6sm43886226wrc.38.2018.09.23.22.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Sep 2018 22:50:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     mingo@kernel.org, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 1/2] clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs
Date:   Mon, 24 Sep 2018 07:50:28 +0200
Message-Id: <1537768229-3241-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <f2ad506a-e537-97cf-465a-593361116b10@linaro.org>
References: <f2ad506a-e537-97cf-465a-593361116b10@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
add the flag for all the other SoCs.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-32k.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 29e2e1a..6949a91 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
+	if (!of_machine_is_compatible("ti,am43"))
+		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
+
 	ti_32k_timer.counter = ti_32k_timer.base;
 
 	/*
-- 
2.7.4

