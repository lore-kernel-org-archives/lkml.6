Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556BC208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556BC208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeJPLBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:01:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:40479 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeJPLBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:01:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9G3Ch6c006773;
        Mon, 15 Oct 2018 22:12:45 -0500
Message-ID: <c39ae9104a867c1ec3e9bbe2fb217d861b0bd482.camel@kernel.crashing.org>
Subject: Re: linux-next: Tree for Oct 15
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Date:   Tue, 16 Oct 2018 14:12:43 +1100
In-Reply-To: <20181016131927.6ceba6ab@canb.auug.org.au>
References: <20181015192546.15faf3a1@canb.auug.org.au>
         <20181015193914.GA9881@roeck-us.net>
         <20181016073359.3fa7bb32@canb.auug.org.au>
         <20181015222213.GA31415@roeck-us.net>
         <20181016130216.3a417381@canb.auug.org.au>
         <20181016131927.6ceba6ab@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 13:19 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 16 Oct 2018 13:02:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Reverting fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f (and the following 2
> > commits) produces a kernel that boots.
> 
> Instead of that, I applied this patch on top of linux-next and it boots
> and produces a stack trace ...
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 16 Oct 2018 13:07:01 +1100
> Subject: [PATCH] mm/memblock.c: use dump_stack() instead of WARN_ON_ONCE for
>  the alignment checks
> 
> Using WARN_ON_ONCE too early causes the PowerPC kernel to fail.

Interesting ... I thought I had fixed that. Might need to be re-fixed.

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  mm/memblock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5fefc70253ee..f2ef3915a356 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1298,8 +1298,10 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  {
>  	phys_addr_t found;
>  
> -	if (WARN_ON_ONCE(!align))
> +	if (!align) {
> +		dump_stack();
>  		align = SMP_CACHE_BYTES;
> +	}
>  
>  	found = memblock_find_in_range_node(size, align, start, end, nid,
>  					    flags);
> @@ -1423,8 +1425,10 @@ static void * __init memblock_alloc_internal(
>  	if (WARN_ON_ONCE(slab_is_available()))
>  		return kzalloc_node(size, GFP_NOWAIT, nid);
>  
> -	if (WARN_ON_ONCE(!align))
> +	if (!align) {
> +		dump_stack();
>  		align = SMP_CACHE_BYTES;
> +	}
>  
>  	if (max_addr > memblock.current_limit)
>  		max_addr = memblock.current_limit;
> -- 
> 2.18.0
> 
> So, patch "memblock: stop using implicit alignment to SMP_CACHE_BYTES"
> should *not* remove the 0 -> SMP_CACHE_BYTES update from mm/memblock.c
> and just add the dump_stack().

