Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeDIHPp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:15:45 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45655 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeDIHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:15:43 -0400
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "Kirill A. Shutemov" <kirill@shutemov.name>, Zi Yan <zi.yan@sent.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: shmem: enable thp migration (Re: [PATCH v1] mm:
 consider non-anonymous thp as unmovable page)
Thread-Topic: [PATCH] mm: shmem: enable thp migration (Re: [PATCH v1] mm:
 consider non-anonymous thp as unmovable page)
Thread-Index: AQHTzVRbJLbJcuvidESXEazGlmX3mKPymtkAgAAfroCABLjegA==
Date: Mon, 9 Apr 2018 07:14:57 +0000
Message-ID: <20180409071456.GA8693@hori1.linux.bs1.fc.nec.co.jp>
References: <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
 <20180405124830.GJ6312@dhcp22.suse.cz>
 <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
 <20180405150547.GN6312@dhcp22.suse.cz>
 <20180405155551.wchleyaf4rxooj6m@node.shutemov.name>
 <20180405160317.GP6312@dhcp22.suse.cz>
 <20180406030706.GA2434@hori1.linux.bs1.fc.nec.co.jp>
 <20180406051452.GB23467@hori1.linux.bs1.fc.nec.co.jp>
 <20180406070815.GC8286@dhcp22.suse.cz>
In-Reply-To: <20180406070815.GC8286@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.128.101.18]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <46617E8EBD5C594E93BC92C5255CD427@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 09:08:15AM +0200, Michal Hocko wrote:
> On Fri 06-04-18 05:14:53, Naoya Horiguchi wrote:
> > On Fri, Apr 06, 2018 at 03:07:11AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> > ...
> > > -----
> > > From e31ec037701d1cc76b26226e4b66d8c783d40889 Mon Sep 17 00:00:00 2001
> > > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > Date: Fri, 6 Apr 2018 10:58:35 +0900
> > > Subject: [PATCH] mm: enable thp migration for shmem thp
> > > 
> > > My testing for the latest kernel supporting thp migration showed an
> > > infinite loop in offlining the memory block that is filled with shmem
> > > thps.  We can get out of the loop with a signal, but kernel should
> > > return with failure in this case.
> > > 
> > > What happens in the loop is that scan_movable_pages() repeats returning
> > > the same pfn without any progress. That's because page migration always
> > > fails for shmem thps.
> > > 
> > > In memory offline code, memory blocks containing unmovable pages should
> > > be prevented from being offline targets by has_unmovable_pages() inside
> > > start_isolate_page_range(). So it's possible to change migratability
> > > for non-anonymous thps to avoid the issue, but it introduces more complex
> > > and thp-specific handling in migration code, so it might not good.
> > > 
> > > So this patch is suggesting to fix the issue by enabling thp migration
> > > for shmem thp. Both of anon/shmem thp are migratable so we don't need
> > > precheck about the type of thps.
> > > 
> > > Fixes: commit 72b39cfc4d75 ("mm, memory_hotplug: do not fail offlining too early")
> > > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > Cc: stable@vger.kernel.org # v4.15+
> > 
> > ... oh, I don't think this is suitable for stable.
> > Michal's fix in another email can come first with "CC: stable",
> > then this one.
> > Anyway I want to get some feedback on the change of this patch.
> 
> My patch is indeed much simpler but it depends on [1] and that doesn't
> sound like a stable material as well because it depends on onether 2
> patches. Maybe we need some other hack for 4.15 if we really care enough.
> 
> [1] http://lkml.kernel.org/r/20180103082555.14592-4-mhocko@kernel.org

OK, so I like just giving up sending to stable.
