Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3A7C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08FB20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08FB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeFUBxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:53:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754626AbeFUBxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:53:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47788401EF17;
        Thu, 21 Jun 2018 01:53:12 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D376E2A0C;
        Thu, 21 Jun 2018 01:53:09 +0000 (UTC)
Date:   Thu, 21 Jun 2018 09:53:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        iommu@lists.linux-foundation.org, dyoung@redhat.com,
        kexec@lists.infradead.org
Subject: Re: [PATCH 2/4 V3] Allocate pages for kdump without encryption when
 SME is enabled
Message-ID: <20180621015306.GG29979@MiWiFi-R3L-srv>
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616082714.32035-3-lijiang@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 01:53:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 01:53:12 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/18 at 04:27pm, Lianbo Jiang wrote:
> When SME is enabled in the first kernel, we will allocate pages
> for kdump without encryption in order to be able to boot the
> second kernel in the same manner as kexec, which helps to keep
> the same code style.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  kernel/kexec_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 20fef1a..3c22a9b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  		}
>  	}
>  
> +	if (pages) {
> +		unsigned int count, i;
> +
> +		pages->mapping = NULL;
> +		set_page_private(pages, order);
> +		count = 1 << order;
> +		for (i = 0; i < count; i++)
> +			SetPageReserved(pages + i);

I guess you might imitate the kexec case, however kexec get pages from
buddy. Crash pages are reserved in memblock, these codes might make no sense.

> +		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
> +	}
>  	return pages;
>  }
>  
> @@ -865,6 +875,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result  = -ENOMEM;
>  			goto out;
>  		}
> +		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
>  		ptr = kmap(page);
>  		ptr += maddr & ~PAGE_MASK;
>  		mchunk = min_t(size_t, mbytes,
> @@ -882,6 +893,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result = copy_from_user(ptr, buf, uchunk);
>  		kexec_flush_icache_page(page);
>  		kunmap(page);
> +		arch_kexec_pre_free_pages(page_address(page), 1);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
