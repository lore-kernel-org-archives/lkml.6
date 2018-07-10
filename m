Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B54C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AB620A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p4Itomkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AB620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeGJVYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:24:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbeGJVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:24:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6AKid57010504;
        Tue, 10 Jul 2018 20:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uoK8LJv+y6FDmIYL2k3Mn6jRYI0KgfNzMvwwktF3Ud8=;
 b=p4ItomkzuwMuwT6hwgdenn22Kmec/BUzyju50zY9aCVXn3l5xu0bykkltHWUrsbs032b
 cRN5Jdv+evWiV0wVhk/J9sge0dmdv4OOm7Clr66oIcMmH6dC3Yy63Ze1J7J2OOq8Alg+
 c4AqxUc1kozh8i5KPN7wjs6Zm5N07ZlQWeyKqEph8ZSNiErWmgJNfjKQ1WNynLuX6Wm6
 eGYsUXJgoBMQ3GDp/HlcTadfzbr3OjtixjJavEmut7PgmufSpjrl8rBTKmqrnN+dkiJs
 ic0nbEfgHjzvdzMDHtxb3T6dxTjKDaJVox5dS638X/6FIqfn7cfjJXwpymcFgng5ed2f Qw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k2p7dumc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 20:47:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6AKl0E3010335
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 20:47:00 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6AKkx12006565;
        Tue, 10 Jul 2018 20:46:59 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 13:46:58 -0700
Subject: Re: [PATCH] mm: hugetlb: don't zero 1GiB bootmem pages.
To:     Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com
References: <20180710184903.68239-1-cannonmatthews@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ad083425-c861-1a77-069d-23b0aa1c84c6@oracle.com>
Date:   Tue, 10 Jul 2018 13:46:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710184903.68239-1-cannonmatthews@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807100220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 11:49 AM, Cannon Matthews wrote:
> When using 1GiB pages during early boot, use the new
> memblock_virt_alloc_try_nid_raw() function to allocate memory without
> zeroing it.  Zeroing out hundreds or thousands of GiB in a single core
> memset() call is very slow, and can make early boot last upwards of
> 20-30 minutes on multi TiB machines.
> 
> To be safe, still zero the first sizeof(struct boomem_huge_page) bytes
> since this is used a temporary storage place for this info until
> gather_bootmem_prealloc() processes them later.
> 
> The rest of the memory does not need to be zero'd as the hugetlb pages
> are always zero'd on page fault.
> 
> Tested: Booted with ~3800 1G pages, and it booted successfully in
> roughly the same amount of time as with 0, as opposed to the 25+
> minutes it would take before.
> 

Nice improvement!

> Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
> ---
>  mm/hugetlb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3612fbb32e9d..c93a2c77e881 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2101,7 +2101,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
>  	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
>  		void *addr;
> 
> -		addr = memblock_virt_alloc_try_nid_nopanic(
> +		addr = memblock_virt_alloc_try_nid_raw(
>  				huge_page_size(h), huge_page_size(h),
>  				0, BOOTMEM_ALLOC_ACCESSIBLE, node);
>  		if (addr) {
> @@ -2109,7 +2109,12 @@ int __alloc_bootmem_huge_page(struct hstate *h)
>  			 * Use the beginning of the huge page to store the
>  			 * huge_bootmem_page struct (until gather_bootmem
>  			 * puts them into the mem_map).
> +			 *
> +			 * memblock_virt_alloc_try_nid_raw returns non-zero'd
> +			 * memory so zero out just enough for this struct, the
> +			 * rest will be zero'd on page fault.
>  			 */
> +			memset(addr, 0, sizeof(struct huge_bootmem_page));

This forced me to look at the usage of huge_bootmem_page.  It is defined as:
struct huge_bootmem_page {
	struct list_head list;
	struct hstate *hstate;
#ifdef CONFIG_HIGHMEM
	phys_addr_t phys;
#endif
};

The list and hstate fields are set immediately after allocating the memory
block here and elsewhere.  However, I can't find any code that sets phys.
Although, it is potentially used in gather_bootmem_prealloc().  It appears
powerpc used this field at one time, but no longer does.

Am I missing something?

Not an issue with this patch, rather existing code.  I'd prefer not to do
the memset() "just to be safe".  Unless I am missing something, I would
like to remove phys field and supporting code first.  Then, this patch
without the memset.

-- 
Mike Kravetz

>  			m = addr;
>  			goto found;
>  		}
> --
> 2.18.0.203.gfac676dfb9-goog
> 
