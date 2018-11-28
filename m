Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA1AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EF0208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YZWTy+4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EF0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeK2Ceh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:34:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41068 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeK2Ceh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:34:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181128153233euoutp02735bdda6e1f4e8f8951b8fe652997881~rU4rl9RAr2504725047euoutp02V
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:32:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181128153233euoutp02735bdda6e1f4e8f8951b8fe652997881~rU4rl9RAr2504725047euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543419153;
        bh=0HGEL4TeTRJ8+NyBrGOVsVtYmddXP3QTLHE5H+MBUdI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YZWTy+4+8UQhmu1B8OjjsdcJYPrZ6rtVRL4dMo4144fJh/H7fF6DtQaA8barfqfCC
         5fjaPtSMS7rMu6Xkl30NezqEJOnHNM231gKGElD7XqUEiZiagF/uNT72qeZw8BKamu
         Vrc9xq05zF/rWU7XWcskAhMwARDbSNcVQ3gzai1Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181128153232eucas1p2c9d6811d09939c5456126cc479ee7a57~rU4qzbuHW2875428754eucas1p2t;
        Wed, 28 Nov 2018 15:32:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 11.A7.04441.015BEFB5; Wed, 28
        Nov 2018 15:32:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181128153231eucas1p1bd79250c2b5170c84e5614d22070826b~rU4qEBqm-3211532115eucas1p1D;
        Wed, 28 Nov 2018 15:32:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181128153231eusmtrp21e217cf75f9ebe98197a07a47051593c~rU4p0Uw6y1433514335eusmtrp2B;
        Wed, 28 Nov 2018 15:32:31 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-42-5bfeb510abbd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.44.04128.F05BEFB5; Wed, 28
        Nov 2018 15:32:31 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181128153230eusmtip22617f3fb2641cde93d25ac25ab7d2796~rU4pLSKZ12100421004eusmtip2t;
        Wed, 28 Nov 2018 15:32:30 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 0/2] drm/exynos: mixer: Fix color format and range setting
Date:   Wed, 28 Nov 2018 16:32:10 +0100
Message-Id: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRzGe3cuOw6nx83wxcIPE+0CeSmzE4kkFJyyzD7Uh6Rs6kklN21H
        LQ1sKUYqmWmXKZEWhjZJbU5Ny8RhDak2K/Fu3qi8heU2xbTVtqP17Xl//9/D8+UlEFEZ5kkk
        ylMZhVyaJMEFaNObZeMOstEaFWCqdaEGaw0YdcPQxaOeqeowSv/iMaB6LPM4VTxahFJTnz+g
        1M3JWYQyGuv51PvsOT6lmezFqE+t93FKZXzFo552jvApVck0vt+V1qjzcLp5cQyjRwv0PLqh
        8gpdqFUD2qTxisRPCULimKTEdEbhH3pWkLCgUiEpq8ilhwNdmBKokHzgREAyCCr7vmL5QECI
        yGoAcwsnAPcwA1jQVwHslog0AVhfHbvemLAurUlVAKrnO5F/jXe5LTy7hZO74dDIAm7P7qQ3
        /H1L7WggZCMK27r6HZKYPAy1qzqHhJI+sFmtt3GCEJI0nK/K4Na84IAhzzEAyRI+/LVSz+cO
        B+BQST7OZTGc0WvX+Gb4p6WcxxVyABw092LcowjAjpp8lLP2QU3/jGMNIbfBulZ/DofBcUsd
        YseQdIH9393sGLHF4qZ7a1gIr18TcbYvnNVq8fXZKZMFcJmGLdmcLiJPw/KGC0XAq+z/VAUA
        auDBpLGyeIYNlDMX/VipjE2Tx/vFJss0wPZj3lr1C8+B5WOMDpAEkDgLYY01SoRJ09kMmQ5A
        ApG4C9NCbUgYJ83IZBTJ0Yq0JIbVgU0EKvEQXt4wFiUi46WpzHmGSWEU61ce4eSpBEGLykPD
        T0zhWXejOwxLhsWrrmzE0ePdsiORwRHJxx68TO7eafURl+4drjXfOYfnJJSbp785/Yjy0j0q
        PjkZ/tMZFbS3q5fDt2ZNpEasZK4AOmxIV04PbWzz+9LRM7rcE+Tme7vSe7ysLtjtdcyeoi3i
        EwdDSs/w1SMBPeb2uV3NEpRNkAZuRxSs9C/2haKVLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xe7r8W/9FG3S9Ere4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEXp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXyaMYO54A9z
        xcKbJ1kbGGcwdzFyckgImEg8+vedsYuRi0NIYCmjxOnLa6ESMhLzzvaxQdjCEn+udbFBFH1i
        lNj44hZYgk3AVOL23U9gtoiAssTfiavAJjELHGSRaNl4hhEkISzgJbHlzyGwIhYBVYntq44z
        dTFycPAKeEi8X14JsUBO4ua5TuYJjDwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBAb3
        tmM/t+xg7HoXfIhRgINRiYf3wIp/0UKsiWXFlbmHGCU4mJVEeEvtgEK8KYmVValF+fFFpTmp
        xYcYTYF2T2SWEk3OB0ZeXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYO
        TqkGRvZtvedtnzGGzVW9lVcmEORw24tHfMMTb57MT8crgg6cvZvsJbRyyaOc9veOfLkrs7Wq
        Qs48PzNz2U2VO2d1n7h3N+i52XmmWS8V5NX5XSrydLfmrHA1009PpsqeYKt5OJdbd97vkmUT
        pUu/NZcETDnkmFb2r/LfidKpctf6Jt07YMG0/c+Ch0osxRmJhlrMRcWJAEbdqzKEAgAA
X-CMS-MailID: 20181128153231eucas1p1bd79250c2b5170c84e5614d22070826b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181128153231eucas1p1bd79250c2b5170c84e5614d22070826b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181128153231eucas1p1bd79250c2b5170c84e5614d22070826b
References: <CGME20181128153231eucas1p1bd79250c2b5170c84e5614d22070826b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series fixes the color format and color range setting
in exynos_mixer.c

Patch 1 fixes color format setting.
Patch 2 fixes color range setting.

Regards,
Chris

Christoph Manszewski (2):
  drm/exynos: mixer: Fix color format setting
  drm/exynos: mixer: Fix color range setting

 drivers/gpu/drm/exynos/exynos_mixer.c | 25 +++++++++++++------------
 drivers/gpu/drm/exynos/regs-mixer.h   |  9 +++++----
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.7.4

