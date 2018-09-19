Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61ACECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C0A2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C0A2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeISSlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:41:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbeISSlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:41:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22AB487637;
        Wed, 19 Sep 2018 13:03:21 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE8019481;
        Wed, 19 Sep 2018 13:03:20 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 17062126; Wed, 19 Sep 2018 10:03:18 -0300 (BRT)
Date:   Wed, 19 Sep 2018 10:03:18 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools: Remove conflicting BITS_PER_LONG define
Message-ID: <20180919130318.GB3717@redhat.com>
References: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
 <20180912190107.GA5502@redhat.com>
 <20180912192129.GB13738@kernel.org>
 <562288b4-aac6-182a-6f75-23d32dbdcad5@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562288b4-aac6-182a-6f75-23d32dbdcad5@nokia.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 19 Sep 2018 13:03:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 19, 2018 at 02:28:29PM +0200, Alexander Sverdlin escreveu:
> On 12/09/2018 21:21, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 12, 2018 at 04:01:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Wed, Sep 12, 2018 at 07:02:32PM +0200, Alexander Sverdlin escreveu:
> >>>   CC       .../tools/objtool/builtin-check.o
> >>>   ...
> >>> In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
> >>>                  from .../tools/include/asm-generic/bitops/__ffs.h:6,
> >>>                  from .../tools/include/asm-generic/bitops.h:16,
> >>>                  from .../tools/include/linux/bitops.h:35,
> >>>                  from .../tools/include/linux/hashtable.h:13,
> >>>                  from elf.h:24,
> >>>                  from check.h:22,
> >>>                  from builtin-check.c:30:
> >>> .../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
> >>>  #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
> >>>
> >>> Include <asm/bitsperlong.h> instead as other headers do.
> >>
> >> Please try test building all tools in tools/
> >>
> >> This broke make -C tools/perf/
> > 
> > Also, where is the build of objtool failing?
> I've prepared some examples for you with "-fdirectives-only -save-temps":
> 
> This is what happens ultimately:
> 
> In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
>                  from .../tools/include/asm-generic/bitops/__ffs.h:6,
>                  from .../tools/include/asm-generic/bitops.h:16,
>                  from .../tools/include/linux/bitops.h:35,
>                  from .../tools/include/linux/hashtable.h:13,
>                  from elf.h:24,
>                  from check.h:22,
>                  from builtin-check.c:30:
> .../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
>  #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
>  
> In file included from .../tools/include/linux/hashtable.h:13:0,
>                  from elf.h:24,
>                  from check.h:22,
>                  from builtin-check.c:30:
> .../tools/include/linux/bitops.h:13:0: note: this is the location of the previous definition
>  # define BITS_PER_LONG __WORDSIZE
> 
> And this are relevant parts from builtin-check.i file:
> 
> # 1 "builtin-check.c"
> # 1 ".../tools/objtool//"
> # 1 "<built-in>"
> 
> ...
> 
> #define __SIZEOF_LONG__ 4
> 
> ...
> 
> # 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4
> 
> ...
> 
> #define __WORDSIZE 32
> 
> ...
> 
> # 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4
> 
> ...
> 
> #define __WORDSIZE 32
> 
> ...
> 
> # 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4
> 
> ...
> 
> #define __WORDSIZE 32
> 
> ...
> 
> # 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4
> 
> ...
> 
> #define __WORDSIZE 32
> 
> ...
> 
> # 1 ".../tools/include/linux/bitops.h" 1
> 
> ...
> 
> #define BITS_PER_LONG __WORDSIZE
> 
> ...
> 
> # 6 ".../tools/include/asm-generic/bitsperlong.h" 2
> 
> ...
> 
> #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
> 
> It could be that your compiler doesn't define __SIZEOF_LONG__, while my does.
> It could be that it's caused by the fact that I'm using a "cross compiler"
> (i686 compiler to build x86_64 kernel), maybe I'm just using a newer compiler
> than you.

That is indeed a cross build environment I'm not regularly testing, I'm
trying these cross builds:

   9 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-4) 8.2.0
  20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
  22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  46 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  48 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  58 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  59 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  60 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  61 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  63 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  64 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  65 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  66 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

I'll try and get one for building a x86_64 tools/perf,
tools/lib/{api,bpf,traceevent} to see if I manage to reproduce the
problem you're reporting.

- Arnaldo
