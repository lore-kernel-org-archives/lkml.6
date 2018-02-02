Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeBBJsU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:48:20 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37207 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750773AbeBBJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:48:15 -0500
X-ME-Sender: <xms:3jN0WvYC3VpwIxIhi42tw4hFRkUv03WiVbzI_Bcgl8zLxJjcNzV61A>
Date: Fri, 2 Feb 2018 20:48:10 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] leaking_addresses.pl changes for 4.16-rc1
Message-ID: <20180202094810.GG29988@eros>
References: <20180131024236.GA31627@eros>
 <20180201204522.GD29988@eros>
 <CA+55aFzG_KLCdZVb-qEC0786A3OK=tG-FFNzkMZC6dRtvn4uUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzG_KLCdZVb-qEC0786A3OK=tG-FFNzkMZC6dRtvn4uUw@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 02:43:28PM -0800, Linus Torvalds wrote:
> On Thu, Feb 1, 2018 at 12:45 PM, Tobin C. Harding <me@tobin.cc> wrote:
> >
> > It has just come to my attention that I should have pushed these changes
> > to Linux next before requesting you to pull them.  Please feel free to
> > drop this request, I can try again next merge window after going through
> > linux next.
> 
> For something like this, I don't think it's a big deal.
> 
> A bigger deal is that it now wants perl-bigint, as of commit
> 8d8a77fb99bd ("leaking_addresses: add range check for vsyscall
> memory").
> 
> And that is not apparently a common enough perl module to be installed
> by default.
> 
> Sure, I just ran
> 
>     dnf install 'perl(bigint)'
> 
> and it did the right thing, but it does seem to be something of an
> inconvenience.

ok I'll try and find a work around so as not to use that.

> And things are *slow*, to the point of breakage. I get
> 
>   timed out parsing: /proc/kallsyms
>   timed out parsing: /proc/2177/smaps
>   timed out parsing: /proc/2238/smaps
>   timed out parsing: /proc/2336/smaps
>   ...

TL;DR it's working just not behaving very well.

I knew that was an issue, I've been running tests with 'smaps' included
in the skip files array.  However the patch I submitted to add this
included skipping /proc/kallsysms.  This got nacked.  I could not come
up with a _good_ solution before doing the pull request and thought it
better to have the 32-bit stuff in in light of all the drama this last
month.  The problem is that timeouts were added to catch binary files
choking the script but the default is too slow for large ASCII files.
Also we don't have a way to say 'scan this file once but not in every
processes sub directory' i.e smaps.  I needed feedback on this since I'm
not totally sure that all smaps files are generated the same.  Also I
think there may be a better way to not pass binary files than using the
timeout.

> and no actual output. I'm not sure what's up with that, and whether
> it's related. Probably not, but I didn't start bisecting.

No output is good - it means no leaks, though I'm still getting a bunch
from dmesg on the 3 machines I tested on.

> So I pulled it but then unpulled it due to issues during testing.

If it is not super important to have 32-bit scanning available then I'd
just as well see this wait until next merge window and getting it
running better.  In hindsight all of this should probably been in the
pull request message.

thanks for taking the time on this.

	Tobin
