Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeDNU6z (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:58:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36836 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeDNU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:58:53 -0400
Date: Sat, 14 Apr 2018 21:58:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nikolay Borisov <nborisov@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in
 shrink_dcache_parent()
Message-ID: <20180414205846.GW30522@ZenIV.linux.org.uk>
References: <20180413181350.88831-1-khazhy@google.com>
 <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com>
 <20180414080206.GV30522@ZenIV.linux.org.uk>
 <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 09:36:23AM -0700, Linus Torvalds wrote:
> But it does *not* make sense for the case where we've hit a dentry
> that is already on the shrink list. Sure, we'll continue to gather all
> the other dentries, but if there is concurrent shrinking, shouldn't we
> give up the CPU more eagerly - *particularly* if somebody else is
> waiting (it might be the other process that actually gets rid of the
> shrinking dentries!)?
> 
> So my gut feel is that we should at least try doing something like
> this in select_collect():
> 
> -       if (!list_empty(&data->dispose))
> +       if (data->found)
>                 ret = need_resched() ? D_WALK_QUIT : D_WALK_NORETRY;
> 
> because even if we haven't actually been able to shrink something, if
> we hit an already shrinking entry we should probably at least not do
> the "retry for rename". And if we actually are going to reschedule, we
> might as well start from the beginning.
> 
> I realize that *this* thread might not be making any actual progress
> (because it didn't find any dentries to shrink), but since it did find
> _a_ dentry that is being shrunk, we know the operation itself - on a
> bigger scale - is making progress.
> 
> Hmm?

That breaks d_invalidate(), unfortunately.  Look at the termination
conditions in the loop there...
