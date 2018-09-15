Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E61AECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B1C208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UzTCQMw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B1C208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeIOOj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 10:39:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 10:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CC+nWuTJQ9mF0+Pa+L35f0Tn5UB4w0bRPtZDMtRndOs=; b=UzTCQMw7/dCnR+2nB0TsAkD5P
        HNlZpGWVOTWhtdyuDUoL+Xe/qyMxBVtdl2EAcCb296IdnI66wODmQHuaxZdVfccplq713vXTVZQXu
        g/H4qQPS6ikM/f5yHQxE+ErXS5A/LrBY/jNJbTizZwFs61pzCQwwL8DcgujellyfFgaQ2m62VVmsW
        52DnXROQJ4iosHLNSmjnW9gb/TAyWa4/K3++znER/rB0zf6gMYDOYHKKqyNBFPLQiN5Gfqu+mya1x
        p4YOIycDUVZgutg6rZod5K7FhCzzyoBRiCVhwXzd96UYn3i3vXC/vzYRbvpbVemswbRFtlz3acT4M
        JnsaBr2og==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g16lB-0007is-LP; Sat, 15 Sep 2018 09:21:01 +0000
Date:   Sat, 15 Sep 2018 02:21:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, akpm@linux-foundation.org,
        dave.hansen@intel.com, oleg@redhat.com, srikar@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v10 PATCH 1/3] mm: mmap: zap pages with read mmap_sem in
 munmap
Message-ID: <20180915092101.GA31572@bombadil.infradead.org>
References: <1536957299-43536-1-git-send-email-yang.shi@linux.alibaba.com>
 <1536957299-43536-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536957299-43536-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 04:34:57AM +0800, Yang Shi wrote:
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Suggested-by: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Matthew Wilcox <willy@infradead.org>

Looks good!  Thanks for sticking with this patch series.

Minor spelling fixes:

> -	/*
> -	 * Remove the vma's, and unmap the actual pages
> -	 */
> +	/* Detatch vmas from rbtree */

"Detach"

> +	/*
> +	 * mpx unmap need to be handled with write mmap_sem. It is safe to
> +	 * deal with it before unmap_region().
> +	 */

	 * mpx unmap needs to be called with mmap_sem held for write.
	 * It is safe to call it before unmap_region()

> +	ret = __do_munmap(mm, start, len, &uf, downgrade);
> +	/*
> +	 * Returning 1 indicates mmap_sem is down graded.
> +	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
> +	 * it to 0 before return.
> +	 */

"downgraded" is one word.

