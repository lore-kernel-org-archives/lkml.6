Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39215C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6E620825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MgFaMXO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6E620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeKEU2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:28:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47027 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbeKEU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:28:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181105110940euoutp01f6289320c1161ead4825d8f39aae2a1d~kNdmG2Hq11405614056euoutp01e
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 11:09:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181105110940euoutp01f6289320c1161ead4825d8f39aae2a1d~kNdmG2Hq11405614056euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541416180;
        bh=OVBPU6pEFrTKwz7faxvBnq1BhxcFtzTfxEyNk4UW7JU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MgFaMXO8bxctiuVsjIuXGaCF1m6KSRBbEiYUwC5QjQ60TPUnH5wU1+BICD5FwGM/T
         GMlEnSYxkPnfb4SrOsnKMKhslAkcpkXAoAiEW0cKU6I+GiDrbtnLv4TyHoEeWYqfa4
         NdcRLoKb6nYctp+vb0T9dc1KD4yweMJTbajvkWgA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181105110939eucas1p11c7ee125cacaa2e4b7a8a5902291600c~kNdlETsFn2710227102eucas1p1d;
        Mon,  5 Nov 2018 11:09:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 21.09.04294.3F420EB5; Mon,  5
        Nov 2018 11:09:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181105110938eucas1p296d8ec89faf365b7c68cc55246beb082~kNdkEA8iV2884028840eucas1p2u;
        Mon,  5 Nov 2018 11:09:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181105110938eusmtrp2912d52028a38efdcdfb6a6bb0f0616da~kNdkBcd8u2620126201eusmtrp2o;
        Mon,  5 Nov 2018 11:09:38 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-9d-5be024f36902
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.8F.04284.2F420EB5; Mon,  5
        Nov 2018 11:09:38 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181105110937eusmtip179f15457f9794947a7840c258be711fe~kNdjHr3ir1829118291eusmtip1G;
        Mon,  5 Nov 2018 11:09:37 +0000 (GMT)
Subject: Re: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
To:     Damian Kos <dkos@cadence.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d6db03aa-6f61-f902-85f6-2245547186bc@samsung.com>
Date:   Mon, 5 Nov 2018 12:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CY1PR0701MB16644A2C7EF670F5AC732BF8CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLcRTH/e57o3JXk56MhN2QmJh5ZfklmIlHbhBBQjBBcTNiq2nNM2Im
        prVMpsSsm1bpTKYhWtWtycxqU/MYM9nmMS2beCz1nPej2t2J/fc53+85v3O+yY8jlTYmjtug
        2SJpNeoMgYmmLl//fjfx04hA2jj7CRUuaGwgcK4+SGNLXSON2/3J+MHndwyuCnhYHHreReMT
        xt24Nr+DxYbDNhY7Olpo3OwpZfDHQIjE1g8uCpe1NhH4rNmJ8MWaKzS2GTtInHPpOIP3V9ex
        uP1IHUodLNrNdiSa7btEu6GLEJsPFRBip6MJiSX6Ylp0VBgY0f0lQIvmhoWiP99HiE7bHrHK
        WE2IPs8jVvxtqqFEd4uZFH1tbmJBzPLoKeukjA1bJW1Syuro9dbHh9isG4rtZdaXTA6y9T+I
        ojjgJ8GX23XoIIrmlPxZBF03nxNy0Y2gtf5Zr/MJQUHJa+LfyBNnLSkb5QhO2X+ychFEUFpd
        3dM1iJ8Hz7520BGO5ZdBW2GQiTDJO1nY93ZlhBk+AX47H/boCj4FPhx1oAhT/Aho9IbYCA/m
        l4Lef663JwYaijupCEfxarjuKEfym8Ngn6uElFkFjzotPRmAD3DwqjWPlc+eCecLXbTMg+CN
        71KvPhRCVZbeaHsgt/gBKQ/rEdw4Xc7IxmS45msKD3PhDQlwwZMky9PhQChyBBfmgdAWjJFv
        GAjGy0WkLCtAn6eUu+PBf8dFyqyCsnufmUIkmPokM/VJY+qTxvR/70lEVSCVlK3LTJd0EzTS
        trE6daYuW5M+du2mTAcK/91bf3zdlcjza40X8RwSBihgkT9NSau36nZkehFwpBCrEJhAmlKx
        Tr1jp6TdtEqbnSHpvGgIRwkqxa5+YYtPV2+RNkpSlqT95xJcVFwOyv9RdnKFcdXwvFR3ufn8
        9qSbpcPjhZGb25MnW2OoF1GVo2qU1mav3iVUJo5frB+d0npsWn2Dz36m+CI7Z+jcrKeGp6lV
        Z/q9L3psoa/au8d8NFzVcLMq78/QMsFZiolx35bE30k8kDvMXDS1ZYq71nJubr1hY6Bo/5ru
        vckp82fH0gKlW68eP5rU6tR/AUdKiBu3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUYRSG+2Z2ZsdsYVoVPxajmuwKbY2X9jPUDPoxPyqSLqQWtuig5l5k
        ZpUsSskCLymlQbrq2pJLUSa4W3kJ3RR1lVJRy8wLrmlFmIhGqVSa7hb47+Gc9zmcA4fC5XWE
        gkrSGXhBp9Yw5HrJ6yXH6N45f2fM/u+vGJTf3Ymh69nTBKpo7SbQ6NgB9PbHDInqnQ1StPxx
        ikDlhVdRc96EFOXcqZQi68QAgfobykg051zGkXn2uQRZ3vdi6JHJBlCNvYlAlYUTOMp8Vkyi
        m42tUjRa1AoifLgqUxXgTFVXuKqcKYzrL8jHuElrL+BKs0sIzvo4h+RqfzoJztQZyY3lOTDO
        VpnB1Rc2YpyjYUjK/THaJVztgAnnHIO12ImN0cpQQZ9q4Lck6kVDGBPDogAlG4KUAUEhSjZQ
        df5gQDCzLzw0ntckpfHCvvALykTzcIE0pUN2yWL+QmaCSs9c4EFBOgiO2JrxXLCektMWAI1F
        Vom74QtfVkzjbvaCvwdySXdoCsCeUqt0teFFH4Xj8xPEKnvTUdB41+QK4XS9FHYW9QO34cRg
        9XKbK0XSu+Ef2wdylWV0OJy9awWrLKH9YXfLsmuqD30Wdn2tBu7MRthZMulayYNWw3brQ1cd
        p3fC36Y+3M2bYdbz0n/sC4cmK7DbQG5coxvXKMY1inGNch9IHgNvPlXUJmhFVimqtWKqLkEZ
        p9dawcrXvGhftNWBvpqTLYCmALNBlnJqLEZOqNPEdG0LgBTOeMsY0hkjl8Wr0y/zgj5WSNXw
        YgsIXjnuDq7widOv/KDOEMsGsyoUwqoCVYEHEOMr69mfHi2nE9QGPpnnU3jhv4dRHopMsHXL
        hqzt5rTWTR1tUX67hKXFLHbeEfQgWXhi9ro301yw7ZYmTBOoqJVf1KCI4sPrvp+2hMV13VD2
        Li7o67++I97MDDeNfJsbT/AamMk8szB9OfLQsaS+45/sdjl1pLlcUbdDlxUaaT5vsavKcs+F
        Up6/sj1jqZLZz5sGM546rvkxEjFRze7BBVH9F8WoVjRLAwAA
