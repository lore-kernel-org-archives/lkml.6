Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5999DC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E212146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E+B1MGdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfBHRls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:41:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48946 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfBHRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:41:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208174144euoutp01f96eb48de53cda39fcec83dce082fb63~BdGCOEBli3252232522euoutp01a
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:41:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208174144euoutp01f96eb48de53cda39fcec83dce082fb63~BdGCOEBli3252232522euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549647704;
        bh=Qc4cX0DTFgQuiIvhqq/3wQbXD2Zyuh5pHVBWoKZGDqo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E+B1MGdh9RguAxZBoKHcB4gjRCD3OXN6GLqF6cM1XC1R55nJNJ6bycCbAAJ3V07Vg
         QNwquAB5tc+721PSsHsX4nhUxwuYLJrOXeqcM1SoPQ6qGTTKOuFxJQQVVa2SluDKRN
         y6hl4aooDIVqYu/00dYBeUncnesxvB2XG4QPF/P4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208174144eucas1p2ba7e1e39aa0e7cfc4f530a63853ee3b8~BdGBoyBvH1000610006eucas1p2y;
        Fri,  8 Feb 2019 17:41:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 26.AD.04441.75FBD5C5; Fri,  8
        Feb 2019 17:41:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208174143eucas1p2981b4b0cc0aad9a3f2099361aafbc5d3~BdGA2D7fd2317123171eucas1p2B;
        Fri,  8 Feb 2019 17:41:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208174143eusmtrp2f94985dac358010e054eb8e5a187c5e7~BdGAnOirB1356913569eusmtrp2Z;
        Fri,  8 Feb 2019 17:41:43 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-de-5c5dbf571193
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.9D.04128.75FBD5C5; Fri,  8
        Feb 2019 17:41:43 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208174142eusmtip22e917b9d8c7c7be73e550e0dfdc05837~BdGAR1CEx2007920079eusmtip2L;
        Fri,  8 Feb 2019 17:41:42 +0000 (GMT)
Subject: Re: [PATCH] fbdev: fbmem: fix memory access if logo is bigger than
 the screen
To:     Martin Kepplinger <martink@posteo.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, manfred.schlaegl@ginzinger.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <16025871-3918-e9be-e6af-de9831cdc064@samsung.com>
Date:   Fri, 8 Feb 2019 18:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190128100435.759-1-martink@posteo.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87rh+2NjDE7strRY+PAus8WVr+/Z
        LE70fWC1uLxrDpvF+Su32S32r6qxuLZiIqsDu8febwtYPI72rWfxuN99nMnj12FRj8+b5AJY
        o7hsUlJzMstSi/TtErgy5u46wF7wkruis9G4gfE1ZxcjB4eEgInEl7dJXYxcHEICKxglZvV9
        ZYNwvjBKtFxZxgzhfGaU6P20AMjhBOt48WorC0RiOaNEx6FGKOc9o8TxxhawKmGBCInpk5ay
        g9giApoSy/7uAytiFrjIKLFxbhNYEZuAlcTE9lWMIDavgJ3Eu+ZrYHEWARWJQ7OmMYEcKAo0
        qP+MOkSJoMTJmU9YQGxOAVOJpWfawMqZBQwkjiyawwphy0tsfzsH7GwJgWXsEhMnH2WBONtF
        YlnDFVYIW1ji1fEt7BC2jMT/nfOZIBqmM0q8+bWUBcJZzyix5swxJogqa4nDxy9CdTtKHJ6w
        ggkSfHwSN94KQmzmk5i0bTozRJhXoqNNCKJaTWLDsg1sMLu6dq6EBqOHxMnWL2wTGBVnIflt
        FpJ/ZiH5ZwEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAVHP63/FPOxi/Xko6xCjA
        wajEwxvREhsjxJpYVlyZe4hRgoNZSYT35m6gEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfR
        QgLpiSWp2ampBalFMFkmDk6pBkblheuqHkw32LrTO29WrJJW2FfX5fwFYf8byo7rxJULNUVm
        7bVLWrR2yUu3f3PsUm23zdg/S+Xjb3X7Jz+b/BgdZ3y9H/LC6GBYzSGLl0f/PW76JVnnxbnG
        OnZX58oiPUMmO4P5uw+GyRfbMU1a1vbg+nTl3rcvloS/3Bq0MThr09JW5VkO7v5KLMUZiYZa
        zEXFiQDv8OYgMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7rh+2NjDL59Y7FY+PAus8WVr+/Z
        LE70fWC1uLxrDpvF+Su32S32r6qxuLZiIqsDu8febwtYPI72rWfxuN99nMnj12FRj8+b5AJY
        o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy5u46
        wF7wkruis9G4gfE1ZxcjJ4eEgInEi1dbWboYuTiEBJYySlz//J6pi5EDKCEjcXx9GUSNsMSf
        a11sILaQwFtGiQtT4kFsYYEIiemTlrKD2CICmhLL/u5jgajpYJSYe18TZCazwEVGiYPvW5lB
        EmwCVhIT21cxgti8AnYS75qvgcVZBFQkDs2axgRiiwINvfWwgwWiRlDi5MwnYDangKnE0jNt
        YPXMAnoSO67/YoWw5SW2v53DPIFRcBaSlllIymYhKVvAyLyKUSS1tDg3PbfYSK84Mbe4NC9d
        Lzk/dxMjMHq2Hfu5ZQdj17vgQ4wCHIxKPLwMTbExQqyJZcWVuYcYJTiYlUR4b+4GCvGmJFZW
        pRblxxeV5qQWH2I0BXpiIrOUaHI+MLLzSuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGan
        phakFsH0MXFwSjUwVn3niRZ6FOc+9bMnL9MSj1W//n2y/VGzq8Nlwe/s5u5DaX11uprqr6r/
        Ns02XFu9doVre8b2TWceXpDz+eO/cPXKmVMiM+fMsGlM/7Y29GrioynTttdcaO+KYJmSImuv
        tOL2lL9G53+7LdR8urvqp8zeCdOrIu7KsK3fEZCww8nn8JOJBgI3NyixFGckGmoxFxUnAgDd
        v4nItAIAAA==
