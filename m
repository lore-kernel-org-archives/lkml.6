Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98009C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912E620665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJWJsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:48:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34197 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeJWJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:48:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id p6-v6so26728490qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 18:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTJ70AXxmOl1r+0nEdTIfgIJuSXsLWts3xunL8b11W8=;
        b=OD/xtIT/5DbHyonW9vwoNy6+rYtzZvNkZMerQPK497ok8BkY1eWYJXGcIduMxwWj5A
         ADgUCFd0CezDTzvtDQmB6dFZ31DMFVsQhpIHGkq60lUYKYWG4PVLbh2QXdAt2k7jKzAz
         5zG8mv9SPTGi9E7kJjwr3W7viASeBIefbS06P+fETTi//1GgS7jN0y+n8hfMoymN0SIR
         Tr9vqvykiQ5u+XupdmpDyiNu0g7o1XJ3ZvP0VZS+yTvkMMxaK7diONuK9ErNDkrzAAzg
         OtYFz3mBb2SQSpEkXXiO1gVNUu6WyqREQG3Ib/2grVIK+DlskPTaf5cstwNIS6gbzcLs
         mEmw==
X-Gm-Message-State: AGRZ1gJ3EOvuqjwS+JQZHIsCf2l6e0yVLLGrA8pzPBpxjn8m4PzbsYrN
        NopHre80cTRcV1gourmq6SzmaQ==
X-Google-Smtp-Source: AJdET5c3BKipp15/tzxA5A55ZWeL7ORF5flMzZBoV5P5QcxH59vwYwO7KSg3YD3w9U6h0yzh7/Wa9A==
X-Received: by 2002:a37:1909:: with SMTP id k9mr5269986qkh.61.1540258065905;
        Mon, 22 Oct 2018 18:27:45 -0700 (PDT)
Received: from [192.168.1.153] (pool-173-54-33-167.nwrknj.fios.verizon.net. [173.54.33.167])
        by smtp.gmail.com with ESMTPSA id 70-v6sm8051508qkf.35.2018.10.22.18.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 18:27:44 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "David Rientjes" <rientjes@google.com>
Cc:     "Mel Gorman" <mgorman@suse.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrea Argangeli" <andrea@kernel.org>,
        "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Stable tree" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Date:   Mon, 22 Oct 2018 21:27:43 -0400
X-Mailer: MailMate (1.12r5528)
Message-ID: <0BA54BDA-D457-4BD8-AC49-1DD7CD032C7F@cs.rutgers.edu>
In-Reply-To: <alpine.DEB.2.21.1810221355050.120157@chino.kir.corp.google.com>
References: <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com>
 <20181009094825.GC6931@suse.de> <20181009122745.GN8528@dhcp22.suse.cz>
 <20181009130034.GD6931@suse.de> <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com>
 <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
 <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
 <20181016074606.GH6931@suse.de>
 <alpine.DEB.2.21.1810221355050.120157@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 22 Oct 2018, at 17:04, David Rientjes wrote:

> On Tue, 16 Oct 2018, Mel Gorman wrote:
>
>> I consider this to be an unfortunate outcome. On the one hand, we 
>> have a
>> problem that three people can trivially reproduce with known test 
>> cases
>> and a patch shown to resolve the problem. Two of those three people 
>> work
>> on distributions that are exposed to a large number of users. On the
>> other, we have a problem that requires the system to be in a specific
>> state and an unknown workload that suffers badly from the remote 
>> access
>> penalties with a patch that has review concerns and has not been 
>> proven
>> to resolve the trivial cases.
>
> The specific state is that remote memory is fragmented as well, this 
> is
> not atypical.  Removing __GFP_THISNODE to avoid thrashing a zone will 
> only
> be beneficial when you can allocate remotely instead.  When you cannot
> allocate remotely instead, you've made the problem much worse for
> something that should be __GFP_NORETRY in the first place (and was for
> years) and should never thrash.
>
> I'm not interested in patches that require remote nodes to have an
> abundance of free or unfragmented memory to avoid regressing.

I just wonder what is the page allocation priority list in your 
environment,
assuming all memory nodes are so fragmented that no huge pages can be
obtained without compaction or reclaim.

Here is my version of that list, please let me know if it makes sense to 
you:

1. local huge pages: with compaction and/or page reclaim, you are 
willing
to pay the penalty of getting huge pages;

2. local base pages: since, in your system, remote data accesses have 
much
higher penalty than the extra TLB misses incurred by the base page size;

3. remote huge pages: at least it is better than remote base pages;

4. remote base pages: it performs worst in terms of locality and TLBs.

This might not be easy to implement in current kernel, because
the zones from remote nodes will always be candidates when
kernel is trying get_page_from_freelist(). Only _GFP_THISNODE
and MPOL_BIND can eliminate these remote node zones, where _GFP_THISNODE
is a kernel version MPOL_BIND and overwrites any user space
memory policy other than MPOL_BIND, which is troublesome.

In addition, to prioritize local base pages over remote pages,
the original huge page allocation has to fail, then kernel can
fall back to base page allocations. And you will never get remote
huge pages any more if the local base page allocation fails,
because there is no way back to huge page allocation after the fallback.

Do you expect both behaviors?


>> In the case of distributions, the first
>> patch addresses concerns with a common workload where on the other 
>> hand
>> we have an internal workload of a single company that is affected --
>> which indirectly affects many users admittedly but only one entity 
>> directly.
>>
>
> The alternative, which is my patch, hasn't been tested or shown why it
> cannot work.  We continue to talk about order >= pageblock_order vs
> __GFP_COMPACTONLY.
>
> I'd like to know, specifically:
>
>  - what measurable affect my patch has that is better solved with 
> removing
>    __GFP_THISNODE on systems where remote memory is also fragmented?
>
>  - what platforms benefit from remote access to hugepages vs accessing
>    local small pages (I've asked this maybe 4 or 5 times now)?
>
>  - how is reclaiming (and possibly thrashing) memory helpful if 
> compaction
>    fails to free an entire pageblock due to slab fragmentation due to 
> low
>    on memory conditions and the page allocator preference to return 
> node-
>    local memory?
>
>  - how is reclaiming (and possibly thrashing) memory helpful if 
> compaction
>    cannot access the memory reclaimed because the freeing scanner has
>    already passed by it, or the migration scanner has passed by it, 
> since
>    this reclaim is not targeted to pages it can find?
>
>  - what metrics can be introduced to the page allocator so that we can
>    determine that reclaiming (and possibly thrashing) memory will 
> result
>    in a hugepage being allocated?

The slab fragmentation and whether reclaim/compaction can help form
huge pages seem to orthogonal to this patch, which tries to decide
the priority between locality and huge pages.

For slab fragmentation, you might find this paper “Making Huge Pages 
Actually Useful”
(https://dl.acm.org/citation.cfm?id=3173203) helpful. The paper is
trying to minimize the number of page blocks that have both moveable and
non-moveable pages.


--
Best Regards
Yan Zi
