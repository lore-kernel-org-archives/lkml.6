Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5682087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JMHNBcDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5682087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJHUCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51640 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJHUCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125047euoutp02f1b280e98ec8020d646c9f7986021419~box4n1I4H2603426034euoutp02T;
        Mon,  8 Oct 2018 12:50:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008125047euoutp02f1b280e98ec8020d646c9f7986021419~box4n1I4H2603426034euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003047;
        bh=HCUBsc9AwGo3dSywBL3RuHpM6uxwP1dY2XsQRHygwAQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JMHNBcDv6A0x8BMRD/scZJzALKCwl8ZgSDz2DZzxSn33mSw6dQ8Y8XlNdGGOFcANo
         PQVoN0rvSCMRB5t/PvNe4Jbjo6p/s4SRyBcua8xiwNzA60IKjKYYbPBvq9Hx5dEclY
         3jr/tCSkn38ydTCtRgaRJjL9B+uTChmswu1pYazA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125046eucas1p135f0e2338464a70023df36939e5612d2~box358IeH1753817538eucas1p1d;
        Mon,  8 Oct 2018 12:50:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.21.04806.6A25BBB5; Mon,  8
        Oct 2018 13:50:46 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125045eucas1p12e1d77f5f605556d4cf6c3b87832fae3~box3E0PRa0610606106eucas1p1M;
        Mon,  8 Oct 2018 12:50:45 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-76-5bbb52a630a9
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2A.99.04284.5A25BBB5; Mon,  8
        Oct 2018 13:50:45 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:45 +0100 (BST)
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
Subject: [PATCH 0/7] Proper arch timer support for Exynos5433-based TM2(e)
 boards
Date:   Mon, 08 Oct 2018 14:50:02 +0200
Message-id: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7djPc7rLgnZHGxyeKG+xccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZZx4+IitYAp3xYw3zYwNjOc5uhg5OCQETCTWv/HqYuTiEBJYwSix8OIJFgjnM6PEievb
        mLoYOcGKTq+czAqRWMYosf5IG5TTwCRxfMFjsCo2AUOJrrddbCC2iEC2ROfjB4wgNrPAImaJ
        A8eEQWxhgWCJ3ev+sIGsZhFQlVjRYwwS5hWwkXjS9o4RYpm8xOoNB5hB5ksILGGTmNg6nRki
        4SIxq2kDC4QtLPHq+BZ2CFtGorPjIBNEQzOjRPuMWewQTg+jxNY5O9ggqqwlDh+/yApxEZ/E
        pG0gU0EBwCvR0SYEUeIhsf7rCrArhARiJW5t6meawCixgJFhFaN4amlxbnpqsXFearlecWJu
        cWleul5yfu4mRmDMnv53/OsOxn1/kg4xCnAwKvHwBvjtihZiTSwrrsw9xCjBwawkwiu6HSjE
        m5JYWZValB9fVJqTWnyIUZqDRUmcd9m8jdFCAumJJanZqakFqUUwWSYOTqkGxvqgM6uPH/t2
        jodfb9uHKBe/qNLIFcddHhVw6pbc6XftOfb7WGn53uRLy5QfLXKc7rNV8eaLWenHj3qoHi1d
        0TNT4pn/xM3vI1tTT2dOCf+iUS/Q/+55Rrj3lX+5n0KmhXZt9XsrvPbP4TfTg9mf3dtixZd1
        b/d2z4K3wXapTvfVo0NV11f0LFNiKc5INNRiLipOBACK4Exq1QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsVy+t/xy7pLg3ZHG8zfrGaxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZZx4+IitYAp3xYw3zYwNjOc5uhg5OSQETCROr5zM2sXIxSEksIRRom/2fRYIp4lJ4s/B
        NkaQKjYBQ4mut11sILaIQLbE/L3d7CA2s8ASZomb9x1AbGGBYInd6/4A1XBwsAioSqzoMQYJ
        8wrYSDxpe8cIsUxeYvWGA8wTGLkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAyrbcd+
        bt7BeGlj8CFGAQ5GJR7eAL9d0UKsiWXFlbmHGCU4mJVEeEW3A4V4UxIrq1KL8uOLSnNSiw8x
        SnOwKInznjeojBISSE8sSc1OTS1ILYLJMnFwSjUwOom734p2/r9W+uYKjcfpJgnv369e5iqR
        yrPEzCVLu/Ywl9l5hlbBeu0vD+WmLeLbv/i/qdYtTbkHWl/upqsaXTIRPrb8ZuqLvoQTGhJP
        Kt9FZk6f5znrmNOD025/DvUlbrdt+hRRtGzt2ciPk9LU7rca3dGMzeF6e6iKh09s4tylUYqv
        Fh0TVWIpzkg01GIuKk4EAO7h3sAnAgAA
X-CMS-MailID: 20181008125045eucas1p12e1d77f5f605556d4cf6c3b87832fae3
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125045eucas1p12e1d77f5f605556d4cf6c3b87832fae3
References: <CGME20181008125045eucas1p12e1d77f5f605556d4cf6c3b87832fae3@eucas1p1.samsung.com>
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


Patch summary:

Marek Szyprowski (7):
  clocksource: exynos_mct: Remove dead code
  clocksource: exynos_mct: Add arch_timer cooperation mode for ARM64
  clocksource: Change CPU hotplug priority of exynos_mct driver
  clocksource: arch_timer: Add support for not-fw-configured timer on
    ARM64
  arm64: dts: exynos: Move arch-timer node to right place
  arm64: dts: exynos: Mark arch_timer device as not-fw-configured on
    TM2(e)
  arm64: platform: Add enable Exynos Multi-Core Timer driver

 arch/arm64/Kconfig.platforms                  |  1 +
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 23 ++++++-------
 drivers/clocksource/Kconfig                   | 11 +++++++
 drivers/clocksource/arm_arch_timer.c          | 15 +++++++--
 drivers/clocksource/exynos_mct.c              | 32 +++++++++++++------
 include/linux/cpuhotplug.h                    |  2 +-
 7 files changed, 60 insertions(+), 25 deletions(-)

-- 
2.17.1

