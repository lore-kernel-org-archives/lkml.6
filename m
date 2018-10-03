Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0671C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9DA2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h/BFf8ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9DA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJCQ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:28:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55539 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJCQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:28:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181003094055euoutp019fc6cdd2fbbdf2e179c0bb41af00a76e~aD9r3Vkrj2366523665euoutp01x
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 09:40:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181003094055euoutp019fc6cdd2fbbdf2e179c0bb41af00a76e~aD9r3Vkrj2366523665euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538559655;
        bh=Vuo3rFMpueR0LzyNnG4djGbZy1qSrZwoDDNGWTTzV1M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=h/BFf8ksxvhOfR1SiEqNCeIE/4TNZ81ZLWHITwuDy+es6poGOsnMf8/lirarlSXVh
         0u93MvmM6IEpcF2FdzA45Az3S4Qq8sYOXxoRM/sa060rNCcHwyaBiPxZBjNJBqc+dz
         57zw5Acue/u1scGHPto2NOHhywdnp01nm818eeOE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181003094054eucas1p13f8d852a38722ff657206b136e831dd0~aD9qsaEXO1866618666eucas1p1C;
        Wed,  3 Oct 2018 09:40:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.11.04294.6AE84BB5; Wed,  3
        Oct 2018 10:40:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B;
        Wed,  3 Oct 2018 09:40:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181003094053eusmtrp29c4129bc6c1ba7d302690382434a05df~aD9plKbhO0629006290eusmtrp2B;
        Wed,  3 Oct 2018 09:40:53 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-e9-5bb48ea638ac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CF.3C.04128.5AE84BB5; Wed,  3
        Oct 2018 10:40:53 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181003094052eusmtip1574908308fb6208d9d301baa91315122~aD9osNMPp0977809778eusmtip1J;
        Wed,  3 Oct 2018 09:40:52 +0000 (GMT)
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
Subject: [PATCH 0/2] drm/exynos: decon: Add properties
Date:   Wed,  3 Oct 2018 11:40:42 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+c690eI0Db9MJCYFJald+cCopIhDdKe/GqFHPai0WeyoaRl2
        gWozLymrdbNWuWpW1ra8TKxc0jRrKywzY2mJYNMyryio5Txa/z3v8/4eHnh5GVzhJIOZlNQ0
        QZvKq5WUjKh4NeZZYc63q6JGW+So7ZGbRHnuRgw9MZaTyFVTCtCH4T4KVXc4aFTUXkig7q/v
        CVTQ2YMjj+cxjd6e6qWRtbOFRM2OaxQyep5hqKCqjkQP6700MvU/JZC3uB4gY/EPalMA96Dk
        AeCsFh3FVY50kFxJ4x6uPdeFcbY7OVx1US3GuRxtNJdvtwBu0Bq6W7Zftj5RUKdkCNrIDXGy
        ZN8VG3b4IpHZd90AToByXA/mMJBdAwfrPpJ6IGMU7D0Az9fqZoYhAC/nlmF+SsEOAmjUZc4m
        8j6fxSToLoBmQwP4l+h400D7KYpdC794Byi/DmTD4MQFyzSEs80k9NwyEf5FALsODhU8nupj
        GIJdAr+550oNofCzW4f7eci6adha+nKal7MZ0Nv1iZKgLbDL9GNGB0Cfy05LOgT+qb6BSeHT
        ALYNtZDSUAhgXZmekKhoaG31Yf5mnF0Gyx2Rkh0D7zeMUH4bsvNg68/5fhufkkUVl3DJlsNz
        ZxQSvRT22O3UbG334DCQNAcN/RO0dLkDsPSFni4EoVf+d90EwAKChHRRkySIq1KFIxEirxHT
        U5MiEg5prGDqs5omXUNVwDEe7wQsA5Rz5VUmm0pB8hlilsYJIIMrA+X5/JQlT+SzjgraQ7Ha
        dLUgOsEihlAGyc0lT1QKNolPEw4KwmFBO7vFmDnBJ0Bw3OiuvBFXq6pn9fbvxl8tI6S3MXFB
        DHPXlLt+4fHN4Q/jl2VHv8vMMYa/du30xYbAjoQd45Ua27GgHeNfw2q+jIb28E3Gi8hQbuYz
        xgZUkycza32G12Hqyd59TRu3Ri3eH79vW16+M4V6YYvU3F5X/9z3a686u1/3YYH+d9fJq0pC
        TOZXLse1Iv8XI44LtFUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7pL+7ZEGxy/xmVxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1nsfLCL3WLS/QksFi/uXWSx6H/8mtni/PkN7BZnm96wW2x6fI3V
        4vKuOWwWM87vY7Lo33GQ1WLtkbvsFgs/bmWxuDv5CKPFjMkv2RyEPdbMW8PosWlVJ5vH9m8P
        WD3mnQz0uN99nMlj85J6j52T9jJ5HN91i92jb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ml7N2sxUMI2l4v3cqYwNjOuZuxg5
        OSQETCR6b7YzdTFycQgJLGWUWHpwGStEQkZi3tk+NghbWOLPtS42iKJPjBL3b+4CS7AJmErc
        vvsJzBYRUJb4O3EVI0gRs8BDVon3CzvBEsICZhJf+jcATeXgYBFQlXh4jgckzCvgIbGo4SbU
        MjmJm+c6mScw8ixgZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGCvbjv3csoOx613wIUYB
        DkYlHt6E+ZujhVgTy4orcw8xSnAwK4nw9iUChXhTEiurUovy44tKc1KLDzGaAu2eyCwlmpwP
        jOO8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2MleJNUbvz7ubO
        ydJKnZysYO4nk/1zP8vUR/+m6v/+Mu3CjL+HN7y9ZLnja/i7gl8G8edPsBZ9z5F6YXRHJPj6
        y16ZJ//5FfkNzbx+me13iZxofnLd64YO21Wq7nduLc/YNDmm6OunoydXzZhmu1N4jorHh7/f
        sx4ZVHTmbhcurms7UfHvycJHW5VYijMSDbWYi4oTAY2wXMqrAgAA
Message-Id: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
X-CMS-MailID: 20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996
References: <CGME20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds two new configurable properties
to exynos5433_drm_decon.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode property.

Regards,
Chris

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 51 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       |  5 +++
 2 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.7.4

