Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DAF2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbKIfSfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DAF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJEDL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:11:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39810 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:11:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so3658658pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ITt33YEkn5yF4X/XcEV8bEEuJBcjDxM5JsoA+km5PJ4=;
        b=cbKIfSfSyDF381CqO9daEyuW17NdE4OC48R2QWBhPpVmGje2okmmmf9xgv8BQRmdLA
         tmzMILu8viEa5FnJJ40sFUpEG9y1JZ3YiSAPuQnriP65GxZwGF1+rUSgkDT6cJdUChHG
         2wnHTXexJPJRMr3XUizDB5vtdNMA0wyOL2ioqV7F/XX4VbSnh7kS8H95hhQqHSDTB8nY
         TBSeuU0FpVp7dS7vwpvsBvdit2hUG8TOOoJfuKFCBb27QmJ+bwStMgEe7Oat2q6FdsyF
         0bDj4rS9ZlM09Jy8x8LN27ahFRo/bNnvo+39sq7DxanEESyYz8qcyR7/giCmggL3Rs0X
         EB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ITt33YEkn5yF4X/XcEV8bEEuJBcjDxM5JsoA+km5PJ4=;
        b=sbOBvSXrdUm541LTnRlTygwqZDsp1fVO1Pc9D+oaQ5OLg3bm1bh9Y/O46BxKmpRE4a
         lSFNF3h+LV25dbMsl1s25CrvNiz1n/FfBI+tsAe9PMXBB6AOpi0KSapGgMFxgIbXKgp6
         Zb3NbTqCKSPLFV4DLWLUdVYW0noOJ6u0RXy92P3cqJRhiW4kdGbPntdPZjWUt29nqdmj
         P9ydZYpNJtZFq7gCGNmauXbouGyuzPGnVG2AyfU7uqwqQ/8zG/GoqE7sv/9HKEMaxxrc
         L0foGJxLRbJo/qx0GbIEtwqzK34caZXas4rl/RDRdE+gNlmCWLwvgmFcBrfW+4JNJmHd
         gjHQ==
X-Gm-Message-State: ABuFfoglPs8ZTlboXfiNTW5CKNMG2b1PQB1a21tuXi2+/Vof0xl86Zg9
        4xJYTBKUsZXnhqabV7SsZTd7Pw==
X-Google-Smtp-Source: ACcGV63Xj8UJMfjS+f98/NOAHDgqmqlmOiLh/mvFHM35wrPdtoMd1R4KZ1e/lxPAUBWg29QSUcpZgw==
X-Received: by 2002:a63:2f81:: with SMTP id v123-v6mr6868713pgv.223.1538684194681;
        Thu, 04 Oct 2018 13:16:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j187-v6sm10799661pfc.39.2018.10.04.13.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 13:16:33 -0700 (PDT)
Date:   Thu, 4 Oct 2018 13:16:32 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Stable tree <stable@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20180925120326.24392-2-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
References: <20180925120326.24392-1-mhocko@kernel.org> <20180925120326.24392-2-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Michal Hocko wrote:

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index da858f794eb6..149b6f4cf023 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2046,8 +2046,36 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		nmask = policy_nodemask(gfp, pol);
>  		if (!nmask || node_isset(hpage_node, *nmask)) {
>  			mpol_cond_put(pol);
> -			page = __alloc_pages_node(hpage_node,
> -						gfp | __GFP_THISNODE, order);
> +			/*
> +			 * We cannot invoke reclaim if __GFP_THISNODE
> +			 * is set. Invoking reclaim with
> +			 * __GFP_THISNODE set, would cause THP
> +			 * allocations to trigger heavy swapping
> +			 * despite there may be tons of free memory
> +			 * (including potentially plenty of THP
> +			 * already available in the buddy) on all the
> +			 * other NUMA nodes.
> +			 *
> +			 * At most we could invoke compaction when
> +			 * __GFP_THISNODE is set (but we would need to
> +			 * refrain from invoking reclaim even if
> +			 * compaction returned COMPACT_SKIPPED because
> +			 * there wasn't not enough memory to succeed
> +			 * compaction). For now just avoid
> +			 * __GFP_THISNODE instead of limiting the
> +			 * allocation path to a strict and single
> +			 * compaction invocation.
> +			 *
> +			 * Supposedly if direct reclaim was enabled by
> +			 * the caller, the app prefers THP regardless
> +			 * of the node it comes from so this would be
> +			 * more desiderable behavior than only
> +			 * providing THP originated from the local
> +			 * node in such case.
> +			 */
> +			if (!(gfp & __GFP_DIRECT_RECLAIM))
> +				gfp |= __GFP_THISNODE;
> +			page = __alloc_pages_node(hpage_node, gfp, order);
>  			goto out;
>  		}
>  	}

This causes, on average, a 13.9% access latency regression on Haswell, and 
the regression would likely be more severe on Naples and Rome.

There exist libraries that allow the .text segment of processes to be 
remapped to memory backed by transparent hugepages and use MADV_HUGEPAGE 
to stress local compaction to defragment node local memory for hugepages 
at startup.  The cost, including the statistics Mel gathered, is 
acceptable for these processes: they are not concerned with startup cost, 
they are concerned only with optimal access latency while they are 
running.

So while it may take longer to start the process because memory compaction 
is attempting to allocate hugepages with __GFP_DIRECT_RECLAIM, in the 
cases where compaction is successful, this is a very significant long-term 
win.  In cases where compaction fails, falling back to local pages of the 
native page size instead of remote thp is a win for the remaining time 
this process wins: as stated, 13.9% faster for all memory accesses to the 
process's text while it runs on Haswell.

So these processes, and there are 100's of users of these libraries, 
explicitly want to incur the cost of startup to attempt to get local thp 
and fallback only when necessary to local pages of the native page size.  
They want the behavior this patch is changing and regress if the patch is 
merged.

This patch does not provide an alternative beyond MPOL_BIND to preserve 
the existing behavior.  In that case, if local memory is actually oom, we 
unnecessarily oom kill processes which would be completely unacceptable to 
these users since they are fine to accept 10-20% of their memory being 
faulted remotely if necessary to prevent processes being oom killed.

These libraries were implemented with the existing behavior of 
MADV_HUGEPAGE in mind and I cannot ask for 100s of binaries to be rebuilt 
to enforce new constraints specifically for hugepages with no alternative 
that does not allow unnecessary oom killing.

There are ways to address this without introducing regressions for 
existing users of MADV_HUGEPAGE: introduce an madvise() mode to accept 
remote thp allocations, which users of this library would never set, or 
fix memory compaction so that it does not incur substantial allocation 
latency when it will likely fail.

We don't introduce 13.9% regressions for binaries that are correctly using 
MADV_HUGEPAGE as it is implemented.

Nacked-by: David Rientjes <rientjes@google.com>