X-CMS-MailID: 20190208174143eucas1p2981b4b0cc0aad9a3f2099361aafbc5d3
X-Msg-Generator: CA
X-RootMTR: 20190128100446epcas2p24b13ff5ae2af639b66d4bcd4d4722799
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128100446epcas2p24b13ff5ae2af639b66d4bcd4d4722799
References: <CGME20190128100446epcas2p24b13ff5ae2af639b66d4bcd4d4722799@epcas2p2.samsung.com>
        <20190128100435.759-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/28/2019 11:04 AM, Martin Kepplinger wrote:
> From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> 
> There is no clipping on the x or y axis for logos larger that the framebuffer
> size. Therefore: a logo bigger than screen size leads to invalid memory access:
> 
> [    1.254664] Backtrace:
> [    1.254728] [<c02714e0>] (cfb_imageblit) from [<c026184c>] (fb_show_logo+0x620/0x684)
> [    1.254763]  r10:00000003 r9:00027fd8 r8:c6a40000 r7:c6a36e50 r6:00000000 r5:c06b81e4
> [    1.254774]  r4:c6a3e800
> [    1.254810] [<c026122c>] (fb_show_logo) from [<c026c1e4>] (fbcon_switch+0x3fc/0x46c)
> [    1.254842]  r10:c6a3e824 r9:c6a3e800 r8:00000000 r7:c6a0c000 r6:c070b014 r5:c6a3e800
> [    1.254852]  r4:c6808c00
> [    1.254889] [<c026bde8>] (fbcon_switch) from [<c029c8f8>] (redraw_screen+0xf0/0x1e8)
> [    1.254918]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:c070d5a0 r5:00000080
> [    1.254928]  r4:c6808c00
> [    1.254961] [<c029c808>] (redraw_screen) from [<c029d264>] (do_bind_con_driver+0x194/0x2e4)
> [    1.254991]  r9:00000000 r8:00000000 r7:00000014 r6:c070d5a0 r5:c070d5a0 r4:c070d5a0
> 
> So prevent displaying a logo bigger than screen size and avoid invalid
> memory access.
> 
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
