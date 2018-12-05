Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B565C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B7B208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544048156;
	bh=Hh+e/smhDXHMBsHOt/yaGvpaNKTEf7FTADbHn0BFfEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h06HJgDTHUW34XWOdzKhRSOaw/xtnC4gHdnXs/iJMZwnxipO5279sNhtgHznZ9Ua1
	 UfHN2vqOm1FervK8BRgF1GkGbmR/XlEqEV3vPpXQdh3Ky2lZwLUIZYzrd0VOL+WsMv
	 qCpWxtOBmsU8I5u5Z0mbOVy9ArGFDHj9mQ23lFzo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B7B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeLEWPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbeLEWPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:15:53 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131C12133F;
        Wed,  5 Dec 2018 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544048152;
        bh=Hh+e/smhDXHMBsHOt/yaGvpaNKTEf7FTADbHn0BFfEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QueIPirOfMajo90lcQq354b09AHvEZq4aSRuinSjLTMDVW0XpDfaoVP0WGduBQCu2
         RAUNhxacAi3S6aDoY+7S2qdiZlHCnbRY35t5GxbiZnzd8/llDNuOtYDbqbpF7jylek
         YSCoP2ArnTeGCFjRpwswQKPZh6Qao/hF2+HkdWcY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF0E74042C; Wed,  5 Dec 2018 19:15:49 -0300 (-03)
Date:   Wed, 5 Dec 2018 19:15:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf, tools: Support srccode output
Message-ID: <20181205221549.GC13522@kernel.org>
References: <20181204001848.24769-1-andi@firstfloor.org>
 <20181205122838.GH2950@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205122838.GH2950@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 05, 2018 at 01:28:38PM +0100, Jiri Olsa escreveu:
> On Mon, Dec 03, 2018 at 04:18:48PM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > When looking at PT or brstackinsn traces with perf script
> > it can be very useful to see the source code. This adds a simple
> > facility to print them with perf script, if the information
> > is available through dwarf
> > 
> > % perf record ...
> > % perf script -F insn,ip,sym,srccode
> > ...
> > 
> >           4004c6 main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004c6 main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004b3 main
> > 6                       v++;
> > 
> > % perf record -b ...
> > % perf script -F insn,ip,sym,srccode,brstackinsn
> > 
> > ...
> >        main+22:
> >         0000000000400543        insn: e8 ca ff ff ff            # PRED
> > |18                     f1();
> >         f1:
> >         0000000000400512        insn: 55
> > |10       {
> >         0000000000400513        insn: 48 89 e5
> >         0000000000400516        insn: b8 00 00 00 00
> > |11             f2();
> >         000000000040051b        insn: e8 d6 ff ff ff            # PRED
> >         f2:
> >         00000000004004f6        insn: 55
> > |5        {
> >         00000000004004f7        insn: 48 89 e5
> >         00000000004004fa        insn: 8b 05 2c 0b 20 00
> > |6              c = a / b;
> >         0000000000400500        insn: 8b 0d 2a 0b 20 00
> >         0000000000400506        insn: 99
> >         0000000000400507        insn: f7 f9
> >         0000000000400509        insn: 89 05 29 0b 20 00
> >         000000000040050f        insn: 90
> > |7        }
> >         0000000000400510        insn: 5d
> >         0000000000400511        insn: c3                        # PRED
> >         f1+14:
> >         0000000000400520        insn: b8 00 00 00 00
> > |12             f2();
> >         0000000000400525        insn: e8 cc ff ff ff            # PRED
> >         f2:
> >         00000000004004f6        insn: 55
> > |5        {
> >         00000000004004f7        insn: 48 89 e5
> >         00000000004004fa        insn: 8b 05 2c 0b 20 00
> > |6              c = a / b;
> > 
> > Not supported for callchains currently, would need some
> > layout changes there.
> 
> nice, works nicely, especialy with --xed
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Trying to fix this:

alpine:3.4
Downloading http://x.x.x.x/perf/perf-4.20.0-rc3.tar.xz...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1426k  100 1426k    0     0   232M      0 --:--:-- --:--:-- --:--:--  232M
8932875925270caf72895c32013a678e9c19aa0d
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-alpine-linux-musl/5.3.0/lto-wrapper
Target: x86_64-alpine-linux-musl
Configured with: /home/buildozer/aports/main/gcc/src/gcc-5.3.0/configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --build=x86_64-alpine-linux-musl --host=x86_64-alpine-linux-musl --target=x86_64-alpine-linux-musl --with-pkgversion='Alpine 5.3.0' --enable-checking=release --disable-fixed-point --disable-libstdcxx-pch --disable-multilib --disable-nls --disable-werror --disable-symvers --enable-__cxa_atexit --enable-esp --enable-cloog-backend --enable-languages=c,c++,objc,java,fortran,ada --disable-libssp --disable-libmudflap --disable-libsanitizer --enable-shared --enable-threads --enable-tls --with-system-zlib
Thread model: posix
gcc version 5.3.0 (Alpine 5.3.0)
  CC       /tmp/build/perf/util/srccode.o
In file included from util/srccode.c:19:0:
/usr/include/sys/fcntl.h:1:2: error: #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h> [-Werror=cpp]
 #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h>
  ^
  CC       /tmp/build/perf/util/data.o
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/util/.srccode.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/srccode.o' failed
make[4]: *** [/tmp/build/perf/util/srccode.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/tests/attr.o

