Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbeDCKyy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:54:54 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55551 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755267AbeDCKyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:54:53 -0400
X-Google-Smtp-Source: AIpwx4+SHIeuW1eyH0bCyPrWanWdP+HtRXKnGVzM/8WmLPA7qMvfiR1XaXRMyb8+7fC1Z1WGPW5KUw==
Date: Tue, 3 Apr 2018 13:54:11 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Message-ID: <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
References: <1522730788-24530-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180403075928.GC5501@dhcp22.suse.cz>
 <20180403082405.GA23809@hori1.linux.bs1.fc.nec.co.jp>
 <20180403083451.GG5501@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403083451.GG5501@dhcp22.suse.cz>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 10:34:51AM +0200, Michal Hocko wrote:
> On Tue 03-04-18 08:24:06, Naoya Horiguchi wrote:
> > On Tue, Apr 03, 2018 at 09:59:28AM +0200, Michal Hocko wrote:
> > > On Tue 03-04-18 13:46:28, Naoya Horiguchi wrote:
> > > > My testing for the latest kernel supporting thp migration found out an
> > > > infinite loop in offlining the memory block that is filled with shmem
> > > > thps.  We can get out of the loop with a signal, but kernel should
> > > > return with failure in this case.
> > > >
> > > > What happens in the loop is that scan_movable_pages() repeats returning
> > > > the same pfn without any progress. That's because page migration always
> > > > fails for shmem thps.
> > >
> > > Why does it fail? Shmem pages should be movable without any issues.
> > 
> > .. because try_to_unmap_one() explicitly skips unmapping for migration.
> > 
> >   #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >                   /* PMD-mapped THP migration entry */
> >                   if (!pvmw.pte && (flags & TTU_MIGRATION)) {
> >                           VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
> >   
> >                           if (!PageAnon(page))
> >                                   continue;
> >   
> >                           set_pmd_migration_entry(&pvmw, page);
> >                           continue;
> >                   }
> >   #endif
> > 
> > When I implemented this code, I felt hard to work on both of anon thp
> > and shmem thp at one time, so I separated the proposal into smaller steps.
> > Shmem uses pagecache so we need some non-trivial effort (including testing)
> > to extend thp migration for shmem. But I think it's a reasonable next step.
> 
> OK, I see. I have forgot about this part. Please be explicit about that
> in the changelog. Also the proper fix is to not use movable zone for
> shmem page THP rather than hack around it in the hotplug specific code
> IMHO.

No. We should just split the page before running
try_to_unmap(TTU_MIGRATION) on the page.

-- 
 Kirill A. Shutemov
