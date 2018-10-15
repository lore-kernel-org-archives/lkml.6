Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF91C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1FE2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dVCGq+xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1FE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeJOUQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:16:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37092 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:16:41 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181015123135euoutp02f1b3169a6ac7952723ef79aa2987bf69~dyCHc_pQq0593805938euoutp02c;
        Mon, 15 Oct 2018 12:31:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181015123135euoutp02f1b3169a6ac7952723ef79aa2987bf69~dyCHc_pQq0593805938euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539606695;
        bh=SJzIYScYhMdb8yzvDfWZurkp4BZWopiHhM4QbH2iS7A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dVCGq+xeOc1+lPhCfU16McJi5UUFq4NubTIUm0T3Ct/1VQ/QL1dNEB7m3HzxaU8mi
         D6jHdb++mwpIbA1D2WVYddOnOlk1+T5OpTHp6uPhZEbUBzNBQfSFR9w+I8EvoUJUYb
         w6k9bh8Lknp9qC7f/m3mQ9qW4VcgL2VVLEuafKUI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123134eucas1p1e0acbffee2ac809c8152ea0e77002675~dyCHD-nQE1987519875eucas1p1e;
        Mon, 15 Oct 2018 12:31:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.6F.04806.6A884CB5; Mon, 15
        Oct 2018 13:31:34 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123134eucas1p1bdc005e0c46e9b1b7895bf2526ba1f2c~dyCGViKaJ1988219882eucas1p1d;
        Mon, 15 Oct 2018 12:31:34 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-8f-5bc488a67e80
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.DE.04128.6A884CB5; Mon, 15
        Oct 2018 13:31:34 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGN00GZC4490K70@eusync1.samsung.com>;
        Mon, 15 Oct 2018 13:31:34 +0100 (BST)
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
Subject: [PATCH v2 0/6] Proper arch timer support for Exynos5433-based
 TM2(e) boards
Date:   Mon, 15 Oct 2018 14:31:06 +0200
Message-id: <20181015123112.9379-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7djPc7rLOo5EG+xYq2mxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZRw83MpS8JerYlbrT8YGxkccXYwcHBICJhLLzil1MXJxCAmsYJT4uOwLM4TzmVFi0tmT
        bF2MnGBFh299ZINILGOUuPFhOyOE08Akca/xDStIFZuAoUTX2y6wDhGBbInOxw8YQWxmgUXM
        EgeOCYPYwgJhEgtONDKB2CwCqhKNWzuZQWxeARuJtw+3s0Nsk5dYveEA2BkSAkvYJN5NvsAE
        kXCR6LjwGcoWlnh1fAtUg4zE5cndLBANzYwS7TNmsUM4PYwSW+fsgHrCWuLw8YusECfxSUza
        Np0ZEgK8Eh1tQhAlHhLzz60BKxcSiJVo3nyBaQKjxAJGhlWM4qmlxbnpqcXGeanlesWJucWl
        eel6yfm5mxiBUXv63/GvOxj3/Uk6xCjAwajEwyvAcyRaiDWxrLgy9xCjBAezkgivRMihaCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8y+ZtjBYSSE8sSc1OTS1ILYLJMnFwSjUwejCIfRRp3eb3
        7bR3y7FTr+es1kj/ur9q6yP7a2+frcucftc8/mHhh1e704+LnHHNtK9Ii9rg+GXN7q8f07SX
        Xb84K+n9rOwJPwRyd0ifb85gM9kbciv2cZZM+vFt37buvb1/SupdIR33p/OcefNmd+zSTtU8
        cohzQeECE4beW99Yf/j/mOtz76cSS3FGoqEWc1FxIgBipnAK1gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsVy+t/xy7rLOo5EG+xexmmxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZRw83MpS8JerYlbrT8YGxkccXYycHBICJhKHb31k62Lk4hASWMIoMXXLP1aQhJBAE5NE
        xz4DEJtNwFCi620XG4gtIpAtMX9vNzuIzSywhFni5n0HEFtYIEzi09sVYDUsAqoSjVs7mUFs
        XgEbibcPt7NDLJOXWL3hAPMERq4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAsNq27Gf
        W3Ywdr0LPsQowMGoxMMrwHMkWog1say4MvcQowQHs5IIr0TIoWgh3pTEyqrUovz4otKc1OJD
        jNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjFLr925jEdwpKdpZtCtnzuS0zwK7Z1YZ
        fE7YEr48RZQjtcN1gUVSKsvu14n3LP0Ci6OevT+3KVQkJMXOe2Wqtmn3w+4nD25tdXiv1y/2
        4PpnhSJ5144EPQbvt5Ps4gof95z9e/X+pfigvM9VMsbeKReltKPy9C9Wq8441HaX7ZeQ3oxE
        1m4hJZbijERDLeai4kQAiAkygicCAAA=
X-CMS-MailID: 20181015123134eucas1p1bdc005e0c46e9b1b7895bf2526ba1f2c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123134eucas1p1bdc005e0c46e9b1b7895bf2526ba1f2c
References: <CGME20181015123134eucas1p1bdc005e0c46e9b1b7895bf2526ba1f2c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

This patchset is an attempt to submit the last piece of missing code
to have proper support for Exynos5433 SoCs based TM2(e) boards. It
performs a cleanup of timer configuration, which so far needed various
out-of-tree workarounds. The fixes provided by this patchset are also
needed for add proper support for system suspend/resume.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v2:
- dropped arch timer patch, it will be discussed separately
- fixed issues pointed by Krzysztof Kozlowski

v1: https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=27965&state=*&archive=both
- initial version


Patch summary:

Marek Szyprowski (6):
  clocksource: exynos_mct: Remove dead code
  clocksource: exynos_mct: Fix error path in timer resources
    initialization
  clocksource: exynos_mct: Add arch_timer cooperation mode for ARM64
  clocksource: Change CPU hotplug priority of exynos_mct driver
  arm64: dts: exynos: Move arch-timer node to right place
  arm64: platform: Add enable Exynos Multi-Core Timer driver

 arch/arm64/Kconfig.platforms               |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 ++++----
 drivers/clocksource/exynos_mct.c           | 68 +++++++++++++++-------
 include/linux/cpuhotplug.h                 |  2 +-
 4 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.17.1

