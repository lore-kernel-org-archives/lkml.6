Return-Path: <hughd@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527160660; cv=none;
        d=google.com; s=arc-20160816;
        b=aAy7OEarNZ5dR1Z4P01ormqXkIzuLEs+cgKABDcqukOY+5idH6IgJnUy2eGK5dpOu/
         puOpEYbYRo9+B9UNp6tLHd1sTs5x9cCqjIc5JDpt7paXemenkP6/TMcxoBQoxR23CF8X
         Ops4FNj+HcJiqQMUaUMCC0MZlloyKTMspzbCxtZvuT+blgzyWAJr/Xtr7yVWSqdFhewQ
         SnbRn2CSfRy+Wexf9Qre2d0vWlAhDzamNV5Z0N1re/PYmsqhwO5cM9CJTau67ttDIcYO
         x10YKT30jlAuK/r9cvkRcPA7FoOaDs3bG0W/Gj3Oplqi99vkFZN24mXTQr2WPoW05h+f
         3Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eG1SEb/QII5Y7xlCsH3B4DYgXflVvM8sfXcbJ7pwlBM=;
        b=HEsI5MZq3Oy6F0cW61EVmlf9EcU8t9y+g4oA/6GmYcFo283j9HkNU5VZsgmyjxV7rf
         efc6I/jylJiAkOFEzh6ywKFsXREXsbnhlYbrMlP5MSGHBF6UYeSNHhuwIE5/bMpSxHnN
         cMp8536ntL976gUXuIK6b7FH4RlPuaJrTFeO0xTXxtipX2K+IDK4PZNbOyn8FRlsz9/M
         O+a0e1ddFEyJldJCIEzXPbAbDfGdK58a4CzR+vxXiLw8/y/yMBinzBZT2iWoEd0DFi58
         PXi3/EWECkVsC0gDeY2kcnx0rwLg5gFNyqVGjEoU89GzOW3+a87mzpY9mKExSOZq0fQ4
         vBUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YdSwTkOd;
       spf=pass (google.com: domain of hughd@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hughd@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YdSwTkOd;
       spf=pass (google.com: domain of hughd@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hughd@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: ADUXVKI4QKA5+Ww3p1NBGmvSJJCKv+Lqwj0KU+h0xdStl+oGBNtxso3RHRTrR/DPoD1CooM74wYlFYnYakBELD/l5+U=
MIME-Version: 1.0
References: <20180524093159.286472249@linuxfoundation.org> <20180524093204.290399449@linuxfoundation.org>
 <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz> <20180524110546.GA16171@kroah.com>
In-Reply-To: <20180524110546.GA16171@kroah.com>
From: Hugh Dickins <hughd@google.com>
Date: Thu, 24 May 2018 04:17:12 -0700
Message-ID: <CANsGZ6bsz-J9XB_O5+B+mmRV2CGaJ8e+Aa=N3WnE7YNARWsAnw@mail.gmail.com>
Subject: Re: [PATCH 4.4 50/92] mm: filemap: avoid unnecessary calls to
 lock_page when waiting for IO to complete during a read
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338268833986557?=
X-GMAIL-MSGID: =?utf-8?q?1601344016267254400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  Thu, May 24, 2018 at 4:06 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org>
wrote:

> On Thu, May 24, 2018 at 12:50:11PM +0200, Jan Kara wrote:
> > On Thu 24-05-18 11:38:27, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me
know.
> >
> > Just one objection: Why does stable care about this (and the previous
> > patch)? I've checked the stable queue and I don't see anything that
would
> > have these patches as a prerequisite. And on their own, they are only
> > cleanups without substantial gains.

> There's a small gain here:

> > > paralleldd
> > >                                     4.4.0                 4.4.0
> > >                                   vanilla             avoidlock
> > > Amean    Elapsd-1          5.28 (  0.00%)        5.15 (  2.50%)
> > > Amean    Elapsd-4          5.29 (  0.00%)        5.17 (  2.12%)
> > > Amean    Elapsd-7          5.28 (  0.00%)        5.18 (  1.78%)
> > > Amean    Elapsd-12         5.20 (  0.00%)        5.33 ( -2.50%)
> > > Amean    Elapsd-21         5.14 (  0.00%)        5.21 ( -1.41%)
> > > Amean    Elapsd-30         5.30 (  0.00%)        5.12 (  3.38%)
> > > Amean    Elapsd-48         5.78 (  0.00%)        5.42 (  6.21%)
> > > Amean    Elapsd-79         6.78 (  0.00%)        6.62 (  2.46%)
> > > Amean    Elapsd-110        9.09 (  0.00%)        8.99 (  1.15%)
> > > Amean    Elapsd-128       10.60 (  0.00%)       10.43 (  1.66%)
> > >
> > > The impact is small but intuitively, it makes sense to avoid
unnecessary
> > > calls to lock_page.

> Yes, it's small, but it's marked in the SLES kernel as "needs to be
> merged into stable", so obviously it matters to someone :)

Hmm. I had the same reaction to these two as Jan, but assumed that they
made applying later patches easier, and didn't take the trouble he did to
find that's not so.

I've no wish to be disputatious, but it does seem that the definition of
"stable" has changed, and not necessarily for the better, if it's now a
home for small gains: I thought we left those to upstream.

Hugh
