Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2F6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F02098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J3A17h5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5F02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeJRUxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:53:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40003 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJRUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:53:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018125207euoutp0287860760bb56037ea2d300527c3e281d~etP51QdTJ2999229992euoutp02C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:52:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018125207euoutp0287860760bb56037ea2d300527c3e281d~etP51QdTJ2999229992euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539867127;
        bh=3xno9Z7sEAY3cPlooPANUF1o9nTpBqiGUvuxoxbhbG0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=J3A17h5NHAqKZXEyfqyozov4Yajq3u1fSVa1fsyaCHadkxQSEOLMl1K+XqXOPX21u
         6diwguPIq0Z9xpbI7oxrYSLyvncuS/7OWpM265dHNltL+pflJjrnPSjUYqLGt9Izvb
         P/lhNE6DUUj13LRlsahot0HjG9Kpos9CVOaPt5xU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018125206eucas1p1103219465f8cdb9b4a1efa05402d100d~etP4uwIAh0072300723eucas1p1B;
        Thu, 18 Oct 2018 12:52:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.AC.04441.6F188CB5; Thu, 18
        Oct 2018 13:52:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032~etP3p4mTk0073500735eucas1p1P;
        Thu, 18 Oct 2018 12:52:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181018125204eusmtrp16c58b3b0ee7d6687f0c045e677c1cef7~etP3Yzih82976529765eusmtrp1K;
        Thu, 18 Oct 2018 12:52:04 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-bd-5bc881f605a0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.CA.04128.4F188CB5; Thu, 18
        Oct 2018 13:52:04 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018125204eusmtip1b7a3348b079c7e5f02b38eae6586f5ce~etP2nrKAh2115921159eusmtip1T;
        Thu, 18 Oct 2018 12:52:04 +0000 (GMT)
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
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Lowry Li <lowry.li@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v3 0/2] drm/exynos: decon: Add properties
Date:   Thu, 18 Oct 2018 14:51:45 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTURzv7N67ex0tblPwaCWyKFTwBVpHDFMIut+qb9XosfIyJae2qWVF
        mUI+stRJKTFMl73MNNd0OlFwSfPV5qN85XwgkvNVPlNMydu1+vZ78j/8OBQmaSLcqejYBFYV
        K4+RCkV4zcc1q+/K3RZZQLqZQIMVVgI9sLYKUFVhJYEs9c8B+rz8XYjqRk0k0ozk4mhyuAtH
        OePTGLLZ3pHoU+oMifTjvQTqMWmFqNDWKEA5tU0EettsJ1HJfDWO7PnNABXmO4Thzkx5UTlg
        9GWZQsa4MkowRa2nmJH7FgHzvvQOU6dpEDAW0yDJPDSUAWZR73FSdFZ0JJKNiU5iVf5hF0VR
        eRlGPP4pcf1Xnx1PAY/wLEBRkA6CXzQ+WUBESehXAKatF5I8WQJwQjNBZAGnLbII4MbCeQ5z
        hdL0AQGvvwRwzkL8K/ysGcM4Q0gHw6/2BSGHXej9cCOvDHAhjO4hoE1XgnOGMx0Cs9vWSQ7j
        9AE41KfF+AsecMCaiXEFSFtJ2D3W8OcZYjoJFmfXkXzoGOxqfI3z2BlOWQzb+l7Ynp+N8+U0
        AAeXegme5ALY9CZruxEK9f1TAm4BjPaGlSZ/Xo6Axl4D4IfZBftnd3MytgU1NQUYL4thxj0J
        nz4Ipw0G4d+zk4vLgMcM3HSUbi90DlbNmEEu8Hjy/1YxAGXAlU1UKxWsOjCWveanlivVibEK
        v8txSj3Y+ljtm5aFWrDcfckMaApId4pHWYtMQsiT1MlKM4AUJnURr6W0yCTiSHnyDVYVd0GV
        GMOqzWAPhUtdxS+KqmQSWiFPYK+wbDyr+usKKCf3FJC0Ly71RKjskJuis1XbPq9KLO0f927K
        1XUYV4//qDG8iQTPcGOwLWdutLe4Y9U0sJB/Vel7ps9D56nq9FTIvmX2aMKe61x33PJq8LK6
        1Dv8x7vbjoo+uNXdLKeSHQPagALtxTHd7LmhavsgOPw46HSI+8Tc7Z611Yhwsm94sUKKq6Pk
        gT6YSi3/Damb1H1UAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7pfGk9EGzw6Y25xa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1nsfLCL3WLS/QksFi/uXWSx6H/8mtni/PkN7BZnm96wW2x6fI3V
        4vKuOWwWM87vY7Lo33GQ1WLtkbvsFgs/bmWxuDv5CKPFjMkv2RyEPdbMW8PosWlVJ5vH9m8P
        WD3mnQz0uN99nMlj85J6j52T9jJ5HN91i92jb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MiZ2bGcpmM9a8ef6XZYGxqksXYyc
        HBICJhJL2m8ydTFycQgJLGWUuDF3LhtEQkZi3tk+KFtY4s+1LjaIok+MEtP+HwJLsAmYSty+
        +wnMFhFQlvg7cRUjSBGzwENWifcLO8ESwgKWEj2nfrOD2CwCqhJ3rs9hBrF5BdwlvszYDLVB
        TuLmuU7mCYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRGy7ZjP7fsYOx6F3yIUYCD
        UYmH90Hq8Wgh1sSy4srcQ4wSHMxKIrzODSeihXhTEiurUovy44tKc1KLDzGaAi2fyCwlmpwP
        jOS8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2Moc0OlUdjQxRC
        d53+5LQkdKLZK/knj8MrzqV3pEiaGxzjNzs0OZu7bc63d0+FmhYx1X5w0JDasHLuiUOzV3sd
        8hDsFF0isI5pbR5vVX7WFW0Wfr2AmAOHNp6w6KgoWyC4vmWf/rZC5nKN2Bs83x4e8Nu236Qw
        RyP15QTr/aYXDk3edfDbrjn5SizFGYmGWsxFxYkAK3shR6wCAAA=
Message-Id: <20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032~etP3p4mTk0073500735eucas1p1P@eucas1p1.samsung.com>
X-CMS-MailID: 20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032
References: <CGME20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In patchset v2, accidentally wrong patches were sent - sorry for that.

Regards,
Chris

Changes in v3:
 - fix compilation error,

Changes in v2: 
 - add premultiplied pixel blend mode (i.e. make it functional),
 - correct minor issues from v1, 
 - refactor code in order to adapt to above changes.

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 84 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       | 22 +++++++
 2 files changed, 104 insertions(+), 2 deletions(-)

-- 
2.7.4

