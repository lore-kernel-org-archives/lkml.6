Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D96C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746742083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tdqibk0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746742083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJRRgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:36:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45202 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeJRRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:36:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018093635euoutp0123cbeee9ec3f1af645fcc73bb1179bbd~eqlLSK4sU2384523845euoutp01D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:36:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018093635euoutp0123cbeee9ec3f1af645fcc73bb1179bbd~eqlLSK4sU2384523845euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539855395;
        bh=ck+YRKBrLAyMBpIJP79lvk5l/3veGfxdtvX8JQb0BAY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tdqibk0SGIoP27vuIvBTXZDqfYjUJGzzIDLDxmthsuv/SDk8QUsT4SX8IngN2GXRS
         7zlv8CnuB7AWrhouKCsQeVHXLHZp1oXMYtpY24tcZQn5uVTKoypRfXb6eisSWE4Qij
         hOMJGDu1HKqHJCqT0Q7toGo++GaF5ytblVdHRBSM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018093634eucas1p2591c9c5f24d9e8abc53757243a7eed0f~eqlKKjtfP0228402284eucas1p2C;
        Thu, 18 Oct 2018 09:36:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AC.AE.04806.12458CB5; Thu, 18
        Oct 2018 10:36:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc~eqlJTAnxg2418824188eucas1p12;
        Thu, 18 Oct 2018 09:36:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181018093632eusmtrp2257f8557739511d3df4d31b11e227cff~eqlJBrgKk2801628016eusmtrp2V;
        Thu, 18 Oct 2018 09:36:32 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-bb-5bc854211d55
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.10.04284.02458CB5; Thu, 18
        Oct 2018 10:36:32 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018093632eusmtip1b760ca2216f8ade8dfd5f74aa3b647dd~eqlINpVYT0295602956eusmtip1h;
        Thu, 18 Oct 2018 09:36:31 +0000 (GMT)
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
Subject: [PATCH v2 0/2] drm/exynos: decon: Add properties
Date:   Thu, 18 Oct 2018 11:36:08 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTUQDm3LejxXVKnTKVFgYFamGPU0YqCV0IIqNfieS0yxTnjE1nVuB6
        oot0zcKRpmmWYj5yTtNZxtSckm2YIWb5APORWlJLTUvLeY3+fed78J3vcBhc8pLczMQrk3mV
        UqaQUiKivn3B7r/1VEfkroy6QNRfZSfRLXsnhmqM1SSyNT0C6N3sDIUahy00MgzpCTQx2E2g
        7JEpHDkcT2n05so0jUwjvSTqseRTyOhoxlB2g5VElW0DNCr6VkeggZw2gIw5n6lQD66ioAJw
        pvJMins2N0xyBZ0R3NBNG8bVlqRzjYYXGGez9NNclrkccE6TzwnRadGhs7wiXsOrAg9Hi+IW
        Fhfpcx3k+aVKB9CC54QOuDGQ3QPvW7UrWMRI2DIAH49O0S5Bwv4AsLXpkiA4ATT/KqZ0gFlN
        WMakgqcUwDujmwTPit/Unoe5BIrdCz8MfKdc2JPdBpdulwOXCWd7SOgoLlqt9mAPwPHRVtyF
        CdYP5s8v0sKVfOB7eybuCkD2LQ2X9TmkDtCMmNVAo49gCYd99p+4gD3gpM28Ft0C/zQWYkL0
        KoD9P3pJ4aAH0PpEt7Y5GJr6JjHXGpzdAastgQIdBrOnH2LCyPWw74u7i8ZXoKE+FxdoMcy4
        IRHc2+GU2Uz9q51wzgIBc7B5TAuE94mC+a+yKD3wufe/6wEA5WAjn6JOlPPqICWfGqCWJapT
        lPKA2KREE1j5Vq+XbbMNoPl3TAtgGSBdJx7mbZESUqZRpyW2AMjgUk/xxX0dkRLxWVnaBV6V
        dEaVouDVLcCLIaQbxY8LaiIlrFyWzCfw/Dle9U/FGLfNWmCdj627fnfmuLXrSszDsA264Mvj
        FrxsIWGp+5HeeVSRnpOtDCUynk17KXLF9qYyeMTP133dYOGgrKqvdCI8WtUd5n1Q/zHO6xNw
        KqKO5c3bAtsNbxuG/Du6euXe5huaKlNIgu+kKshUP3dyJGS/7uu12qqSN73uqeyhiFKD1FNK
        qONku3fiKrXsL1n7eaJSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcQDF++9+Kg4u28TLEolZQZFX55z7L1SMAi/UQ6IP4RIdelPRbbK7
        aVaQRhQaqdOXSTIS1AdRyy2/1oc6xc1Cl2mCytIYZaJpKiVKSpvS2+Gc3+E8HBIRWVEpWaQ3
        cUa9tkSGh6IfDt2+mFOZHk3ccG0cXOiewuDTqQkB7LG+wKD7dRuAs783cTi47CRgw1I9Cn98
        mUZhnX8NgV7vSwJOPlgnoN0/h8EZZzMOrd53Alg3MILBrjEfAVu2elHoaxwD0Nq4iqeK2U5b
        J2DtHdU42/9nGWNtE+ns0hO3gHW03mcHG94KWLdzgWBrX3UAdscedT00i0kyGswm7lShgTcl
        yzRyGM/I1ZCJT1AzcoUq+2K8UhabkpTPlRSVccbYlFymcG9/nyj1YLcPurygErxBawBJ0lQC
        7fwuqwGhpIhqA/Tn9/MBPyTgR9K2yVr8WIvpv3M1+DG0DejmWRcWDHBKSS/6to8gCRVNH1g6
        QBBCqK8YvdlSfRSIKTW98m0UCWqUOkM37+4TQS2kWHro0RpxvBBFz09VI/Ug7Dk40QEknJnX
        Feh4OcNrdbxZX8DkGXR2EHilb3zPMQA+9WS4AEUCWZhwmXNrRJi2jK/QuQBNIjKJ8G6iRyMS
        5msr7nBGQ47RXMLxLqAMjFsQaXieIfCx3pQjV8pVUC1XKVSKRCiLEHrjKrJEVIHWxBVzXCln
        /N8TkCHSSqCITD5nH+/rTz0kZyQOXzdTZWkfuaGvGro03LmRnrlzTzF6wVt+ucG+snm22Bcx
        fpofrbO1lSNIzFV/UvhCrFORu2vJ1tnU02jVw7QNqXh1qzU6xP7Yf+1Xrx/5SN1qXXzmBY5B
        fuLklZtN61xiLqpv8vx0b6W19GW0r7plKF+olZ9HjLz2Hwz5+I6rAgAA
Message-Id: <20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc~eqlJTAnxg2418824188eucas1p12@eucas1p1.samsung.com>
X-CMS-MailID: 20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc
References: <CGME20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc@eucas1p1.samsung.com>
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

Changes in v2:
 - add premultiplied pixel blend mode (i.e. make it functional),
 - correct minor issues from v1,
 - refactor code in order to adapt to above changes.

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 83 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       | 22 +++++++
 2 files changed, 103 insertions(+), 2 deletions(-)

-- 
2.7.4

