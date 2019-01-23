Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B40C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A89D21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kn1tAZ8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfAWH2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:28:10 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36056 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:28:10 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190123072807euoutp026cc4bdbeaf68e92a281cfe2640246568~8aZtbr91W2825128251euoutp02v
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:28:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190123072807euoutp026cc4bdbeaf68e92a281cfe2640246568~8aZtbr91W2825128251euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548228487;
        bh=Kwashk6PJKuzpg3z/R1B0kvX5QaN9x3t+0AvpREXyRg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Kn1tAZ8wtLtGdUXhHWTVl3M1lAnhyVyfRAagOhnGg8JSAWYqdJVmw3xKujlWWrEFM
         txh3n74NTTd1fe2t5cZiwu17HqZlUC44tkQ5IEx7jxvciE3u13ceUfI6Vc9rHOLL8m
         ER/oZRYjUlkL54wyjkB15Xnd5gO6I8mRkEVD21uQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190123072806eucas1p2a792cd077e24098ba789e66054d436df~8aZscUlh50378203782eucas1p2b;
        Wed, 23 Jan 2019 07:28:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5C.94.04441.687184C5; Wed, 23
        Jan 2019 07:28:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190123072805eucas1p136f90773e9880906de93bcf148f19a86~8aZrgw6l53058330583eucas1p1q;
        Wed, 23 Jan 2019 07:28:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190123072805eusmtrp2b22d4ae8e6914d463e8ee1a132ae268c~8aZrRoLBm0692606926eusmtrp2f;
        Wed, 23 Jan 2019 07:28:05 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-d8-5c481786c3c5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.85.04284.587184C5; Wed, 23
        Jan 2019 07:28:05 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190123072804eusmtip19ebe6306de0b1866521c92d6be39b41a~8aZqHhOrR0811108111eusmtip1B;
        Wed, 23 Jan 2019 07:28:04 +0000 (GMT)
Subject: Re: kmemleak panic
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        Sachin Nikam <snikam@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
Date:   Wed, 23 Jan 2019 08:28:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123055414.GA4747@rapoport-lnx>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SazBUYRjHe/ecPefYac1paTxDU2OnmimTkOqdLqqZLqdP1Zc+lEaLM5Lr
        7EakJiVdJLdB7GxpGF20kSUhtdnSKhmWLmqIabAy1ioppcjuSfn2e57n/7zP/z/zMoQsh3Jl
        QiOP8MpIRbickpBVz360rDjrwvl7ZZa4Y02ZlsJTIw8Q/p31jMZN+mESf6rgsPV6KsL5Q1MU
        Lu8rpHF7rYbCVaPNBC5+axLh7rTN+GWuEtdda6Zxv/4DhTvTBkmc/PApjetHesW4IzuRwskF
        1WL8Mc1Cb57Paa9qETfxMwtx6aWjYq5G3UVzupILFDd0+4qY63xTR3GNeRMkl1H4GHGXkoYp
        rqzyNclVNCVwo7qFu6X7JBuC+fDQWF650u+g5NCL4WwUnSmPa0w7QyaiHrcU5MAA6wu/Mn8i
        G8vYmwgmLq5OQZJp/org+zkrLRSjCC7la6mZjc7uBkoY3EBgqCz5q7IiGK+9JbapnFg36O+q
        EdnYmd0DZu0dwiYi2G4xmE/n2Z+iWG9IsaTYWcr6Qc6jFrsRkl0CQ6kZ0w8xzHzWH5LbJYJk
        HjzP7yVt7DC9OtaVbJcT7CK4b9EQArvA+94Cke0WsK0MFBpykWB7KzRaikiBnWDQWEkLvACm
        amYWkhCcy1PTQpGK4J6m+m/o9fDEaLI7IthlUFa7Umhvgb4XfSJbG1hH6LDME0w4QlbVZUJo
        S+H8WZmgXgpqY+m/s/WtbUQGkqtnRVPPiqOeFUf9/+41RJYgFz5GFRHCq7wj+aOeKkWEKiYy
        xDMoKkKHpj9r06TxSzUaaws0IJZB8rnS8TU7/GViRawqPsKAgCHkztJtpu3+MmmwIv4Yr4wK
        UMaE8yoDcmNIuYs0YU7PfhkbojjCh/F8NK+cmYoYB9dEdNTRuLf2Slxr5qmOsb4iH4fVa28d
        2AQDg+WTAYctJ5Y09C5Of2U2hnw5aVrlpy8Oqo8NmER3HfXHSZNOJq5bE7YrSuuRbv68d+sP
        8rlp52D3p1NJerPHwLd8r3H3XHLEp5UYiK/zqMhDWo1xwf51Lf2V1o2BWc03F2okvvJ3nu5y
        UnVI4b2cUKoUfwALIlOTqAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xu7qt4h4xBv17ZC3mrF/DZvH/w25G
        i7+TjrFbnN7/jsXi5WYPi/fLehgtZr75z2ax8ekidovLu+awWWz7fJbZYun1i0wW9/scLM5M
        K7LYs+Asu8Wz/ffYLO70vWKxaN17hN3i4IcnrBY3pjSwWbTO38Fq8ajvLbuDqMeaeWsYPX7/
        msTo0b/uM6vHzll32T02repk83izei6rx51re9g8Tsz4zeIxYdEBRo/e5ndsHuu3XGXx2Hy6
        2uPzJrkA3ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9
        uwS9jFPvpjAWTFSqONHXwtLA+EC6i5GTQ0LAROLO/aNsXYxcHEICSxklljevYYNIyEicnNbA
        CmELS/y51gUWFxJ4yyjxakc9iC0sIC3x7O5OJhBbRCBQYv/sJmaQQcwCD1klprduZIWY2sIq
        cXhjPwtIFZuAoUTXW4hJvAJ2ElP3nWcEsVkEVCXe9EwA2yYqECMx60kfO0SNoMTJmU/AejmB
        er/ebQWrZxZQl/gz7xIzhC0vsf3tHChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEkt
        Lc5Nzy021CtOzC0uzUvXS87P3cQITCXbjv3cvIPx0sbgQ4wCHIxKPLw/zNxjhFgTy4orcw8x
        SnAwK4nwul50ixHiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGCayyuJNzQ1NLewNDQ3Njc2
        s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwFhxw7hx7iFdi5CC79sbDr99EpCyYmvA0srF
        V/p8N9u3Kly7sfP1g/7jkn3ZDUY9IjIGHLs1ehavrb3pVq08TfbHbYZ5cvYti3ZtOb/95kHH
        az0v99yyPVQ0q7b+Rnprbp30rQDrL4l9cQ3eszveFiSKy3Y1Tiva+DXz1twX5xJmH74mLKce
        vVqJpTgj0VCLuag4EQBJikcUOwMAAA==
