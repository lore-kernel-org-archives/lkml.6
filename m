Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40908C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A41204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vVNPpO0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A41204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeIJRpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:45:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44722 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeIJRpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:45:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180910125104euoutp02121e2ad112842fa354cdb37dd19a9760~TCuI9y4751277912779euoutp02G
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 12:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180910125104euoutp02121e2ad112842fa354cdb37dd19a9760~TCuI9y4751277912779euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536583864;
        bh=ypbjOLndNJqAAulvloZBVdYQRWSgTTtXktdAR8+U+kE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vVNPpO0SLsTC6K4c40ALg2Pk5AT1VZ3ycdpSMqY2U3mBZBGpwOIkPF6VsoBblomkv
         aLrPxmh2/h8blJdcscIs2FaoFMvpMlwoIQuqxX8mxULYK2BljLHOzSNpnGKAF3cTi7
         KYCpdN1lAGylRs6P8nD7QtpUfEKKlln7acmpOYiQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180910125103eucas1p19706c6ccaf6155e7d14ea4aafab39a44~TCuIPLCX-0751307513eucas1p14;
        Mon, 10 Sep 2018 12:51:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.56.04441.7B8669B5; Mon, 10
        Sep 2018 13:51:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180910125103eucas1p1e7da7341048a5e54a89e21a94559f576~TCuHaF7jg0750707507eucas1p1q;
        Mon, 10 Sep 2018 12:51:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180910125102eusmtrp13e76e8a49e52181906d29f8162f820a1~TCuHJTukm1989119891eusmtrp1a;
        Mon, 10 Sep 2018 12:51:02 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-83-5b9668b7bcfa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.65.04284.6B8669B5; Mon, 10
        Sep 2018 13:51:02 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180910125102eusmtip2f693f896e77efb6b32be2af2731c7080~TCuG1rXeb0989509895eusmtip2c;
        Mon, 10 Sep 2018 12:51:02 +0000 (GMT)
Subject: Re: [PATCH 3/4] fbdev: Add FBINFO_HIDE_SMEM_START flag
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 10 Sep 2018 14:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180822085405.10787-3-daniel.vetter@ffwll.ch>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rbM6ZFG/y7pmCx8OFdZovlZ9Yx
        W1z5+p7NYvaEzUwWZ7pzLU70fWC1uLxrDpsDu8fshossHnu/LWDxWLznJZPH/e7jTB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZVyffJax4A5HxY8pJ5gbGOexdzFyckgImEg09q9k7WLk4hASWMEo
        8fXtXCYI5wujRPONCWwQzmdGiS+nmlhhWjZ864dKLGeUmDS9Bcp5zyjx4OVUNpAqYQF7iU2P
        f4ItERGIlzg8YzU7SBGzwCVGickfrjCBJNgErCQmtq9iBLFZBFQl9i7uZeli5OAQFYiQ6D+j
        DhLmFRCUODnzCQuIzSlgI3Gn/QZYK7OAvMT2t3OYQWZKCCxjl9i+9gw7SC+vQJnEso1JEJe6
        SDy9fJYNwhaWeHV8C9TTMhKnJ/ewQPROZ5R482splLOeUWLNmWNMEFXWEoePX2QFGcosoCmx
        fpc+iCkh4ChxsMEOwuSTuPFWEOIcPolJ26YzQ4R5JTrahCBmqElsWLaBDWZr186VzBC2h8S7
        5y/ZJzAqzkLy5Cwkj81CWLuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYKI5/e/4
        px2MXy8lHWIU4GBU4uHlKJgaLcSaWFZcmXuIUYKDWUmEd5fOtGgh3pTEyqrUovz4otKc1OJD
        jNIcLErivHxaadFCAumJJanZqakFqUUwWSYOTqkGRhaNVSY+al3z+dlj9pr1vdK4OjXioOWp
        leeu/PjJyLco2PhN5EGJdW8PdzNrbz2dFyLmp5f71/IOz3NdQ7Nz5+tcvbsefOTYdO/Ltf0e
        AldZjPZHrld1m9LOVcG5sap606ROLT3f9ml7F0fd2v9q18rJt4QWprnaTQjs5y50ZG1q3Nh/
        NmT9IiWW4oxEQy3mouJEAM16+YQwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7rbMqZFG7xv07ZY+PAus8XyM+uY
        La58fc9mMXvCZiaLM925Fif6PrBaXN41h82B3WN2w0UWj73fFrB4LN7zksnjfvdxJo/Pm+QC
        WKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mq5P
        PstYcIej4seUE8wNjPPYuxg5OSQETCQ2fOtn62Lk4hASWMooseTDe5YuRg6ghIzE8fVlEDXC
        En+udUHVvGWUmNj6iQkkISxgL7Hp8U+wQSIC8RKdJ04zgthCAgcZJRb8cgZpYBa4xCgxZ+Jj
        FpAEm4CVxMT2VWBFvAJ2EidPPQSLswioSuxd3AtmiwpESNx62MECUSMocXLmEzCbU8BG4k77
        DbDFzALqEn/mXWKGsOUltr+dwzyBUXAWkpZZSMpmISlbwMi8ilEktbQ4Nz232FCvODG3uDQv
        XS85P3cTIzCGth37uXkH46WNwYcYBTgYlXh4OQqmRguxJpYVV+YeYpTgYFYS4d2lMy1aiDcl
        sbIqtSg/vqg0J7X4EKMp0BMTmaVEk/OB8Z1XEm9oamhuYWlobmxubGahJM573qAySkggPbEk
        NTs1tSC1CKaPiYNTqoGxfcKOo199WaUeTWH+X7172cXPv9xnM0lX3WR5Z/p6UlnIwR+J649u
        4Qh+fPv/+0vy+gtS688tyrPsPX6P5/qK6QdWXRQVMvwY16V4Tj5XVenO1AfrozgmzvpvfflY
        xEKx6Vvv2XBe/uYhml5fHx7LGl+bVuFg/G/LGsaWAp6z3afcwrIVZj1kUGIpzkg01GIuKk4E
        AE59R763AgAA
Message-Id: <20180910125103eucas1p1e7da7341048a5e54a89e21a94559f576~TCuHaF7jg0750707507eucas1p1q@eucas1p1.samsung.com>
X-CMS-MailID: 20180910125103eucas1p1e7da7341048a5e54a89e21a94559f576
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180822085420epcas1p1725a9444c93e8deb30d253d0fea2d5d6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180822085420epcas1p1725a9444c93e8deb30d253d0fea2d5d6
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
        <CGME20180822085420epcas1p1725a9444c93e8deb30d253d0fea2d5d6@epcas1p1.samsung.com>
        <20180822085405.10787-3-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/22/2018 10:54 AM, Daniel Vetter wrote:
> DRM drivers really, really, really don't want random userspace to
> share buffer behind it's back, bypassing the dma-buf buffer sharing
> machanism. For that reason we've ruthlessly rejected any IOCTL
> exposing the physical address of any graphics buffer.
> 
> Unfortunately fbdev comes with that built-in. We could just set
> smem_start to 0, but that means we'd have to hand-roll our own fb_mmap
> implementation. For good reasons many drivers do that, but
> smem_start/length is still super convenient.
> 
> Hence instead just stop the leak in the ioctl, to keep fb mmap working
> as-is. A second patch will set this flag for all drm drivers.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
