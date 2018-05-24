Return-Path: <jack@suse.cz>
X-Google-Smtp-Source: AB8JxZod8FlgPvKiwGwZRih/R1Jc0G1A0Qalf34eeTdoVEXFnmJSFF7P9Zem+uU379L88IMpC8sS
ARC-Seal: i=1; a=rsa-sha256; t=1527163358; cv=none;
        d=google.com; s=arc-20160816;
        b=b8tY5k/XQBfZfw4UYnoGEDKZgs8LV6oWOtTiLsbQkqSnmC0OyoyyTx1Lcd/05/slhr
         7wAwdKdgIfJ5pNVbwftUEsAEs/lQRWaR3UlIE/t3nqhT7cLaLWCjqgj+N5l1inFuKc5n
         VjtX/MogsvkBf/Jqdpw/EoJ6aQV3avFiz7xyNY//OEAZDlyNLRMb3b4qv3y7KrC3e+ET
         IeGhBczkLJ+h2RMX7ds+4azzVvLAX4iSDXX/a+hZtDg766uVyWAqLT/5HrGHjJc/9GVU
         IgkEDnRTVDNU1UmTkYX+dnHXt2YFLI2v6ErWOBXzwvsY7DPuk5ds1xzqeNw7dH9vaHFU
         4mYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XVeyKVD7c1jF/OLms2L+nC9rfe79yaGx/OdS4eh5yQg=;
        b=P1/rtfAykqF1P7dSJgPRjO/YiBmZnaCm8vgr/m7lZVr7VWDaEVPAIBr6jlHdhRCT5E
         0e5P0IUreFGNSnc/cQ3GJ6ZJfizbCaELxk5hLPQWvXd8ziXk+6CQRSfg8prirYXIw0I3
         nptY8VrsZ6eFTotT36os2fyWtlWnM4TYpRbnMFxCmcrmwuHCEOM3IHDhWkBAmBvSqYpe
         FvN6vttY4uupVurLHdx5wyrth+kqYlVgXRMZitG1bW4q+/TAM11U+zpMig1/OzElvf3C
         dfdwTD9+T4g+3oK4Z/la/uBRq0XWNhTszjZjcXJ5hhxcBKH6tkR0XpgENZSnHwMpgJn9
         2dLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Date: Thu, 24 May 2018 14:02:37 +0200
From: Jan Kara <jack@suse.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4.4 50/92] mm: filemap: avoid unnecessary calls to
 lock_page when waiting for IO to complete during a read
Message-ID: <20180524120237.25y5dqpuvdufwiam@quack2.suse.cz>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524093204.290399449@linuxfoundation.org>
 <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz>
 <20180524110546.GA16171@kroah.com>
 <CANsGZ6bsz-J9XB_O5+B+mmRV2CGaJ8e+Aa=N3WnE7YNARWsAnw@mail.gmail.com>
 <20180524112841.GA17626@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524112841.GA17626@kroah.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338268833986557?=
X-GMAIL-MSGID: =?utf-8?q?1601346845596346481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 24-05-18 13:28:41, Greg KH wrote:
> On Thu, May 24, 2018 at 04:17:12AM -0700, Hugh Dickins wrote:
> >   Thu, May 24, 2018 at 4:06 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > wrote:
> > 
> > > On Thu, May 24, 2018 at 12:50:11PM +0200, Jan Kara wrote:
> > > > On Thu 24-05-18 11:38:27, Greg Kroah-Hartman wrote:
> > > > > 4.4-stable review patch.  If anyone has any objections, please let me
> > know.
> > > >
> > > > Just one objection: Why does stable care about this (and the previous
> > > > patch)? I've checked the stable queue and I don't see anything that
> > would
> > > > have these patches as a prerequisite. And on their own, they are only
> > > > cleanups without substantial gains.
> > 
> > > There's a small gain here:
> > 
> > > > > paralleldd
> > > > >                                     4.4.0                 4.4.0
> > > > >                                   vanilla             avoidlock
> > > > > Amean    Elapsd-1          5.28 (  0.00%)        5.15 (  2.50%)
> > > > > Amean    Elapsd-4          5.29 (  0.00%)        5.17 (  2.12%)
> > > > > Amean    Elapsd-7          5.28 (  0.00%)        5.18 (  1.78%)
> > > > > Amean    Elapsd-12         5.20 (  0.00%)        5.33 ( -2.50%)
> > > > > Amean    Elapsd-21         5.14 (  0.00%)        5.21 ( -1.41%)
> > > > > Amean    Elapsd-30         5.30 (  0.00%)        5.12 (  3.38%)
> > > > > Amean    Elapsd-48         5.78 (  0.00%)        5.42 (  6.21%)
> > > > > Amean    Elapsd-79         6.78 (  0.00%)        6.62 (  2.46%)
> > > > > Amean    Elapsd-110        9.09 (  0.00%)        8.99 (  1.15%)
> > > > > Amean    Elapsd-128       10.60 (  0.00%)       10.43 (  1.66%)
> > > > >
> > > > > The impact is small but intuitively, it makes sense to avoid
> > unnecessary
> > > > > calls to lock_page.
> > 
> > > Yes, it's small, but it's marked in the SLES kernel as "needs to be
> > > merged into stable", so obviously it matters to someone :)
> > 
> > Hmm. I had the same reaction to these two as Jan, but assumed that they
> > made applying later patches easier, and didn't take the trouble he did to
> > find that's not so.
> > 
> > I've no wish to be disputatious, but it does seem that the definition of
> > "stable" has changed, and not necessarily for the better, if it's now a
> > home for small gains: I thought we left those to upstream.
> 
> This is in the SLES kernel for a reason, and again, it's in the section
> that says "this should be pushed to stable".  So if it's good enough for
> the SLES kernel, why isn't it good enough for all users of this kernel
> tree?

Heh, fair enough. I guess Mel in the end didn't find patches worthy enough
to be pushed to stable tree. But at least now I know they are well tested
with 4.4 base so they should do no harm in the stable tree so my stance is
closer to neutral.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
