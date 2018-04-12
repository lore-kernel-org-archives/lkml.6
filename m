Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeDLO10 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:27:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbeDLO1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:27:22 -0400
Date: Thu, 12 Apr 2018 07:27:18 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
Message-ID: <20180412142718.GA20398@bombadil.infradead.org>
References: <20180411060320.14458-1-willy@infradead.org>
 <20180411060320.14458-3-willy@infradead.org>
 <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake>
 <20180411192448.GD22494@bombadil.infradead.org>
 <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
 <20180411235652.GA28279@bombadil.infradead.org>
 <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 09:10:23AM -0500, Christopher Lameter wrote:
> On Wed, 11 Apr 2018, Matthew Wilcox wrote:
> > I don't see how that works ... can you explain a little more?
>
> c->freelist is NULL and thus ___slab_alloc (slowpath) is called.
> ___slab_alloc populates c->freelist and gets the new object pointer.
> 
> if debugging is on then c->freelist is set to NULL at the end of
> ___slab_alloc because deactivate_slab() is called.
> 
> Thus the next invocation of the fastpath will find that c->freelist is
> NULL and go to the slowpath. ...

_ah_.  I hadn't figured out that c->page was always NULL in the debugging
case too, so ___slab_alloc() always hits the 'new_slab' case.  Thanks!
