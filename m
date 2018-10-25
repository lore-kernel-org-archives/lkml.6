Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F39C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1332083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1332083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJZBS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:18:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:45370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbeJZBS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:18:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34CABAEAE;
        Thu, 25 Oct 2018 16:45:24 +0000 (UTC)
Date:   Thu, 25 Oct 2018 18:45:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mel Gorman <mgorman@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-ID: <20181025164522.GU18839@dhcp22.suse.cz>
References: <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
 <20180926141708.GX6278@dhcp22.suse.cz>
 <20180926142227.GZ6278@dhcp22.suse.cz>
 <20181018191147.33e8d5e1ebd785c06aab7b30@linux-foundation.org>
 <20181019080657.GJ18839@dhcp22.suse.cz>
 <583b20e5-4925-e175-1533-5c2d2bab9192@suse.cz>
 <20181024161754.0d174e7c22113f4f8aad1940@linux-foundation.org>
 <983e0c59-99ef-796c-bfc4-00e67782d1f1@suse.cz>
 <20181025161410.GT18839@dhcp22.suse.cz>
 <E0A009A6-FF31-459E-B223-6743C395F659@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0A009A6-FF31-459E-B223-6743C395F659@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-10-18 09:18:05, Andrew Morton wrote:
> 
> 
> On October 25, 2018 9:14:10 AM PDT, Michal Hocko <mhocko@kernel.org> wrote:
> 
> >Andrew. Do you want me to repost the patch or you plan to update the
> >changelog yourself?
> 
> Please send a replacement changelog and I'll paste it in?

THP allocation mode is quite complex and it depends on the defrag
mode. This complexity is hidden in alloc_hugepage_direct_gfpmask from a
large part currently. The NUMA special casing (namely __GFP_THISNODE) is
however independent and placed in alloc_pages_vma currently. This both
adds an unnecessary branch to all vma based page allocation requests and
it makes the code more complex unnecessarily as well. Not to mention
that e.g. shmem THP used to do the node reclaiming unconditionally
regardless of the defrag mode until recently. This was not only
unexpected behavior but it was also hardly a good default behavior and I
strongly suspect it was just a side effect of the code sharing more than
a deliberate decision which suggests that such a layering is wrong.

Get rid of the thp special casing from alloc_pages_vma and move the logic
to alloc_hugepage_direct_gfpmask. __GFP_THISNODE is applied to
the resulting gfp mask only when the direct reclaim is not requested and
when there is no explicit numa binding to preserve the current logic.

Please note that there's also a slight difference wrt MPOL_BIND now. The
previous code would avoid using __GFP_THISNODE if the local node was
outside of policy_nodemask(). After this patch __GFP_THISNODE is avoided
for all MPOL_BIND policies. So there's a difference that if local
node is actually allowed by the bind policy's nodemask, previously
__GFP_THISNODE would be added, but now it won't be. From the behavior
POV this is still correct because the policy nodemask is used.

-- 
Michal Hocko
SUSE Labs
