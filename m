Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AA6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97902223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97902223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHKBJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:09:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeHKBJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:09:19 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9AAF4941;
        Fri, 10 Aug 2018 22:37:28 +0000 (UTC)
Date:   Fri, 10 Aug 2018 15:37:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     osalvador@techadventures.net
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 3/3] mm/memory_hotplug: Cleanup
 unregister_mem_sect_under_nodes
Message-Id: <20180810153727.c9ae4aab518f1b84e04c999a@linux-foundation.org>
In-Reply-To: <20180810152931.23004-4-osalvador@techadventures.net>
References: <20180810152931.23004-1-osalvador@techadventures.net>
        <20180810152931.23004-4-osalvador@techadventures.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 17:29:31 +0200 osalvador@techadventures.net wrote:

> From: Oscar Salvador <osalvador@suse.de>
> 
> With the assumption that the relationship between
> memory_block <-> node is 1:1, we can refactor this function a bit.
> 
> This assumption is being taken from register_mem_sect_under_node()
> code.
> 
> register_mem_sect_under_node() takes the mem_blk's nid, and compares it
> to the pfn's nid we are checking.
> If they match, we go ahead and link both objects.
> Once done, we just return.
> 
> So, the relationship between memory_block <-> node seems to stand.
> 
> Currently, unregister_mem_sect_under_nodes() defines a nodemask_t
> which is being checked in the loop to see if we have already unliked certain node.

"unlinked a certain node"

> But since a memory_block can only belong to a node, we can drop the nodemask

"to a single node"?

> and the check within the loop.
> 
> If we find a match between the mem_block->nid and the nid of the
> pfn we are checking, we unlink the objects and return, as unlink the objects

"unlinking"

> once is enough.
> 
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -448,35 +448,27 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
>  	return 0;
>  }
>  
> -/* unregister memory section under all nodes that it spans */
> +/* unregister memory section from the node it belongs to */
>  int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  				    unsigned long phys_index)
>  {
> -	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
>  	unsigned long pfn, sect_start_pfn, sect_end_pfn;
> -
> -	if (!unlinked_nodes)
> -		return -ENOMEM;
> -	nodes_clear(*unlinked_nodes);
> +	int nid = mem_blk->nid;
>  
>  	sect_start_pfn = section_nr_to_pfn(phys_index);
>  	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
> -		int nid;
> +		int page_nid = get_nid_for_pfn(pfn);
>  
> -		nid = get_nid_for_pfn(pfn);
> -		if (nid < 0)
> -			continue;
> -		if (!node_online(nid))
> -			continue;
> -		if (node_test_and_set(nid, *unlinked_nodes))
> -			continue;
> -		sysfs_remove_link(&node_devices[nid]->dev.kobj,
> -			 kobject_name(&mem_blk->dev.kobj));
> -		sysfs_remove_link(&mem_blk->dev.kobj,
> -			 kobject_name(&node_devices[nid]->dev.kobj));
> +		if (page_nid >= 0 && page_nid == nid) {
> +			sysfs_remove_link(&node_devices[nid]->dev.kobj,
> +				 kobject_name(&mem_blk->dev.kobj));
> +			sysfs_remove_link(&mem_blk->dev.kobj,
> +				 kobject_name(&node_devices[nid]->dev.kobj));
> +			break;
> +		}
>  	}
> -	NODEMASK_FREE(unlinked_nodes);
> +
>  	return 0;
>  }

I guess so.  But the node_online() check was silently removed?