X-CMS-MailID: 20181105110938eucas1p296d8ec89faf365b7c68cc55246beb082
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181105103448epcas1p29a9889a9a19fc56629dcc7e24785556c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181105103448epcas1p29a9889a9a19fc56629dcc7e24785556c
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
        <CY1PR0701MB166434BBB71DB76593E0F513CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
        <3056496.a8qoricJmv@avalon>
        <CGME20181105103448epcas1p29a9889a9a19fc56629dcc7e24785556c@epcas1p2.samsung.com>
        <CY1PR0701MB16644A2C7EF670F5AC732BF8CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.2018 11:33, Damian Kos wrote:
> Hi Laurent,
>
> Understood. Thanks.


I will look at it today or tomorrow.


Regards

Andrzej


>
> Damian
>
> -----Original Message-----
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com> 
> Sent: Monday, November 5, 2018 11:30
> To: Damian Kos <dkos@cadence.com>
> Cc: David Airlie <airlied@linux.ie>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Archit Taneja <architt@codeaurora.org>; Andrzej Hajda <a.hajda@samsung.com>; Gustavo Padovan <gustavo@padovan.org>; Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Sean Paul <sean@poorly.run>; Sandy Huang <hjc@rock-chips.com>; Heiko Stübner <heiko@sntech.de>; Quentin Schulz <quentin.schulz@free-electrons.com>; Piotr Sroka <piotrs@cadence.com>; dri-devel@lists.freedesktop.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-rockchip@lists.infradead.org; Rafal Ciepiela <rafalc@cadence.com>; quentin.schulz@bootlin.com; jbergsagel@ti.com
> Subject: Re: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
>
> EXTERNAL MAIL
>
>
> Hi Damian,
>
> On Monday, 5 November 2018 11:44:53 EET Damian Kos wrote:
>> Hi Guys,
>>
>> I'm wondering if this time patch is so good that there're no change 
>> requests, or is it so bad that it was rejected without a comment : ) 
>> Please let me know if this patch is being in review or was rejected 
>> and, if so, what needs to be changed.
> I unfortunately don't have time to review your series for the time being. 
> Hopefully someone else will have a better review bandwidth :-) Sorry about that.
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
>
>

