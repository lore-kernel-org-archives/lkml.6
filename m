Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeBNFIu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 00:08:50 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39259 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeBNFIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 00:08:48 -0500
X-Google-Smtp-Source: AH8x2255fLHwwWmvoxDCHD6ZTtAjEtqYrnE+DyeMjPzki3MxWGYpLOEfggJSy4munf9DTjDVJDvZZA==
Date: Wed, 14 Feb 2018 14:08:43 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        gi-oh.kim@profitbricks.com, heiko.carstens@de.ibm.com,
        baiyaowei@cmss.chinamobile.com, richard.weiyang@gmail.com,
        paul.burton@mips.com, miles.chen@mediatek.com, vbabka@suse.cz,
        mgorman@suse.de, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 1/1] mm: initialize pages on demand during boot
Message-ID: <20180214050843.GA2811@jagdpanzerIV>
References: <20180209192216.20509-1-pasha.tatashin@oracle.com>
 <20180209192216.20509-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209192216.20509-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/09/18 14:22), Pavel Tatashin wrote:
[..]
> +/*
> + * If this zone has deferred pages, try to grow it by initializing enough
> + * deferred pages to satisfy the allocation specified by order, rounded up to
> + * the nearest PAGES_PER_SECTION boundary.  So we're adding memory in increments
> + * of SECTION_SIZE bytes by initializing struct pages in increments of
> + * PAGES_PER_SECTION * sizeof(struct page) bytes.
> + *
> + * Return true when zone was grown by at least number of pages specified by
> + * order. Otherwise return false.
> + *
> + * Note: We use noinline because this function is needed only during boot, and
> + * it is called from a __ref function _deferred_grow_zone. This way we are
> + * making sure that it is not inlined into permanent text section.
> + */
> +static noinline bool __init
> +deferred_grow_zone(struct zone *zone, unsigned int order)
> +{
> +	int zid = zone_idx(zone);
> +	int nid = zone->node;

		^^^^^^^^^

Should be CONFIG_NUMA dependent

struct zone {
...
#ifdef CONFIG_NUMA
	int node;
#endif
...

	-ss
