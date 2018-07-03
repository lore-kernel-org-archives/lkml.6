Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBE4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FFD24AB4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IPbVLZi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FFD24AB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeGCOcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:32:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55308 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbeGCOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:32:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180703143246euoutp0188a6660c94c50f3d2daae368f3887f4a~94mO05Tor0791707917euoutp01P;
        Tue,  3 Jul 2018 14:32:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180703143246euoutp0188a6660c94c50f3d2daae368f3887f4a~94mO05Tor0791707917euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530628366;
        bh=oy0GB7Mxz3cd4ehBC62EiePzHhTSklZpJRYc9b6IVoI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=IPbVLZi6cFfTxpFOhPpoVaTOy1yqLVvk3REPqRgsREIGOct/hHRHsPy/Iq/rOnsjA
         j27ogr2aDYcXjp/gzcVyeRKuaeRDY0T2E5IncBmjWvrQPOBzOziPtgW1ktEKf//nPy
         IcXUCvaDsGLgnB8KeYEbbRUvRfbOheoh1N/Gso6o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180703143245eucas1p2392f9273a3c34a414fe8ea032ff779f9~94mONyPgO0219302193eucas1p2D;
        Tue,  3 Jul 2018 14:32:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AB.66.05700.D098B3B5; Tue,  3
        Jul 2018 15:32:45 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180703143244eucas1p2e6651d1ebab472768357e9f7d132721d~94mNj8e0V2384123841eucas1p27;
        Tue,  3 Jul 2018 14:32:44 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-57-5b3b890d6f14
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.BD.04178.C098B3B5; Tue,  3
        Jul 2018 15:32:44 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PBA00C3NOEK8A20@eusync4.samsung.com>; Tue, 03 Jul
        2018 15:32:44 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omapfb: encoder-tpd12s015: fix error return code
Date:   Tue, 03 Jul 2018 16:32:44 +0200
Message-id: <2458818.0lnoAlLxQ2@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1528640655-18948-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djP87q8ndbRBqcOC1pc+fqezWLZg9OM
        FltvSVuc6PvAanF51xw2i9lL+lks1s+/xebA7rF3S5bH/e7jTB7Hb2xn8vi8SS6AJYrLJiU1
        J7MstUjfLoErY+rerYwFx5gqVh68ztzA2MrUxcjJISFgIrGi8TmQzcUhJLCCUeLdvYlgCSGB
        z4wSG3s5YIpeXX8BVbSMUaLlWRc7hPObUWLJ5k9sIFVsAlYSE9tXMYLYIgLqEq0bdoHZzALH
        GSW+3XIHsYUFXCX2LGlkBrFZBFQlpi39CTSVg4NXQFPi9T0+kLCogJfEln3tYEdwApUfO3kX
        zOYVEJT4MfkeC8RIeYl9+6eyQtg6EmePrWMEuUdCYAObxNa/p5khrnaRmDpnFxuELSzx6vgW
        dghbRqKz4yATRMN0Rok3v5ayQDjrGSXWnDkGDRhricPHL0Kt4JOYtG06M8ilEgK8Eh1tQhAl
        HhJrPr1jhgTXDEaJtpdaExhlZiE5dhaSY2chOXYBI/MqRvHU0uLc9NRiw7zUcr3ixNzi0rx0
        veT83E2MwARw+t/xTzsYv15KOsQowMGoxMO7otQ6Wog1say4MvcQowQHs5II7zZVq2gh3pTE
        yqrUovz4otKc1OJDjNIcLErivHEadVFCAumJJanZqakFqUUwWSYOTqkGxqL0E9X+CdvLFxcK
        tO2OM57L3Nfz50XGuYKt1QL7Tm2tvvqKn1lGfUe3VI8UwxvBC187TXdE3OCsvqdpkBmf7J0d
        WH59gjlDWx3vvyX8gj9qOY49E67ZOO3y6Ue+zzU1460nRPO2/Vqw7p7GDpuajIlaSxsFn0mt
        M52UbDI991m1WmDelOImJZbijERDLeai4kQA4d1ihvwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xa7o8ndbRBsdemFhc+fqezWLZg9OM
        FltvSVuc6PvAanF51xw2i9lL+lks1s+/xebA7rF3S5bH/e7jTB7Hb2xn8vi8SS6AJYrLJiU1
        J7MstUjfLoErY+rerYwFx5gqVh68ztzA2MrUxcjJISFgIvHq+gsgm4tDSGAJo8TkaYvAEkIC
        fxklrv5JBLHZBKwkJravYgSxRQTUJVo37GIEaWAWOM4o0b7iNViDsICrxJ4ljcwgNouAqsS0
        pT+B4hwcvAKaEq/v8YGERQW8JLbsawcr5wQqP3byLtTiWYwSv37PBlvAKyAo8WPyPRYQm1lA
        XmLf/qmsELaWxPqdx5kmMPLPQlI2C0nZLCRlCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+du
        YgSG77ZjPzfvYLy0MfgQowAHoxIP74pS62gh1sSy4srcQ4wSHMxKIrzbVK2ihXhTEiurUovy
        44tKc1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTAG/Q81mWH3bv/tGaoHXmUn
        u5a63stRmXD8YIxjz2tJqzOhz85JVT5SUPnes/Fe8d562S9cK77/dX107Z3+zq3nBc9b55TK
        ThK+t3bLn9BdM09OXfSMfZUnb0dlyL7ZbPxHzBd1hyzqVjoik8ve4TzPi23rzTlPFVN+MhVM
        /rekgqFWOLk6QaZDiaU4I9FQi7moOBEALH/DC1sCAAA=
X-CMS-MailID: 20180703143244eucas1p2e6651d1ebab472768357e9f7d132721d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180610145623epcas2p38562cc47b619add45620b677fb036479
References: <CGME20180610145623epcas2p38562cc47b619add45620b677fb036479@epcas2p3.samsung.com>
        <1528640655-18948-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, June 10, 2018 04:24:13 PM Julia Lawall wrote:
> Return an error code on failure.
> 
> Problem found using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

