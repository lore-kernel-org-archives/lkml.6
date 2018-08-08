Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2555C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9BF21723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGaomTK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9BF21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbeHHSfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeHHSfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:35:17 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88BA21723;
        Wed,  8 Aug 2018 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533744894;
        bh=6zItu93WU938LiJO7MuAo57IBuI8Qm9z2k3jZBUPL9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGaomTK262QbEcpDfSWrrD6aCszAWgDt0Us5zP0Zlg9BrDhWjIKf04UhbUKCVp3G5
         C9AWTUUfb7WKvhMYlmlEfnpZNzCYCT3v0F124VLhtbsGMnS1YbXuvoFUr1GzBhUZgO
         RMCKPAVZO/djJCwt+xysD+DkLownJc/PBUZOsOG0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 674CD140A1C; Wed,  8 Aug 2018 13:14:51 -0300 (-03)
Date:   Wed, 8 Aug 2018 13:14:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Message-ID: <20180808161451.GD9543@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org>
 <20180808155921.GB9543@kernel.org>
 <20180808160843.GC9543@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808160843.GC9543@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 08, 2018 at 01:08:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> No need for __packed.
 
> I'm removing that to avoid having this failling in compilers that have
> such a warning, since we default to Werror.
 
> Holler if there is something I'missing :-)

BTW:

  15    68.32 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16   105.45 debian:experimental           : Ok   gcc (Debian 8.2.0-1) 8.2.0
  17    39.76 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  18    18.40 debian:experimental-x-mips    : FAIL mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  19    18.30 debian:experimental-x-mips64  : FAIL mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20    20.58 debian:experimental-x-mipsel  : FAIL mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  21    38.90 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22    39.14 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23    38.65 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24    41.29 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25    40.03 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26    17.49 fedora:24-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27    94.44 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28   104.96 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29   107.23 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30   120.34 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180502 (Red Hat 8.1.1-1)

Lets see, different warning, much newer GCC version (8.1.0), and additional
errors in that file, I'll remove the __packed and see whats left, see at the
end, out of curiosity, for  (ARCompact ISA Linux uClibc toolchain 2017.09-rc2),
older compiler (7.1.1) but same warnings/errors:

  18    18.40 debian:experimental-x-mips    : FAIL mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0

  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
In file included from util/s390-cpumsf.c:161:
util/s390-cpumsf-kernel.h:16:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
util/s390-cpumsf-kernel.h:25:15: error: packed attribute causes inefficient alignment for 'CL' [-Werror=attributes]
  unsigned int CL:2;     /* 32-33 Configuration Level  */
               ^~
util/s390-cpumsf-kernel.h:28:21: error: packed attribute causes inefficient alignment for 'ia' [-Werror=attributes]
  unsigned long long ia;     /* Instruction Address   */
                     ^~
util/s390-cpumsf-kernel.h:29:21: error: packed attribute causes inefficient alignment for 'gpp' [-Werror=attributes]
  unsigned long long gpp;     /* Guest Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:30:21: error: packed attribute causes inefficient alignment for 'hpp' [-Werror=attributes]
  unsigned long long hpp;     /* Host Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:34:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
In file included from util/cpumap.h:10,
                 from util/s390-cpumsf.c:150:
util/s390-cpumsf.c: In function 's390_cpumsf_diag_show':
util/s390-cpumsf.c:208:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:208:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
util/s390-cpumsf.c:233:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:233:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_make_event':
util/s390-cpumsf.c:421:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:421:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
  ^~~~~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_samples':
util/s390-cpumsf.c:501:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'off_t' {aka 'long long int'} [-Werror=format=]
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:501:3: note: in expansion of macro 'pr_err'
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_run_decoder':
util/s390-cpumsf.c:610:12: error: format '%ld' expects argument of type 'long int', but argument 6 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~
util/s390-cpumsf.c:610:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
  26    17.49 fedora:24-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
-----------------------------------------------------------------------------------

  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
In file included from util/s390-cpumsf.c:161:0:
util/s390-cpumsf-kernel.h:16:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
util/s390-cpumsf-kernel.h:25:15: error: packed attribute causes inefficient alignment for 'CL' [-Werror=attributes]
  unsigned int CL:2;     /* 32-33 Configuration Level  */
               ^~
util/s390-cpumsf-kernel.h:28:21: error: packed attribute causes inefficient alignment for 'ia' [-Werror=attributes]
  unsigned long long ia;     /* Instruction Address   */
                     ^~
util/s390-cpumsf-kernel.h:29:21: error: packed attribute causes inefficient alignment for 'gpp' [-Werror=attributes]
  unsigned long long gpp;     /* Guest Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:30:21: error: packed attribute causes inefficient alignment for 'hpp' [-Werror=attributes]
  unsigned long long hpp;     /* Host Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:34:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
In file included from util/cpumap.h:10:0,
                 from util/s390-cpumsf.c:150:
util/s390-cpumsf.c: In function 's390_cpumsf_diag_show':
util/s390-cpumsf.c:208:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
          ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:208:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
util/s390-cpumsf.c:233:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
          ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:233:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_make_event':
util/s390-cpumsf.c:421:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
            ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:421:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
  ^~~~~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_samples':
util/s390-cpumsf.c:501:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'off_t {aka long long int}' [-Werror=format=]
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
          ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:501:3: note: in expansion of macro 'pr_err'
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_run_decoder':
util/s390-cpumsf.c:610:12: error: format '%ld' expects argument of type 'long int', but argument 6 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~
util/s390-cpumsf.c:610:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~
  CC       /tmp/build/perf/util/dump-insn.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.s390-cpumsf.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/s390-cpumsf.o' failed
make[4]: *** [/tmp/build/perf/util/s390-cpumsf.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD       /tmp/build/perf/util/intel-pt-decoder/libperf-in.o
/git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
make[3]: *** [util] Error 2
Makefile.perf:633: recipe for target '/tmp/build/perf/libperf-in.o' failed
make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
Makefile.perf:205: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
make: Leaving directory '/git/linux/tools/perf'
[root@seventh ~]# 

