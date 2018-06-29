Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C7AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80271271EB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80271271EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966056AbeF2Iqc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:46:32 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46036 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965835AbeF2Iqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:46:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07976004|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.CJyPqfE_1530261976;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CJyPqfE_1530261976)
          by smtp.aliyun-inc.com(10.147.41.187);
          Fri, 29 Jun 2018 16:46:22 +0800
Date:   Fri, 29 Jun 2018 16:46:16 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nds32: To implement these icache invalidation APIs
 since nds32 cores don't snoop data cache. This issue is found by Guo Ren.
 Based on the Documentation/core-api/cachetlb.rst and it says:
Message-ID: <20180629084615.GA6236@guoren>
References: <20180628104927.9130-1-greentime@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628104927.9130-1-greentime@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 06:49:27PM +0800, Greentime Hu wrote:
> +void flush_icache_page(struct vm_area_struct *vma, struct page *page)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	cpu_cache_wbinval_page((unsigned long)page_address(page),
> +			       vma->vm_flags & VM_EXEC);
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(flush_icache_page);
> +
I'm afraid that the page_address(page) will return NULL for non-mapped page.

So I use kmap_atomic/kunmap_atomic here.

ref: https://github.com/c-sky/csky-linux/blob/master/arch/csky/abiv2/cacheflush.c

> +void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
> +	                     unsigned long addr, int len)
> +{
> +	unsigned long _addr = (unsigned long) page_address(page) + (addr & ~PAGE_MASK);
> +	flush_icache_range(_addr, _addr + len);
> +}

The same as above.

 Guo Ren
