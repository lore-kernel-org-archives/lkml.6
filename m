Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeDGRTL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 13:19:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60792 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeDGRTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 13:19:09 -0400
Date: Sat, 7 Apr 2018 18:19:06 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/20] afs: Fixes and development
Message-ID: <20180407171906.GB30522@ZenIV.linux.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
 <CA+55aFxtS1jyefWXG+H6UjfC5KaqPOgTf3imHxL1iS1avJP5Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxtS1jyefWXG+H6UjfC5KaqPOgTf3imHxL1iS1avJP5Lw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 09:50:05AM -0700, Linus Torvalds wrote:
> On Thu, Apr 5, 2018 at 1:29 PM, David Howells <dhowells@redhat.com> wrote:
> >>
> > Here are a set of AFS patches, a few fixes, but mostly development.  The fixes
> > are:
> 
> So I pulled this after your updated fscache pull request, and I notice
> that these three commits are duplicate (not shared):
> 
>       fscache: Attach the index key and aux data to the cookie
>       fscache: Pass object size in rather than calling back for it
>       fscache: Maintain a catalogue of allocated cookies
> 
> and partly as a result I get some trivial conflicts.
> 
> Now, the conflicts really do look entirely trivial, and that's not the
> problem, but the fact that you *didn't* re-send the AFS pull request
> makes me wonder if you perhaps didn't want me to pull it after all?
> 
> So I decided to not do the resolution, and instead just verify with
> you that you still want this pulled?
> 
> No need to rebase, no need to do anything at all, really, except reply
> with "yes I want you to pull this" or "no, the fscache pull updates
> meant that I want you to do something else, hold off".
> 
> Pls advice.
> 
> (I may decide later to pull anyway, because I *think* you want me to
> pull, but thought to ask in case you're online and answer quickly).

FWIW, the main problem I see in there is the use of lookup_one_len()
with parent locked only shared.  As it is, that's simply broken -
lookup of full name happening at the same time will bugger the
things badly.

I have a series that lowers requirements to "parent must be held at
least shared" (see vfs.git#work.dcache) and it seems to be working.
With that series the locking problem goes away; however, the use of
dget_parent() around that lookup_one_len() call is pointless -
->lookup() is guaranteed that
	* dentry->d_parent is stable at least until dentry becomes
positive.  Dentry it originally pointed to remains pinned and positive
through the entire call of ->lookup(); 'dir' argument of ->lookup()
is the inode of that dentry.
	* dentry->d_name is stable at least until it becomes positive.
	* dir remains locked at least shared through the entire call
of ->lookup().

All ->lookup() instances rely upon that and there's no need to
play silly buggers with careful grabbing a reference to dentry->d_parent.
That, of course, can be dealt with after merge, but since that commit
has to be at least rebased to avoid bisection hazard... might as well
get rid of dget_parent() there at the same time.
