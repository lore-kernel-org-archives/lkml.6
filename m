Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeBGHyV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 02:54:21 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49661 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeBGHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 02:54:20 -0500
X-Originating-IP: 50.39.166.153
Date: Tue, 6 Feb 2018 23:54:09 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180207075409.GA5726@localhost>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <20180207042334.GA16175@bombadil.infradead.org>
 <20180207050200.GH3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207050200.GH3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 09:02:00PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 06, 2018 at 08:23:34PM -0800, Matthew Wilcox wrote:
> > On Tue, Feb 06, 2018 at 06:17:03PM -0800, Paul E. McKenney wrote:
> > > So it is OK to kvmalloc() something and pass it to either kfree() or
> > > kvfree(), and it had better be OK to kvmalloc() something and pass it
> > > to kvfree().
> > > 
> > > Is it OK to kmalloc() something and pass it to kvfree()?
> > 
> > Yes, it absolutely is.
> > 
> > void kvfree(const void *addr)
> > {
> >         if (is_vmalloc_addr(addr))
> >                 vfree(addr);
> >         else
> >                 kfree(addr);
> > }
> > 
> > > If so, is it really useful to have two different names here, that is,
> > > both kfree_rcu() and kvfree_rcu()?
> > 
> > I think it's handy to have all three of kvfree_rcu(), kfree_rcu() and
> > vfree_rcu() available in the API for the symmetry of calling kmalloc()
> > / kfree_rcu().
> > 
> > Personally, I would like us to rename kvfree() to just free(), and have
> > malloc(x) be an alias to kvmalloc(x, GFP_KERNEL), but I haven't won that
> > fight yet.
> 
> But why not just have the existing kfree_rcu() API cover both kmalloc()
> and kvmalloc()?  Perhaps I am not in the right forums, but I am not hearing
> anyone arguing that the RCU API has too few members.  ;-)

I don't have any problem with having just `kvfree_rcu`, but having just
`kfree_rcu` seems confusingly asymmetric.

(Also, count me in favor of having just one "free" function, too.)
