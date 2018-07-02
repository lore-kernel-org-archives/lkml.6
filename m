Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7A7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36199218C2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d+eWUAjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36199218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeGBNXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:23:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50544 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeGBNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:23:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180702132337euoutp02592d17633106be36acede6b5207aafa4~9kAlFZOof1870518705euoutp02b
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 13:23:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180702132337euoutp02592d17633106be36acede6b5207aafa4~9kAlFZOof1870518705euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530537817;
        bh=K2dRMZ3IqQg7dzggnUw6GdH7UVDwpLaVRNUF0FK5QA0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d+eWUAjHF69Kd9fQaoh2EHzZ8ARUeVoTLAMNvGv6b1ZuFhZTZ9gDuZhFoRVHZvZ/y
         smbUb7A9MVStMHab6qtTKcsLXBpQaKmZogJmYvnvGWt5rDQnppU6JAr2g1rYTh/OTA
         nFDVaRqqf1kwDBoNsYsvk3J+1uFwbH7gO75ByeAQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180702132336eucas1p1969f2938694744450568b4f0f2f194f5~9kAj4F2cx2829228292eucas1p1V;
        Mon,  2 Jul 2018 13:23:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 94.1F.17380.8572A3B5; Mon,  2
        Jul 2018 14:23:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w;
        Mon,  2 Jul 2018 13:23:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180702132335eusmtrp2af4e0f56699029742c0d84475aa37708~9kAiixB_c1766317663eusmtrp2E;
        Mon,  2 Jul 2018 13:23:35 +0000 (GMT)
X-AuditID: cbfec7f4-6f9ff700000043e4-2b-5b3a2758eec7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.12.04183.7572A3B5; Mon,  2
        Jul 2018 14:23:35 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180702132334eusmtip276dcc3d3962394f03ccc23dfc1b8658e~9kAiGHk_V1508215082eusmtip2I;
        Mon,  2 Jul 2018 13:23:34 +0000 (GMT)
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
To:     Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 2 Jul 2018 15:23:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613133913.GD20315@dhcp22.suse.cz>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7oR6lbRBjt28FnMWb+GzeL0hEVM
        Fiu7m9ksNj2+xmpxedccNot7a/6zWrz+tozZYsHxFlaL2Y19jBa/f8xhc+Dy2LxCy2PTqk42
        j02fJrF7dL29wuRxYsZvFo/NS+o91v15xeRxZsERdo/Pm+QCOKO4bFJSczLLUov07RK4Mha9
        us5ScJCr4t7OPywNjHs5uhg5OSQETCQOzv7N0sXIxSEksIJRYv36B0wgCSGBL4wSu97IQiQ+
        M0p82nCdDaZj15wOVojEckaJnq4fUM57RonVHY+ZQaqEBZwk9h9bxgpiiwh4S3Q+3Aa2g1lg
        AZNE36MpYKPYBAwlut52AdkcHCwCKhIdy4xBwqICMRLbLj9gAbF5BQQlTs58AmZzAm2+/+ch
        2HnMAvIS29/OYYawxSVuPZnPBDJfQuARu0Tf4qNsEM1lEpNaf0Gd7SKxs+06K4QtLPHq+BZ2
        CFtG4v9OmOZmRon2GbPYIZweRomtc3ZAdVtLHD5+kRXkUmYBTYn1u/Qhwo4SLadugj0gIcAn
        ceOtIMRBfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3BC5eYJzAqzULy5iwkr81C8toshL0LGFlW
        MYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKax0/+Of9nBuOtP0iFGAQ5GJR7eCnmraCHW
        xLLiytxDjBIczEoivNtUgUK8KYmVValF+fFFpTmpxYcYpTlYlMR54zTqooQE0hNLUrNTUwtS
        i2CyTBycUg2M8cXHLfiPRjceurKiOv9cnr3i0dM+nScCv7dtWSUcOmurynYutaOLGTqvOvQs
        bTv36c1uoXJjp1d1lZFntnTLu1UVcS12tfVWXBj8mOXtssX7Zv6Zutnpz/WzloeZN0YYdEjO
        SWA7slDLaw/DbmPJHhHX3WwLe13cZy35dmrvSy2b4OhG3SkySizFGYmGWsxFxYkA0XZovF8D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7rh6lbRBpf3sVrMWb+GzeL0hEVM
        Fiu7m9ksNj2+xmpxedccNot7a/6zWrz+tozZYsHxFlaL2Y19jBa/f8xhc+Dy2LxCy2PTqk42
        j02fJrF7dL29wuRxYsZvFo/NS+o91v15xeRxZsERdo/Pm+QCOKP0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mha9us5ScJCr4t7OPywNjHs5uhg5
        OSQETCR2zelg7WLk4hASWMoocePuS3aIhIzEyWkNrBC2sMSfa11sILaQwFtGiWvNWiC2sICT
        xP5jy8BqRAS8JTofbmMBGcQssIhJ4mbzLGaIqbuZJTaub2cEqWITMJToegsxiVfATuLU3Tag
        OAcHi4CKRMcyY5CwqECMxOqNl9khSgQlTs58wgJicwJdev/PQyYQm1nATGLe5ofMELa8xPa3
        c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMj
        MG63Hfu5ZQdj17vgQ4wCHIxKPLwV8lbRQqyJZcWVuYcYJTiYlUR4t6kChXhTEiurUovy44tK
        c1KLDzGaAv02kVlKNDkfmFLySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0
        MXFwSjUwBpy8/7S5jedhqRlDgm7vD+Msbg7u4zcOBzy5XSnOKfR0yvofE+p76muXHH12Zh7/
        musLehqq+OP8XL7Krfwz11WusuzLVg9flVy27fkLyyd/Wli+b/eSBDe+1be3cwQu+/E4R/+h
        4t+zm3JYdpZ+vmHxX1PEaeeufHuhhU4OffPj0nvnzP+kqcRSnJFoqMVcVJwIAGmkLPrxAgAA
Message-Id: <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
X-CMS-MailID: 20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 2018-06-13 15:39, Michal Hocko wrote:
> On Wed 13-06-18 05:55:46, Christoph Hellwig wrote:
>> On Wed, Jun 13, 2018 at 02:40:00PM +0200, Marek Szyprowski wrote:
>>> It is not only the matter of the spinlocks. GFP_ATOMIC is not supported
>>> by the
>>> memory compaction code, which is used in alloc_contig_range(). Right, this
>>> should be also noted in the documentation.
>> Documentation is good, asserts are better.  The code should reject any
>> flag not explicitly supported, or even better have its own flags type
>> with the few actually supported flags.
> Agreed. Is the cma allocator used for anything other than GFP_KERNEL
> btw.? If not then, shouldn't we simply drop the gfp argument altogether
> rather than give users a false hope for differen gfp modes that are not
> really supported and grow broken code?

Nope, all cma_alloc() callers are expected to use it with GFP_KERNEL gfp 
mask.
The only flag which is now checked is __GFP_NOWARN. I can change the 
function
signature of cma_alloc to:
struct page *cma_alloc(struct cma *cma, size_t count, unsigned int 
align, bool no_warn);

What about clearing the allocated buffer? Should it be another bool 
parameter,
done unconditionally or moved to the callers?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

