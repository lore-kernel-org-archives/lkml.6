Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D1EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D76E20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HRE2A4fI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D76E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeGIKdF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:33:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54185 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754431AbeGIKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:33:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180709103301euoutp02b076a1e7b7e073e966feb09df6e54745~-rMn2M40X1077210772euoutp02f
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 10:33:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180709103301euoutp02b076a1e7b7e073e966feb09df6e54745~-rMn2M40X1077210772euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531132381;
        bh=RYX5TkKYSXVy1gS5HLr22bi5VOviMJB/Xzgt3VsOfuA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HRE2A4fIr0542ypN44a7CmTDuvojIw3/eN+u2qamxI2I+TJC5Nd9tElzM5nRaehc2
         XVOWi370/eBoy3THwZ2/z+/LI4PjqOS2KM7C3pZv4tIqkWDKadkvRzV5FnT/Ej8rSr
         VGG3beAWhq174587MxqJW8zMxZU4f4v4s6VIWty0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180709103300eucas1p2e563ce992d58f107f2897ea29ef887ad~-rMm1hKI13247332473eucas1p27;
        Mon,  9 Jul 2018 10:33:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F4.B9.05700.CD9334B5; Mon,  9
        Jul 2018 11:33:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180709103259eucas1p1fc03f1da5e8964f903d09c5573923c10~-rMmDLdF-0476504765eucas1p12;
        Mon,  9 Jul 2018 10:32:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180709103259eusmtrp16da234ace5c77798c7d9915729ac6b8b~-rMlzhwJE1013010130eusmtrp1k;
        Mon,  9 Jul 2018 10:32:59 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-37-5b4339dc2fa4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.41.04183.BD9334B5; Mon,  9
        Jul 2018 11:32:59 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180709103259eusmtip1e47dd10b13c771f6a712b4a3925a1253~-rMlXieae2194921949eusmtip1-;
        Mon,  9 Jul 2018 10:32:59 +0000 (GMT)
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 9 Jul 2018 12:32:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180702133016.GA16909@infradead.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87p3LJ2jDW7/EraYs34Nm8XpCYuY
        LFZ2N7NZbHp8jdXi8q45bBb31vxntXj9bRmzxYLjLawWsxv7GC1+/5jD5sDlsXmFlsemVZ1s
        Hps+TWL36Hp7hcnjxIzfLB6bl9R7rPvzisnjzIIj7B6fN8kFcEZx2aSk5mSWpRbp2yVwZUye
        mV/QxFKxe99DpgbGacxdjJwcEgImEvu+PWPtYuTiEBJYwSjxq2UqlPOFUWLvi6PsEM5nRomO
        y1uZYFo+9y5ng0gsZ5Ro7jnEDOG8Z5TYtPQX2GBhASeJ/ceWsYLYIgKaEreWt4MVMQscYZJ4
        0nKNHSTBJmAo0fW2iw3EZhFQkZj4bSEjiC0qECMxb9FfFhCbV0BQ4uTMJ2A2p4CxxNHdU8Fs
        ZgF5ie1v5zBD2OISt57MZwJZICFwi11iSv91NojmMolTk4+xQdztIvFx0l92CFtY4tXxLVC2
        jMTpyT0sEM3NjBLtM2axQzg9jBJb5+yA6raWOHz8ItA/HEDrNCXW79KHCDtKtJy6yQYSlhDg
        k7jxVhDiID6JSdumM0OEeSU62oQgqtUkZh1fB7f24IVLzBMYlWYheXMWktdmIXltFsLeBYws
        qxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQIT2el/xz/tYPx6KekQowAHoxIP74dCp2gh
        1sSy4srcQ4wSHMxKIryJVkAh3pTEyqrUovz4otKc1OJDjNIcLErivHEadVFCAumJJanZqakF
        qUUwWSYOTqkGRhM+SaG3yc+6jcvDf0jWbRT98Vgy5PAbmeU8Z1eEnZtfmFEatZjP49PtBpva
        5AcBKzIcuGSiVFMbnpWvtOp8zL5mQcJlzhdyLjP5DN5uZtkx5fHxwJcMcxeyr8qyu3voe4bE
        0QypuHX/Zv8RCq9pnnisR2JOdac677p6930vdmXMz+w/+7IsUYmlOCPRUIu5qDgRABqN/K1g
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7q3LZ2jDbpPKVjMWb+GzeL0hEVM
        Fiu7m9ksNj2+xmpxedccNot7a/6zWrz+tozZYsHxFlaL2Y19jBa/f8xhc+Dy2LxCy2PTqk42
        j02fJrF7dL29wuRxYsZvFo/NS+o91v15xeRxZsERdo/Pm+QCOKP0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MibPzC9oYqnYve8hUwPjNOYuRk4O
        CQETic+9y9m6GLk4hASWMkps6TrKDpGQkTg5rYEVwhaW+HOtiw3EFhJ4yyixcZI1iC0s4CSx
        /9gysBoRAU2JW8vbwYYyCxxjknjzC2roRRaJ7tmvwBJsAoYSXW8hBvEK2EncmrWSCcRmEVCR
        mPhtISOILSoQI7Fy82uoGkGJkzOfsIDYnALGEkd3T2WBWGAmMW/zQ6hl8hLb386BssUlbj2Z
        zzSBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCo3Xbs55Yd
        jF3vgg8xCnAwKvHwfih0ihZiTSwrrsw9xCjBwawkwptoBRTiTUmsrEotyo8vKs1JLT7EaAr0
        3ERmKdHkfGBCySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwLhz
        8mbbJxMP/3vfynzW+FpVpahHVtHDV+/0Lrz8/yJO3P+H3d0Em5DFqn53JA+zTmdzurCKy0PM
        5oL7/NZIMxHv2MrAxkNehXeOF/P1M/4onphbtvFM8tfoS5W7I07aNb6XV6672S0fMXlR7pYN
        ukoKB47qJIrerp/62Xmh79vKQwy27qd+WCixFGckGmoxFxUnAgDimMgP8AIAAA==
Message-Id: <20180709103259eucas1p1fc03f1da5e8964f903d09c5573923c10~-rMmDLdF-0476504765eucas1p12@eucas1p1.samsung.com>
X-CMS-MailID: 20180709103259eucas1p1fc03f1da5e8964f903d09c5573923c10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
        <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
        <20180613122359.GA8695@bombadil.infradead.org>
        <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
        <20180613125546.GB32016@infradead.org>
        <20180613133913.GD20315@dhcp22.suse.cz>
        <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
        <20180702133016.GA16909@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2018-07-02 15:30, Christoph Hellwig wrote:
> On Mon, Jul 02, 2018 at 03:23:34PM +0200, Marek Szyprowski wrote:
>> What about clearing the allocated buffer? Should it be another bool
>> parameter,
>> done unconditionally or moved to the callers?
> Please keep it in the callers.  I plan to push it up even higher
> from the current callers short to midterm.

Okay, I will post a patch with this approach then.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

