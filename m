Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B86CC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321DC20883
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCkjLU+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321DC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeFTWRI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:17:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933460AbeFTWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZTh5juJ0Ylj+WUkpLsSn4PNTtkx8QCqCceOp2aTjH9Y=; b=rCkjLU+GTi/4Z+bLFPGVELIcL
        7328zKRE2Upv1Pn0yDLf5J2JHDg8u3IT4wp5l/aPpxXRFFS8MI4LSeC+1/YDLV+sSGgGFmgr0Fja9
        tAEEoOgAx1Y+INRONfE7H7l/B0LwZHcn0TkESQaNSpE0UngUV7uFmOd7EenTAFwe01ustE66h6lFJ
        yqc5AIlixtp+uU2pCx65pI9/oTmkJwSvL0rcxVoPPy1EWjj8zw7bV/7kzNLoF1U7JnOCuY7vmJgP1
        0U4QfmaF6O6pYxvx/Ubclo/OhMkqri2B0+GPynKsy1XRvldiNE+V/2birUYcm+E3aVi2t+BpPIXvY
        dMk/eWtqA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVlPI-0006FU-8V; Wed, 20 Jun 2018 22:16:52 +0000
Subject: Re: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Cc:     kristen.c.accardi@intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
 <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <12014310-19f7-dc31-d983-9c7e00c8b446@infradead.org>
Date:   Wed, 20 Jun 2018 15:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 03:09 PM, Rick Edgecombe wrote:
> Create __vmalloc_node_try_addr function that tries to allocate at a specific
> address.  The implementation relies on __vmalloc_node_range for the bulk of the
> work.  To keep this function from spamming the logs when an allocation failure
> is fails, __vmalloc_node_range is changed to only warn when __GFP_NOWARN is not
> set.  This behavior is consistent with this flags interpretation in
> alloc_vmap_area.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  include/linux/vmalloc.h |  3 +++
>  mm/vmalloc.c            | 41 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 398e9c9..6eaa896 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -82,6 +82,9 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  			unsigned long start, unsigned long end, gfp_t gfp_mask,
>  			pgprot_t prot, unsigned long vm_flags, int node,
>  			const void *caller);
> +extern void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
> +			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
> +			int node, const void *caller);
>  #ifndef CONFIG_MMU
>  extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
>  static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index cfea25b..9e0820c9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1710,6 +1710,42 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  }
>  
>  /**
> + *	__vmalloc_try_addr  -  try to alloc at a specific address

    *   __vmalloc_node_try_addr - try to allocate at a specific address

> + *	@addr:		address to try
> + *	@size:		size to try
> + *	@gfp_mask:	flags for the page level allocator
> + *	@prot:		protection mask for the allocated pages
> + *	@vm_flags:	additional vm area flags (e.g. %VM_NO_GUARD)
> + *	@node:		node to use for allocation or NUMA_NO_NODE
> + *	@caller:	caller's return address
> + *
> + *	Try to allocate at the specific address. If it succeeds the address is
> + *	returned. If it fails NULL is returned.  It may trigger TLB flushes.
> + */
> +void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
> +			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
> +			int node, const void *caller)
> +{

so this isn't optional, eh?  You are going to force it on people because?

thanks,
-- 
~Randy
