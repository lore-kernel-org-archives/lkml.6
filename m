Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC45C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FED256F7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FED256F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeGBCL2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:11:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932328AbeGBCL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:11:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 733A583207;
        Mon,  2 Jul 2018 02:11:26 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F13C111DCEE;
        Mon,  2 Jul 2018 02:11:25 +0000 (UTC)
Date:   Mon, 2 Jul 2018 10:11:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Subject: Re: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
Message-ID: <20180702021121.GL3223@MiWiFi-R3L-srv>
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702020417.21281-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 02:11:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 02:11:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for your quick fix. You might have missed another comment to v2
patch 1/2 which is at the bottom.

On 07/01/18 at 10:04pm, Pavel Tatashin wrote:
> +/*
> + * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
> + * And number of present sections in this node is map_count.
> + */
> +void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> +				   unsigned long pnum_end,
> +				   unsigned long map_count)
> +{
> +	unsigned long pnum, usemap_longs, *usemap, map_index;
> +	struct page *map, *map_base;
> +
> +	usemap_longs = BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS);
> +	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nid),
> +							  usemap_size() *
> +							  map_count);
> +	if (!usemap) {
> +		pr_err("%s: usemap allocation failed", __func__);
> +		goto failed;
> +	}
> +	map_base = sparse_populate_node(pnum_begin, pnum_end,
> +					map_count, nid);
> +	map_index = 0;
> +	for_each_present_section_nr(pnum_begin, pnum) {
> +		if (pnum >= pnum_end)
> +			break;
> +
> +		BUG_ON(map_index == map_count);
> +		map = sparse_populate_node_section(map_base, map_index,
> +						   pnum, nid);
> +		if (!map) {

Here, I think it might be not right to jump to 'failed' directly if one
section of the node failed to populate memmap. I think the original code
is only skipping the section which memmap failed to populate by marking
it as not present with "ms->section_mem_map = 0".

> +			pr_err("%s: memory map backing failed. Some memory will not be available.",
> +			       __func__);
> +			pnum_begin = pnum;
> +			goto failed;
> +		}
> +		check_usemap_section_nr(nid, usemap);
> +		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
> +					usemap);
> +		map_index++;
> +		usemap += usemap_longs;
> +	}
> +	return;
> +failed:
> +	/* We failed to allocate, mark all the following pnums as not present */
> +	for_each_present_section_nr(pnum_begin, pnum) {
> +		struct mem_section *ms;
> +
> +		if (pnum >= pnum_end)
> +			break;
> +		ms = __nr_to_section(pnum);
> +		ms->section_mem_map = 0;
> +	}
> +}
> +
>  /*
>   * Allocate the accumulated non-linear sections, allocate a mem_map
>   * for each and record the physical to section mapping.
> -- 
> 2.18.0
> 
