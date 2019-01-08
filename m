Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA7AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6073E2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfAHJBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:01:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbfAHJBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:01:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14410C07D8C5;
        Tue,  8 Jan 2019 09:01:50 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDDCC60E3F;
        Tue,  8 Jan 2019 09:01:40 +0000 (UTC)
Date:   Tue, 8 Jan 2019 17:01:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190108090138.GB18718@MiWiFi-R3L-srv>
References: <1546848299-23628-1-git-send-email-kernelfans@gmail.com>
 <20190108080538.GB4396@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108080538.GB4396@rapoport-lnx>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 08 Jan 2019 09:01:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 01/08/19 at 10:05am, Mike Rapoport wrote:
> I'm not thrilled by duplicating this code (yet again).
> I liked the v3 of this patch [1] more, assuming we allow bottom-up mode to
> allocate [0, kernel_start) unconditionally. 
> I'd just replace you first patch in v3 [2] with something like:

In initmem_init(), we will restore the top-down allocation style anyway.
While reserve_crashkernel() is called after initmem_init(), it's not
appropriate to adjust memblock_find_in_range_node(), and we really want
to find region bottom up for crashkernel reservation, no matter where
kernel is loaded, better call __memblock_find_range_bottom_up().

Create a wrapper to do the necessary handling, then call
__memblock_find_range_bottom_up() directly, looks better.

Thanks
Baoquan

> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7df468c..d1b30b9 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -274,24 +274,14 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>  	 * try bottom-up allocation only when bottom-up mode
>  	 * is set and @end is above the kernel image.
>  	 */
> -	if (memblock_bottom_up() && end > kernel_end) {
> -		phys_addr_t bottom_up_start;
> -
> -		/* make sure we will allocate above the kernel */
> -		bottom_up_start = max(start, kernel_end);
> -
> +	if (memblock_bottom_up()) {
>  		/* ok, try bottom-up allocation first */
> -		ret = __memblock_find_range_bottom_up(bottom_up_start, end,
> +		ret = __memblock_find_range_bottom_up(start, end,
>  						      size, align, nid, flags);
>  		if (ret)
>  			return ret;
>  
>  		/*
> -		 * we always limit bottom-up allocation above the kernel,
> -		 * but top-down allocation doesn't have the limit, so
> -		 * retrying top-down allocation may succeed when bottom-up
> -		 * allocation failed.
> -		 *
>  		 * bottom-up allocation is expected to be fail very rarely,
>  		 * so we use WARN_ONCE() here to see the stack trace if
>  		 * fail happens.
> 
> [1] https://lore.kernel.org/lkml/1545966002-3075-3-git-send-email-kernelfans@gmail.com/
> [2] https://lore.kernel.org/lkml/1545966002-3075-2-git-send-email-kernelfans@gmail.com/
> 
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * __memblock_find_range_top_down - find free area utility, in top-down
> >   * @start: start of candidate range
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
