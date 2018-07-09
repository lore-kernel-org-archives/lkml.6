Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809CFC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BF720877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqTSDyRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BF720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeGIKcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:32:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53892 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbeGIKcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:32:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180709103201euoutp02a334262f47705dc9d8e0ddaab413f68a~-rLv6Pzw30842308423euoutp02g
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 10:32:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180709103201euoutp02a334262f47705dc9d8e0ddaab413f68a~-rLv6Pzw30842308423euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531132321;
        bh=MBIOcxlQY4oOgBNyK0tA1CC4b0A3gvu09Pd2OBuMzvg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aqTSDyRUdPQMsC5CyAx/uDSRrSX8V5kKmexssozAMjdnktSpjIrfIxMPQc+a79A5C
         BtPDmRoIx1m1rRJykzqdPKa5PAnECCtRrjwoJlvh6K3kxslX8wBAixZpHihR449V0L
         Em17mvkOx6GP6PYrkcatXoZTs5aTDV8ZZGFwr6Gk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180709103200eucas1p27d677ceafd9e4e22f22f5a944f5abc9d~-rLu2CuFT0700807008eucas1p24;
        Mon,  9 Jul 2018 10:32:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.99.05700.0A9334B5; Mon,  9
        Jul 2018 11:32:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180709103159eucas1p1e72d940f6c947769ff7b55cd5bfb4b61~-rLtaSiDM3047830478eucas1p14;
        Mon,  9 Jul 2018 10:31:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180709103158eusmtrp1bfea2a6cf42c1ec8a6ac790ec316b0b0~-rLtLl6-n1013010130eusmtrp1M;
        Mon,  9 Jul 2018 10:31:58 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-92-5b4339a0e618
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.21.04183.E99334B5; Mon,  9
        Jul 2018 11:31:58 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180709103158eusmtip1fc2c976233b18300761bfdc9fecc67d5~-rLsu8-e92566725667eusmtip1o;
        Mon,  9 Jul 2018 10:31:58 +0000 (GMT)
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 9 Jul 2018 12:31:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180702133247.GT19043@dhcp22.suse.cz>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87oLLJ2jDVbPFrSYs34Nm8XpCYuY
        LFZ2N7NZbHp8jdXi8q45bBb31vxntXj9bRmzxYLjLawWsxv7GC1+/5jD5sDlsXmFlsemVZ1s
        Hps+TWL36Hp7hcnjxIzfLB6bl9R7rPvzisnjzIIj7B6fN8kFcEZx2aSk5mSWpRbp2yVwZRzr
        X8pS8IO34tScG2wNjKu4uxg5OSQETCR6dx1m72Lk4hASWMEosWv3QSYI5wujxOPZN1kgnM+M
        Eic37GCCaVm8p4kRIrGcUeLWiitQ/e8ZJTYfWckGUiUs4CSx/9gyVhBbREBFYn3fHbAiZoGT
        TBJLdx4ES7AJGEp0ve0Ca2ABKvr66A87iC0qECMxb9FfFhCbV0BQ4uTMJ2A2J9Dq1w8/gdnM
        AvIS29/OYYawxSVuPZkPdriEwCN2if9/frNBNJdJfFv0H+hWDqCEi8T0A9YQLwhLvDq+hR3C
        lpE4PbmHBaK3mVGifcYsdginh1Fi65wdbBBV1hKHj19kBRnELKApsX6XPkTYUaLl1E02iPl8
        EjfeCkLcwycxadt0Zogwr0RHmxBEtZrErOPr4NYevHCJeQKj0iwkX85C8tksJJ/NQti7gJFl
        FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAiO/3v+KcdjF8vJR1iFOBgVOLh/VDoFC3E
        mlhWXJl7iFGCg1lJhDfRCijEm5JYWZValB9fVJqTWnyIUZqDRUmcN06jLkpIID2xJDU7NbUg
        tQgmy8TBKdXAuOdJsEIN96sNd+YmH9/ysHB35pIqJ6PLoW+s2LU/bq88dCDqU2kP89mfKTfs
        vyveSFvwgPXKXMacOqvoHzUZJRpfBQ1rChbdNtD/PC/95qF7/HdEu6YFGpVxLTXwfvXvo+yR
        8/1Ht6pVLRUR3S0SznZ/qodMR4mVsEI6xzSTPokrOpearmsHKbEUZyQaajEXFScCAIEe26Rg
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7rzLJ2jDR7+1LaYs34Nm8XpCYuY
        LFZ2N7NZbHp8jdXi8q45bBb31vxntXj9bRmzxYLjLawWsxv7GC1+/5jD5sDlsXmFlsemVZ1s
        Hps+TWL36Hp7hcnjxIzfLB6bl9R7rPvzisnjzIIj7B6fN8kFcEbp2RTll5akKmTkF5fYKkUb
        WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZRzrX8pS8IO34tScG2wNjKu4uxg5
        OSQETCQW72li7GLk4hASWMooMevoUXaIhIzEyWkNrBC2sMSfa11sILaQwFtGiXMrAkBsYQEn
        if3HloHViAioSKzvu8MOMohZ4DSTRNOt+SwQUy+xSPT2/2UEqWITMJToegsyiYODV8BOYuVP
        M5AwC1Dz10d/wBaLCsRIrNz8GmwZr4CgxMmZT1hAbE6gS18//ARmMwuYSczb/JAZwpaX2P52
        DpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIE
        xu22Yz+37GDsehd8iFGAg1GJh/dDoVO0EGtiWXFl7iFGCQ5mJRHeRCugEG9KYmVValF+fFFp
        TmrxIUZToOcmMkuJJucDU0peSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+
        Jg5OqQZGrrMKnzWiw82ibHV7bXzzqusmV303ktB6H7rlYIlyv5/h/dXKqyq3FJTtZNkcEdF8
        tOdT3+pi/fd77doPtU6vNpdc5bq0tZhvtvQT472ei9RW3zCcJlb8yFxN6OeFUx9U/zDveyoU
        t/PS6+70HY/8inwtVu72MO5fdrZarCd5b33g/b1iid+UWIozEg21mIuKEwElDFsr8QIAAA==
