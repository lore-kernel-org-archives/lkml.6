Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeBXBPb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:15:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeBXBPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:15:30 -0500
Date: Fri, 23 Feb 2018 17:15:28 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Cong Wang <xiyou.wangcong@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Chris Mi <chrism@mellanox.com>
Subject: Re: Fwd: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running
 selftest
Message-ID: <20180224011528.GA15231@bombadil.infradead.org>
References: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
 <b926a569-c05e-dd49-a25d-555e88e9ff8e@infradead.org>
 <CAM_iQpUveA5T6-y7bguaPUok-LphJrLYxw6kNgaMorsxm4z9NA@mail.gmail.com>
 <CAM_iQpWSRe0t1Dr=7o+1ejULV=F+_Wx1v7yyw=NRBUTYttMxog@mail.gmail.com>
 <96bf4941-17c0-0796-292c-b66087f5f52e@infradead.org>
 <CAFhKne9Dyx1uvRz_9rvCq7mewAbLA5T77P21oBQfOR7JzP_1aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhKne9Dyx1uvRz_9rvCq7mewAbLA5T77P21oBQfOR7JzP_1aQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 Randy Dunlap wrote:
> [add Matthew Wilcox; hopefully he can look/see]

Thanks, Randy.  I don't understand why nobody else thought to cc the
author of the patch that it was bisected to ...

> On 02/23/2018 04:13 PM, Cong Wang wrote:
> > On Fri, Feb 23, 2018 at 3:27 PM, Cong Wang <xiyou.wangcong@gmail.com>
> wrote:
> >> On Fri, Feb 23, 2018 at 11:00 AM, Randy Dunlap <rdunlap@infradead.org>
> wrote:
> >>> On 02/23/2018 08:05 AM, Khalid Aziz wrote:
> >>>> Same selftest does not cause panic on 4.15. git bisect pointed to
> commit 6ce711f2750031d12cec91384ac5cfa0a485b60a ("idr: Make 1-based IDRs
> more efficient").
> >>>> Kernel config is attached.
> >>
> >> Looks like something horribly wrong with u32 key id idr...
> >
> > Adding a few printk's, I got:
> >
> > [   31.231560] requested handle = ffe00000
> > [   31.232426] allocated handle = 0
> > ...
> > [   31.246475] requested handle = ffd00000
> > [   31.247555] allocated handle = 1
> >
> >
> > So the bug is here where we can't allocate a specific handle:
> >
> >                         err = idr_alloc_u32(&tp_c->handle_idr, ht,
> &handle,
> >                                             handle, GFP_KERNEL);
> >                         if (err) {
> >                                 kfree(ht);
> >                                 return err;
> >                         }

Please try this patch.  It fixes ffe00000, but there may be more things
tested that it may not work for.

Chris Mi, what happened to that set of testcases you promised to write
for me?

diff --git a/lib/idr.c b/lib/idr.c
index c98d77fcf393..10d9b8d47c33 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -36,8 +36,8 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
 {
 	struct radix_tree_iter iter;
 	void __rcu **slot;
-	int base = idr->idr_base;
-	int id = *nextid;
+	unsigned int base = idr->idr_base;
+	unsigned int id = *nextid;
 
 	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
 		return -EINVAL;
