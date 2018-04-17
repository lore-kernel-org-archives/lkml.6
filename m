Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeDQOph (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:45:37 -0400
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:43744 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753139AbeDQOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:45:29 -0400
Date: Tue, 17 Apr 2018 09:45:27 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Mike Snitzer <snitzer@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] slab: introduce the flag SLAB_MINIMIZE_WASTE
In-Reply-To: <alpine.LRH.2.02.1804161530360.19492@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1804170940340.17557@nuc-kabylake>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211024220.2175@nuc-kabylake> <alpine.LRH.2.02.1803211153320.16017@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211226350.3174@nuc-kabylake>
 <alpine.LRH.2.02.1803211425330.26409@file01.intranet.prod.int.rdu2.redhat.com> <20c58a03-90a8-7e75-5fc7-856facfb6c8a@suse.cz> <20180413151019.GA5660@redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com>
 <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com> <20180416144638.GA22484@redhat.com> <alpine.LRH.2.02.1804161530360.19492@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfOE1VLzCkYy4qlzmfXRXA0rVMD3tF4LspKQnAN48XCHWMvzikNCTjYiZ0yBT0L2OK3ZcQFxS1Gl5V8Uq7E4vcrSRrk26ZSWggqafxcvFh536fPZxP6IX
 FFtJriPvoPVV9Iwy8SVmT9D+wqraYaVdwiMftGBoY7CjRqAEzKJp3rRYhBttvPzxUgcFfZ7LWZz7+C5E+ATQJ4NVbu2ivUOREczi/+nm14uSBRe7OtxhdJeT
 yVuWBaBp6KVI86Mvu4JieGxT5NJUDM3ARnqinpG274QxxSROJiBjAPMIazEmBc5iX8kAMjKOx+5phGzg8WobsV1YPleKsfAy79aF2TFUfFzscQNHjLyDiSZ4
 Q3QnciKSTzPC25uvgctKRDp2aWsNOgyE6wkjOLZPlXbVmCTxourTeuyeMnEJDfiF5P39NJNo8Jra7YxuLC40UMjO2rAsuNxHTUyZH0SBfKMIk5U6rIz5mpoi
 MA5F8KMPytL+bca2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Mikulas Patocka wrote:

> This patch introduces a flag SLAB_MINIMIZE_WASTE for slab and slub. This
> flag causes allocation of larger slab caches in order to minimize wasted
> space.
>
> This is needed because we want to use dm-bufio for deduplication index and
> there are existing installations with non-power-of-two block sizes (such
> as 640KB). The performance of the whole solution depends on efficient
> memory use, so we must waste as little memory as possible.

Hmmm. Can we come up with a generic solution instead?

This may mean relaxing the enforcement of the allocation max order a bit
so that we can get dense allocation through higher order allocs.

But then higher order allocs are generally seen as problematic.

Note that SLUB will fall back to smallest order already if a failure
occurs so increasing slub_max_order may not be that much of an issue.

Maybe drop the max order limit completely and use MAX_ORDER instead? That
means that callers need to be able to tolerate failures.
