Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA885C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A502084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kVRe8ZfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A502084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJYX51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:57:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58700 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJYX51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:57:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181025152411euoutp02686642d995742dd5453d872d48b04bdc~g41q0to0n2073620736euoutp02F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:24:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181025152411euoutp02686642d995742dd5453d872d48b04bdc~g41q0to0n2073620736euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540481051;
        bh=UKrrHW45NLg3rlfVxk+0pH0sBGhR7EATxrxh/zG1CH8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kVRe8ZfKnvMPiQW99XqdSPogt0/UfShw0l7DzgRgcRi72psA8Jyp2F7LEGZP1WsR4
         srWRaJY4XTxUtBjQRaVQfIeUluzvDwnbu/HoKsZOOWmpqtErM0lAE0kQuZFbxwuswg
         a6MMEstQd5c81NB99oZYFmlky3hn9k0eAs5XB2P0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181025152410eucas1p2afe1496101091850a16bafd9e44bf637~g41prQuAe0198101981eucas1p2X;
        Thu, 25 Oct 2018 15:24:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.50.04294.910E1DB5; Thu, 25
        Oct 2018 16:24:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7~g41o9kz2u0946109461eucas1p2r;
        Thu, 25 Oct 2018 15:24:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181025152409eusmtrp212b3349a3c0b83e88d277b9ecb69ec3a~g41ouUwJH2641026410eusmtrp29;
        Thu, 25 Oct 2018 15:24:09 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-dc-5bd1e019ece4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 80.84.04284.810E1DB5; Thu, 25
        Oct 2018 16:24:08 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181025152408eusmtip183ae2301083ffe1b6b107475f7238700~g41oCaJwd2540325403eusmtip1w;
        Thu, 25 Oct 2018 15:24:08 +0000 (GMT)
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
Subject: [PATCH v2 0/2] drm/exynos: fimd: Add properties
Date:   Thu, 25 Oct 2018 17:23:48 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUhTYRjl3f3Ydbq6Tss3kwWLiqxcaeGNJArE9lMojBKtmRe/timbmvqn
        oUympenCNtSyKM2Ums413cRCy6aUs2HKVPwAqflZ1lQINNt21f6d5zznvOc88BII7xEWTKTJ
        smm5TCwR4BzU9PGP7cS+aXv8yZqnQmrstQ2jymz9LKpVp8coa2c9oL6u/sQpzVQFSs1O2lHq
        /swCQg0OtrCpgcJFNmWYGcGoIUstTukG37KoVx8m2JTuwRx+YbfI0FSCi9rXpjHR1F0rS9T2
        /I6o3NgERC4DPxa/zolKpiVpubRceP4mJ9VYM4xktWJ5o+pNthLUoaXAh4DkafiwrhYpBRyC
        RzYCWNZgw5hhBcCJ2jmcGVwAqi0DrB2LvgNlFi8AHHBpwI7lWdsc8Khw8gwcn/iNe3AgeRBu
        VDZ5RQj5BoVd/Q7vUwEkBWt7zWwPRslDcMh4D2ci+HDUVuJtBUktG06bCr0LLpkLq5TmrR7R
        0FpfgzE4AM5bjWwGh8BNcx2LMRcBOLYygjFDBYDdzaVbh5+DBse8W0W4Ox2FeouQoS/CznW7
        l4bkLuhY8vfQiBtqTFqEoblQXcxj1IfhgtGIb8fOulYBg0VQdY+5i0cmQFO5nlUB+NX/s54A
        0ASC6ByFNIVWhMvo22EKsVSRI0sJu5UpNQD3p/n017rSASzrST2AJIDAj9vX8iWeh4lzFfnS
        HgAJRBDI7Rq3x/O4yeL8AlqeeUOeI6EVPWA/gQqCuA2PW+N5ZIo4m86g6Sxavr1lET7BSqB9
        6ezIuyzpMSj5KUnyK3ZVToZv5KIpPTavS6f/4RyukamOtR/QTsapVRFXXc6i4PD2798SCvYU
        OHuvZaWnS8T+jtCpZd+YpaiNEF5iqu1IcWR68/vPZxvXlt9poqurNvscEct7K+OOd09mdDf+
        soZMmXsTL836sfucq8KhmCUBqkgVnwpF5ArxP6nHotYwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7oSDy5GG3yeZWFxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
        Ysb5fUwWa4/cZbeYMfklmwO/x6ZVnWwe2789YPW4332cyWPzknqPvi2rGD0+b5ILYIvSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9gy+ypzwUbW
        ipsd/9kbGOezdDFyckgImEhMW78DyObiEBJYyihx4+o1ZoiEjMS8s31sELawxJ9rXWwQRZ8Y
        Je7seA6WYBMwlbh99xOYLSKgLPF34ipGkCJmgYMsEi0bzzCCJIQFLCTmHN3JDmKzCKhKXN7S
        A9bAK+AhMfn6O6gNchI3z3UyT2DkWcDIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwvLcd
        +7l5B+OljcGHGAU4GJV4eE9suBAtxJpYVlyZe4hRgoNZSYR37+2L0UK8KYmVValF+fFFpTmp
        xYcYTYGWT2SWEk3OB8ZeXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYO
        TqkGxr7NkT6WnEbnPZWsnaPfHthyauGZ4EVa+zwWVq8V0TxT79phHLt16t+nZyxeMaZHli/c
        aPJ1jonH8aM3L9TLiJoKl4u5bOPJ/NXx7Yjf9qezGd8qPv2l7cQ/IStnfX2a706Rsr6H3aoi
        ny5e5dL5WjZdjnXxRs2F010Mf6wMOnFl7U5V9lVnvyuxFGckGmoxFxUnAgDecSLqhQIAAA==
Message-Id: <20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7~g41o9kz2u0946109461eucas1p2r@eucas1p2.samsung.com>
X-CMS-MailID: 20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7
References: <CGME20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds two new configurable properties
to exynos_drm_fimd.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode propery.

Regards,
Chris

Changes in v2:
 - add premultiplied pixel blend mode (i. e. make it functional),
 - correct issues from v1,
 - refactor code in order to adapt above changes.

Christoph Manszewski (2):
  drm/exynos: fimd: Make plane alpha configurable
  drm/exynos: fimd: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 123 +++++++++++++++++++++++++------
 include/video/samsung_fimd.h             |  10 +++
 2 files changed, 110 insertions(+), 23 deletions(-)

-- 
2.7.4

