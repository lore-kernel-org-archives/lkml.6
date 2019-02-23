Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E303C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6323F20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSVc/DD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfBWNID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfBWNIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so5168863wrg.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aU82OCB8EaU5gSyx1GLNfzRZ/n+CtM0wF3xQO3ltdE=;
        b=qSVc/DD17GWnUdCpaw7WaO089XVB4WI0aYdiodmu3f4mRuCbyMNJjLWac5g+UrKCQH
         z5WOU7kh32bdNH1BYvU5e73cwM1JmBOGIArhuhbVUZPeYPVjs7OhbIfQPSm06yXJmvZC
         7MePrRJ/7paUPIdNOEjGgDt+YrxchIsvPmno26wEolNiHDFzqNalM2LxtzZhTPHmBoJg
         zlCMZ9qGohEvCxa25K/jTtMRzVF8icL/EeS3xumqm7Bi95oUXE+uABbAD+HAPAZ6W+Z0
         Q22ZJV1TK8DE1kk4ypHu5Pqu3PS/UYih/I0c8u53EQvgweT2Wcg1dwoNOkCMJX9HTkNG
         E/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aU82OCB8EaU5gSyx1GLNfzRZ/n+CtM0wF3xQO3ltdE=;
        b=Y/uz6KLtEyuzGKYFFTl61eRdD1AdoNTpvh4zOQHoHtt8p6IwJsf1CpoSkCs8i5DfF/
         8qo0PUNhI86ZXkTtDC+o6TYG+zj9YBYWSvwY/MmS0V3zL5Z0yxzJ0l7WUqaeTIeafgC2
         9r8npDpJH+IzTV6ZYCJakxYYA2GV6xHqT76Sc8qc5MzgDW+7Xoola5IkiJuOSC0kMqCE
         s9d7nytsmX5TqNQGiIH9wHHUK/c+Ph1xvTyHp73OyBTEQhoaiTXrhTYz4xHR7Gs2T/Wi
         NF0e2Ja+5ECv8fTjyaPZa0paxrmWYEBdfCPd4uaWBV9u5EiMgasXn+ffwZqs/ABQLb4N
         C9HA==
X-Gm-Message-State: AHQUAubnFjkgtP0APMjgKRlHwBDSbMOiDguoHnD/f50wq48by3VyptzQ
        81YX6EpWyTM6MgdxlsPwwJUoJA==
X-Google-Smtp-Source: AHgI3IbVSKg4gdtbIp6JL/bIu4AfzpxP6z3ySoB1CaQgud8u8kuxTeg7pUq6c1WhDyxFvU9/cajSHQ==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr6191029wrq.90.1550927279831;
        Sat, 23 Feb 2019 05:07:59 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:07:59 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES)
Subject: [PATCH 04/18] clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown
Date:   Sat, 23 Feb 2019 14:06:52 +0100
Message-Id: <20190223130707.16704-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

When shutting down the timer, ensure that after we have stopped the
timer any pending interrupts are cleared. This fixes a problem when
suspending, as interrupts are disabled before the timer is stopped,
so the timer interrupt may still be asserted, preventing the system
entering a low power state when the wfi is executed.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 1e325f89d408..d55c30f6981d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -411,6 +411,7 @@ static int set_state_shutdown(struct clock_event_device *evt)
 
 	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_stop(mevt);
+	exynos4_mct_tick_clear(mevt);
 	return 0;
 }
 
-- 
2.17.1

