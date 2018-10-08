Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB3C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D772204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tOo588cJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D772204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJHQoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:44:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33018 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:44:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008093328euoutp02b13b538a90d02aed1bba8be3ff1c70a3~bmFmWlVu41777817778euoutp02v
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 09:33:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008093328euoutp02b13b538a90d02aed1bba8be3ff1c70a3~bmFmWlVu41777817778euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538991208;
        bh=2yfVDftmxn6b+N+BDZbGbwKfakj9kNYaq50m8UDxsfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOo588cJfxatOZCo9L7MLI+Zd87au4jghkUYssijow79ZGDcqQpj0Vt3UETMWfM5U
         IT0ijxFakoHL9gZneXQ3+GzvYFYUPnxkW8gRbEM5Ir82/VvJlBASO25gjtEB3xP8zd
         Q7bKVAEkJhbCVQYzUzXpOb3u4A2EqanvkrEvRj+k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008093327eucas1p1bc29705b3c6f3fe7364e1ab3c736d692~bmFlQtyFU2623326233eucas1p1f;
        Mon,  8 Oct 2018 09:33:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.A2.04806.6642BBB5; Mon,  8
        Oct 2018 10:33:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008093326eucas1p24634c69cc44d324b377755af1f761241~bmFkaQ-gm0356403564eucas1p2g;
        Mon,  8 Oct 2018 09:33:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008093325eusmtrp18790e0437cd69f633ee50c0e55509ce5~bmFkIMfUd0078200782eusmtrp1f;
        Mon,  8 Oct 2018 09:33:25 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-09-5bbb24666328
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.7B.04128.5642BBB5; Mon,  8
        Oct 2018 10:33:25 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008093325eusmtip21775678b4e4fc6fbdb7ad086c7043349~bmFjcf1n90534205342eusmtip2q;
        Mon,  8 Oct 2018 09:33:25 +0000 (GMT)
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
Subject: [PATCH 0/2] drm/exynos: fimd: Add properties
Date:   Mon,  8 Oct 2018 11:33:00 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7ppKrujDR6+0bG4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEVx2aSk
        5mSWpRbp2yVwZSzrPctS0MNS8evqDZYGxrnMXYycHBICJhLzv51k72Lk4hASWMEoMX13AzOE
        84VR4vWi30wQzmdGiQedH5hgWj4e7YNKLGeU+HevhRWu5fS2+6wgVWwCphK3735iA7FFBJQl
        /k5cxQhSxCywlUVi78kbQO0cHMJARWvOS4PUsAioSrw98IAFYoOcxM1znWAHcgqUS6y/0wt2
        k4TAJnaJyc23wBK8AmUSa069YIRocJGYuWUnVLOwxKvjW9ghbBmJ05N7WCCamxklbn25xgrh
        TGCUOLi6C6rDWmLTjVdgFzELaEqs36UPEXaUWPL3JCNIWEKAT+LGW0GQMDOQOWnbdGaIMK9E
        R5sQRLWaxOstW9hg1r74/BXqNA+J220tbJAAOsUoceh8F9sERvlZCMsWMDKuYhRPLS3OTU8t
        Ns5LLdcrTswtLs1L10vOz93ECExAp/8d/7qDcd+fpEOMAhyMSjy8AX67ooVYE8uKK3MPMUpw
        MCuJ8IpuBwrxpiRWVqUW5ccXleakFh9ilOZgURLnXTZvY7SQQHpiSWp2ampBahFMlomDU6qB
        8VJtqPxDJZ2QR2eCCtXZDWb/fKPlJu6w2H3RrFrNVTJWjSkZ73yDpq/ZssEkUHWN/Orqq063
        GSayJHzOtizJTVE2ZW5KrmTZmXhSNHMap3L327z9ZlGvY5ZrnnqzRzqLTyyp+6lM0IZYs9y7
        YR6Vp8//679XctV7I0NoWuui4Fl6Lst4C+SUWIozEg21mIuKEwFXL1lkPAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Pd1Uld3RBpcX61vcWneO1aL33Ekm
        i40z1rNaHN+9lNHiytf3bBaT7k9gsXhx7yKLRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz
        mHF+H5PF2iN32S1mTH7J5sDvsWlVJ5vH9m8PWD3udx9n8ti8pN6jb8sqRo/Pm+QC2KL0bIry
        S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mpb1nmUp6GGp
        +HX1BksD41zmLkZODgkBE4mPR/uYuhi5OIQEljJKHD06nR0iISMx72wfG4QtLPHnWheYLSTw
        iVGi93YGiM0mYCpx++4nsLiIgLLE34mrGEEGMQscZJFo2XgGyOHgEAYqWnNeGqSGRUBV4u2B
        BywgNq+Ah8SMIz8YIebLSdw81wl2EKdAucT6O73MELvKJD5N28c4gZFvASPDKkaR1NLi3PTc
        YiO94sTc4tK8dL3k/NxNjMBY2Hbs55YdjF3vgg8xCnAwKvHwrgjYFS3EmlhWXJl7iFGCg1lJ
        hFd0O1CINyWxsiq1KD++qDQntfgQoynQUROZpUST84FxmlcSb2hqaG5haWhubG5sZqEkznve
        oDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgXFX3FX2HevuaCtFPMm/dr6jYIr8Iq4Jezxm3bRNsmE7
        e8vm6BNJqRAfHbaDT99cemgTNiuLK3F20BrzAgfTHZs/d3w+7JR09myJ668fM2f/bZa9+22T
        1dqbS4SfTr/2vOVv8pyF5e8yzXLmOk9XMWXsnr/68skYz28V2zS8997cd+aUZE/rs/93lFiK
        MxINtZiLihMBaZj1vZsCAAA=
Message-Id: <20181008093326eucas1p24634c69cc44d324b377755af1f761241~bmFkaQ-gm0356403564eucas1p2g@eucas1p2.samsung.com>
X-CMS-MailID: 20181008093326eucas1p24634c69cc44d324b377755af1f761241
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181008093326eucas1p24634c69cc44d324b377755af1f761241
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008093326eucas1p24634c69cc44d324b377755af1f761241
References: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
        <CGME20181008093326eucas1p24634c69cc44d324b377755af1f761241@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds two new configurable properties
to exynos_drm_fimd.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode property.

Regards,
Chris


Christoph Manszewski (2):
  drm/exynos: fimd: Make plane alpha configurable
  drm/exynos: fimd: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 87 ++++++++++++++++++++++++--------
 include/video/samsung_fimd.h             |  2 +
 2 files changed, 69 insertions(+), 20 deletions(-)

-- 
2.7.4

