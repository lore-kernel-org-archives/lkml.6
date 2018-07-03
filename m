Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8AFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B782497F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KKzadTvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B782497F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934349AbeGCRmD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:42:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934004AbeGCRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OWrqDYToAGRgWr9JltUL88bPnMv2cFnQuwuUmkvNvP4=; b=KKzadTvKAgbIRbHrDNvZN/RxT
        Jvuk2z3Gv4Mhsmd/d5rq7BMOtVsVVT3FnhfjM/JsYwry85thZCqdq4zqJMd8tx3h1TbVMVwQ3Ty1Z
        sIOwGX3J7wcEE0gWvnQPXKkIhmyk71EtSNbH3ClB46DTx0PfPnEldU81KFxRHYlQbdAurnis2FU5c
        Rzo0UbubPKmHV5yt3MC+B7In6jFdjsJsXxQG2OpUXNHp0GI5jVswWCjRp6N5fqcsWvl4ncXf4pgKa
        9gDkm+hoFWf+UVly2pQ3tl0u0qASfbfEUwOWklVrJcODsekQDgLaFriQ8uSUgVX6oPdDRwNaMt77R
        YoFfTwfQg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faPJQ-0005u0-T6; Tue, 03 Jul 2018 17:42:00 +0000
Date:   Tue, 3 Jul 2018 10:42:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     eric@anholt.net, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, svptas.linux@gmail.com,
        ajitn.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] gpu: drm: v3d: use new return type vm_fault_t
Message-ID: <20180703174200.GA4834@bombadil.infradead.org>
References: <20180703161043.GA26927@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703161043.GA26927@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:40:43PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> see commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> for reference.
> 
> Previously vm_insert_mixed returns err which driver
> mapped into VM_FAULT_* type. The new function
> vmf_insert_mixed will replace this inefficiency by
> returning VM_FAULT_* type.

I really think this changelog could do with more work.  Specifically for
this patch, I'd just say:

Convert v3d_gem_fault to return vm_fault_t

Instead of converting an errno into a vm_fault_t ourselves, use
vmf_insert_mixed() which returns a vm_fault_t directly.

>  	unsigned long pfn;
>  	pgoff_t pgoff;
> -	int ret;
>  
>  	/* We don't use vmf->pgoff since that has the fake offset: */
>  	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
>  	pfn = page_to_pfn(bo->pages[pgoff]);
>  
> -	ret = vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
> -
> -	switch (ret) {
> -	case -EAGAIN:
> -	case 0:
> -	case -ERESTARTSYS:
> -	case -EINTR:
> -	case -EBUSY:
> -		/*
> -		 * EBUSY is ok: this just means that another thread
> -		 * already did the job.
> -		 */
> -		return VM_FAULT_NOPAGE;
> -	case -ENOMEM:
> -		return VM_FAULT_OOM;
> -	default:
> -		return VM_FAULT_SIGBUS;
> -	}
> +	return vmf_insert_mixed(vma, vmf->address,
> +		__pfn_to_pfn_t(pfn, PFN_DEV));
>  }

The line-split here is kind of ugly.  I'd do a little more extensive surgery:

-	unsigned long pfn;
+	pfn_t pfn;

- 	pfn = page_to_pfn(bo->pages[pgoff]);
+	pfn = __pfn_to_pfn_t(page_to_pfn(bo->pages[pgoff]), PFN_DEV);

+	return vmf_insert_mixed(vma, vmf->address, pfn);
