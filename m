Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeDMVOd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:14:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeDMVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:14:32 -0400
Date: Fri, 13 Apr 2018 14:14:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Khazhismel Kumykov <khazhy@google.com>
Cc: nborisov@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in
 shrink_dcache_parent()
Message-Id: <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
In-Reply-To: <20180413202823.204377-1-khazhy@google.com>
References: <20180413181350.88831-1-khazhy@google.com>
        <20180413202823.204377-1-khazhy@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2018 13:28:23 -0700 Khazhismel Kumykov <khazhy@google.com> wrote:

> shrink_dcache_parent may spin waiting for a parallel shrink_dentry_list.
> In this case we may have 0 dentries to dispose, so we will never
> schedule out while waiting for the parallel shrink_dentry_list to
> complete.
> 
> Tested that this fixes syzbot reports of stalls in shrink_dcache_parent()

Well I guess the patch is OK as a stopgap, but things seem fairly
messed up in there.  shrink_dcache_parent() shouldn't be doing a
busywait, waiting for the concurrent shrink_dentry_list().

Either we should be waiting (sleeping) for the concurrent operation to
complete or we should just bail out of shrink_dcache_parent(), perhaps
with 

	if (list_empty(&data.dispose))
		break;

or similar.  Dunno.


That block comment over `struct select_data' is not a good one.  "It
returns zero iff...".  *What* returns zero?  select_collect()?  No it
doesn't, it returns an `enum d_walk_ret'.  Perhaps the comment is
trying to refer to select_data.found.  And the real interpretation of
select_data.found is, umm, hard to describe.  "Counts the number of
dentries which are on a shrink list or which were moved to the dispose
list".  Why?  What's that all about?

This code needs a bit of thought, documentation and perhaps a redo,
I suspect.
