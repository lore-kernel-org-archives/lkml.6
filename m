Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B662C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D67320834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D67320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLCQLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:11:16 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:43725 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCQLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:11:16 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5A86C804EA;
        Mon,  3 Dec 2018 17:10:54 +0100 (CET)
Date:   Mon, 3 Dec 2018 17:10:52 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 3/6] sh: prefer memblock APIs returning virtual address
Message-ID: <20181203161052.GA4244@ravnborg.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=VnNF1IyMAAAA:8 a=FTNaidAvUsMVHdn4hVIA:9
        a=9GetFJ8xNGreKwwT:21 a=sKQTW2iCjVXyVLe6:21 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike.

On Mon, Dec 03, 2018 at 05:47:12PM +0200, Mike Rapoport wrote:
> Rather than use the memblock_alloc_base that returns a physical address and
> then convert this address to the virtual one, use appropriate memblock
> function that returns a virtual address.
> 
> There is a small functional change in the allocation of then NODE_DATA().
> Instead of panicing if the local allocation failed, the non-local
> allocation attempt will be made.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/sh/mm/init.c | 18 +++++-------------
>  arch/sh/mm/numa.c |  5 ++---
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index c8c13c77..3576b5f 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
>  void __init allocate_pgdat(unsigned int nid)
>  {
>  	unsigned long start_pfn, end_pfn;
> -#ifdef CONFIG_NEED_MULTIPLE_NODES
> -	unsigned long phys;
> -#endif
>  
>  	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
>  
>  #ifdef CONFIG_NEED_MULTIPLE_NODES
> -	phys = __memblock_alloc_base(sizeof(struct pglist_data),
> -				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
> -	/* Retry with all of system memory */
> -	if (!phys)
> -		phys = __memblock_alloc_base(sizeof(struct pglist_data),
> -					SMP_CACHE_BYTES, memblock_end_of_DRAM());
> -	if (!phys)
> +	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
> +				sizeof(struct pglist_data),
> +				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> +				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +	if (!NODE_DATA(nid))
>  		panic("Can't allocate pgdat for node %d\n", nid);
> -
> -	NODE_DATA(nid) = __va(phys);
> -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
The new code will always assign NODE_DATA(nid), where the old
code only assigned NODE_DATA(nid) in the good case.
I dunno if this is an issue, just noticed the difference and
wanted to point it out.

	Sam
