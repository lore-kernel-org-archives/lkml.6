Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6808C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5569121536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5569121536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeHQXMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:12:46 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:58450 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeHQXMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:12:46 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fql2B-0007L2-I0; Fri, 17 Aug 2018 22:07:47 +0200
Date:   Fri, 17 Aug 2018 22:07:47 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>,
        Nick Terrell <terrelln@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Message-ID: <20180817200747.bzmsl5nfwewyksvg@angband.pl>
References: <20180322012943.4145794-1-terrelln@fb.com>
 <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
 <20180817165403.GC12066@tassilo.jf.intel.com>
 <20180817175746.d2brxipp7xa4y2uw@angband.pl>
 <20180817192244.GF12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180817192244.GF12066@tassilo.jf.intel.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:22:44PM -0700, Andi Kleen wrote:
> On Fri, Aug 17, 2018 at 07:57:46PM +0200, Adam Borowski wrote:
> > > The "favourite compressor" seems to roughly change every year, so if
> > > we keep adding new ones things will get more and more convoluted.
> > 
> > The above patchset drops just bzip2.  It is the only one that's strictly
> > beaten in every way (ratio, time, memory usage), there are also no other
> 
> Does time include build time? I've been reverting back to gzip recently
> because I care very much about that.

Too lazy to benchmark a kernel image (IIRC Nick Terrell posted that a while
ago), here's copypasta of a random 16824672 byte executable, in userspace,
with default level setting:

	comp	decomp	size
xz	8.038s	0.356s	4320292
bz2	2.265s	0.730s	5234516
zst	0.274s	0.102s	5657626
gz	0.880s	0.152s	6515505
Z	0.499s	0.133s	8932459
lzo	0.100s	0.095s	9198874

As you can see, zstd's compression time is drastically better than gzip,
while ratio is better.  The default level is very low (-3 on -1..-22 scale)
but you can crank it up for stronger compression.

The defaults fit your use case.

> > uses of bzip2 anywhere in the kernel so we'd get to drop its code
> > completely: 900 lines of Linus' happiness.
> 
> Great!
> 
> > Other candidates are lzo and bare lzma (you want lz4, zstd or xz instead),
> > but those are used elsewhere thus there's hardly any gain.  If you want them
> > gone, please say so -- I'll include their droppage.
> 
> Yes would be good to remove the kernel image support for those too
> just to simplify the config process, even if it doesn't save much code.

There's one caveat: fast choices are quite new:
* lz4 userspace tools are not even in current Debian stable (just unstable)
* uncompressed kernel got in only this merge window
* zstd has userspace tools in Debian stable but is not merged into the
  kernel yet
(other dists are probably similar)

Thus, it might be a good idea to keep lzo for a while longer.

Bare lzma can probably go -- xz filters are nice for binaries of archs it
knows (disabled otherwise), and lack of header requires hacks to find out
the payload's size.

So it's up to you guys: do you want me to drop lzo and/or lzma?
We can also drop them just for vmlinuz but not initrd.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ What Would Jesus Do, MUD/MMORPG edition:
⣾⠁⢰⠒⠀⣿⡁ • multiplay with an admin char to benefit your mortal [Mt3:16-17]
⢿⡄⠘⠷⠚⠋⠀ • abuse item cloning bugs [Mt14:17-20, Mt15:34-37]
⠈⠳⣄⠀⠀⠀⠀ • use glitches to walk on water [Mt14:25-26]
