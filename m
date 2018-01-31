Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeAaUcp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:32:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:39011 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbeAaUco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:32:44 -0500
Date: Wed, 31 Jan 2018 21:32:42 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/migrate: Add new migration reason MR_HUGETLB
Message-ID: <20180131203242.GB21609@dhcp22.suse.cz>
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
 <20180130075949.GN21609@dhcp22.suse.cz>
 <b4bd6cda-a3b7-96dd-b634-d9b3670c1ecf@linux.vnet.ibm.com>
 <20180131075852.GL21609@dhcp22.suse.cz>
 <20180131121217.4c80263d68a4ad4da7b170f0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131121217.4c80263d68a4ad4da7b170f0@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-01-18 12:12:17, Andrew Morton wrote:
> On Wed, 31 Jan 2018 08:58:52 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Wed 31-01-18 07:55:05, Anshuman Khandual wrote:
> > > On 01/30/2018 01:29 PM, Michal Hocko wrote:
> > > > On Tue 30-01-18 08:37:14, Anshuman Khandual wrote:
> > > >> alloc_contig_range() initiates compaction and eventual migration for
> > > >> the purpose of either CMA or HugeTLB allocation. At present, reason
> > > >> code remains the same MR_CMA for either of those cases. Lets add a
> > > >> new reason code which will differentiate the purpose of migration
> > > >> as HugeTLB allocation instead.
> > > > Why do we need it?
> > > 
> > > The same reason why we have MR_CMA (maybe some other ones as well) at
> > > present, for reporting purpose through traces at the least. It just
> > > seemed like same reason code is being used for two different purpose
> > > of migration.
> > 
> > But do we have any real user asking for this kind of information?
> 
> It seems a reasonable cleanup: reusing MR_CMA for hugetlb just because
> it happens to do the right thing is a bit hacky - the two things aren't
> particularly related and a reader could be excused for feeling
> confusion.

My bad! I thought this is a tracepoint thingy. But it seems to be only
used as a migration reason for page_owner. Now it makes more sense.
 
> But the change seems incomplete:
> 
> > +		if (migratetype == MIGRATE_CMA)
> > +			migrate_reason = MR_CMA;
> > +		else
> > +			migrate_reason = MR_HUGETLB;
> 
> If we're going to do this cleanup then shouldn't we go all the way and
> add MIGRATE_HUGETLB?

Yes. We can expect more users of alloc_contig_range in future. Maybe we
want to use MR_CONTIG_RANGE instead.
-- 
Michal Hocko
SUSE Labs
