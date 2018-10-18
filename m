Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC9721550
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V5zlImZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC9721550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeJRR6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:58:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53131 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbeJRR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018095718euoutp016bd5895d743845253d7ac83a534641e4~eq3RMLqty0160201602euoutp01e;
        Thu, 18 Oct 2018 09:57:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018095718euoutp016bd5895d743845253d7ac83a534641e4~eq3RMLqty0160201602euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539856638;
        bh=h+DAgBMdXW66D9M3iwDYly4siSxPNHVl5qlT4WELpzU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=V5zlImZNTBoF+5jKjEMp5FDCDd6LAvSutQu31bA9QQZGzNEJGBwReABn2gqZgK1TH
         d1pAltluS1FUVCgqmTJW78et/NyL0iJrsLFHmoiUGJkyCnx8XmAc0Nwnx9AwDolk4a
         n1+DbKkZ3JuoxeGa27MCVSeKbRt1wc21JPw3LBB0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095718eucas1p2b97a0fec37fbcae0686cce9e833d94d3~eq3QxUv492884828848eucas1p2X;
        Thu, 18 Oct 2018 09:57:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DB.63.04441.DF858CB5; Thu, 18
        Oct 2018 10:57:17 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095717eucas1p2c89f6e71642e6db62676e1af5514529f~eq3QCyEdV0201302013eucas1p2p;
        Thu, 18 Oct 2018 09:57:17 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-6a-5bc858fdcc2f
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.C2.04128.DF858CB5; Thu, 18
        Oct 2018 10:57:17 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS00GLZGZA2H50@eusync3.samsung.com>;
        Thu, 18 Oct 2018 10:57:17 +0100 (BST)
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
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 3/6] clocksource: exynos_mct: Refactor resources
 allocation
Date:   Thu, 18 Oct 2018 11:57:05 +0200
Message-id: <20181018095708.1527-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181018095708.1527-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7djP87p/I05EG2y+ZWKxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEr49zZbvaCXxIVz24+Z29g3CXSxcjJISFgIrHs4DbmLkYuDiGBFYwSj378Zodw
        PjNK7L4ykQWmatuLpywQiWWMEne+z2KDcBqYJHa2PgarYhMwlOh628UGYosIZEt0Pn7ACFLE
        LHCSWeLfzU3sIAlhgQCJ67s/g9ksAqoSx1umMoPYvAI2Ev3rj7BCrJOXWL3hAFicU8BW4sz8
        d1BnHGGT+PWCA8J2kZi7axczhC0s8er4FnYIW0bi8uRusFMlBJoZJdpnzGKHcHoYJbbO2cEG
        UWUtcfj4RbBtzAJ8EpO2TQeaxAEU55XoaBOCKPGQ2HxiKSvEmxMYJZY//s8+gVFyASPDKkbx
        1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMDYPv3v+KcdjF8vJR1iFOBgVOLhfZB6PFqINbGs
        uDL3EKMEB7OSCG+12YloId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzL5m2MFhJITyxJzU5NLUgt
        gskycXBKNTAuefTU8mbtN0UZO6GQg7u4eMId62/2S22PZjz98nhsalrTOUGb+IPa6w1amWS7
        pmuUzlJc8qrlUXrm0+2nIx5NLH2oaZnzxD/Ms365Xno+1w7zXTWaxi4LKkULr6cKKV/cr/Xx
        Bn9R5BYtLbONSTf/lm7ZKF8isSZ2a9PunGVuFms5lm5+8UeJpTgj0VCLuag4EQBIeDDL6QIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsVy+t/xq7p/I05EG/w8KGixccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEr49zZbvaCXxIVz24+Z29g3CXSxcjJISFgIrHtxVOWLkYuDiGBJYwSh3a/Z4Vw
        mpgkrrxZyw5SxSZgKNH1tosNxBYRyJaYv7ebHaSIWeAks8Slx+9YQBLCAn4Sp65A2CwCqhLH
        W6Yyg9i8AjYS/euPsEKsk5dYveEAWJxTwFbizHyIeiGgmu4/69knMPIsYGRYxSiSWlqcm55b
        bKRXnJhbXJqXrpecn7uJERiU24793LKDsetd8CFGAQ5GJR7eB6nHo4VYE8uKK3MPMUpwMCuJ
        8FabnYgW4k1JrKxKLcqPLyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnVwJia
        z3lCdseNX5/3P6o8f+KKX1fzjXutZxP0rTfPj1u0+0PGiwnn1Ti/f2Lu/hSic+5bfNSSXqY9
        IYVlMXmHJwp4pn2yEWm+6rByaWXalu6b6u/uv1RabbSKUbifJSL6y7W985ctPvWkTfRLQfhK
        h2q2yozbihIP16wQswkudVOU33zKNSH3WpYSS3FGoqEWc1FxIgA8uj/eRgIAAA==
X-CMS-MailID: 20181018095717eucas1p2c89f6e71642e6db62676e1af5514529f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018095717eucas1p2c89f6e71642e6db62676e1af5514529f
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
        <CGME20181018095717eucas1p2c89f6e71642e6db62676e1af5514529f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move interrupts allocation from exynos4_timer_resources() into separate
function together with the interrupt number parsing code from
mct_init_dt(), so the code for managing interrupts is kept together.
While touching exynos4_timer_resources() function, move of_iomap() to it.
No functional changes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 50 +++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 49413900b24c..4c886ff2941a 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -502,11 +502,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
+static int __init exynos4_timer_resources(struct device_node *np)
 {
-	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: unable to ioremap mct address space\n", __func__);
+
 	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
@@ -517,9 +520,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
 
-	reg_base = base;
-	if (!reg_base)
-		panic("%s: unable to ioremap mct address space\n", __func__);
+	return 0;
+}
+
+static int __init exynos4_timer_interrupts(struct device_node *np,
+					   unsigned int int_type)
+{
+	int nr_irqs, i, err, cpu;
+
+	mct_int_type = int_type;
+
+	/* This driver uses only one global timer interrupt */
+	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+
+	/*
+	 * Find out the number of local irqs specified. The local
+	 * timer irqs are specified after the four global timer
+	 * irqs are specified.
+	 */
+	nr_irqs = of_irq_count(np);
+	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
+		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
 	if (mct_int_type == MCT_INT_PPI) {
 
@@ -579,24 +600,13 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
-	u32 nr_irqs, i;
 	int ret;
 
-	mct_int_type = int_type;
-
-	/* This driver uses only one global timer interrupt */
-	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
-
-	/*
-	 * Find out the number of local irqs specified. The local
-	 * timer irqs are specified after the four global timer
-	 * irqs are specified.
-	 */
-	nr_irqs = of_irq_count(np);
-	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
-		mct_irqs[i] = irq_of_parse_and_map(np, i);
+	ret = exynos4_timer_resources(np);
+	if (ret)
+		return ret;
 
-	ret = exynos4_timer_resources(np, of_iomap(np, 0));
+	ret = exynos4_timer_interrupts(np, int_type);
 	if (ret)
 		return ret;
 
-- 
2.17.1

