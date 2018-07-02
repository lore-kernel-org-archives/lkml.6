Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E101BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F43214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F43214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGBBeN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:34:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752843AbeGBBeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D42A81A4EA7;
        Mon,  2 Jul 2018 01:34:07 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F667C39;
        Mon,  2 Jul 2018 01:34:06 +0000 (UTC)
Date:   Mon, 2 Jul 2018 09:34:02 +0800
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
Subject: Re: [PATCH v2 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
Message-ID: <20180702013402.GI3223@MiWiFi-R3L-srv>
References: <20180630030944.9335-1-pasha.tatashin@oracle.com>
 <20180630030944.9335-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630030944.9335-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 01:34:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 01:34:07 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 06/29/18 at 11:09pm, Pavel Tatashin wrote:
> Change sprase_init() to only find the pnum ranges that belong to a specific
> node and call sprase_init_nid() for that range from sparse_init().
> 
> Delete all the code that became obsolete with this change.

> @@ -617,87 +491,24 @@ void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>   */
>  void __init sparse_init(void)
>  {
> -	unsigned long pnum;
> -	struct page *map;
> -	struct page **map_map;
> -	unsigned long *usemap;
> -	unsigned long **usemap_map;
> -	int size, size2;
> -	int nr_consumed_maps = 0;
> -
> -	/* see include/linux/mmzone.h 'struct mem_section' definition */
> -	BUILD_BUG_ON(!is_power_of_2(sizeof(struct mem_section)));
> +	unsigned long pnum_begin = first_present_section_nr();
> +	int nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
> +	unsigned long pnum_end, map_count = 1;
>  
> -	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
> -	set_pageblock_order();

Not very sure if removing set_pageblock_order() calling here is OK. What
if CONFIG_HUGETLB_PAGE_SIZE_VARIABLE is enabled? usemap_size() depends
on value of 'pageblock_order'.

Thanks
Baoquan

> +	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
> +		int nid = sparse_early_nid(__nr_to_section(pnum_end));
>  
> -	/*
> -	 * map is using big page (aka 2M in x86 64 bit)
> -	 * usemap is less one page (aka 24 bytes)
> -	 * so alloc 2M (with 2M align) and 24 bytes in turn will
> -	 * make next 2M slip to one more 2M later.
> -	 * then in big system, the memory will have a lot of holes...
> -	 * here try to allocate 2M pages continuously.
> -	 *
> -	 * powerpc need to call sparse_init_one_section right after each
> -	 * sparse_early_mem_map_alloc, so allocate usemap_map at first.
> -	 */
> -	size = sizeof(unsigned long *) * nr_present_sections;
> -	usemap_map = memblock_virt_alloc(size, 0);
> -	if (!usemap_map)
> -		panic("can not allocate usemap_map\n");
> -	alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,
> -				(void *)usemap_map,
> -				sizeof(usemap_map[0]));
> -
> -	size2 = sizeof(struct page *) * nr_present_sections;
> -	map_map = memblock_virt_alloc(size2, 0);
> -	if (!map_map)
> -		panic("can not allocate map_map\n");
> -	alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
> -				(void *)map_map,
> -				sizeof(map_map[0]));
> -
> -	/* The numner of present sections stored in nr_present_sections
> -	 * are kept the same since mem sections are marked as present in
> -	 * memory_present(). In this for loop, we need check which sections
> -	 * failed to allocate memmap or usemap, then clear its
> -	 * ->section_mem_map accordingly. During this process, we need
> -	 * increase 'nr_consumed_maps' whether its allocation of memmap
> -	 * or usemap failed or not, so that after we handle the i-th
> -	 * memory section, can get memmap and usemap of (i+1)-th section
> -	 * correctly. */
> -	for_each_present_section_nr(0, pnum) {
> -		struct mem_section *ms;
> -
> -		if (nr_consumed_maps >= nr_present_sections) {
> -			pr_err("nr_consumed_maps goes beyond nr_present_sections\n");
> -			break;
> -		}
> -		ms = __nr_to_section(pnum);
> -		usemap = usemap_map[nr_consumed_maps];
> -		if (!usemap) {
> -			ms->section_mem_map = 0;
> -			nr_consumed_maps++;
> -			continue;
> -		}
> -
> -		map = map_map[nr_consumed_maps];
> -		if (!map) {
> -			ms->section_mem_map = 0;
> -			nr_consumed_maps++;
> +		if (nid == nid_begin) {
> +			map_count++;
>  			continue;
>  		}
> -
> -		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
> -								usemap);
> -		nr_consumed_maps++;
> +		sparse_init_nid(nid, pnum_begin, pnum_end, map_count);
> +		nid_begin = nid;
> +		pnum_begin = pnum_end;
> +		map_count = 1;
>  	}
> -
> +	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
>  	vmemmap_populate_print_last();
> -
> -	memblock_free_early(__pa(map_map), size2);
> -	memblock_free_early(__pa(usemap_map), size);
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -- 
> 2.18.0
> 
