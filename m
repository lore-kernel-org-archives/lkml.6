Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC534C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6171120874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TxnyVi+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6171120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757173AbeFSKC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:02:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756442AbeFSKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GnRUZU+YNPV9hRDIH4MQR776E6J6fLwT2o+7JVZWQ8M=; b=TxnyVi+Sc21Dqpeskv/7jcMGm
        Z5p/4LqOm8Adf1IMzegJ1iPp9LBYoDL5Vocv0spnmzx6LR/rfLk/1MeZ23BXVRs5/A1IlKYOzkpmX
        f/ead+WZhcu+MGIbJpqRCmJqikFU2OHvYQjVm8WJMUOzej+02+ukRcv7sY4TWKYryr+WAJq3kMkVH
        1MdaqaR73e44pNppfp8JRmaL70umB2P8GkUrzeoXtAz0lfg2jc9r2HnxxOOzoyok9C57/CONz+Wdk
        GQFeyycj82CysqrehiFnk0Sh5FJ5W4ZPkBwdc2Uu8OtE35rzfkpXOvgwTOAWksVGriTfUEQZ934EK
        GdZEmiSig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVDSu-0001SY-Et; Tue, 19 Jun 2018 10:02:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B534620268507; Tue, 19 Jun 2018 12:02:18 +0200 (CEST)
Date:   Tue, 19 Jun 2018 12:02:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180619100218.GN2458@hirez.programming.kicks-ass.net>
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 07:34:16AM +0800, Yang Shi wrote:

> diff --git a/mm/mmap.c b/mm/mmap.c
> index fc41c05..e84f80c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2686,6 +2686,141 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return __split_vma(mm, vma, addr, new_below);
>  }
>  
> +/* Consider PUD size or 1GB mapping as large mapping */
> +#ifdef HPAGE_PUD_SIZE
> +#define LARGE_MAP_THRESH	HPAGE_PUD_SIZE
> +#else
> +#define LARGE_MAP_THRESH	(1 * 1024 * 1024 * 1024)
> +#endif
> +
> +/* Unmap large mapping early with acquiring read mmap_sem */
> +static int do_munmap_zap_early(struct mm_struct *mm, unsigned long start,
> +			       size_t len, struct list_head *uf)
> +{
> +	unsigned long end = 0;
> +	struct vm_area_struct *vma = NULL, *prev, *last, *tmp;
> +	bool success = false;
> +	int ret = 0;
> +
> +	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE - start)
> +		return -EINVAL;
> +
> +	len = (PAGE_ALIGN(len));
> +	if (len == 0)
> +		return -EINVAL;
> +
> +	/* Just deal with uf in regular path */
> +	if (unlikely(uf))
> +		goto regular_path;
> +
> +	if (len >= LARGE_MAP_THRESH) {
> +		down_read(&mm->mmap_sem);
> +		vma = find_vma(mm, start);
> +		if (!vma) {
> +			up_read(&mm->mmap_sem);
> +			return 0;
> +		}
> +
> +		prev = vma->vm_prev;
> +
> +		end = start + len;
> +		if (vma->vm_start > end) {
> +			up_read(&mm->mmap_sem);
> +			return 0;
> +		}
> +
> +		if (start > vma->vm_start) {
> +			int error;
> +
> +			if (end < vma->vm_end &&
> +			    mm->map_count > sysctl_max_map_count) {
> +				up_read(&mm->mmap_sem);
> +				return -ENOMEM;
> +			}
> +
> +			error = __split_vma(mm, vma, start, 0);
> +			if (error) {
> +				up_read(&mm->mmap_sem);
> +				return error;
> +			}
> +			prev = vma;
> +		}
> +
> +		last = find_vma(mm, end);
> +		if (last && end > last->vm_start) {
> +			int error = __split_vma(mm, last, end, 1);
> +
> +			if (error) {
> +				up_read(&mm->mmap_sem);
> +				return error;
> +			}
> +		}
> +		vma = prev ? prev->vm_next : mm->mmap;

Hold up, two things: you having to copy most of do_munmap() didn't seem
to suggest a helper function? And second, since when are we allowed to
split VMAs under a read lock?
