Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933688AbeCGSW2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:22:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeCGSWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:22:17 -0500
Date: Wed, 7 Mar 2018 10:22:12 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Chintan Pandya <cpandya@codeaurora.org>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix misleading 'age' in verbose slub prints
Message-ID: <20180307182212.GA23411@bombadil.infradead.org>
References: <1520423266-28830-1-git-send-email-cpandya@codeaurora.org>
 <alpine.DEB.2.20.1803071212150.6373@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803071212150.6373@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 12:13:56PM -0600, Christopher Lameter wrote:
> On Wed, 7 Mar 2018, Chintan Pandya wrote:
> > In this case, object got freed later but 'age' shows
> > otherwise. This could be because, while printing
> > this info, we print allocation traces first and
> > free traces thereafter. In between, if we get schedule
> > out, (jiffies - t->when) could become meaningless.
> 
> Ok then get the jiffies earlier?
> 
> > So, simply print when the object was allocated/freed.
> 
> The tick value may not related to anything in the logs that is why the
> "age" is there. How do I know how long ago the allocation was if I look at
> the log and only see long and large number of ticks since bootup?

I missed that the first read-through too.  The trick is that there are two printks:

[ 6044.170804] INFO: Allocated in binder_transaction+0x4b0/0x2448 age=731 cpu=3 pid=5314
...
[ 6044.216696] INFO: Freed in binder_free_transaction+0x2c/0x58 age=735 cpu=6 pid=2079

If you print the raw value, then you can do the subtraction yourself;
if you've subtracted it from jiffies each time, you've at least introduced
jitter, and possibly enough jitter to confuse and mislead.
