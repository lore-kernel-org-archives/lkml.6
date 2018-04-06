Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeDFHIT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:08:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35323 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbeDFHIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:08:18 -0400
Date: Fri, 6 Apr 2018 09:08:15 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Zi Yan <zi.yan@sent.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: shmem: enable thp migration (Re: [PATCH v1] mm:
 consider non-anonymous thp as unmovable page)
Message-ID: <20180406070815.GC8286@dhcp22.suse.cz>
References: <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
 <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
 <20180405124830.GJ6312@dhcp22.suse.cz>
 <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
 <20180405150547.GN6312@dhcp22.suse.cz>
 <20180405155551.wchleyaf4rxooj6m@node.shutemov.name>
 <20180405160317.GP6312@dhcp22.suse.cz>
 <20180406030706.GA2434@hori1.linux.bs1.fc.nec.co.jp>
 <20180406051452.GB23467@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406051452.GB23467@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-04-18 05:14:53, Naoya Horiguchi wrote:
> On Fri, Apr 06, 2018 at 03:07:11AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> ...
> > -----
> > From e31ec037701d1cc76b26226e4b66d8c783d40889 Mon Sep 17 00:00:00 2001
> > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Date: Fri, 6 Apr 2018 10:58:35 +0900
> > Subject: [PATCH] mm: enable thp migration for shmem thp
> > 
> > My testing for the latest kernel supporting thp migration showed an
> > infinite loop in offlining the memory block that is filled with shmem
> > thps.  We can get out of the loop with a signal, but kernel should
> > return with failure in this case.
> > 
> > What happens in the loop is that scan_movable_pages() repeats returning
> > the same pfn without any progress. That's because page migration always
> > fails for shmem thps.
> > 
> > In memory offline code, memory blocks containing unmovable pages should
> > be prevented from being offline targets by has_unmovable_pages() inside
> > start_isolate_page_range(). So it's possible to change migratability
> > for non-anonymous thps to avoid the issue, but it introduces more complex
> > and thp-specific handling in migration code, so it might not good.
> > 
> > So this patch is suggesting to fix the issue by enabling thp migration
> > for shmem thp. Both of anon/shmem thp are migratable so we don't need
> > precheck about the type of thps.
> > 
> > Fixes: commit 72b39cfc4d75 ("mm, memory_hotplug: do not fail offlining too early")
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Cc: stable@vger.kernel.org # v4.15+
> 
> ... oh, I don't think this is suitable for stable.
> Michal's fix in another email can come first with "CC: stable",
> then this one.
> Anyway I want to get some feedback on the change of this patch.

My patch is indeed much simpler but it depends on [1] and that doesn't
sound like a stable material as well because it depends on onether 2
patches. Maybe we need some other hack for 4.15 if we really care enough.

[1] http://lkml.kernel.org/r/20180103082555.14592-4-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
