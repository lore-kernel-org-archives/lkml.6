Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40282ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66382084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66382084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeGTGDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:03:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40994 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeGTGDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:03:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6B46228E40;
        Fri, 20 Jul 2018 01:17:25 -0400 (EDT)
Date:   Fri, 20 Jul 2018 15:17:28 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: m68k allmodconfig build errors
In-Reply-To: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
Message-ID: <alpine.LNX.2.21.1807201454590.8@nippy.intranet>
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, Randy Dunlap wrote:

> Hi Geert,
> 
> I am seeing a few errors when cross-building m68k on x86_64, using the 
> toolchain at https://mirrors.edge.kernel.org/pub/tools/crosstool/ 
> (thanks, Arnd). (so this is gcc 8.1.0)
> 
> block/partitions/ldm.o: In function `ldm_partition':
> ldm.c:(.text+0x1900): undefined reference to `strcmp'
> ldm.c:(.text+0x1964): undefined reference to `strcmp'
> drivers/rtc/rtc-proc.o: In function `is_rtc_hctosys':
> rtc-proc.c:(.text+0x290): undefined reference to `strcmp'
> drivers/watchdog/watchdog_pretimeout.o: In function `watchdog_register_governor':
> (.text+0x142): undefined reference to `strcmp'
> 
> 
> Adding #include <linux/string.h> does not help.
> 
> Is this a toolchain problem or drivers or something else?
> 

This gcc build was apparently configured like so:

/home/arnd/git/gcc/configure --target=m68k-linux --enable-targets=all 
--prefix=/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/m68k-linux 
--enable-languages=c --without-headers --disable-bootstrap --disable-nls 
--disable-threads --disable-shared --disable-libmudflap --disable-libssp 
--disable-libgomp --disable-decimal-float --disable-libquadmath 
--disable-libatomic --disable-libcc1 --disable-libmpx 
--enable-checking=release

In my own cross toolchain builds strcmp comes from glibc but this 
toolchain has no libc at all.

> help?
> 

Linux will use the strcmp in lib/string.c unless __HAVE_ARCH_STRCMP is 
defined in the arch headers. Grep suggests that m68k, mips, x86, xtensa, 
arc, sh, arm64, s390 all define that macro. But maybe you could just patch 
out that definition for build testing.

-- 

> thanks,
> 
