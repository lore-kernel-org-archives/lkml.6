Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD1ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC61214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ST14Rx+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC61214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeIQPAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:00:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39897 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeIQPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:00:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180917093403euoutp010e8cc290634be609774361963c83eed0~VJjHhahNJ0616906169euoutp01F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:34:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180917093403euoutp010e8cc290634be609774361963c83eed0~VJjHhahNJ0616906169euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537176843;
        bh=JM6XjBr35fT5YZL4XW8eE9r2qhg5Ujehby5KiU9fT0k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ST14Rx+0IrhpbJLmPnDA9fh9jQxP8kc5lXZYgF3MvtCRdh5Tl6jBzhfTOh9okI8pM
         LMow2VUEWDJhRIPpPzKC9CJI9/w8x0v8RQ3rC+f2Sr8UgKd+R8AyCL5cqsmxIMRnLb
         ZfztzfJR9C10DlufQMg33cKthxX9tgC2quWOTSQw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180917093402eucas1p2cd93ea61bc731b04719ed66660ca03ba~VJjGrqCf72931229312eucas1p23;
        Mon, 17 Sep 2018 09:34:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1E.34.04806.A057F9B5; Mon, 17
        Sep 2018 10:34:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180917093401eucas1p1f1e0de762a88b1327ba229971996e5da~VJjFwrEK11702417024eucas1p1m;
        Mon, 17 Sep 2018 09:34:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180917093401eusmtrp1f7c78e3a6d91377390fd6b8bf9b5bc07~VJjFd5Q-_2980029800eusmtrp1c;
        Mon, 17 Sep 2018 09:34:01 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-b9-5b9f750a61e2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.06.04284.9057F9B5; Mon, 17
        Sep 2018 10:34:01 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180917093400eusmtip1548f7aa42d9b056fd62669814adfdd52~VJjE2Vm0m0086100861eusmtip1F;
        Mon, 17 Sep 2018 09:34:00 +0000 (GMT)
