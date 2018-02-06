Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeBFWz4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:55:56 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:45859 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbeBFWzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:55:54 -0500
X-Google-Smtp-Source: AH8x225UsqvXsUnBGpKZVJoIlLikfXHBXMbvcZwrOHoQmrQA4uV7YaLEiPnxhvl717IZT1oCHTMpAA==
Date: Tue, 6 Feb 2018 14:55:48 -0800
From: Minchan Kim <minchan@kernel.org>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC] ashmem: Fix lockdep RECLAIM_FS false positive
Message-ID: <20180206225548.GB9680@eng-minchan1.roam.corp.google.com>
References: <20180206004903.224390-1-joelaf@google.com>
 <20180206220159.GA9680@eng-minchan1.roam.corp.google.com>
 <CAJWu+opFVtVbPygHBYX5gv-LeH1uugY1DDPp2q4va4mOsvBeWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+opFVtVbPygHBYX5gv-LeH1uugY1DDPp2q4va4mOsvBeWw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 02:32:13PM -0800, Joel Fernandes wrote:
> Hi Minchan,
> 
> On Tue, Feb 6, 2018 at 2:01 PM, Minchan Kim <minchan@kernel.org> wrote:
> [...]
> > On Mon, Feb 05, 2018 at 04:49:03PM -0800, Joel Fernandes wrote:
> >> During invocation of ashmem shrinker under memory pressure, ashmem
> >> calls into VFS code via vfs_fallocate. We however make sure we
> >> don't enter it if the allocation was GFP_FS to prevent looping
> >> into filesystem code. However lockdep doesn't know this and prints
> >> a lockdep splat as below.
> >>
> >> This patch fixes the issue by releasing the reclaim_fs lock after
> >> checking for GFP_FS but before calling into the VFS path, and
> >> reacquiring it after so that lockdep can continue reporting any
> >> reclaim issues later.
> >
> > At first glance, it looks reasonable. However, Couldn't we return
> > just 0 in ashmem_shrink_count when the context is under FS?
> >
> 
> We're already checking if GFP_FS in ashmem_shrink_scan and bailing out
> though, did I miss something?

I understand your concern now. Apart from that, if ashmem_shrink_count
is called under GFP_FS, you can just return 0 for removing pointless
ashmem_shrink_scan calling. But it might be trivial so up to you. :)

> 
> The problem is not that there is a deadlock that occurs, the problem
> that even when we're not under FS, lockdep reports an issue that can't
> happen. The fix is for the lockdep false positive that occurs.

Yub, you are right. I am happy to add

Reviewed-by: Minchan Kim <minchan@kernel.org?

Other than that, I thought a while we could make it in generic so we
can add SHRINKER_FS_AWARE like that so VM code itself can do for
preventing such false positive instead of doing it in each driver
itself.

However, if driver can do by itself, it could be more flexible.
Also, at this moment, my suggestion would be also overengineering so
I'm not against you. 

Thanks!
