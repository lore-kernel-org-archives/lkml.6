Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C282C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D538620675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHIE2KNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfBWNIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33769 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfBWNIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so5224403wrw.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwQfWziq3qwqhPCKOxGuiZqx00tpUJAjOFtgPROv/OM=;
        b=MHIE2KNhqZOEK3XdiDEnhtKxQzBVx+LZWTgM/PUXjUgbZy5hVMbxH0ml+LiDGj0obj
         bvMmYh6xtN1YRmJAHOMCsVAfHU18e7QlKZu/6Q859x25nxAMI8oENy+KE8IOrqlaNLS/
         D4PAWv1dMNC6H7MyuH5FvWfIOd2u+TatymJSnUBQ/ook2co7pbnUotOx69+Z1F4LT+qW
         jSXkNENG4M/nJYOWC8h2c5vyRZ2bDDhMl3OMgjbWThZyp3NycXT5geA7iap7o7MHvOII
         jWoH8P3feuc7U9H7H2sijB468e7qZzNGUE3b+XstH0BvVALCP99rqWA/SHpdGPMZ+bX7
         mo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwQfWziq3qwqhPCKOxGuiZqx00tpUJAjOFtgPROv/OM=;
        b=qR9IkxdRwsGXWwNo0ZgZyimoVIxbwrc1NB1ZQIccDF0jt2cy37T6NrqP/2FXDCoiT+
         Phu4lE8nKPDkZh0q7/nsb+IVKw71LXQjzy1HHdXBuFHKUjn73kZIt6mGwb7TtcRSIc0+
         yqhoxTXARtyeTXoAfhC93ddYcgRN8yFKAaaOCDuz7+2DFa1sHW0LXz01GhS+CZkPCyKb
         cdVwuGYTQAO9JJNOi6TiMtmYdNVxVBkKksXGHyJ2XgdcpKH0kKxs7Eu4PuQiIXDT6YZl
         MImdZXfIpsv1ksazIyXdz9s2fChmKrb68NT8i6pDN+E0eMXmwMW+8nJ2qDWHGVnpcMiz
         edFg==
X-Gm-Message-State: AHQUAuaCfp+wzopuCN3KEcbqIg0qsB5jCWSq60OfvA1SmYq4FZP72miL
        xKwuII1TTrT+zoVgsk7qYaHmTVrJue8=
X-Google-Smtp-Source: AHgI3IaqT7nU5sFNzGRXG3YuOJJSk8DzWlEggvL1uq1Kad1dZQ0onM0mt4DfcLDvA5PWDZIR3g8bPQ==
X-Received: by 2002:a5d:6112:: with SMTP id v18mr6260356wrt.207.1550927299078;
        Sat, 23 Feb 2019 05:08:19 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] clocksource/drivers/timer-pxa: Rename the file for consistency
Date:   Sat, 23 Feb 2019 14:07:02 +0100
Message-Id: <20190223130707.16704-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of consistency, let's rename the file to a name similar
to other file names in this directory.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                     | 2 +-
 drivers/clocksource/{pxa_timer.c => timer-pxa.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{pxa_timer.c => timer-pxa.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 47052ea15f20..a9e7c642ecce 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
 obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
-obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
+obj-$(CONFIG_CLKSRC_PXA)	+= timer-pxa.o
 obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
 obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/timer-pxa.c
similarity index 100%
rename from drivers/clocksource/pxa_timer.c
rename to drivers/clocksource/timer-pxa.c
-- 
2.17.1

