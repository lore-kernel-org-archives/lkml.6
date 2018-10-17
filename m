Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18770ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D393621523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kv7DMbMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D393621523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJQVhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:37:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57622 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJQVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:37:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017134206euoutp01167c8c6b6e96d4baf23f708a1bb54915~eaSQ5C5kt1251312513euoutp01C;
        Wed, 17 Oct 2018 13:42:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017134206euoutp01167c8c6b6e96d4baf23f708a1bb54915~eaSQ5C5kt1251312513euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539783726;
        bh=zJetpoNhW01GT4Xt0gk6SKTpHAA/tdY/kH9zyQ9f4Ok=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=kv7DMbMYq4g6qZ9MUmdKcg/NrURhwwp8toEcAWkscYtZspY6jpOEeUAhjTGGzB2CH
         tgVekNF3XGr5BTmFW3PVoyygd87K/kiGYNn1BvkIJgaMIB9Z2wiNnAcXFg46k5c5/k
         fsByNleCuE3ZNpAUdYWFgg3o5dztGdgoUn17+ABQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134206eucas1p16493289394fa81fe801c0001e7b1cf6d~eaSQWvqic1588515885eucas1p1R;
        Wed, 17 Oct 2018 13:42:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 04.AD.04806.D2C37CB5; Wed, 17
        Oct 2018 14:42:05 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134205eucas1p148faab76ac153e9afbb8a519e6d8d1e2~eaSPnTYDM1901519015eucas1p1I;
        Wed, 17 Oct 2018 13:42:05 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-d7-5bc73c2d9acf
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.22.04284.D2C37CB5; Wed, 17
        Oct 2018 14:42:05 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ001A0WQ1IZ80@eusync4.samsung.com>;
        Wed, 17 Oct 2018 14:42:05 +0100 (BST)
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
Subject: [PATCH v3 1/6] clocksource: exynos_mct: Remove dead code
Date:   Wed, 17 Oct 2018 15:41:54 +0200
Message-id: <20181017134159.9656-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181017134159.9656-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7djPc7q6NsejDX5vsrbYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mnatsi2YzFexp7GBrYHxIXcXIweHhICJxMc/nF2MXBxCAisYJdbfn8MM4XxmlPjwczuQ
        wwlW9LB7JztEYhmjxKumFYwQTgOTxL2FS1lBqtgEDCW63naxgdgiAtkSnY8fMILYzAKLmCUO
        HBMGsYUFHCUmv30KFmcRUJW4dXAPWD2vgI3EkstXWCG2yUus3nCAGeQ8TgFbibX9VSC7JAT2
        sEns/PSdFeJsF4nvG7QgyoUlXh3fwg5hy0h0dhxkgqhvZpRonzGLHcLpYZTYOmcHG0SVtcTh
        4xdZIY7jk5i0bTozxFBeiY42IYgSD4l/j/6A3SkkMIFR4vlh7QmMkgsYGVYxiqeWFuempxYb
        56WW6xUn5haX5qXrJefnbmIExvHpf8e/7mDc9yfpEKMAB6MSD+8OsWPRQqyJZcWVuYcYJTiY
        lUR4qxSPRwvxpiRWVqUW5ccXleakFh9ilOZgURLnXTZvY7SQQHpiSWp2ampBahFMlomDU6qB
        MSGneGHJJcsLuwtyG0Q5KzN1b9+cn/lH61Hmqp2be8S7q/SfmLdWuq1S6HlrJBz6/nNQRei3
        zkmvZzjPnNowb1dwjfiyJfXCpz2vVe4pC5NWyNqf/tvUun/XkzTxhKOiLX+WfHou5LjRwK+6
        8JvqqRhHm/2L+S88eaj67uqOBtYVqTJVJS91lViKMxINtZiLihMBi+SJ7N8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xa7q6NsejDbbtkrHYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mnatsi2YzFexp7GBrYHxIXcXIyeHhICJxMPunexdjFwcQgJLGCWevVsC5TQxSXR2dbKB
        VLEJGEp0ve0Cs0UEsiXm7+1mB7GZBZYwS9y87wBiCws4Skx++5QRxGYRUJW4dXAPWD2vgI3E
        kstXWCG2yUus3nCAuYuRg4NTwFZibX8VSFgIqOTl57lMExh5FjAyrGIUSS0tzk3PLTbUK07M
        LS7NS9dLzs/dxAgMwm3Hfm7ewXhpY/AhRgEORiUe3h1ix6KFWBPLiitzDzFKcDArifBWKR6P
        FuJNSaysSi3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cC4iDdoqZ2F
        4OMt+8KWxYS8dot4In2/vvdGKIdZ3XHTOvv2dXwNMX7pK102b4iTWin89ICXdVKYoY7961Vt
        h1bHyHGEKmt82/zOpHdx3fMQw8qUFWJGle11f2dqbApb+3T34VDJgq1bPd8IW9tJlWyde+fD
        sfaEnGvdgXeldObI9XyLuamtkqjEUpyRaKjFXFScCAAwbEFfPgIAAA==
X-CMS-MailID: 20181017134205eucas1p148faab76ac153e9afbb8a519e6d8d1e2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134205eucas1p148faab76ac153e9afbb8a519e6d8d1e2
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134205eucas1p148faab76ac153e9afbb8a519e6d8d1e2@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code. In case of !CONFIG_OF
the code is anyway equal because of_irq_count() has a stub
returning 0. Device node pointer is always provided when driver
has been probed from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..ef18bbf8d20c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -507,13 +507,12 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
-	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
-				clk_get(NULL, "fin_pll");
+	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
 	clk_rate = clk_get_rate(tick_clk);
 
-	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
+	mct_clk = of_clk_get_by_name(np, "mct");
 	if (IS_ERR(mct_clk))
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
@@ -581,11 +580,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
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

