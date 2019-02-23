Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E010EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B825B20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZg4KyRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfBWNIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35682 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfBWNIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so4279902wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GtXFZaf3Lxm4MFz8aDdKlTiKXkM/CBAgN7ASkzCfdj4=;
        b=HZg4KyRaou6Pwartm8ApD5A+3CMDP3VkUGmc4aspEnC7GhGGLWM5FvldLCmX8tO7HQ
         RSKNwNEfD8T2SFwhkNfpM81IbxESoOn/ebEAzPv0DeaCVHeEjSsgSEN4wEThkl7lxKwV
         NlsoRI5ttCpQeRe1a4CbVeIIcWJVYfSnqBwGATBXl98I02Z7V4Oxe3QA0nAoHcHd4O99
         1KwNYb+tNpuc28uV9ftVOm3LXb6QlkEGPkWEVgFJl98DzsoMljZvMHzYRXpSjdxSMQnP
         6g6I1gVDgtPFiVlK1ykBysgD009jWHqAR6Rn+eKpXj3A+maSbRiG76dBzQRWyHm6IFIY
         QeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GtXFZaf3Lxm4MFz8aDdKlTiKXkM/CBAgN7ASkzCfdj4=;
        b=QgvPeqZ1UBtwUyUwfPrN/w/wSWcXai36OHYpcdUHEI0JGOv6ShT1pjjL8Tc7Ou9EUy
         NT6HZVxduBwqjWLzyzBk6GLs8lQrJ7+W371FkD/1UCdtmZJCp8vRteTURfSZOeA6GEPc
         mNLn8GMHlPptIiLNDfH61l+NpDeZJtt+WtZSysKweN5NiJjzJNlueGNQO13QFaUFw+zS
         OkJqpJh5bJXpgsQ7G1cjawSwjoh9D7fTj4eBtswgXguWlYQxKWXyYlHQhyvBnMebSSoi
         NIHuflgnO9FsxLmqVuQqL5gOqGQJdl1lnDMY8EV8c7Cxlxvyabeg9x4uGoO38GmKvzaE
         ZiOA==
X-Gm-Message-State: AHQUAuaSfAGqkTdIEUx14tnOGj7uvcl6/pKtnZkl0YofFulQaFwQRdjY
        SBg/IvInRqkQOwGckaRexVGaSA==
X-Google-Smtp-Source: AHgI3IbSAXgNrAudQGSxlpigzJIAKn5HXgB82Bp82krn1A5mPCd/fBlyKUvXKva6zpZYo3U8Aljd4A==
X-Received: by 2002:a1c:a756:: with SMTP id q83mr5358850wme.8.1550927293551;
        Sat, 23 Feb 2019 05:08:13 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES)
Subject: [PATCH 11/18] clocksource/drivers/exynos_mct: Remove unused header includes
Date:   Sat, 23 Feb 2019 14:06:59 +0100
Message-Id: <20190223130707.16704-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The driver does not use sched.h and platform_device.h.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 33e90c080877..34bd250d46c6 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -10,14 +10,12 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
-#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
 #include <linux/of.h>
-- 
2.17.1

