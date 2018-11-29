Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC8B2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x1Fs4Kl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC8B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeK2X5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbeK2X5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:57:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E31C2081B;
        Thu, 29 Nov 2018 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543495950;
        bh=pTVyMW9MrPqEeTVDA2O58XcFU6dvc5oBhc7sxWjIq0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1Fs4Kl8AaUI0QD+oM6dwNP2U95tTI6s261ejCW2d02+6D8H/suO23x1LRkr70DGP
         VylsMkN0Dy4mDHHv+KNpNF0ydCmjuv+ku6Cs3Zv+qn+YtyT+BxofjSrOIKaSlA3TfL
         N2VeoZEqAnlYxzGQScG8rdX4z5Ki+NZk2N630gTI=
Date:   Thu, 29 Nov 2018 13:52:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: hide incomplete nr_indirectly_reclaimable in
 /proc/zoneinfo
Message-ID: <20181129125228.GN3149@kroah.com>
References: <20181030174649.16778-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030174649.16778-1-guro@fb.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 05:48:25PM +0000, Roman Gushchin wrote:
> Yongqin reported that /proc/zoneinfo format is broken in 4.14
> due to commit 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable
> in /proc/vmstat")
> 
> Node 0, zone      DMA
>   per-node stats
>       nr_inactive_anon 403
>       nr_active_anon 89123
>       nr_inactive_file 128887
>       nr_active_file 47377
>       nr_unevictable 2053
>       nr_slab_reclaimable 7510
>       nr_slab_unreclaimable 10775
>       nr_isolated_anon 0
>       nr_isolated_file 0
>       <...>
>       nr_vmscan_write 0
>       nr_vmscan_immediate_reclaim 0
>       nr_dirtied   6022
>       nr_written   5985
>                    74240
>       ^^^^^^^^^^
>   pages free     131656
> 
> The problem is caused by the nr_indirectly_reclaimable counter,
> which is hidden from the /proc/vmstat, but not from the
> /proc/zoneinfo. Let's fix this inconsistency and hide the
> counter from /proc/zoneinfo exactly as from /proc/vmstat.
> 
> BTW, in 4.19+ the counter has been renamed and exported by
> the commit b29940c1abd7 ("mm: rename and change semantics of
> nr_indirectly_reclaimable_bytes"), so there is no such a problem
> anymore.
> 
> Cc: <stable@vger.kernel.org> # 4.14.x-4.18.x
> Fixes: 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
> Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmstat.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 527ae727d547..6389e876c7a7 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1500,6 +1500,10 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>  	if (is_zone_first_populated(pgdat, zone)) {
>  		seq_printf(m, "\n  per-node stats");
>  		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> +			/* Skip hidden vmstat items. */
> +			if (*vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
> +					 NR_VM_NUMA_STAT_ITEMS] == '\0')
> +				continue;
>  			seq_printf(m, "\n      %-12s %lu",
>  				vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
>  				NR_VM_NUMA_STAT_ITEMS],
> -- 
> 2.17.2
> 

I do not see this patch in Linus's tree, do you?

If not, what am I supposed to do with this?

confused,

greg k-h
