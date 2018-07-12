Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DEFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20020213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20020213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeGLH42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:56:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbeGLH41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:56:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 764BBAE54;
        Thu, 12 Jul 2018 07:48:04 +0000 (UTC)
Date:   Thu, 12 Jul 2018 09:48:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com
Subject: Re: [PATCH v2] mm: hugetlb: don't zero 1GiB bootmem pages.
Message-ID: <20180712074803.GB32648@dhcp22.suse.cz>
References: <20180711213313.92481-1-cannonmatthews@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711213313.92481-1-cannonmatthews@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 14:33:13, Cannon Matthews wrote:
> When using 1GiB pages during early boot, use the new
> memblock_virt_alloc_try_nid_raw() function to allocate memory without
> zeroing it.  Zeroing out hundreds or thousands of GiB in a single core
> memset() call is very slow, and can make early boot last upwards of
> 20-30 minutes on multi TiB machines.
> 
> The memory does not need to be zero'd as the hugetlb pages are always
> zero'd on page fault.
> 
> Tested: Booted with ~3800 1G pages, and it booted successfully in
> roughly the same amount of time as with 0, as opposed to the 25+
> minutes it would take before.
> 
> Signed-off-by: Cannon Matthews <cannonmatthews@google.com>

Thanks for the updated version.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2: removed the memset of the huge_bootmem_page area and added
> INIT_LIST_HEAD instead.
> 
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3612fbb32e9d..488330f23f04 100644
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
> @@ -2119,6 +2119,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
>  found:
>  	BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>  	/* Put them into a private list first because mem_map is not up yet */
> +	INIT_LIST_HEAD(&m->list);
>  	list_add(&m->list, &huge_boot_pages);
>  	m->hstate = h;
>  	return 1;
> --
> 2.18.0.203.gfac676dfb9-goog

-- 
Michal Hocko
SUSE Labs
