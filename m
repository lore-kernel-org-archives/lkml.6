Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeESA2T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 20:28:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeESA2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 20:28:17 -0400
Date: Fri, 18 May 2018 17:28:15 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Kagan <rkagan@virtuozzo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180519002815.GA21615@bombadil.infradead.org>
References: <20180518175025.GD6361@bombadil.infradead.org>
 <20180518153138.459c78a83c6bada41b4b187d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518153138.459c78a83c6bada41b4b187d@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:31:38PM -0700, Andrew Morton wrote:
> On Fri, 18 May 2018 10:50:25 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > If the radix tree underlying the IDR happens to be full and we attempt
> > to remove an id which is larger than any id in the IDR, we will call
> > __radix_tree_delete() with an uninitialised 'slot' pointer, at which
> > point anything could happen.  This was easiest to hit with a single entry
> > at id 0 and attempting to remove a non-0 id, but it could have happened
> > with 64 entries and attempting to remove an id >= 64.
> > 
> > Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
> > Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> > Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Neither of the changelogs I'm seeing attempt to describe the end-user
> impact of the bug.  People like to know that so they can decide which
> kernel version(s) need patching, so please always remember it.

The problem is that it could be user-triggerable a dozen different
ways.

> Looknig at the sysbot report, the impact is at least "privileged user
> can trigger a WARN", but I assume there could be worse,
> as-yet-undiscovered impacts.  So I'm thinking a cc:stable is needed,
> yes?

I thought if I used the Fixes: tag it would automatically get picked up.
Did I misunderstand?  I can imagine many different parts of the kernel
that use the IDR could trigger such a warning (although syzbot should
probably have tripped over them before now) so I wouldn't downplay
it to "only privileged users".
