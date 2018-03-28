Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522263011; cv=none;
        d=google.com; s=arc-20160816;
        b=kvpStxfsfx1zk3yec+IpEkstyIW6+UK3EhRi20Mfi66SVp1Pazy8pcb0GSeRGpbPjL
         DNSooGYFCNp5Fq01W3HapFYh01mbaR5SebC1n4o0v4HpkGtifc5rztnMdMH2ErkhfCq7
         GdsJEDGZ5ifcRMpZkN4iQKKpshPiX7/ni7ToKe80ne7ufctrCP8e6UyFcfHfHY/7SGsp
         krRCZc7U2gDRlwBGkBsyAtmrRCiVa1GMab1Qm88Kjy4hMprBk2qiSV2qLNPlJqSF14rb
         R7vy6ttfh5FsdyLY++kJeua2JzxXBqGXR1yzuN+d4RrZK/nX6JS/QnAgcOI03QUDnbNA
         a9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=V3IZk5frzRtssHf5WQJWZB7sL9J0bmN4lJpenw2hKUc=;
        b=Q/zy4QTu38z50P1aiftJ2rjhh1zxxP0blMO+L/V4Gp0X4CUQF3yvsQslbg9+aXv2Gl
         BhtcwndFe+uZwYciuaxu1mpWJgQxD9Y8SbeusLBLtqy1raVGMoQdYj5mq+EcXaGL3wOF
         PffS/J1ArOXCWW2rk7WqS8NM8LrS8bGYR2fHzcugIsT7YJPgNvIIIakvdSHOqgI/UrG4
         qr6bRsyVkLt2A3ArxtCC7J/Q4+D1E5feX0nxDbYRSu1R3FzB684EwGofHm0ek4pEYFIe
         F4IHZT9UL/MDZovrt8eJ+u551sUeOdfo+bIdVh6KTpJFXZPk1IiJ7D6T4TDO5g3lMC/n
         hvTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=niS4wCaY;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=niS4wCaY;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/XTkdLK+/7042T/OWRp+PznIehijhyLroA+Ye9kUiCCgQfGXKvbM27RdR27uXtwHv391q34w==
Date: Wed, 28 Mar 2018 11:50:09 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manoj Gupta <manojgupta@chromium.org>, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for
 NULL
Message-ID: <20180328185009.GB87376@google.com>
References: <20180327235553.210165-1-mka@chromium.org>
 <20180328061616.GA8212@kroah.com>
 <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
 <20180328180556.GB32098@kroah.com>
 <20180328181456.GA87376@google.com>
 <20180328181936.GA3522@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328181936.GA3522@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596137136019067169?=
X-GMAIL-MSGID: =?utf-8?q?1596208459646688681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Wed, Mar 28, 2018 at 08:19:36PM +0200 Greg Kroah-Hartman ha dit:

> On Wed, Mar 28, 2018 at 11:14:56AM -0700, Matthias Kaehlcke wrote:
> > El Wed, Mar 28, 2018 at 08:05:56PM +0200 Greg Kroah-Hartman ha dit:
> > 
> > > 
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > > 
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > > 
> > > http://daringfireball.net/2007/07/on_top
> > > 
> > > On Wed, Mar 28, 2018 at 07:47:53AM -0700, Manoj Gupta wrote:
> > > > Please note that there is nothing wrong in the generated code, just
> > > > that it confuses objtool.
> > > 
> > > Then fix the tool, the C code is correct :)
> > > 
> > > > Clang has simply omitted the statement where NULL is returned since
> > > > the pointer was always dereferenced post inlining.
> > > 
> > > Then tell clang not to do that, like we tell gcc not to do that as that
> > > is a foolish thing for a compiler to do when building the kernel.
> > 
> > Thanks all for your input, we'll try to get
> > -fno-delete-null-pointer-checks or a similar flag to be added to
> > clang.
> 
> Wait, clang does not have that?

Nope, clang doesn't currently have such a flag.

> That's crazy, how has this not been hit yet when building the
> kernel?

IIRC this patch was needed to work around the lack of the flag:

commit beaec533fc2701a28a4d667f67c9f59c6e4e0d13
Author: Alexander Potapenko <glider@google.com>
Date:   Wed Jul 19 20:27:30 2017 +0200

    llist: clang: introduce member_address_is_nonnull()

    Currently llist_for_each_entry() and llist_for_each_entry_safe() iterate
    until &pos->member != NULL.  But when building the kernel with Clang,
    the compiler assumes &pos->member cannot be NULL if the member's offset
    is greater than 0 (which would be equivalent to the object being
    non-contiguous in memory).  Therefore the loop condition is always true,
    and the loops become infinite.

    To work around this, introduce the member_address_is_nonnull() macro,
    which casts object pointer to uintptr_t, thus letting the member pointer
    to be NULL.

    Signed-off-by: Alexander Potapenko <glider@google.com>
    Tested-by: Sodagudi Prasad <psodagud@codeaurora.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


Other than that I am not aware of any known issues.
