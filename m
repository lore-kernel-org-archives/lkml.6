Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F241CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BAA21479
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BAA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeJFFUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:20:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJFFUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:20:21 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A51BD22;
        Fri,  5 Oct 2018 22:19:35 +0000 (UTC)
Date:   Fri, 5 Oct 2018 15:19:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
Message-Id: <20181005151934.87226fa92825c3002a475413@linux-foundation.org>
In-Reply-To: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 00:07:04 +0300 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> When a memblock allocation APIs are called with align = 0, the alignment is
> implicitly set to SMP_CACHE_BYTES.
> 
> Replace all such uses of memblock APIs with the 'align' parameter explicitly
> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> memblock internal allocation functions.
> 
> For the case when memblock APIs are used via helper functions, e.g. like
> iommu_arena_new_node() in Alpha, the helper functions were detected with
> Coccinelle's help and then manually examined and updated where appropriate.
> 
> ...
>
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1298,9 +1298,6 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  {
>  	phys_addr_t found;
>  
> -	if (!align)
> -		align = SMP_CACHE_BYTES;
> -

Can we add a WARN_ON_ONCE(!align) here?  To catch unconverted code
which sneaks in later on.

