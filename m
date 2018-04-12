Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeDLHl1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:41:27 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:54540 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeDLHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:41:26 -0400
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, Zi Yan <zi.yan@sent.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] mm: migrate: vm event counter for hugepage
 migration
Thread-Topic: [PATCH v1 0/2] mm: migrate: vm event counter for hugepage
 migration
Thread-Index: AQHT0WxxyRxBwyDghE6+dkLRphReNaP8EpCAgAAW0wA=
Date: Thu, 12 Apr 2018 07:40:41 +0000
Message-ID: <20180412074039.GA3340@hori1.linux.bs1.fc.nec.co.jp>
References: <1523434167-19995-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180412061859.GR23400@dhcp22.suse.cz>
In-Reply-To: <20180412061859.GR23400@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.128.101.30]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <26566DB56A5F954CB0641A6E02F3BC84@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 08:18:59AM +0200, Michal Hocko wrote:
> On Wed 11-04-18 17:09:25, Naoya Horiguchi wrote:
> > Hi everyone,
> > 
> > I wrote patches introducing separate vm event counters for hugepage migration
> > (both for hugetlb and thp.)
> > Hugepage migration is different from normal page migration in event frequency
> > and/or how likely it succeeds, so maintaining statistics for them in mixed
> > counters might not be helpful both for develors and users.
> 
> This is quite a lot of code to be added se we should better document
> what it is intended for. Sure I understand your reasonaning about huge
> pages are more likely to fail but is this really worth a separate
> counter? Do you have an example of how this would be useful?

Our customers periodically collect some log info to understand what
happened after system failures happen.  Then if we have separate counters
for hugepage migration and the values show some anomaly, that might
help admins and developers understand the issue more quickly.
We have other ways to get this info like checking /proc/pid/pagemap and
/proc/kpageflags, but they are costly and most users decide not to
collect them in periodical logging.

> 
> If we are there then what about different huge page sizes (for hugetlb)?
> Do we need per-hstate stats?

Yes, per-hstate counters are better. And existing hugetlb counters
htlb_buddy_alloc_* are also affected by this point.

> 
> In other words, is this really worth it?

Actually, I'm not sure at this point.

Thanks,
Naoya Horiguchi

> 
> >  include/linux/vm_event_item.h |   7 +++
> >  mm/migrate.c                  | 103 +++++++++++++++++++++++++++++++++++-------
> >  mm/vmstat.c                   |   8 ++++
> >  3 files changed, 102 insertions(+), 16 deletions(-)
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