Message-Id: <20180709103159eucas1p1e72d940f6c947769ff7b55cd5bfb4b61~-rLtaSiDM3047830478eucas1p14@eucas1p1.samsung.com>
X-CMS-MailID: 20180709103159eucas1p1e72d940f6c947769ff7b55cd5bfb4b61
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
        <20180702133247.GT19043@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 2018-07-02 15:32, Michal Hocko wrote:
> On Mon 02-07-18 15:23:34, Marek Szyprowski wrote:
>> On 2018-06-13 15:39, Michal Hocko wrote:
>>> On Wed 13-06-18 05:55:46, Christoph Hellwig wrote:
>>>> On Wed, Jun 13, 2018 at 02:40:00PM +0200, Marek Szyprowski wrote:
>>>>> It is not only the matter of the spinlocks. GFP_ATOMIC is not supported
>>>>> by the
>>>>> memory compaction code, which is used in alloc_contig_range(). Right, this
>>>>> should be also noted in the documentation.
>>>> Documentation is good, asserts are better.  The code should reject any
>>>> flag not explicitly supported, or even better have its own flags type
>>>> with the few actually supported flags.
>>> Agreed. Is the cma allocator used for anything other than GFP_KERNEL
>>> btw.? If not then, shouldn't we simply drop the gfp argument altogether
>>> rather than give users a false hope for differen gfp modes that are not
>>> really supported and grow broken code?
>> Nope, all cma_alloc() callers are expected to use it with GFP_KERNEL gfp
>> mask.
>> The only flag which is now checked is __GFP_NOWARN. I can change the
>> function
>> signature of cma_alloc to:
>> struct page *cma_alloc(struct cma *cma, size_t count, unsigned int
>> align, bool no_warn);
> Are there any __GFP_NOWARN users? I have quickly hit the indirection
> trap and searching for alloc callback didn't tell me really much.

They might be via dma_alloc_from_contiguous() and dma_alloc_*() path.

>> What about clearing the allocated buffer? Should it be another bool
>> parameter, done unconditionally or moved to the callers?
> That really depends on callers. I have no idea what they actually ask
> for.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

