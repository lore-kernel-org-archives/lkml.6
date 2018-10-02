Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35A42083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35A42083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeJBMih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:38:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:57458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbeJBMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:38:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64747ACF8;
        Tue,  2 Oct 2018 05:57:07 +0000 (UTC)
Date:   Tue, 2 Oct 2018 07:57:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     jun qian <hangdianqj@163.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Barry song <21cnbao@gmail.com>
Subject: Re: [PATCH] mm:slab: Adjust the print format for the slabinfo
Message-ID: <20181002055704.GM18290@dhcp22.suse.cz>
References: <20181002025939.115804-1-hangdianqj@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002025939.115804-1-hangdianqj@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-10-18 19:59:39, jun qian wrote:
> Header and the corresponding information is not aligned,
> adjust the printing format helps us to understand the slabinfo better.

What prevents you from formating the output when printint the file? In
other words why do we want to do special formating in the kernel?
 
> Signed-off-by: jun qian <hangdianqj@163.com>
> Cc: Barry song <21cnbao@gmail.com>
> ---
>  mm/slab_common.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index fea3376f9816..07a324cbbfb6 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1263,9 +1263,13 @@ static void print_slabinfo_header(struct seq_file *m)
>  #else
>  	seq_puts(m, "slabinfo - version: 2.1\n");
>  #endif
> -	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
> -	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
> -	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
> +	seq_printf(m, "%-22s %-14s %-11s %-10s %-13s %-14s",
> +		  "# name", "<active_objs>", "<num_objs>", "<objsize>",
> +		  "<objperslab>", "<pagesperslab>");
> +	seq_printf(m, " : %-9s %-8s %-13s %-14s",
> +		  "tunables", "<limit>", "<batchcount>", "<sharedfactor>");
> +	seq_printf(m, " : %-9s %-15s %-12s %-16s",
> +		  "slabdata", "<active_slabs>", "<num_slabs>", "<sharedavail>");
>  #ifdef CONFIG_DEBUG_SLAB
>  	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
>  	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
> @@ -1319,13 +1323,13 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
>  
>  	memcg_accumulate_slabinfo(s, &sinfo);
>  
> -	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
> +	seq_printf(m, "%-22s %-14lu %-11lu %-10u %-13u %-14d",
>  		   cache_name(s), sinfo.active_objs, sinfo.num_objs, s->size,
>  		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
>  
> -	seq_printf(m, " : tunables %4u %4u %4u",
> +	seq_printf(m, " : %-9s %-8u %-13u %-14u", "tunables",
>  		   sinfo.limit, sinfo.batchcount, sinfo.shared);
> -	seq_printf(m, " : slabdata %6lu %6lu %6lu",
> +	seq_printf(m, " : %-9s %-15lu %-12lu %-16lu", "slabdata",
>  		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
>  	slabinfo_show_stats(m, s);
>  	seq_putc(m, '\n');
> -- 
> 2.17.1
> 
> 

-- 
Michal Hocko
SUSE Labs
