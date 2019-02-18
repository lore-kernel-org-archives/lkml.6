Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE320643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="lPdVLPON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389841AbfBROEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:04:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42410 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389758AbfBRODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so4517362edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
        b=lPdVLPONMX15tVFEdOGTWdO0qWE/4jq/BAze0ALMLuA0nMhYdTscqDSDouBdQJMKI+
         9P9j1Oo5wGvSlAFqwJ5MbsxrTSd68gxajlZug9ZW4tzsNll+n461GjbggeOeqUQpgDm7
         W1pyYQRMbpuwsNn1TXoxIgHxqzMBLkEm6z/Mm2OFJDHKy3mdBVweK2p66YcDrrpeiyKy
         popuvplA8CMeHuToUOieTP7qkuHWUthsRGN5rVdQwprYyfywzPhUboAT3lTaCfKDFUXD
         GZCmTGPgJsVS9ZBLdp8t6SAGMuf9SNrpjtxDkSgWKiN8DRRDgz3mzZ/37doMnbxznzr/
         OTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
        b=ii17OXBVme1O3mcohk9ATHN4sfF/+6TmAeEBv9QilUDRvcmdmSd74ccC0mU00SJiI4
         DkRDi3oHZLayBYdI+kKXcLS+9gZrYK5FqIPsTsFRZrtDCGJo062N/QXP5p+DF5SHySYB
         MoveUpUADIG758tB4KuMeLAa3KX+7iVTVeSgMlus9EbhSXX9qED0c7fVt8nAjDwHbW4E
         BckEfuRWSFsTlAP5bLKjPUVenf7Fnsw3/GpJHppWi/Z1Riz2dYq92Z49D4va1ZvynP8L
         vSX3y9AOrOzm+PWK05ltYMvhtnxY6EpD71hHYj6g2PME/iAxjSllWdq89Wc88mvzf11n
         YBig==
X-Gm-Message-State: AHQUAubgbxDqWs5uRAo2xzqQ81rMYzWZhoEmUl7CqBCgQXmu21Rn1nog
        MQSQKLURblq8KxSRquHqC6JjaA==
X-Google-Smtp-Source: AHgI3IZ8OLgKjAeX/g4O2478yycvuHIzPgfc0uD5abEOkLT1aY3Iky8/UzyD7nuf/AReqmoOjyDzEw==
X-Received: by 2002:a17:906:791:: with SMTP id l17mr13001446ejc.1.1550498630266;
        Mon, 18 Feb 2019 06:03:50 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:49 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 3/8] drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer #defines
Date:   Mon, 18 Feb 2019 15:03:16 +0100
Message-Id: <20190218140321.19166-3-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 846d18daf893..e1c34b2f53a5 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -19,20 +19,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
 
 struct ftm_clock_device {
 	void __iomem *clksrc_base;
-- 
2.17.1

