Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85B9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7272320652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCXxpQ5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7272320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbeFTW1A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:27:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933755AbeFTW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p55QclUKo10CQ35MbXYPMCkdd/Esy3Q1pJIRiv8FQNQ=; b=MCXxpQ5Qlps/XFl6stZase3QV
        1+ulC0tXeVbMMHg8pBKV1RyfA/37AOXA57Q7I9eeFa62QyL8adyZgA1iUKpvFH+NdtkIx4f0CD6JN
        eDpF+k0jAEY6mqHhgii0VXPKRTfvexW4ii2+zjG8+y+uT97Cl/RQ14HJtOvUgYPG+cVm//fqceEZT
        4P4w/3VUdKr80sQwiUs36FkeOA4v3OwrhVmHKEaMjOrU1PtpkYLXFyopKlqpse/e3xXFFYujLH3jG
        tG1UxsmuYmg4vLRMykdOx+2C0tebVufYSC9oWyyKhdAxsgcmmGGmqbdmZ05324Bcc/kbpfez+BqTm
        hEh+BrR4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVlYz-0001wr-Tu; Wed, 20 Jun 2018 22:26:53 +0000
Date:   Wed, 20 Jun 2018 15:26:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, kristen.c.accardi@intel.com,
        dave.hansen@intel.com, arjan.van.de.ven@intel.com
Subject: Re: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
Message-ID: <20180620222653.GC11479@bombadil.infradead.org>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
 <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 03:09:28PM -0700, Rick Edgecombe wrote:
>  
>  /**
> + *	__vmalloc_try_addr  -  try to alloc at a specific address
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

 * Try to allocate memory at a specific address.  May trigger TLB flushes.
 *
 * Context: Process context.
 * Return: The allocated address if it succeeds.  NULL if it fails.

> @@ -1759,8 +1795,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	return addr;
>  
>  fail:
> -	warn_alloc(gfp_mask, NULL,
> -			  "vmalloc: allocation failure: %lu bytes", real_size);
> +	if (!(gfp_mask & __GFP_NOWARN))
> +		warn_alloc(gfp_mask, NULL,
> +			"vmalloc: allocation failure: %lu bytes", real_size);
>  	return NULL;

Not needed:

void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
{
...
        if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
                return;

