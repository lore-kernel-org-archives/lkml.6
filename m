Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeA3QKa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:10:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:56448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752147AbeA3QK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:10:29 -0500
Date: Tue, 30 Jan 2018 17:10:25 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Zi Yan <zi.yan@sent.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Lock mmap_sem when calling migrate_pages() in
 do_move_pages_to_node()
Message-ID: <20180130161025.GH21609@dhcp22.suse.cz>
References: <20180130030011.4310-1-zi.yan@sent.com>
 <20180130081415.GO21609@dhcp22.suse.cz>
 <5A7094DA.4000804@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A7094DA.4000804@cs.rutgers.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 10:52:58, Zi Yan wrote:
> 
> 
> Michal Hocko wrote:
> > On Mon 29-01-18 22:00:11, Zi Yan wrote:
> >> From: Zi Yan <zi.yan@cs.rutgers.edu>
> >>
> >> migrate_pages() requires at least down_read(mmap_sem) to protect
> >> related page tables and VMAs from changing. Let's do it in
> >> do_page_moves() for both do_move_pages_to_node() and
> >> add_page_for_migration().
> >>
> >> Also add this lock requirement in the comment of migrate_pages().
> > 
> > This doesn't make much sense to me, to be honest. We are holding
> > mmap_sem for _read_ so we allow parallel updates like page faults
> > or unmaps. Therefore we are isolating pages prior to the migration.
> > 
> > The sole purpose of the mmap_sem in add_page_for_migration is to protect
> > from vma going away _while_ need it to get the proper page.
> 
> Then, I am wondering why we are holding mmap_sem when calling
> migrate_pages() in existing code.
> http://elixir.free-electrons.com/linux/latest/source/mm/migrate.c#L1576

You mean in the original code? I strongly suspect this was to not take
it for each page.
-- 
Michal Hocko
SUSE Labs
