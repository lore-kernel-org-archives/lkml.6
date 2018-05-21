Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeEUHNT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:13:19 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:40392 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeEUHNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:13:18 -0400
From: Richard Weinberger <richard@nod.at>
To: Stefan Schaeckeler <sschaeck@cisco.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: mtdoops: optionally dump boottime
Date: Mon, 21 May 2018 09:13:09 +0200
Message-ID: <5252756.S0IrdeWEj0@blindfold>
In-Reply-To: <20180521022924.GA33758@sjc-ads-587.cisco.com>
References: <20180521022924.GA33758@sjc-ads-587.cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan,

Am Montag, 21. Mai 2018, 04:29:24 CEST schrieb Stefan Schaeckeler:
> Hello Richard and others,
> 
> > I get the use-case, but why is this only for mtdoops?
> 
> Powerpc's nvram module also stores oops messages and does so by adding an
> additional timestamp, as well (search for kmsg_dump_get_buffer() in
> arch/powerpc/kernel/nvram_64.c).

Just one more reason to make it generic.
 
> This timestamp is the number of seconds since 1970 and stored as a 64 bit
> integer in the nvram header. Basically, the last kmesg timestamp is a few ms
> less than this additionally stored timestamp. Recording boottime would be more
> elegant, I guess.
> 
> 
> > IMHO this needs to go into generic code such that all kmsg dumpers can
> > benefit from it.
> 
> This would be not that easy:
> 
> #1 kmsg_dump_get_buffer(...size...) returns the most recent <size> bytes.
> Consecutive calls return older chunks. It would be natural to return the
> boottime as the first line, e.g. in the last call, but some clients such as
> mtdoops call kmsg_dump_get_buffer() only once. The returned buffer may be
> complete including boottime, or not.
> 
> #2 consistency with other clients: nvram_64.c has the same requirement of
> storing a kind of wall-time but does it in a completely different way: no
> readable ascii text timestamp preprended to the kmsg buffer but a 64 bit
> timestamp in its header. Note, I don't think we should make mtdoops behave like
> nvram_64.c by storing the timestamp as a 64 bit integer (in its header) b/c
> most people do a cat or string of the mtd device /dev/mtdX and a 64 bit integer
> would just read as garbage.

I think this is the perfect opportunity to talk with other kmesg dump users on
how to add a timestamp.
As last resort we can always do it in our own way but I think making it generic
is at lest worth a try...

> I hope we can have separate implementations for recording additional
> timestamps. Later, I'll send a patch with stylistic changes unless we
> completely disagree on how to move forward.

Both #1 and #2 aren't show-stoppers.

Thanks,
//richard
