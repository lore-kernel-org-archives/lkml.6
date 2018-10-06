Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EADC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D73E2087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8E4irN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D73E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeJFSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 14:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbeJFSyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 14:54:51 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3B62087D;
        Sat,  6 Oct 2018 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538826713;
        bh=Yzq1N2K2DakVIOYb63EVP/O2HZa4LexiAFhGmdoEq7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8E4irN70Sa8f5uYzaU0O7DTB4OCVSbdM12CJEhZHqIg3Jf5OKlWK4x6roKirCUdY
         XuYbp+YBsQoKENAgyGEAtReuRj4I+po+Nd0m/01iaj1DnKOP3X+PZZCHaGvW/hA5e0
         RNSgBocNEHRE6fqwFblsavQ/9unDzhZ3jarEXrfc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 536FF141DDC; Sat,  6 Oct 2018 08:51:51 -0300 (-03)
Date:   Sat, 6 Oct 2018 08:51:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf record: encode -k clockid frequency into Perf
 trace
Message-ID: <20181006115151.GJ20250@kernel.org>
References: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
 <20181004123657.GD32371@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004123657.GD32371@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 04, 2018 at 02:36:57PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 03, 2018 at 07:57:12PM +0300, Alexey Budankov wrote:
> > 
> > Store -k clockid frequency into Perf trace to enable timestamps 
> > derived metrics conversion into wall clock time on reporting stage.
> > 
> > Below is the example of perf report output:
> > 
> > tools/perf/perf record -k raw -- ../../matrix/linux/matrix.gcc
> > ...
> > [ perf record: Captured and wrote 31.222 MB perf.data (818054 samples) ]
> > 
> > tools/perf/perf report --header
> > # ========
> > ...
> > # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, use_clockid = 1, clockid = 4
> > ...
> > # clockid frequency: 1000 MHz
> > ...
> > # ========
> > 
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>



  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/util/header.o
util/header.c: In function 'print_clockid':
util/header.c:1520:38: error: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
  fprintf(fp, "# clockid frequency: %ld MHz\n",
                                    ~~^
                                    %d
   ff->ph->env.clockid_res_ns * 1000);
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
util/header.c: In function 'process_clockid':
util/header.c:2552:22: error: passing argument 2 of 'do_read_u64' from incompatible pointer type [-Werror=incompatible-pointer-types]
  if (do_read_u64(ff, &clockid_res_ns))
                      ^~~~~~~~~~~~~~~
util/header.c:229:49: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'size_t *' {aka 'unsigned int *'}
 static int do_read_u64(struct feat_fd *ff, u64 *addr)
                                            ~~~~~^~~~
In file included from /usr/mips-linux-gnu/include/string.h:494,
                 from util/string2.h:7,
                 from util/header.c:5:
In function 'memcpy',
    inlined from '__do_read_buf' at util/header.c:202:2,
    inlined from '__do_read' at util/header.c:213:9,
    inlined from 'do_read_u64' at util/header.c:233:8,
    inlined from 'process_clockid' at util/header.c:2552:6:
/usr/mips-linux-gnu/include/bits/string_fortified.h:34:10: error: '__builtin___memcpy_chk' forming offset [5, 8] is out of the bounds [0, 4] of object 'clockid_res_ns' with type 'size_t' {aka 'unsigned int'} [-Werror=array-bounds]
   return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/header.c: In function 'process_clockid':
util/header.c:2550:9: note: 'clockid_res_ns' declared here
  size_t clockid_res_ns;
         ^~~~~~~~~~~~~~
  MKDIR    /tmp/build/perf/scripts/
  LD       /tmp/build/perf/scripts/libperf-in.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/ui/browsers/map.o
  CC       /tmp/build/perf/builtin-kvm.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.header.o.tmp': No such file or directory
make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/header.o] Error 1
make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
make[3]: *** Waiting for unfinished jobs....

In a series of cross compiling environments:

  20    22.19 debian:experimental-x-mips    : FAIL mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  21    47.76 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
  22    19.27 debian:experimental-x-mipsel  : FAIL mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  23    51.27 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24    44.45 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25    43.60 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26    51.07 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  27    49.89 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  28    19.38 fedora:24-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29   138.25 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  30   145.14 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  31   163.94 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  32   166.77 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5)
  33   157.20 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3)
  34    40.37 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  35    46.41 mageia:5                      : Ok   gcc (GCC) 4.9.2
  36    44.33 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  37    41.12 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  38    43.96 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  39    43.83 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  40    44.45 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  41   141.53 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  42    35.29 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  43    41.76 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  44    32.06 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  45    39.26 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  46    35.33 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  47    95.94 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  48    13.76 ubuntu:16.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49    34.59 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50    13.59 ubuntu:16.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51    34.39 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52    35.60 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53    32.96 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54   100.88 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  55   111.23 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  56   114.81 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  57    15.12 ubuntu:18.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  58    36.84 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  59    11.27 ubuntu:18.04-x-m68k           : FAIL m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  60    14.18 ubuntu:18.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  61    39.74 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62    40.19 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  63    70.67 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  64    32.72 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  65    14.43 ubuntu:18.04-x-sh4            : FAIL sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

