Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934487AbeDXNlz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:41:55 -0400
Received: from foss.arm.com ([217.140.101.70]:53528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933173AbeDXNlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:41:52 -0400
Date: Tue, 24 Apr 2018 14:41:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Chunyu Hu <chuhu.ncepu@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
        Chunyu Hu <chuhu@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC] mm: kmemleak: replace __GFP_NOFAIL to GFP_NOWAIT in
 gfp_kmemleak_mask
Message-ID: <20180424134148.qkvqqa4c37l6irvg@armageddon.cambridge.arm.com>
References: <1524243513-29118-1-git-send-email-chuhu@redhat.com>
 <20180420175023.3c4okuayrcul2bom@armageddon.cambridge.arm.com>
 <20180422125141.GF17484@dhcp22.suse.cz>
 <CACT4Y+YWUgyzCBadg+Oe8wDkFCaBzmcKDgu3rKjQxim7NXNLpg@mail.gmail.com>
 <CABATaM6eWtssvuj3UW9LHLK3HWo8P9g0z9VzFnuqKPKO5KMJ3A@mail.gmail.com>
 <20180424132057.GE17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424132057.GE17484@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 07:20:57AM -0600, Michal Hocko wrote:
> On Mon 23-04-18 12:17:32, Chunyu Hu wrote:
> [...]
> > So if there is a new flag, it would be the 25th bits.
> 
> No new flags please. Can you simply store a simple bool into fail_page_alloc
> and have save/restore api for that?

For kmemleak, we probably first hit failslab. Something like below may
do the trick:

diff --git a/mm/failslab.c b/mm/failslab.c
index 1f2f248e3601..63f13da5cb47 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -29,6 +29,9 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
 		return false;
 
+	if (s->flags & SLAB_NOLEAKTRACE)
+		return false;
+
 	return should_fail(&failslab.attr, s->object_size);
 }
 

Can we get a second should_fail() via should_fail_alloc_page() if a new
slab page is allocated?

-- 
Catalin
