Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF15C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AA021852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfBZL67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:58:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbfBZL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:58:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QBucae035214
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:58:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw3n4vy7n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:58:57 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Feb 2019 11:58:55 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 11:58:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QBwlTR32505948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 11:58:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8096A4055;
        Tue, 26 Feb 2019 11:58:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24D46A404D;
        Tue, 26 Feb 2019 11:58:46 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Feb 2019 11:58:46 +0000 (GMT)
Date:   Tue, 26 Feb 2019 13:58:44 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/memblock: make full utilization of numa info
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
 <1551011649-30103-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551011649-30103-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022611-0016-0000-0000-0000025B0F93
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022611-0017-0000-0000-000032B57194
Message-Id: <20190226115844.GG11981@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 08:34:05PM +0800, Pingfan Liu wrote:
> There are numa machines with memory-less node. When allocating memory for
> the memory-less node, memblock allocator falls back to 'Node 0' without fully
> utilizing the nearest node. This hurts the performance, especially for per
> cpu section. Suppressing this defect by building the full node fall back
> info for memblock allocator, like what we have done for page allocator.

Is it really necessary to build full node fallback info for memblock and
then rebuild it again for the page allocator?

I think it should be possible to split parts of build_all_zonelists_init()
that do not touch per-cpu areas into a separate function and call that
function after topology detection. Then it would be possible to use
local_memory_node() when calling memblock.
 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Andi Kleen <ak@linux.intel.com>
> CC: Petr Tesarik <ptesarik@suse.cz>
> CC: Michal Hocko <mhocko@suse.com>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Nicholas Piggin <npiggin@gmail.com>
> CC: Daniel Vacek <neelx@redhat.com>
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/memblock.h |  3 +++
>  mm/memblock.c            | 68 ++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 64c41cf..ee999c5 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -342,6 +342,9 @@ void *memblock_alloc_try_nid_nopanic(phys_addr_t size, phys_addr_t align,
>  void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
>  			     phys_addr_t min_addr, phys_addr_t max_addr,
>  			     int nid);
> +extern int build_node_order(int *node_oder_array, int sz,
> +	int local_node, nodemask_t *used_mask);
> +void memblock_build_node_order(void);
> 
>  static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
>  {
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 022d4cb..cf78850 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1338,6 +1338,47 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
>  	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
>  }
> 
> +static int **node_fallback __initdata;
> +
> +/*
> + * build_node_order() relies on cpumask_of_node(), hence arch should set up
> + * cpumask before calling this func.
> + */
> +void __init memblock_build_node_order(void)
> +{
> +	int nid, i;
> +	nodemask_t used_mask;
> +
> +	node_fallback = memblock_alloc(MAX_NUMNODES * sizeof(int *),
> +		sizeof(int *));
> +	for_each_online_node(nid) {
> +		node_fallback[nid] = memblock_alloc(
> +			num_online_nodes() * sizeof(int), sizeof(int));
> +		for (i = 0; i < num_online_nodes(); i++)
> +			node_fallback[nid][i] = NUMA_NO_NODE;
> +	}
> +
> +	for_each_online_node(nid) {
> +		nodes_clear(used_mask);
> +		node_set(nid, used_mask);
> +		build_node_order(node_fallback[nid], num_online_nodes(),
> +			nid, &used_mask);
> +	}
> +}
> +
> +static void __init memblock_free_node_order(void)
> +{
> +	int nid;
> +
> +	if (!node_fallback)
> +		return;
> +	for_each_online_node(nid)
> +		memblock_free(__pa(node_fallback[nid]),
> +			num_online_nodes() * sizeof(int));
> +	memblock_free(__pa(node_fallback), MAX_NUMNODES * sizeof(int *));
> +	node_fallback = NULL;
> +}
> +
>  /**
>   * memblock_alloc_internal - allocate boot memory block
>   * @size: size of memory block to be allocated in bytes
> @@ -1370,6 +1411,7 @@ static void * __init memblock_alloc_internal(
>  {
>  	phys_addr_t alloc;
>  	void *ptr;
> +	int node;
>  	enum memblock_flags flags = choose_memblock_flags();
> 
>  	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
> @@ -1397,11 +1439,26 @@ static void * __init memblock_alloc_internal(
>  		goto done;
> 
>  	if (nid != NUMA_NO_NODE) {
> -		alloc = memblock_find_in_range_node(size, align, min_addr,
> -						    max_addr, NUMA_NO_NODE,
> -						    flags);
> -		if (alloc && !memblock_reserve(alloc, size))
> -			goto done;
> +		if (!node_fallback) {
> +			alloc = memblock_find_in_range_node(size, align,
> +					min_addr, max_addr,
> +					NUMA_NO_NODE, flags);
> +			if (alloc && !memblock_reserve(alloc, size))
> +				goto done;
> +		} else {
> +			int i;
> +			for (i = 0; i < num_online_nodes(); i++) {
> +				node = node_fallback[nid][i];
> +				/* fallback list has all memory nodes */
> +				if (node == NUMA_NO_NODE)
> +					break;
> +				alloc = memblock_find_in_range_node(size,
> +						align, min_addr, max_addr,
> +						node, flags);
> +				if (alloc && !memblock_reserve(alloc, size))
> +					goto done;
> +			}
> +		}
>  	}
> 
>  	if (min_addr) {
> @@ -1969,6 +2026,7 @@ unsigned long __init memblock_free_all(void)
> 
>  	reset_all_zones_managed_pages();
> 
> +	memblock_free_node_order();
>  	pages = free_low_memory_core_early();
>  	totalram_pages_add(pages);
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