X-CMS-MailID: 20190123072805eucas1p136f90773e9880906de93bcf148f19a86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8
References: <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
        <20190119132832.GA29881@MBP.local>
        <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
        <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
        <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
        <20190121143704.GE29504@arrakis.emea.arm.com>
        <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
        <20190121174234.GC26461@rapoport-lnx>
        <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
        <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
        <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
        <20190123055414.GA4747@rapoport-lnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2019-01-23 06:54, Mike Rapoport wrote:

...
> Resending it as a formal patch now, I took a liberty to add your Tested-by.
>
> >From a847ca684db29a3c09e4dd2a8a008b35cf36e52f Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Wed, 23 Jan 2019 07:38:50 +0200
> Subject: [PATCH] of: fix kmemleak crash caused by imbalance in early memory
>  reservation
>
> Marc Gonzalez reported the following kmemleak crash:
>
> Unable to handle kernel paging request at virtual address ffffffc021e00000
> Mem abort info:
>   ESR = 0x96000006
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000006
>   CM = 0, WnR = 0
> swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
> [ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803,
> pmd=0000000000000000
> Internal error: Oops: 96000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 6 PID: 523 Comm: kmemleak Tainted: G S      W         5.0.0-rc1 #13
> Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
> pstate: 80000085 (Nzcv daIf -PAN -UAO)
> pc : scan_block+0x70/0x190
> lr : scan_block+0x6c/0x190
> sp : ffffff8012e8bd20
> x29: ffffff8012e8bd20 x28: ffffffc0fdbaf018
> x27: ffffffc022000000 x26: 0000000000000080
> x25: ffffff8011aadf70 x24: ffffffc0f8cc8000
> x23: ffffff8010dc8000 x22: ffffff8010dc8830
> x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050
> x19: ffffffc021e00000 x18: 0000000000002409
> x17: 0000000000000200 x16: 0000000000000000
> x15: ffffff8010e14dd8 x14: 0000000000002406
> x13: 000000004c4dd0c6 x12: ffffffc0f77dad58
> x11: 0000000000000001 x10: ffffff8010d9e688
> x9 : ffffff8010d9f000 x8 : ffffff8010d9e688
> x7 : 0000000000000002 x6 : 0000000000000000
> x5 : ffffff8011511c20 x4 : 00000000000026d1
> x3 : ffffff8010e14d88 x2 : 5b36396f4e7d4000
> x1 : 0000000000208040 x0 : 0000000000000000
> Process kmemleak (pid: 523, stack limit = 0x(____ptrval____))
> Call trace:
>  scan_block+0x70/0x190
>  scan_gray_list+0x108/0x1c0
>  kmemleak_scan+0x33c/0x7c0
>  kmemleak_scan_thread+0x98/0xf0
>  kthread+0x11c/0x120
>  ret_from_fork+0x10/0x1c
> Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260)
> ---[ end trace 176d6ed9d86a0c33 ]---
> note: kmemleak[523] exited with preempt_count 2
>
> The crash happens when a no-map area is allocated in
> early_init_dt_alloc_reserved_memory_arch(). The allocated region is
> registered with kmemleak, but it is then removed from memblock using
> memblock_remove() that is not kmemleak-aware.
>
> Replacing __memblock_alloc_base() with memblock_find_in_range() makes sure
> that the allocated memory is not added to kmemleak and then
> memblock_remove()'ing this memory is safe.
>
> As a bonus, since memblock_find_in_range() ensures the allocation in the
> specified range, the bounds check can be removed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

With the minor fix mentioned below, you can add my:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  drivers/of/of_reserved_mem.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 1977ee0adcb1..6807a1cffe55 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -37,21 +37,16 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>  	 */
>  	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
>  	align = !align ? SMP_CACHE_BYTES : align;
> -	base = __memblock_alloc_base(size, align, end);
> +	base = memblock_find_in_range(size, align, start, end);

Please remove a comment about __memblock_alloc_base() above that block
of code. It is no longer needed after this change.

>  	if (!base)
>  		return -ENOMEM;
>  
> -	/*
> -	 * Check if the allocated region fits in to start..end window
> -	 */
> -	if (base < start) {
> -		memblock_free(base, size);
> -		return -ENOMEM;
> -	}
> -
>  	*res_base = base;
>  	if (nomap)
>  		return memblock_remove(base, size);
> +	else
> +		return memblock_reserve(base, size);
> +
>  	return 0;
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

