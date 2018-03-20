Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeCTHQ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:16:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbeCTHQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:16:27 -0400
Date: Tue, 20 Mar 2018 08:16:24 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, thp: do not cause memcg oom for thp
Message-ID: <20180320071624.GB23100@dhcp22.suse.cz>
References: <alpine.DEB.2.20.1803191409420.124411@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803191409420.124411@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-03-18 14:10:05, David Rientjes wrote:
> Commit 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and
> madvised allocations") changed the page allocator to no longer detect thp
> allocations based on __GFP_NORETRY.
> 
> It did not, however, modify the mem cgroup try_charge() path to avoid oom
> kill for either khugepaged collapsing or thp faulting.  It is never
> expected to oom kill a process to allocate a hugepage for thp; reclaim is
> governed by the thp defrag mode and MADV_HUGEPAGE, but allocations (and
> charging) should fallback instead of oom killing processes.

For some reason I thought that the charging path simply bails out for
costly orders - effectively the same thing as for the global OOM killer.
But we do not. Is there any reason to not do that though? Why don't we
simply do


diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1a917b5b7b7..08accbcd1a18 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1493,7 +1493,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 
 static void mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
-	if (!current->memcg_may_oom)
+	if (!current->memcg_may_oom || order > PAGE_ALLOC_COSTLY_ORDER)
 		return;
 	/*
 	 * We are in the middle of the charge context here, so we
-- 
Michal Hocko
SUSE Labs
