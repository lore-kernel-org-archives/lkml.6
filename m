Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9204ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484BE2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZzMbauLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484BE2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeIVUQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:16:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbeIVUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DHPyk/4n2wsdQMMLyVKEE2E4KR8yao6/DW/SfCOvR78=; b=ZzMbauLBIe+XWR004by4cNrGh
        BcrjrNUDn2WKUiTQJdbfiskroTGzFk3Wqt++f4GSS/0uQ24fF50Vt+GsSCbBAcq1t3mU0jPisawJd
        Umsn96cXnjAYm7WeXuC8Vw8VbqOXZuNXv1leTLBheNxteFUqkKnHwsb8fdH/Rj+tBLzASOdniuxzV
        Gh5a7S7Y73B0IkIm2sZhdjUOnjaqZATjtTWKKDhT/eNeg3XTQbXkkWB2aDsb4iR6yp7FJtNF90L0w
        bsrl3Z8ihqHkRqeQXdpkuEYdeGPfBfiL4UJwL+NesvYQyIKZFt5gF9+cyQhV1qt2uGKgP9JxzkOpE
        hoaGbRa6Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3iny-0004FE-6S; Sat, 22 Sep 2018 14:22:42 +0000
Date:   Sat, 22 Sep 2018 07:22:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, mark.rutland@arm.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, tchibo@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/kcov: Replace vm_insert_page with vmf_insert_page
Message-ID: <20180922142241.GD14042@bombadil.infradead.org>
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:42:54AM +0530, Souptick Joarder wrote:
>  		for (off = 0; off < size; off += PAGE_SIZE) {
>  			page = vmalloc_to_page(kcov->area + off);
> -			if (vm_insert_page(vma, vma->vm_start + off, page))
> -				WARN_ONCE(1, "vm_insert_page() failed");
> +			if (vmf_insert_page(vma, vma->vm_start + off, page)
> +					!= VM_FAULT_NOPAGE)
> +				WARN_ONCE(1, "vmf_insert_page() failed");
>  		}

I think this is the wrong approach (as well as being buggy).

We should have a vmalloc_insert_range() _or something similar_ that
replaces this entire loop.  That makes each _user_ simpler.  What you're
trying to do right now makes each user more complex, and that's the
wrong approach.
