Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeEUCmh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:42:37 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:57644 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeEUCmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:42:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ASAgDYLgJb/4kNJK1aGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYNDgV6ZGIF5dRqVLguEbIITITcVAQIBAQEBAQECbCiFKgQ7PwU?=
 =?us-ascii?q?WITQFGDGFKQUHAad+iD2CD4g1gVQ/gQ+BdmE1iCOCJAKNBItICY5MgUKGTIR?=
 =?us-ascii?q?6kHeBJTIigVJwFYJ/ghwajjeQcwEB?=
X-IronPort-AV: E=Sophos;i="5.49,425,1520899200";
   d="scan'208";a="398384548"
Date: Sun, 20 May 2018 19:29:24 -0700
From: Stefan Schaeckeler <sschaeck@cisco.com>
To: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: mtdoops: optionally dump boottime
Message-ID: <20180521022924.GA33758@sjc-ads-587.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard and others,

> I get the use-case, but why is this only for mtdoops?

Powerpc's nvram module also stores oops messages and does so by adding an
additional timestamp, as well (search for kmsg_dump_get_buffer() in
arch/powerpc/kernel/nvram_64.c).

This timestamp is the number of seconds since 1970 and stored as a 64 bit
integer in the nvram header. Basically, the last kmesg timestamp is a few ms
less than this additionally stored timestamp. Recording boottime would be more
elegant, I guess.


> IMHO this needs to go into generic code such that all kmsg dumpers can
> benefit from it.

This would be not that easy:

#1 kmsg_dump_get_buffer(...size...) returns the most recent <size> bytes.
Consecutive calls return older chunks. It would be natural to return the
boottime as the first line, e.g. in the last call, but some clients such as
mtdoops call kmsg_dump_get_buffer() only once. The returned buffer may be
complete including boottime, or not.

#2 consistency with other clients: nvram_64.c has the same requirement of
storing a kind of wall-time but does it in a completely different way: no
readable ascii text timestamp preprended to the kmsg buffer but a 64 bit
timestamp in its header. Note, I don't think we should make mtdoops behave like
nvram_64.c by storing the timestamp as a 64 bit integer (in its header) b/c
most people do a cat or string of the mtd device /dev/mtdX and a 64 bit integer
would just read as garbage.

I hope we can have separate implementations for recording additional
timestamps. Later, I'll send a patch with stylistic changes unless we
completely disagree on how to move forward.

 Stefan
