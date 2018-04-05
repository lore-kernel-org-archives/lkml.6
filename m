Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDEMsg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:48:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeDEMsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:48:33 -0400
Date: Thu, 5 Apr 2018 14:48:30 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Message-ID: <20180405124830.GJ6312@dhcp22.suse.cz>
References: <1522730788-24530-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180403075928.GC5501@dhcp22.suse.cz>
 <20180403082405.GA23809@hori1.linux.bs1.fc.nec.co.jp>
 <20180403083451.GG5501@dhcp22.suse.cz>
 <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
 <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-04-18 15:28:38, Kirill A. Shutemov wrote:
> On Thu, Apr 05, 2018 at 10:59:27AM +0200, Michal Hocko wrote:
> > On Tue 03-04-18 13:54:11, Kirill A. Shutemov wrote:
> > > On Tue, Apr 03, 2018 at 10:34:51AM +0200, Michal Hocko wrote:
> > > > On Tue 03-04-18 08:24:06, Naoya Horiguchi wrote:
> > > > > On Tue, Apr 03, 2018 at 09:59:28AM +0200, Michal Hocko wrote:
> > > > > > On Tue 03-04-18 13:46:28, Naoya Horiguchi wrote:
> > > > > > > My testing for the latest kernel supporting thp migration found out an
> > > > > > > infinite loop in offlining the memory block that is filled with shmem
> > > > > > > thps.  We can get out of the loop with a signal, but kernel should
> > > > > > > return with failure in this case.
> > > > > > >
> > > > > > > What happens in the loop is that scan_movable_pages() repeats returning
> > > > > > > the same pfn without any progress. That's because page migration always
> > > > > > > fails for shmem thps.
> > > > > >
> > > > > > Why does it fail? Shmem pages should be movable without any issues.
> > > > > 
> > > > > .. because try_to_unmap_one() explicitly skips unmapping for migration.
> > > > > 
> > > > >   #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > > > >                   /* PMD-mapped THP migration entry */
> > > > >                   if (!pvmw.pte && (flags & TTU_MIGRATION)) {
> > > > >                           VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
> > > > >   
> > > > >                           if (!PageAnon(page))
> > > > >                                   continue;
> > > > >   
> > > > >                           set_pmd_migration_entry(&pvmw, page);
> > > > >                           continue;
> > > > >                   }
> > > > >   #endif
> > > > > 
> > > > > When I implemented this code, I felt hard to work on both of anon thp
> > > > > and shmem thp at one time, so I separated the proposal into smaller steps.
> > > > > Shmem uses pagecache so we need some non-trivial effort (including testing)
> > > > > to extend thp migration for shmem. But I think it's a reasonable next step.
> > > > 
> > > > OK, I see. I have forgot about this part. Please be explicit about that
> > > > in the changelog. Also the proper fix is to not use movable zone for
> > > > shmem page THP rather than hack around it in the hotplug specific code
> > > > IMHO.
> > > 
> > > No. We should just split the page before running
> > > try_to_unmap(TTU_MIGRATION) on the page.
> > 
> > Something like this or it is completely broken. I completely forgot the
> > whole page_vma_mapped_walk business.
> 
> No, this wouldn't work. We need to split page, not pmd to make migration
> work.

RIght, I confused the two. What is the proper layer to fix that then?
rmap_walk_file?

-- 
Michal Hocko
SUSE Labs
