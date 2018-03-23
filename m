Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeCWJ0m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:26:42 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:47088 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCWJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:26:41 -0400
X-Google-Smtp-Source: AG47ELsPs37B7oe+Rt/0U7BkOTdCictCuJzlSJBdScEs9NTNGteouWq42gfcxCLe/NvMr9mf6EpKeA==
Date: Fri, 23 Mar 2018 02:26:39 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, thp: do not invoke oom killer on thp charges
In-Reply-To: <20180323090704.GK23100@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.20.1803230208100.97541@chino.kir.corp.google.com>
References: <20180321205928.22240-1-mhocko@kernel.org> <alpine.DEB.2.20.1803211418170.107059@chino.kir.corp.google.com> <20180321214104.GT23100@dhcp22.suse.cz> <alpine.DEB.2.20.1803220106010.175961@chino.kir.corp.google.com> <20180322085611.GY23100@dhcp22.suse.cz>
 <alpine.DEB.2.20.1803221304160.3268@chino.kir.corp.google.com> <20180323090704.GK23100@dhcp22.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Michal Hocko wrote:

> > Examples of where this isn't already done?  It certainly wasn't a problem 
> > before __GFP_NORETRY was dropped in commit 2516035499b9 but you suspect 
> > it's a problem now.
> 
> It is not a problem _right now_ as I've already pointed out few
> times. We do not trigger the OOM killer for anything but #PF path. But
> this is an implementation detail which can change in future and there is
> actually some demand for the change. Once we start triggering the oom
> killer for all charges then we do not really want to have the disparity.
> 

Ok, my patch is only addressing the code as it sits today, not any 
theoretical code in the future.  The fact remains that the 
PAGE_ALLOC_COSTLY_ORDER and high_zoneidx test for lowmem allocations in 
the allocation path are because oom killing is unlikely to free contiguous 
pages and lowmem, respectively.  We wouldn't avoid oom kill in memcg just 
because a charge is __GFP_DMA.  We shouldn't avoid oom kill in memcg just 
because the order is PAGE_ALLOC_COSTLY_ORDER: it's about contiguous 
memory, not about amount of memory.  I believe you understand that and so 
I'm optimistic that we are good in closing this thread out.  Thanks.
