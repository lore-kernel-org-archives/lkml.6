Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8923C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E692184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PyS+Leow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBLFqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:46:32 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36942 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLFqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:46:32 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212054629epoutp03d40eb4c44917b172a65b380dfe5a843c~Ch6rLsP832994829948epoutp03T
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:46:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212054629epoutp03d40eb4c44917b172a65b380dfe5a843c~Ch6rLsP832994829948epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549950389;
        bh=ObE5qjcK2olro++mN1w+JJtXEXm23mAFGBEQ4PTB2JQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PyS+LeowN+D1Iu18dwcKpqIDx5cZWQcACV+htWdu3AlDNttVzd+J5dbGlsMRWh32C
         YzhonKKxQvaVmooMWyxSUC8ekiVBQ7sb4jalbRG5OB4UpYrTY2PN7ufqMs2wCNa7td
         ZslxnSN7lp33Y9QFIpWspgjaA5oqL7lfireHHj0o=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190212054626epcas1p44c21c292f4a472fe00fa9531de2122d3~Ch6owcC3w0944809448epcas1p4b;
        Tue, 12 Feb 2019 05:46:26 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.A2.04074.0BD526C5; Tue, 12 Feb 2019 14:46:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212054624epcas1p166fb85b935e9f9cd3d2836f6fb84a450~Ch6mpbE9Y3169531695epcas1p1o;
        Tue, 12 Feb 2019 05:46:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190212054624epsmtrp1bede74b35324828ac7333df738558601~Ch6mniLOr1861418614epsmtrp1H;
        Tue, 12 Feb 2019 05:46:24 +0000 (GMT)
X-AuditID: b6c32a35-6eb5f9c000000fea-0e-5c625db0ad90
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.4B.03601.0BD526C5; Tue, 12 Feb 2019 14:46:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212054624epsmtip1dab53f7a91e7f844d7e57e459c53971e~Ch6maW1A31256112561epsmtip1E;
        Tue, 12 Feb 2019 05:46:24 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
Date:   Tue, 12 Feb 2019 14:46:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmvu6G2KQYgwU79S02zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3+LzhMaPF7cYVbBaH37SzOnB7rJm3htFj
        dsNFFo+Fn76yehx8t4fJo2/LKkaPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
        DHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
        5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRn9B35zVhwRrhidpN8A+Mb/i5GTg4JAROJ3r4z
        jF2MXBxCAjsYJY59XckIkhAS+MQosfRWKETiG6PE/dmvWWE6Fh88zwaR2MsocW3DSiYI5z2j
        xOWtvewgVcICIRJr+g4wg9giAmkSb9vvMoHYzAInGCV6JlqB2GwCWhL7X9xgA7H5BRQlrv54
        DLaaV8BO4tfW72A2i4CqxNx1HWC9ogIREod730HVCEqcnPmEBcTmFPCSuLXuKhvEfHGJW0/m
        Q+2Sl2jeOpsZ5DgJgcnsEq+etDFBvOAicapjGQuELSzx6vgWdghbSuJlfxuUXS2x8uQRNojm
        DkaJLfsvQP1vLLF/6WSgQRxAGzQl1u/Sh1jGJ/Huaw8rSFhCgFeio00IolpZ4vKDu1BrJSUW
        t3eyQdgeEi+OrmedwKg4C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlpsWGCIHNmbGMEJV8t0
        B+OUcz6HGAU4GJV4eBVyE2OEWBPLiitzDzFKcDArifD+8E+KEeJNSaysSi3Kjy8qzUktPsRo
        CgzticxSosn5wGyQVxJvaGpkbGxsYWJoZmpoqCTOu97BOUZIID2xJDU7NbUgtQimj4mDU6qB
        0Un4CnNMMm+bisLjbbbhn1Iffnlwurnb6p+Utcsubonqzz+CFkqIfXCdXuu9V69cZMuGSMdv
        SY/t5l537Ph43GzXVx7pCMHaUFYdM73wz9vsNl76tyRBbpJGdM7CsI0xbfvq327JzRRbvZBp
        0yvbnt3TBGP7tZvNin/PsD84IUv9yb2Y45x/lViKMxINtZiLihMB5UzpUM4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSnO6G2KQYg+07JS02zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3+LzhMaPF7cYVbBaH37SzOnB7rJm3htFj
        dsNFFo+Fn76yehx8t4fJo2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDL6jvxmLDgjXDG7Sb6B
        8Q1/FyMnh4SAicTig+fZuhi5OIQEdjNKzJ+3jR0iISkx7eJR5i5GDiBbWOLw4WKImreMEu3P
        zrGB1AgLhEis6TvADGKLCKRJHGq4zQ5SxCxwglFi2/FTTBAdcxklnk/ZBtbBJqAlsf/FDTCb
        X0BR4uqPx4wgNq+AncSvrd/BbBYBVYm56zqYQGxRgQiJj0/3MUHUCEqcnPmEBcTmFPCSuLXu
        KtgcZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFu
        em6xYYFRXmq5XnFibnFpXrpecn7uJkZw9Glp7WA8cSL+EKMAB6MSD69CbmKMEGtiWXFl7iFG
        CQ5mJRHeH/5JMUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4
        pRoYZxoXy/5Q6dnzKnxFgerSQ2zLl+gfvl3hfqSo84bduVZ519ecC5KzPYwtfq6On/y7asZz
        Xb15zi9PmIRtSNzQqbMns9Vx1t9zxgL7/abvafsslFcy1WCzd8H7TV+dfr5he3g/tmtOL4Pn
        H9Vp5i9FDFW+bd+rGsu50/ZihiurWOzS3yKfF9V9U2Ipzkg01GIuKk4EAJYnVXG6AgAA
X-CMS-MailID: 20190212054624epcas1p166fb85b935e9f9cd3d2836f6fb84a450
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
        <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
> This patch set changes workqueue related features in devfreq framework.
> First patch switches to delayed work instead of deferred.
> The second switches to regular system work and deletes custom 'devfreq'.
> 
> Using deferred work in this context might harm the system performance.
> When the CPU enters idle, deferred work is not fired. The devfreq device's
> utilization does not have to be connected with a particular CPU.
> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
> They all are missing opportunity to check the HW state and react when
> the deferred work is not fired.
> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
> on full speed, might show x5 worse performance if the crucial CPU is in idle.

The devfreq framework keeps the balancing between performance
and power-consumption. It is wrong to focus on only either
performance or power.

This cover-letter focus on the only performance without any power-consumption
disadvantages. It is easy to raise the performance with short sampling rate
with polling modes. To get the performance, it is good as short as possible
of period.

Sometimes, when cpu is idle, the device might require the busy state.
It is very difficult to catch the always right timing between them.

Also, this patch cannot prevent the unneeded wakeup from idle state.
Apparently, it only focuses on performance without considering
the power-consumption disadvantage. In the embedded device,
the power-consumption is very important point. We can not ignore
the side effect.

Always, I hope to improve the devfreq framwork more that older.
But, frankly, it is difficult to agree because it only consider
the performance without considering the side-effect.

The power management framework always have to consider
the power-consumption issue. This point is always true.

> 
> Changes:
> v2:
> - single patch split into two
> - added cover letter
> 
> link for the previous version and discussion:
> https://marc.info/?l=linux-pm&m=154904631226997&w=2
> 
> Regards,
> Lukasz Luba
> 
> Lukasz Luba (2):
>   drivers: devfreq: change devfreq workqueue mechanism
>   drivers: devfreq: change deferred work into delayed
> 
>  drivers/devfreq/devfreq.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
