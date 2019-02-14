Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B86C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14DB21916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408055AbfBNUi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:38:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:38:26 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5BEAAA7A;
        Thu, 14 Feb 2019 20:38:25 +0000 (UTC)
Date:   Thu, 14 Feb 2019 12:38:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "labbott@redhat.com" <labbott@redhat.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
Message-Id: <20190214123824.fe95cc2e603f75382490bfb4@linux-foundation.org>
In-Reply-To: <20190214125704.6678-1-peng.fan@nxp.com>
References: <20190214125704.6678-1-peng.fan@nxp.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 12:45:51 +0000 Peng Fan <peng.fan@nxp.com> wrote:

> In case cma_init_reserved_mem failed, need to free the memblock allocated
> by memblock_reserve or memblock_alloc_range.
> 
> ...
>
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -353,12 +353,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
>  
>  	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
>  	if (ret)
> -		goto err;
> +		goto free_mem;
>  
>  	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
>  		&base);
>  	return 0;
>  
> +free_mem:
> +	memblock_free(base, size);
>  err:
>  	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
>  	return ret;

This doesn't look right to me.  In the `fixed==true' case we didn't
actually allocate anything and in the `fixed==false' case, the
allocated memory is at `addr', not at `base'.

