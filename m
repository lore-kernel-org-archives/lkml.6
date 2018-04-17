Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755259AbeDQQiJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:38:09 -0400
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:39558 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754675AbeDQQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:38:06 -0400
Date: Tue, 17 Apr 2018 11:38:02 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Vlastimil Babka <vbabka@suse.cz>
cc: Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] slab: introduce the flag SLAB_MINIMIZE_WASTE
In-Reply-To: <f8f736fe-9e0e-acd2-8040-f4f25ea5a7a2@suse.cz>
Message-ID: <alpine.DEB.2.20.1804171135190.18801@nuc-kabylake>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211024220.2175@nuc-kabylake> <alpine.LRH.2.02.1803211153320.16017@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211226350.3174@nuc-kabylake>
 <alpine.LRH.2.02.1803211425330.26409@file01.intranet.prod.int.rdu2.redhat.com> <20c58a03-90a8-7e75-5fc7-856facfb6c8a@suse.cz> <20180413151019.GA5660@redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com>
 <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com> <20180416144638.GA22484@redhat.com> <alpine.LRH.2.02.1804161530360.19492@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804170940340.17557@nuc-kabylake>
 <f8f736fe-9e0e-acd2-8040-f4f25ea5a7a2@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfC2tcBarzIi4LmxLo5jCBgV9NG8nTk4cKl7qby9jcUednoctKl/uKCI9xGSWCgFWHv0fRgklEEW3+DiXQ3oBGI+utFeT7RmwLUNqPKNR+8HptUHhW1o5
 x8Ejg27ot6uUtIEWSPEfqVtdecpKRLPtP/HmmHkjDqeWcoRFnlSKXZX57sEJ2lhNretmolLfTPTNRpIDWj8kNMbtYYwdedrN3dKJwAanvCr7cqZX4WXReniM
 ghgpOnCXqOLM0LB3hrqEufZGtnhI6jBzBsjbtcriJUEb64XJzyKdQtgfsoPj7hXlQXhRUbV4PmudejOEmdNMxZIp8fv7KQvvX6Rw1QtLq4HSOc8d8M/C9qAu
 9NCSEw8nEfDFwEqcNccPLiK+8m/dsrXT3Eo/dIqWYvzkUx1vX1J/hYAPeLYddd7wIHUFUZ+0G3b/Mvplgt52N7SzRPH8PKdviLmBS0VnncYygt4LeSIrIv/l
 QH8Y5rxNc/eXX4Qr
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018, Vlastimil Babka wrote:

> On 04/17/2018 04:45 PM, Christopher Lameter wrote:

> > But then higher order allocs are generally seen as problematic.
>
> I think in this case they are better than wasting/fragmenting 384kB for
> 640kB object.

Well typically we have suggested that people use vmalloc in the past.


> > Note that SLUB will fall back to smallest order already if a failure
> > occurs so increasing slub_max_order may not be that much of an issue.
> >
> > Maybe drop the max order limit completely and use MAX_ORDER instead?
>
> For packing, sure. For performance, please no (i.e. don't try to
> allocate MAX_ORDER for each and every cache).

No of course not. We would have to modify the order selection on kmem
cache creation.

> > That
> > means that callers need to be able to tolerate failures.
>
> Is it any different from now? I suppose there would still be
> smallest-order fallback involved in sl*b itself? And if your allocation
> is so large it can fail even with the fallback (i.e. >= costly order),
> you need to tolerate failures anyway?

Failures can occur even with < costly order as far as I can telkl. Order 0
is the only safe one.

> One corner case I see is if there is anyone who would rather use their
> own fallback instead of the space-wasting smallest-order fallback.
> Maybe we could map some GFP flag to indicate that.

Well if you have a fallback then maybe the slab allocator should not fall
back on its own but let the caller deal with it.
