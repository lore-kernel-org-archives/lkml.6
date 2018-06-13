Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA153C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3ED208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bpRVCnB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3ED208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935533AbeFMMkI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:40:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59897 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbeFMMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:40:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180613124004euoutp02de52b488eef5dbc051c2f7c80d8934ad~3uKIf1VP20598605986euoutp02F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:40:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180613124004euoutp02de52b488eef5dbc051c2f7c80d8934ad~3uKIf1VP20598605986euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528893605;
        bh=kjbFZxYgDMzKNvVVM/CexGI20+haJiuluR8eQG1GVSA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bpRVCnB4lKAO9fPiTgNLvxj401lQNHqIJoy5b4v+3HBUt6ezvOTsOLndKtIc2TuzF
         IIxZrGYKTsRYEatNUOBtwavnOWR5QW9rdu15JOLqJtAP+57VAvcb37oRwj0q4AZ6hr
         jMmCMSnPEhCh3jrgcVzy0W/ULZExGOhdbV8lK4HA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180613124003eucas1p1370782d9c428df403ba0812319360b8f~3uKHEIt9G1440014400eucas1p18;
        Wed, 13 Jun 2018 12:40:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 94.13.17380.2A0112B5; Wed, 13
        Jun 2018 13:40:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G;
        Wed, 13 Jun 2018 12:40:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180613124001eusmtrp11f9d7279cf0e883638d104432119472c~3uKFQHvGU0805208052eusmtrp1L;
        Wed, 13 Jun 2018 12:40:01 +0000 (GMT)
X-AuditID: cbfec7f4-b4fc79c0000043e4-fc-5b2110a2938f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 90.86.04183.1A0112B5; Wed, 13
        Jun 2018 13:40:01 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180613124001eusmtip2fde1af256a8c253fa8f203e48ac62ff2~3uKE4i-1T2482224822eusmtip2T;
        Wed, 13 Jun 2018 12:40:01 +0000 (GMT)
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 13 Jun 2018 14:40:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613122359.GA8695@bombadil.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGOfu+ffs2nByn4eslL6PEhLzRHzOjTIMWgpT9p1JN/ZjSnLKp
        aZmXlNJ5KSxqrUUrzJl4oWneEENNV2lS3nJCIqgk1ghUQlM0t0/L/37Pc573vOeBQxOibq47
        narMZFRKmUJMCci2wfWRoy+wb3zwaGeIRN/cQElelRdTEtPcJFcy1qWnJDMN21yJwVzClTwp
        qkKSjTU9FUFLW+oCpKblap5UYx3nSN9rN0hpS02BtGlziSMdNrzjSVdMXufpOMGJZEaRms2o
        gk5eEaQsPc3JaHDIafo2SRaiLb4G8WnAx6Bze4GrQQJahOsQlFfO8VixiqCrfpFkxQqC0tfN
        nL2R7t7+3ZQRgbnn6674heDT9IQ95Ywj4e1g7c7FNO2C/eFna6gtQ+A/CL7ffYhsGQqHgMaq
        oWxM4sNQO9VK2PgAToC2sVnSxkLsBB8ez9uZj8PhedVL+yyBvaHdqidYdoXp+We7rxvhwXLP
        KXY2GxYab5GsfwbGm61clp1hydzKY9kThu5X2GsCLkZwR6vjsaICwRt9B8WmwqHf/MXehsBH
        oLkriLVPQ8lHC2WzATvClNWJfY8jVLc9IlhbCKW3RWzaD3Tmpn9rez+PEveQWLevpW5fM92+
        Zrr/ew2IrEeuTJY6Tc6oQ5XMtUC1LE2dpZQHJqWnmdDOnxraMq92oK7NxD6EaSR2EEbwfONF
        XFm2OjetDwFNiF2EMYs+8SJhsiz3OqNKv6zKUjDqPuRBk2JX4SX//DgRlssymasMk8Go9k45
        NN+9EGU2rptWZvsVaxAz1DKTFFO7NBAWYkywRIW6Lm64acc4iprpaL73VGSRZVB5drgy7Abt
        WQxz8jL/2eDYrBYsim4/Z4xS/jhU5/O7rKDzJq/NclEZrJwo9azO7zfIjBfkDwpJrVuVnzG7
        5nhUUqHHALOax0/UH3TQxg54GfLEpDpFFhJAqNSyvxsq5g9PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7oLBRSjDabuk7aYs34Nm8XK7mY2
        i02Pr7FaXN41h83i3pr/rBYLjrewWsxu7GO0+P1jDpsDh8fmFVoemz5NYvfoenuFyePEjN8s
        HpuX1Hus+/OKyePMgiPsHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8da
        GZkq6dvZpKTmZJalFunbJehlvJpbUbCGp2Ld3WssDYz/OLsYOTkkBEwk9hw8zN7FyMUhJLCU
        UeLzutfMEAkZiZPTGlghbGGJP9e62CCK3jJKPOpsB0sICzhJ7D+2DMjm4BAR0JB4s8UIpIZZ
        4A+jxKf928BqhAR+M0ocbwEbyiZgKNH1FmQQJwevgJ1Ey8FDYHEWAVWJZTe2gNmiAjESqzde
        ZoeoEZQ4OfMJC4jNKWAtsbBvKSOIzSxgJjFv80NmCFteYvvbOVC2uMStJ/OZJjAKzULSPgtJ
        yywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGJfbjv3csoOx613wIUYBDkYl
        Ht4HF+WjhVgTy4orcw8xSnAwK4nw+r1QiBbiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGDK
        yCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwLjswAQ5h8e9N39+
        SGm3t6tb2nuPM/DXE2k39oM/NY6XF7zsOlVm+LObKVNsuUOS1KtvTeVz58dnLNPZM9m6b3uK
        YvCids1dF/hKTzfHhpde75u3RuumjX3R4vdrd3ddf3LJLbTlyi/mOXe3KHyYf57T6dAP2XVi
        u07u/xz//JfA5CqRxuKt/BZKLMUZiYZazEXFiQDdZvZb4QIAAA==
Message-Id: <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
X-CMS-MailID: 20180613124001eucas1p2422f7916367ce19fecd40d6131990383
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
        <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
        <20180613122359.GA8695@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 2018-06-13 14:24, Matthew Wilcox wrote:
> On Wed, Jun 13, 2018 at 10:58:37AM +0200, Marek Szyprowski wrote:
>> cma_alloc() function has gfp mask parameter, so users expect that it
>> honors typical memory allocation related flags. The most imporant from
>> the security point of view is handling of __GFP_ZERO flag, because memory
>> allocated by this function usually can be directly remapped to userspace
>> by device drivers as a part of multimedia processing and ignoring this
>> flag might lead to leaking some kernel structures to userspace.
>> Some callers of this function (for example arm64 dma-iommu glue code)
>> already assumed that the allocated buffers are cleared when this flag
>> is set. To avoid such issues, add simple code for clearing newly
>> allocated buffer when __GFP_ZERO flag is set. Callers will be then
>> updated to skip implicit clearing or adjust passed gfp flags.
> I think the documentation for this function needs improving.  For example,
> GFP_ATOMIC does not work (it takes a mutex lock, so it can sleep).
> At the very least, the kernel-doc needs:
>
>   * Context: Process context (may sleep even if GFP flags indicate otherwise).
>
> Unless someone wants to rework this allocator to use spinlocks instead
> of mutexes ...

It is not only the matter of the spinlocks. GFP_ATOMIC is not supported 
by the
memory compaction code, which is used in alloc_contig_range(). Right, this
should be also noted in the documentation.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

