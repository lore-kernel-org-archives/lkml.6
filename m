Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeDTT51 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:57:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeDTT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:57:25 -0400
Date: Fri, 20 Apr 2018 12:57:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs fixes
Message-Id: <20180420125724.28c218907de8ab805beba3f3@linux-foundation.org>
In-Reply-To: <20180420190956.GP30522@ZenIV.linux.org.uk>
References: <20180420155846.GO30522@ZenIV.linux.org.uk>
        <20180420112945.98686d9c78121bdc1e93483a@linux-foundation.org>
        <20180420190956.GP30522@ZenIV.linux.org.uk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 20:09:56 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Fri, Apr 20, 2018 at 11:29:45AM -0700, Andrew Morton wrote:
> > On Fri, 20 Apr 2018 16:58:46 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
> > 
> > > 	Assorted fixes.  Some of that is only a matter with fault injection
> > > (broken handling of small allocation failure in various mount-related places),
> > > but the last one is a root-triggerable stack overflow, and combined with
> > > userns it gets really nasty ;-/
> > > 
> > > The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> > > 
> > >   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-linus
> > > 
> > > for you to fetch changes up to 16a34adb9392b2fe4195267475ab5b472e55292c:
> > > 
> > >   Don't leak MNT_INTERNAL away from internal mounts (2018-04-19 23:52:15 -0400)
> > > ...
> > >
> > > Tetsuo Handa (1):
> > >       mm,vmscan: Allow preallocating memory for register_shrinker().
> > 
> > Confused.  You had a bunch of issues with this patch
> > (http://lkml.kernel.org/r/20180411005938.GN30522@ZenIV.linux.org.uk)
> > and Tetsuo sent out a v2 but now we've merged the v1.  Deliberate?
> 
> I think by that time I'd applied v1 and fixed those issues myself (same as his
> variant, modulo slightly different names).

AH.

> > Also, it would be nice if you could get the Link: thing working in your
> > commits please - this one took a bit of hunting down.
> 
> *blink*
> 
> What Link: thing?  You mean lkml.kernel.org references to original postings?

yup.  It's often fairly useful.

> Or is it something else?  Never done that, actually; any tips re tools needed
> for that?  Normally it's save a bunch of postings into a local file in mutt,
> scp it over to development box, then git am -s - either all at once, or step
> by step with ediiting and git commit --amend in between...

I'd have expected git-am to have a way of doing that by now.

> I realize that message-id can be picked and massaged into Link: ... form,
> of course, but I'd rather not reinvent the wheel if it's already done by
> somebody...

I just do this:

message_url()
{
	pname="$1"

	idline=$(grep -i "^Message-Id:" "$pname" | head -1)
	if [ x"$idline" != "x" ]
	then
		msgid=$(echo "$idline" | sed -e 's/[^<]*<\([^>]*\).*/\1/')
		if [ x"$msgid" != "x" ]
		then
			echo "http://lkml.kernel.org/r/$msgid"
		fi
	fi
}
