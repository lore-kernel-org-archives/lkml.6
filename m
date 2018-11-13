Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A858C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3248120684
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oLbP3pwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3248120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbeKMUYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:24:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38533 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbeKMUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:24:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181113102708euoutp01a6f9ecea169c9c2fadc79fe35be3e61f~mqCvIo3M60245502455euoutp01F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:27:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181113102708euoutp01a6f9ecea169c9c2fadc79fe35be3e61f~mqCvIo3M60245502455euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542104828;
        bh=KOuq7Q1tUW5EUErYjKua3Z6v9rW6e4skVjQdVXbuFOw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oLbP3pwVMU0jHuxOSbZp0/WzIy7uFoz9VqhWdky3CvgT9M/ZglP9YJyXJKcPEg8jL
         sHpOlEHZBabTVF/HyPjFE7eAvrNaaknUG4SQX33MhXSGJzbIFemiQzzgPoESCKMTQq
         Kx9IOr5CqurB4HcpybEDV4QyWwTrYSqfVqiwaUz4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181113102707eucas1p29074d229fc3883f608177ecee344cf01~mqCuonUZc1551515515eucas1p2c;
        Tue, 13 Nov 2018 10:27:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.97.04441.BF6AAEB5; Tue, 13
        Nov 2018 10:27:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181113102706eucas1p256fdba1b4f65ceb6f57f1fe537ffe216~mqCtySJwD2691026910eucas1p2q;
        Tue, 13 Nov 2018 10:27:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181113102706eusmtrp276405c5caf600a5cb8170252048e5c5a~mqCtxSQa23209232092eusmtrp2O;
        Tue, 13 Nov 2018 10:27:06 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-0f-5beaa6fb9176
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.F7.04284.AF6AAEB5; Tue, 13
        Nov 2018 10:27:06 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181113102706eusmtip16d4f916d4fc4703ba1d93b1f1b41f883~mqCtdTBpE1586515865eusmtip1a;
        Tue, 13 Nov 2018 10:27:06 +0000 (GMT)
Subject: Re: [PATCH] media: videobuf2-core: Fix error handling when fileio
 is deallocated
To:     Myungho Jung <mhjungk@gmail.com>, pawel@osciak.com,
        kyungmin.park@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9402424d-6e0c-b628-c6c2-8f87b5276a36@samsung.com>
Date:   Tue, 13 Nov 2018 11:27:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112004951.GA3948@myunghoj-Precision-5530>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87q/l72KNrixUtXibNMbdovLu+aw
        WfRs2MpqsWzTHyaLZwtiLKa8/cnuwOaxc9Zddo9NqzrZPB7/esnm0bdlFaPH501yAaxRXDYp
        qTmZZalF+nYJXBkfXx9mKjjOVXF+4keWBsYbHF2MnBwSAiYS+84eZ+9i5OIQEljBKNE46S2U
        84VR4srz/4wQzmdGidczFzLDtEzbuIcNIrGcUWL/hMNQLe8ZJZ7t/cIOUiUsEC3RM283K4gt
        IpAuMfHsF7BuZgFbiY5DnSwgNpuAoUTX2y42EJtXwE5i+sl5YL0sAqoSK85+Burl4BAViJFY
        c8UfokRQ4uTMJ2CtnAI2Enf+vGSEGCkvsf3tHKjx4hK3nsxnArlHQmAVu8StD5+YIK52kej+
        /hPKFpZ4dXwLO4QtI/F/J0xDM6NE+4xZ7BBOD6PE1jk72CCqrCUOH78IdhGzgKbE+l36EGFH
        iWPb+tlAwhICfBI33gpCHMEnMWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiXkCo9IsJK/NQvLO
        LCTvzELYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg4jn97/inHYxfLyUdYhTg
        YFTi4T0x/WW0EGtiWXFl7iFGCQ5mJRHenSavooV4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8
        iBYSSE8sSc1OTS1ILYLJMnFwSjUw7nGvu3vm+57omRe7day01qRG+izpfVooNdFvcqdpvfDj
        GKl8f2XVyLVO82dvXFZT6nL4xfMbrBvrisJ3Zpu2HFyTV9tR8lLb+UjsxpCTisVbnl3KeD/1
        5hvrtRyT/h1iv50zR5H9bGYzz6kgSw/RzabKlXK56SXTElmYVN/lrLTiYtoz7e8iJZbijERD
        Leai4kQAc9+AGTgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7q/lr2KNvi+wtzibNMbdovLu+aw
        WfRs2MpqsWzTHyaLZwtiLKa8/cnuwOaxc9Zddo9NqzrZPB7/esnm0bdlFaPH501yAaxRejZF
        +aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkfXx9mKjjO
        VXF+4keWBsYbHF2MnBwSAiYS0zbuYeti5OIQEljKKPF510xWiISMxMlpDVC2sMSfa11QRW8Z
        JW6uW8wGkhAWiJbYe/YlcxcjB4eIQLrE8x5FkDCzgK1Ex6FOFoj6fkaJu5umgw1iEzCU6Hrb
        BdbLK2AnMf3kPHYQm0VAVWLF2c9gNaICMRLdX/+xQtQISpyc+YQFxOYUsJG48+clI8QCdYk/
        8y4xQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi
        0rx0veT83E2MwEjbduzn5h2MlzYGH2IU4GBU4uE9Mf1ltBBrYllxZe4hRgkOZiUR3p0mr6KF
        eFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YBPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmk
        J5akZqemFqQWwfQxcXBKNTDWzvne2tmj+2RVq06JeZRbxR7Zz39mbRbbu/w+36mJk/8eESp9
        1L1GU5tLa2HAn6LQkHfL59fzqayT35vbuEBH59e919+lHx4v/u8R6igoc2TzrA+3ws9pnXk/
        MWX7xo16CU8m2D79k76m6+2k5Qv8FVhCXGYW3FO5zXnqwozcBQF3jY5tbN/SpsRSnJFoqMVc
        VJwIAOQTgfrKAgAA
X-CMS-MailID: 20181113102706eucas1p256fdba1b4f65ceb6f57f1fe537ffe216
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181112005053epcas4p1c674759797b4a930cfcce3abc7edd9ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181112005053epcas4p1c674759797b4a930cfcce3abc7edd9ad
References: <CGME20181112005053epcas4p1c674759797b4a930cfcce3abc7edd9ad@epcas4p1.samsung.com>
        <20181112004951.GA3948@myunghoj-Precision-5530>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

On 2018-11-12 01:49, Myungho Jung wrote:
> The mutex that is held from vb2_fop_read() can be unlocked while waiting
> for a buffer if the queue is streaming and blocking. Meanwhile, fileio
> can be released. So, it should return an error if the fileio address is
> changed.
>
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> Reported-by: syzbot+4180ff9ca6810b06c1e9@syzkaller.appspotmail.com

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for analyzing the code and fixing this issue!

> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 975ff5669f72..bff94752eb27 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -2564,6 +2564,10 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  		dprintk(5, "vb2_dqbuf result: %d\n", ret);
>  		if (ret)
>  			return ret;
> +		if (fileio != q->fileio) {
> +			dprintk(3, "fileio deallocated\n");
> +			return -EFAULT;
> +		}
>  		fileio->dq_count += 1;
>  
>  		fileio->cur_index = index;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

