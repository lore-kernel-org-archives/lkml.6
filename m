Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeDLOK1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:10:27 -0400
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:58530 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752426AbeDLOKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:10:25 -0400
Date: Thu, 12 Apr 2018 09:10:23 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180411235652.GA28279@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake>
References: <20180411060320.14458-1-willy@infradead.org> <20180411060320.14458-3-willy@infradead.org> <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake> <20180411192448.GD22494@bombadil.infradead.org> <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
 <20180411235652.GA28279@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfHdKeTqCycvX9eUqSw38lJ0XQ0BPFvzD0VX3fYopyYiBBokqkiEpSNhoEeQN/5u1iE2rMVM4U9nk1Oj/Hmu4pCSFieX0Yq/syl7uKpzL1glnwGTqAEBs
 bxgwGl87ze+oCRuy7G66zJljH2kTKUuZuU8koY66bSbgDx2sgC+lSm3PcV0zyVG5Aw8PaEO+wOGL6eENOdUj2p+Dx6zdM5yExDt/Ew+sbmClK5Sx40leR8eV
 iTF7mF2p0hlfgttKl1/NKyilCW5U+mzo4bw4SIJQgrMyd0fLWPIEyR+N9D0Z4WTwIqQJLm+JNEcZfiCa34iEORhFbOYWtx9yxTR3SgqIjI2Lns4+czEQHSFy
 hpSRrYwxO7BFvgzOTLZoDDVbVxqcTHUBvsWi+wAckdMl5MRK5xZylEJjcC37Vmqv6oTi3Fqjp9dQ9qLApTquLLEBjr6xzxTegVSKa7ePOvnmZhSgG6xjyBUh
 p4Ylb/H95r0Rblt1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018, Matthew Wilcox wrote:

>
> I don't see how that works ... can you explain a little more?
>
> I see ___slab_alloc() is called from __slab_alloc().  And I see
> slab_alloc_node does this:
>
>         object = c->freelist;
>         page = c->page;
>         if (unlikely(!object || !node_match(page, node))) {
>                 object = __slab_alloc(s, gfpflags, node, addr, c);
>                 stat(s, ALLOC_SLOWPATH);
>
> But I don't see how slub_debug leads to c->freelist always being NULL.
> It looks like it gets repopulated from page->freelist in ___slab_alloc()
> at the load_freelist label.

c->freelist is NULL and thus ___slab_alloc (slowpath) is called.
___slab_alloc populates c->freelist and gets the new object pointer.

if debugging is on then c->freelist is set to NULL at the end of
___slab_alloc because deactivate_slab() is called.

Thus the next invocation of the fastpath will find that c->freelist is
NULL and go to the slowpath. ...
