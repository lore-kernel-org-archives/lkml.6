Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeBBUNz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:13:55 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46523 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751589AbeBBUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:13:46 -0500
X-ME-Sender: <xms:ecZ0Ws0ItQ62BeqNib6lYjaAGQVbIQJBxOaZv6pFm_fidGidR_qdow>
Date: Sat, 3 Feb 2018 07:13:41 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] leaking_addresses.pl changes for 4.16-rc1
Message-ID: <20180202201341.GI29988@eros>
References: <20180131024236.GA31627@eros>
 <20180201204522.GD29988@eros>
 <CA+55aFzG_KLCdZVb-qEC0786A3OK=tG-FFNzkMZC6dRtvn4uUw@mail.gmail.com>
 <20180202094810.GG29988@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202094810.GG29988@eros>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 08:48:10PM +1100, Tobin C. Harding wrote:
> On Thu, Feb 01, 2018 at 02:43:28PM -0800, Linus Torvalds wrote:
> > On Thu, Feb 1, 2018 at 12:45 PM, Tobin C. Harding <me@tobin.cc> wrote:
> > >
> > > It has just come to my attention that I should have pushed these changes
> > > to Linux next before requesting you to pull them.  Please feel free to
> > > drop this request, I can try again next merge window after going through
> > > linux next.
> > 
> > For something like this, I don't think it's a big deal.
> > 
> > A bigger deal is that it now wants perl-bigint, as of commit
> > 8d8a77fb99bd ("leaking_addresses: add range check for vsyscall
> > memory").
> > 
> > And that is not apparently a common enough perl module to be installed
> > by default.
> > 
> > Sure, I just ran
> > 
> >     dnf install 'perl(bigint)'
> > 
> > and it did the right thing, but it does seem to be something of an
> > inconvenience.
> 
> ok I'll try and find a work around so as not to use that.
> 
> > And things are *slow*, to the point of breakage. I get
> > 
> >   timed out parsing: /proc/kallsyms
> >   timed out parsing: /proc/2177/smaps
> >   timed out parsing: /proc/2238/smaps
> >   timed out parsing: /proc/2336/smaps
> >   ...
> 
> TL;DR it's working just not behaving very well.
> 
> I knew that was an issue, I've been running tests with 'smaps' included
> in the skip files array.  However the patch I submitted to add this
> included skipping /proc/kallsysms.  This got nacked.  I could not come
> up with a _good_ solution before doing the pull request and thought it
> better to have the 32-bit stuff in in light of all the drama this last
> month.  The problem is that timeouts were added to catch binary files
> choking the script but the default is too slow for large ASCII files.
> Also we don't have a way to say 'scan this file once but not in every
> processes sub directory' i.e smaps.  I needed feedback on this since I'm
> not totally sure that all smaps files are generated the same.  Also I
> think there may be a better way to not pass binary files than using the
> timeout.

oops, the timeout was to catch files that block on read (like /proc/kmsg).

So, adding 'smaps' to @skip_parse_files_any makes it run but I am unsure
if this is correct.  I am under the impression that there will be
various files that need skipping once the script is run on other peoples
setups.


thanks,
Tobin.
