Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826292082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TGaZIyPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826292082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeKCVNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:13:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeKCVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FAIughlOQizMpvej/ZzsYD/nFYLsY/S76qLuWAAD+bM=; b=TGaZIyPuHj4akRnZ/w/EydHyl
        bP2/qBOrMI65s0zZkl/fifyWNFyFU33FmMGTSXxKIO4Cysdfyswsu54Rrw3HxhyPCbSNQCmxkGt0f
        WlFUnaxq4cE8ryi7fLXxhGudtzEqIR0f9jm03v24LudqA+hrsydiTwHPRcqAhh3JASHG1+VFbPVr4
        ZYxRBzTsL9KHM4dn3lhAGnpQhAkgf9shJcolcILS1TBIWIvNZiTQ/q+QoqyiLXLmVgmXElqhqiSA7
        1VgTMCDD+8MXLztDgVeTuY70WH86o5dHnS5yNEI9jehos+HNoLwYjNH9fwE2Mpjvz4S3OyNrN5NDO
        QiO8jOafw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIudQ-0001Cz-5P; Sat, 03 Nov 2018 12:02:36 +0000
Date:   Sat, 3 Nov 2018 05:02:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        pasha.tatashin@oracle.com, vbabka@suse.cz, riel@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Create the new vm_fault_t type
Message-ID: <20181103120235.GA10491@bombadil.infradead.org>
References: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 10:35:04AM +0530, Souptick Joarder wrote:
> Page fault handlers are supposed to return VM_FAULT codes,
> but some drivers/file systems mistakenly return error
> numbers. Now that all drivers/file systems have been converted
> to use the vm_fault_t return type, change the type definition
> to no longer be compatible with 'int'. By making it an unsigned
> int, the function prototype becomes incompatible with a function
> which returns int. Sparse will detect any attempts to return a
> value which is not a VM_FAULT code.


> -/* Encode hstate index for a hwpoisoned large page */
> -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
...
> +/* Encode hstate index for a hwpoisoned large page */
> +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)

I think it's important to mention in the changelog that these values
have been changed to avoid conflicts with other VM_FAULT codes.

> +/**
> + * typedef vm_fault_t -  __bitwise unsigned int
> + *
> + * vm_fault_t is the new unsigned int type to return VM_FAULT
> + * code by page fault handlers of drivers/file systems. Now if
> + * any page fault handlers returns non VM_FAULT code instead
> + * of VM_FAULT code, it will be a mismatch with function
> + * prototype and sparse will detect it.
> + */

The first line should be what the typedef *means*, not repeat the
compiler's definition.  The rest of the description should be information
for someone coming to the type for the first time; what you've written
here is changelog material.

/**
 * typedef vm_fault_t - Return type for page fault handlers.
 *
 * Page fault handlers return a bitmask of %VM_FAULT values.
 */

> +typedef __bitwise unsigned int vm_fault_t;
> +
> +/**
> + * enum - VM_FAULT code

Can you document an anonymous enum?  I've never tried.  Did you run this
through 'make htmldocs'?

> + * This enum is used to track the VM_FAULT code return by page
> + * fault handlers.

 * Page fault handlers return a bitmask of these values to tell the
 * core VM what happened when handling the fault.

