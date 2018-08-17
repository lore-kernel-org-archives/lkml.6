Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08F21A1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A08F21A1D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeHQVCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:02:45 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:47202 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:02:45 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fqj0M-0006Wj-W3; Fri, 17 Aug 2018 19:57:47 +0200
Date:   Fri, 17 Aug 2018 19:57:46 +0200
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
Message-ID: <20180817175746.d2brxipp7xa4y2uw@angband.pl>
References: <20180322012943.4145794-1-terrelln@fb.com>
 <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
 <20180817165403.GC12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180817165403.GC12066@tassilo.jf.intel.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 09:54:03AM -0700, Andi Kleen wrote:
> On Fri, Aug 17, 2018 at 06:15:45PM +0200, René Rebe wrote:
> > Hey,
> > 
> > is there any mainline future for this zstd support?
> > Currently my most favourite compressor for this, and for what it’s worth
> > zstd/initrd now even tested on #t2sde / hp/pa-risc
> 
> Can you remove some other compressor for the kernel image if you merge this?

Funny you say this.  I want to post this after the merge window is over:
https://github.com/kilobyte/linux/commits/nobz2-next-20180731

Sorry for a tree atop next, but there are conflicts that needed to be
adressed.  The patchset is also undertested (works for me, but not even
compile-tested on archs I don't have a toolchain for at hand).

> The "favourite compressor" seems to roughly change every year, so if
> we keep adding new ones things will get more and more convoluted.

The above patchset drops just bzip2.  It is the only one that's strictly
beaten in every way (ratio, time, memory usage), there are also no other
uses of bzip2 anywhere in the kernel so we'd get to drop its code
completely: 900 lines of Linus' happiness.

Other candidates are lzo and bare lzma (you want lz4, zstd or xz instead),
but those are used elsewhere thus there's hardly any gain.  If you want them
gone, please say so -- I'll include their droppage.

> Surely zstd is universally better than some existing compressor
> the kernel already uses for itself for a particular sweet spot?
> If it isn't it's likely not needed.

zstd is better in the balanced niche: unless you want extreme speed (lz4) or
best compression (xz), zstd handily beats algorithms in the middle.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ What Would Jesus Do, MUD/MMORPG edition:
⣾⠁⢰⠒⠀⣿⡁ • multiplay with an admin char to benefit your mortal [Mt3:16-17]
⢿⡄⠘⠷⠚⠋⠀ • abuse item cloning bugs [Mt14:17-20, Mt15:34-37]
⠈⠳⣄⠀⠀⠀⠀ • use glitches to walk on water [Mt14:25-26]
