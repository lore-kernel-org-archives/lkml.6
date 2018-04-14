Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbeDNICN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 04:02:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54730 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeDNICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 04:02:11 -0400
Date: Sat, 14 Apr 2018 09:02:06 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Nikolay Borisov <nborisov@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in
 shrink_dcache_parent()
Message-ID: <20180414080206.GV30522@ZenIV.linux.org.uk>
References: <20180413181350.88831-1-khazhy@google.com>
 <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 10:00:29AM +0300, Nikolay Borisov wrote:
> 
> 
> On 14.04.2018 00:14, Andrew Morton wrote:
> > On Fri, 13 Apr 2018 13:28:23 -0700 Khazhismel Kumykov <khazhy@google.com> wrote:
> > 
> >> shrink_dcache_parent may spin waiting for a parallel shrink_dentry_list.
> >> In this case we may have 0 dentries to dispose, so we will never
> >> schedule out while waiting for the parallel shrink_dentry_list to
> >> complete.
> >>
> >> Tested that this fixes syzbot reports of stalls in shrink_dcache_parent()
> > 
> > Well I guess the patch is OK as a stopgap, but things seem fairly
> > messed up in there.  shrink_dcache_parent() shouldn't be doing a
> > busywait, waiting for the concurrent shrink_dentry_list().
> > 
> > Either we should be waiting (sleeping) for the concurrent operation to
> > complete or we should just bail out of shrink_dcache_parent(), perhaps
> > with 
> > 
> > 	if (list_empty(&data.dispose))
> > 		break;
> > 
> > or similar.  Dunno.
> 
> I agree, however, not being a dcache expert I'd refrain from touching
> it, since it seems to be rather fragile. Perhaps Al could take a look in
> there?

"Bail out" is definitely a bad idea, "sleep"... what on?  Especially
since there might be several evictions we are overlapping with...
