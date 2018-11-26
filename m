Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C96C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9381D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Qeerm8P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9381D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeKZRv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:51:58 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42875 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKZRv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:51:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181126065847euoutp022ff32ff2621bbf9e06e149fa1d44f627~qmlipuqBJ0301903019euoutp02n
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:58:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181126065847euoutp022ff32ff2621bbf9e06e149fa1d44f627~qmlipuqBJ0301903019euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543215527;
        bh=HnYOAMRdi9vjHWX9mnXpO1gJV/yuD46Pf1+gYCS0I0o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Qeerm8P20LEGp9/HzaVpTRQ2aWBtlpW+BxsIrFfQQhmbcIC/UAjEUYh1ZRPQwPICw
         knoaW5osEzuFS2FYtQJqYdqtcMasbigUchUqnJouv9sBqz2pDJHuweiltivhMLhwnk
         EEQsq/RaL/lJ7f/ZsmOU9h7sB0ErpaJeCHGL+1mQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181126065847eucas1p2c37ca796b354e1d13d46dc6a3391aa68~qmliA8LjG3270732707eucas1p2h;
        Mon, 26 Nov 2018 06:58:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.5D.04806.6A99BFB5; Mon, 26
        Nov 2018 06:58:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181126065846eucas1p1eba87e17f3182087931dc59d9a1dcddc~qmlhSYMby1831418314eucas1p1I;
        Mon, 26 Nov 2018 06:58:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181126065846eusmtrp226ab7e85a8556b6f8c9462a4dc312532~qmlhD04gj0538905389eusmtrp2A;
        Mon, 26 Nov 2018 06:58:46 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-4c-5bfb99a68b6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.47.04128.6A99BFB5; Mon, 26
        Nov 2018 06:58:46 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181126065845eusmtip1b60a8439f487c15a4c63417185f464f1~qmlgotFtm2749727497eusmtip1c;
        Mon, 26 Nov 2018 06:58:45 +0000 (GMT)
Subject: Re: [PATCH] drm/mediatek: Only try to attach bridge if there is one
To:     Nicolas Boichat <drinkcat@chromium.org>, CK Hu <ck.hu@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <6be0a453-80fb-4d97-1610-e4db124faf61@samsung.com>
Date:   Mon, 26 Nov 2018 07:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126040737.138682-1-drinkcat@chromium.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7rLZv6ONvi2zMKi99xJJovG3dvY
        La58fc9msfrKChaLTY+vsVpc3jWHzeJy80VGi6YWYwcOj9kNF1k8ds66y+6x/dsDVo/73ceZ
        PDYvqfdoObmfxePzJrkA9igum5TUnMyy1CJ9uwSujIMPdzEXLGWuaPv0ir2B8TpTFyMnh4SA
        icTFf3OYuxi5OIQEVjBKPH71B8r5wijRs3IXG4TzmVFi+YVXzDAt34/+YIVILGeU2PunA6rq
        LaPEsVUbwKqEBXwkTs2+yQ5iiwi4S+w80MwCUsQscJdRYuqcRSwgCTYBTYm/m2+ygdi8AnYS
        n1ohmlkEVCW6P+0DqxEViJDouL8aqkZQ4uTMJ2BxTgEbiZaO72BfMAvISzRvnc0MYYtL3Hoy
        nwlkmYTAMXaJxrmP2SDudpG4d72REcIWlnh1fAs7hC0j8X/nfGhw1Es0zbzCDNHcwShxYvFy
        qGZricPHLwI9zQG0QVNi/S59iLCjRM+tWSwgYQkBPokbbwUhbuCTmLRtOjNEmFeio00IolpR
        4v7ZrdBQFJdYeuEr2wRGpVlIPpuF5JtZSL6ZhbB3ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8
        dL3k/NxNjMAEdfrf8a87GPf9STrEKMDBqMTD++LPr2gh1sSy4srcQ4wSHMxKIrwl7b+jhXhT
        EiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTBeSusRK6hhfJpy
        9dTiR8Ln3t04PY17aXS0ukPyI+1C00dT1y865bJF+0/utzB2H74+7ekyH8SnPLs2M3yH/Jdn
        q0MDmt+9q3rQd9H9ucf+5ojWG/y9/7QOromNtcv9JSZTo5h5769NeJ2FyvlNltantqxqTAyt
        qpvnoljwwWKtD3/s5xMFYS5KLMUZiYZazEXFiQAX2wdyTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7rLZv6ONvi3it2i99xJJovG3dvY
        La58fc9msfrKChaLTY+vsVpc3jWHzeJy80VGi6YWYwcOj9kNF1k8ds66y+6x/dsDVo/73ceZ
        PDYvqfdoObmfxePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jIMPdzEXLGWuaPv0ir2B8TpTFyMnh4SAicT3oz9Yuxi5OIQEljJKPL3z
        iAUiIS6xe/5bZghbWOLPtS42iKLXjBIr515nBUkIC/hInJp9kx3EFhFwl9h5oJkFpIhZ4C6j
        xIGbZxkhOvoZJQ597wLbxyagKfF38002EJtXwE7iU+sGsBUsAqoS3Z/2ga0WFYiQOPtyHSNE
        jaDEyZlPwOKcAjYSLR3fweYwC6hL/Jl3iRnClpdo3jobyhaXuPVkPtMERqFZSNpnIWmZhaRl
        FpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjctuxn1t2MHa9Cz7EKMDBqMTD++LP
        r2gh1sSy4srcQ4wSHMxKIrwl7b+jhXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmC7ySuIN
        TQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwLtnmz15SoZw1530SX/pB
        DYNp+RNDbpZ9YKlfFZ09QZS9J+j/gTn3Fnk5TpXhvt0oYJi0uabi44aGmvtmig9cpWf2Piqz
        VE8+MJPTweyjSmCW5MGrZ9fvyulL3npkjmLtvHn/PhnUWPafr/5U4b/uQoT2iXvdm055f6pd
        s+tNfILvykj1vnZ7JZbijERDLeai4kQAOa+jcd8CAAA=
X-CMS-MailID: 20181126065846eucas1p1eba87e17f3182087931dc59d9a1dcddc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181126041445epcas4p1f0db29e800181de3971f08f6939eec51
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181126041445epcas4p1f0db29e800181de3971f08f6939eec51
References: <CGME20181126041445epcas4p1f0db29e800181de3971f08f6939eec51@epcas4p1.samsung.com>
        <20181126040737.138682-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.2018 05:07, Nicolas Boichat wrote:
> Even if dsi->bridge is NULL, we still try to call drm_bridge_attach,
> and print out an error message, before creating the connector.
>
> When no bridge is provided, let's skip these 2 steps and directly
> create the connector.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


 --

Regards
Andrzej
