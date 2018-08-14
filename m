Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD23C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE2A21735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE2A21735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeHNM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:26:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728272AbeHNM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:26:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7903B40203F2;
        Tue, 14 Aug 2018 09:39:37 +0000 (UTC)
Received: from [10.36.117.57] (ovpn-117-57.ams2.redhat.com [10.36.117.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD7722156712;
        Tue, 14 Aug 2018 09:39:34 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] mm/memory_hotplug: Refactor
 unregister_mem_sect_under_nodes
To:     osalvador@techadventures.net, akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        rafael@kernel.org, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
References: <20180813154639.19454-1-osalvador@techadventures.net>
 <20180813154639.19454-4-osalvador@techadventures.net>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <24b69c72-0ebd-476d-1c47-9c64c24b831f@redhat.com>
Date:   Tue, 14 Aug 2018 11:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813154639.19454-4-osalvador@techadventures.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 09:39:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 09:39:37 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2018 17:46, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> unregister_mem_sect_under_nodes() tries to allocate a nodemask_t
> in order to check whithin the loop which nodes have already been unlinked,
> so we do not repeat the operation on them.
> 
> NODEMASK_ALLOC calls kmalloc() if NODES_SHIFT > 8, otherwise
> it just declares a nodemask_t variable whithin the stack.
> 
> Since kamlloc() can fail, we actually check whether NODEMASK_ALLOC failed or
> not, and we return -ENOMEM accordingly.
> remove_memory_section() does not check for the return value though.
> 
> The problem with this is that if we return -ENOMEM, it means that
> unregister_mem_sect_under_nodes will not be able to remove the symlinks,
> but since we do not check the return value, we go ahead and we call unregister_memory(),
> which will remove all the mem_blks directories.
> 
> This will leave us with dangled symlinks.
> 
> The easiest way to overcome this is to fallback by calling sysfs_remove_link()
> unconditionally in case NODEMASK_ALLOC failed.
> This means that we will call sysfs_remove_link on nodes that have been already unlinked,
> but nothing wrong happens as sysfs_remove_link() backs off somewhere down the chain in case
> the link has already been removed.
> 
> I think that this is better than
> 
> a) dangled symlinks
> b) having to recovery from such error in remove_memory_section
> 
> Since from now on we will not need to take care about return values, we can make the function void.
> 
> While at it, we can also drop the node_online() check, as a node can only be
> offline if all the memory/cpus associated with it have been removed.

I would prefer splitting this change out into a separate patch.

> 
> As we have a safe fallback, one thing that could also be done is to add __GFP_NORETRY
> in the flags when calling NODEMASK_ALLOC, so we do not retry.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  drivers/base/node.c  | 26 +++++++++++++++-----------
>  include/linux/node.h |  5 ++---
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index dd3bdab230b2..0a3ca62687ea 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -449,35 +449,39 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
>  }
>  
>  /* unregister memory section under all nodes that it spans */
> -int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> +void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  				    unsigned long phys_index)
>  {
>  	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
>  	unsigned long pfn, sect_start_pfn, sect_end_pfn;
>  
> -	if (!unlinked_nodes)
> -		return -ENOMEM;
> -	nodes_clear(*unlinked_nodes);
> +	if (unlinked_nodes)
> +		nodes_clear(*unlinked_nodes);
>  
>  	sect_start_pfn = section_nr_to_pfn(phys_index);
>  	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
> -		int nid;
> +		int nid = get_nid_for_pfn(pfn);;
>  
> -		nid = get_nid_for_pfn(pfn);
>  		if (nid < 0)
>  			continue;
> -		if (!node_online(nid))
> -			continue;
> -		if (node_test_and_set(nid, *unlinked_nodes))
> +		/*
> +		 * It is possible that NODEMASK_ALLOC fails due to memory pressure.
> +		 * If that happens, we fallback to call sysfs_remove_link unconditionally.
> +		 * Nothing wrong will happen as sysfs_remove_link will back off
> +		 * somewhere down the chain in case the link has already been removed.
> +		 */
> +		if (unlinked_nodes && node_test_and_set(nid, *unlinked_nodes))
>  			continue;
> +
>  		sysfs_remove_link(&node_devices[nid]->dev.kobj,
>  			 kobject_name(&mem_blk->dev.kobj));
>  		sysfs_remove_link(&mem_blk->dev.kobj,
>  			 kobject_name(&node_devices[nid]->dev.kobj));
>  	}
> -	NODEMASK_FREE(unlinked_nodes);
> -	return 0;
> +
> +	if (unlinked_nodes)
> +		NODEMASK_FREE(unlinked_nodes);

NODEMASK_FEEE/kfree can deal with NULL pointers.

>  }
>  
>  int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 257bb3d6d014..1203378e596a 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -72,7 +72,7 @@ extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int register_mem_sect_under_node(struct memory_block *mem_blk,
>  						void *arg);
> -extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> +extern void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  					   unsigned long phys_index);
>  
>  #ifdef CONFIG_HUGETLBFS
> @@ -105,10 +105,9 @@ static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
>  {
>  	return 0;
>  }
> -static inline int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> +static inline void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  						  unsigned long phys_index)
>  {
> -	return 0;
>  }
>  
>  static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
> 


-- 

Thanks,

David / dhildenb
