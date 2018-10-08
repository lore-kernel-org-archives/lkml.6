Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DFF2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jI+mt7WH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DFF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJHUCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45196 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125048euoutp014a0d12f7bb8dc315a43a4603cfe32a45~box5Bo2fj1891918919euoutp01Z;
        Mon,  8 Oct 2018 12:50:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008125048euoutp014a0d12f7bb8dc315a43a4603cfe32a45~box5Bo2fj1891918919euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003048;
        bh=PGPFJzJpmURqr/aQZntB233XqnYePEIvAeWG3Km56PI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=jI+mt7WH4aCnwyDgeeKxliFIUgvD//IvsiXFPIsa43YfqkKIjpSLeEm1095KG7Jfz
         E+4epUC6SLcBz6t47MmcPifUBp6PUUC0szxZamx0DAzFLgyZxjl8B9m0W2WRYRXdMm
         N3r8to2+CJJek5Tk+EXyT5qGQC2z2dQNjnchBlsI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125047eucas1p1df616ca4698694aacea53e84a545af55~box4cyxIj1752717527eucas1p1Y;
        Mon,  8 Oct 2018 12:50:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D5.21.04806.7A25BBB5; Mon,  8
        Oct 2018 13:50:47 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125046eucas1p1e0304c8c22a4ac128a8e507c86442a37~box3wpAIt0610606106eucas1p1P;
        Mon,  8 Oct 2018 12:50:46 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-7c-5bbb52a73cda
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BB.99.04284.6A25BBB5; Mon,  8
        Oct 2018 13:50:46 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:46 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 1/7] clocksource: exynos_mct: Remove dead code
Date:   Mon, 08 Oct 2018 14:50:03 +0200
Message-id: <20181008125009.3721-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7djPc7rLg3ZHGzzZw2axccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZbRvmc5YcJSt4uGSO0wNjFtYuxg5OSQETCRON81i7mLk4hASWMEoMWHhMVYI5zOjxP8F
        vWwwVV8X/WeESCxjlLiw7DZYQkiggUli9VN3EJtNwFCi620XWFxEIFui8/EDRhCbWWARs8SB
        Y8IgtrCAncSR+7PAalgEVCWWL3gHZvMK2EhMXbqKCWKZvMTqDQeYQWxOAVuJJ12rWEAWSwjs
        YZO4//49VJGLxPwp95ghbGGJV8e3sEPYMhKdHQeZIBqaGSXaZ8xih3B6GCW2ztkB9Y+1xOHj
        F1khzuOTmLRtOtAkDqA4r0RHmxBEiYfElfvHWCBensAo8XRTO9MERskFjAyrGMVTS4tz01OL
        jfNSy/WKE3OLS/PS9ZLzczcxAuP59L/jX3cw7vuTdIhRgINRiYc3wG9XtBBrYllxZe4hRgkO
        ZiURXtHtQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8y+ZtjBYSSE8sSc1OTS1ILYLJMnFwSjUw
        nrnJEnvrz+Ht2ed/tJzMyisPivIJYGTKfyN0Y1rFGvGbfcwaftsEs/1mTp93xU3vxXWD7SuP
        azaGHOtxy5FOl7Lts9EU2m4U4y4V1Lfk6omHttX/FHMXLes+X316yY0nLsdjOptck+7N2m9T
        vmXnr1BxXsfD68LOMBqFKbrtu/fl0cSpqx+cVGIpzkg01GIuKk4EAOxrCpvjAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVy+t/xy7rLgnZHG/w/pmKxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZbRvmc5YcJSt4uGSO0wNjFtYuxg5OSQETCS+LvrP2MXIxSEksIRRYv7C9awQThOTxMZr
        E9hAqtgEDCW63naB2SIC2RLz93azg9jMAkuYJW7edwCxhQXsJI7cnwVWwyKgKrF8wTswm1fA
        RmLq0lVMENvkJVZvOMAMYnMK2Eo86VrFAmILAdX0Tr/IOoGRZwEjwypGkdTS4tz03GJDveLE
        3OLSvHS95PzcTYzAQNx27OfmHYyXNgYfYhTgYFTi4Q3w2xUtxJpYVlyZe4hRgoNZSYRXdDtQ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dUA2PRqQfr2P7/
        nr3Y111m76+PGtJir05u+9rmc+hRwZPXFbNmzJeatkni0a8fh0qZuq31vB1WdX9cYNMhLbe7
        rvb5lmf82nGxm4s2H5c8nilws+GVXtbemEL5zStNnRm3hFxpu/RogbLs8ZW+q2LzlJ9e1vjG
        xfRW9+8sjofLzyXP5NvQw2vpyWesxFKckWioxVxUnAgA8PjnVEACAAA=
X-CMS-MailID: 20181008125046eucas1p1e0304c8c22a4ac128a8e507c86442a37
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125046eucas1p1e0304c8c22a4ac128a8e507c86442a37
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125046eucas1p1e0304c8c22a4ac128a8e507c86442a37@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..43b335ff4a96 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -581,11 +581,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1