Subject: Re: [PATCH 01/17] thermal: add thermal_zone_device_toggle() helper
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 17 Sep 2018 11:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <0495124b-9ae8-3b4b-5f0c-208d2e06e5a5@samsung.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTtm/fm+Zyc4WssvKklTmggaTs82oOiBxEVEUQT5KTPpXSMGcfS
        Py5Ji2laVuo4LmWLmoM2mJPmhstMlhqm2bRYWBZpLui4YIXm6yX479x7zrn3no+PJuSDYlc6
        VB3JadSqMAUlISss0698Jbo85brMIinz3W5FjDGlmWTyurrFTH18J2Jmv/wUMy/MCSImUX+X
        ZO719TownVUGirGnNCHGMPzBgenrvUYxP8pdGFOhjWKmq3JJpuaTHe3CbMKIhWL1n9sotlLf
        48A+eb+ZLajuF7Gm4isU+7G7mmJTLgxTrLk7l2CfZ0yRrNVmFrF208pDTscl2wK5sNAoTrN2
        h78kZDK5Fp39TZ1v/NRIxKFBcRJypAFvgv7kO2QSktByXIjgVm8LEopxBBWpdQSvkmM7gmGb
        ct6R86aWEvoP5xwFnoJhBEHKePIcQdPOeD9M9RzjNUuxDzx/bRbxGgLnk/DuTbuIJyi8Ba5f
        KkY8JrEXTHSPiXnvMnwMUltX820pXgItWX0kjx3xTsjKuvlPTuB10HTXIBawB5iHDAQ/H3AO
        DZWZNiSYo+BGXBLiZwLeA39mlwv3O8OAtdxBwO7wMj2ZFLwZCAZ/3f9flCIoabWIBNVWaLR2
        /H+v3TD88alIGCoD29AS4QgZ3KjIIIS2FC5flAtqbyh7UEbN70qqLCIEzMK9AQuVhjz1C2Lq
        F0TTL4iWj4hi5MLptOHBnHajmjvnp1WFa3XqYL+AiHATmvuDL2esE09R7Z9TDQjTSOEkrU/L
        VcrFqihtdHgDAppQLJUSsjylXBqoio7hNBEnNbowTtuA3GhS4SKV+QQp5ThYFcmd4biznGae
        FdGOrnGoxH1D6dWxE7lup2MDZa8y3hvF6V/9DxdXfshp1pTNtG56+3XL7br7A9/a7ZHnFoWd
        THcyjsWe7jUkVkc0RxaEDhZQv6MPhE76dJSOBsWoH/nHe6gP0m1793W17BtZtcZYs2zjit3B
        XqXbOx+T40cUZyaOPtP1WEa9A2qys43lnJfvYgWpDVGt9yE0WtVfKZ12+X8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7qcpfOjDU5O5LN49vk4o8Xa3qMs
        FvOvXGO1ONB4mdHi/6PXrBantjcxWbTMWsRiseTJQ3aLy7vmsFl87j3CaDHn3W12iycP+9gs
        XmwRt9i04gabxc9d81gs9t77zOgg4NH0/hibx6z7Z9k8ds66y+6x9Zapx+I9L5k8Nq3qZPO4
        c20Pm0dv8zs2j+3X5jF7nJj+ncXj+I3tTB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa
        6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXzr2cdY8Jut4vC9w8wNjG9Yuxg5OSQETCTm
        Xt3H1sXIxSEksJRRovNSH3MXIwdQQkbi+PoyiBphiT/XuqBq3jJK7F2zlgWkRljAW+L73QiQ
        GhEBLYkTl7YzQdQcYJLY8/kZO4jDLLCIRWLPv03MIFVsAlYSE9tXMYLYvAJ2Ens29jKB2CwC
        qhJfr30Cu0hUIELi1sMOFogaQYmTM5+A2ZwC9hIzZ04B62UW0JPYcf0XK4QtL7H97RzmCYyC
        s5C0zEJSNgtJ2QJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiBEb7t2M/NOxgvbQw+xCjA
        wajEw5vRNy9aiDWxrLgy9xCjBAezkggvM9/8aCHelMTKqtSi/Pii0pzU4kOMpkBPTGSWEk3O
        ByafvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjJ2xkyL5/y3Y
        sN8pNKi+M8nZ8P6Uko1XqiKeuby7ezc+Z7fwz6Kt2+J51G49EHjxeVXK6yahqkeGe1uftM5b
        u+E/05kS52fpgQYrpv+vD2q1nhF+fYesN7eF8eGYDRFfM2+ul1OQz1V4XhK1fkv38dff8t8x
        PLBMV7urVJDXnvF2/fsXU9b0HlBiKc5INNRiLipOBAB0bsgABgMAAA==
Message-Id: <20180917093401eucas1p1f1e0de762a88b1327ba229971996e5da~VJjFwrEK11702417024eucas1p1m@eucas1p1.samsung.com>
X-CMS-MailID: 20180917093401eucas1p1f1e0de762a88b1327ba229971996e5da
X-Msg-Generator: CA
X-RootMTR: 20180410124248epcas1p453f74df4e183f9d68de255847c093d4e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180410124248epcas1p453f74df4e183f9d68de255847c093d4e
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124248epcas1p453f74df4e183f9d68de255847c093d4e@epcas1p4.samsung.com>
        <1523364131-31059-2-git-send-email-b.zolnierkie@samsung.com>
        <20180910171605.GA4196@localhost.localdomain>
        <0495124b-9ae8-3b4b-5f0c-208d2e06e5a5@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/14/2018 01:40 PM, Bartlomiej Zolnierkiewicz wrote:

[...]

>>> --- a/include/linux/thermal.h
>>> +++ b/include/linux/thermal.h
>>> @@ -467,6 +467,7 @@ struct thermal_cooling_device *
>>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>>>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>>>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
>>> +int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on);
>>>  
>>
>> You missed the #else section of the #if IS_ENABLED(CONFIG_THERMAL),
>> didn't you?
> 
> No, this function shouldn't be used outside of CONFIG_THERMAL.

Please disregard my previous comment. I see now that the CONFIG_THERMAL=n
stub is needed and I will add it in the next patch revision.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
