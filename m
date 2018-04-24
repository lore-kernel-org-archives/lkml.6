Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756976AbeDXM3Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:29:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755555AbeDXM3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:29:21 -0400
Date: Tue, 24 Apr 2018 08:29:14 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Matthew Wilcox <willy@infradead.org>
cc: Michal Hocko <mhocko@kernel.org>, David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        eric.dumazet@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3] kvmalloc: always use vmalloc if CONFIG_DEBUG_SG
In-Reply-To: <20180424034643.GA26636@bombadil.infradead.org>
Message-ID: <alpine.LRH.2.02.1804240818530.28016@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com> <20180420130852.GC16083@dhcp22.suse.cz> <alpine.LRH.2.02.1804201635180.25408@file01.intranet.prod.int.rdu2.redhat.com>
 <20180420210200.GH10788@bombadil.infradead.org> <alpine.LRH.2.02.1804201704580.25408@file01.intranet.prod.int.rdu2.redhat.com> <20180421144757.GC14610@bombadil.infradead.org> <alpine.LRH.2.02.1804221733520.7995@file01.intranet.prod.int.rdu2.redhat.com>
 <20180423151545.GU17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804232003100.2299@file01.intranet.prod.int.rdu2.redhat.com> <20180424034643.GA26636@bombadil.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2018, Matthew Wilcox wrote:

> On Mon, Apr 23, 2018 at 08:06:16PM -0400, Mikulas Patocka wrote:
> > Some bugs (such as buffer overflows) are better detected
> > with kmalloc code, so we must test the kmalloc path too.
> 
> Well now, this brings up another item for the collective TODO list --
> implement redzone checks for vmalloc.  Unless this is something already
> taken care of by kasan or similar.

The kmalloc overflow testing is also not ideal - it rounds the size up to 
the next slab size and detects buffer overflows only at this boundary.

Some times ago, I made a "kmalloc guard" patch that places a magic number 
immediatelly after the requested size - so that it can detect overflows at 
byte boundary 
( https://www.redhat.com/archives/dm-devel/2014-September/msg00018.html )

That patch found a bug in crypto code:
( http://lkml.iu.edu/hypermail/linux/kernel/1409.1/02325.html )

Mikulas
