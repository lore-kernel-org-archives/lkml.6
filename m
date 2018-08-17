Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB988C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2F321A1C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqvRPe+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2F321A1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeHQV1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeHQV1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:27:43 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DE921A2F;
        Fri, 17 Aug 2018 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534530199;
        bh=Jv9N3yHEQQlz1orOZVyHmKGZmyRnikltyxTk+XTJfPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqvRPe+gPbwjDZyCZ5+WC0pc85O4p5gxHH0NrczVX44lFRBT3FGtVDdwqRV3CZ1gE
         ohVKoPio/5yGzzE9TUSEXCK/2oPi/zQloCAmPza5orw+M5/QysYvO5ihww+lzi8H78
         v1EAhxnGrWJnoH9dE6g3ID0RZyFx+fCxRm+9TrD0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3EE76141C3A; Fri, 17 Aug 2018 15:23:15 -0300 (-03)
Date:   Fri, 17 Aug 2018 15:23:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 06/13] perf tools: Add compression id into struct
 kmod_path
Message-ID: <20180817182315.GD22443@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
 <20180817094813.15086-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817094813.15086-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 17, 2018 at 11:48:06AM +0200, Jiri Olsa escreveu:
> Storing decompression ID in the struct kmod_path, so it
> can be later stored in the struct dso.
> 
> Switching the struct kmod_path::comp from bool to int
> to return the compressions array index. Adding 0 index
> item into compressions array, so the comp usage stays
> as it was: 0 - no compression, != 0 index of compression.
> 
> Updating the kmod_path tests.
> 
> Link: http://lkml.kernel.org/n/tip-vxxfco32fh5veg1817udcx2c@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/kmod-path.c | 42 ++++++++++++++++++------------------
>  tools/perf/util/dso.c        | 18 ++++++++++------
>  tools/perf/util/dso.h        |  2 +-
>  3 files changed, 33 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
> index 148dd31cc201..f92f78f683ea 100644
> --- a/tools/perf/tests/kmod-path.c
> +++ b/tools/perf/tests/kmod-path.c
> @@ -6,7 +6,7 @@
>  #include "debug.h"
>  
>  static int test(const char *path, bool alloc_name, bool alloc_ext,
> -		bool kmod, bool comp, const char *name, const char *ext)
> +		bool kmod, int comp, const char *name, const char *ext)
>  {
>  	struct kmod_path m;
>  
> @@ -54,47 +54,47 @@ static int test_is_kernel_module(const char *path, int cpumode, bool expect)
>  int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_unused)
>  {
>  	/* path                alloc_name  alloc_ext   kmod  comp   name     ext */
> -	T("/xxxx/xxxx/x-x.ko", true      , true      , true, false, "[x_x]", NULL);
> -	T("/xxxx/xxxx/x-x.ko", false     , true      , true, false, NULL   , NULL);
> -	T("/xxxx/xxxx/x-x.ko", true      , false     , true, false, "[x_x]", NULL);
> -	T("/xxxx/xxxx/x-x.ko", false     , false     , true, false, NULL   , NULL);
> +	T("/xxxx/xxxx/x-x.ko", true      , true      , true, 0    , "[x_x]", NULL);
> +	T("/xxxx/xxxx/x-x.ko", false     , true      , true, 0    , NULL   , NULL);
> +	T("/xxxx/xxxx/x-x.ko", true      , false     , true, 0    , "[x_x]", NULL);
> +	T("/xxxx/xxxx/x-x.ko", false     , false     , true, 0    , NULL   , NULL);
>  	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
>  	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
>  	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
>  
>  #ifdef HAVE_ZLIB_SUPPORT
>  	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
> -	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, true, "[x]", "gz");
> -	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, true, NULL , "gz");
> -	T("/xxxx/xxxx/x.ko.gz", true     , false     , true, true, "[x]", NULL);
> -	T("/xxxx/xxxx/x.ko.gz", false    , false     , true, true, NULL , NULL);
> +	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, 1   , "[x]", "gz");
> +	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, 1   , NULL , "gz");
> +	T("/xxxx/xxxx/x.ko.gz", true     , false     , true, 1   , "[x]", NULL);
> +	T("/xxxx/xxxx/x.ko.gz", false    , false     , true, 1   , NULL , NULL);
>  	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
>  	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
>  	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_USER, false);
>  
>  	/* path              alloc_name  alloc_ext  kmod   comp  name    ext */
> -	T("/xxxx/xxxx/x.gz", true      , true     , false, true, "x.gz" ,"gz");
> -	T("/xxxx/xxxx/x.gz", false     , true     , false, true, NULL   ,"gz");
> -	T("/xxxx/xxxx/x.gz", true      , false    , false, true, "x.gz" , NULL);
> -	T("/xxxx/xxxx/x.gz", false     , false    , false, true, NULL   , NULL);
> +	T("/xxxx/xxxx/x.gz", true      , true     , false, 1   , "x.gz" ,"gz");
> +	T("/xxxx/xxxx/x.gz", false     , true     , false, 1   , NULL   ,"gz");
> +	T("/xxxx/xxxx/x.gz", true      , false    , false, 1   , "x.gz" , NULL);
> +	T("/xxxx/xxxx/x.gz", false     , false    , false, 1   , NULL   , NULL);
>  	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
>  	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_KERNEL, false);
>  	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_USER, false);
>  
>  	/* path   alloc_name  alloc_ext  kmod   comp  name     ext */
> -	T("x.gz", true      , true     , false, true, "x.gz", "gz");
> -	T("x.gz", false     , true     , false, true, NULL  , "gz");
> -	T("x.gz", true      , false    , false, true, "x.gz", NULL);
> -	T("x.gz", false     , false    , false, true, NULL  , NULL);
> +	T("x.gz", true      , true     , false, 1   , "x.gz", "gz");
> +	T("x.gz", false     , true     , false, 1   , NULL  , "gz");
> +	T("x.gz", true      , false    , false, 1   , "x.gz", NULL);
> +	T("x.gz", false     , false    , false, 1   , NULL  , NULL);
>  	M("x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
>  	M("x.gz", PERF_RECORD_MISC_KERNEL, false);
>  	M("x.gz", PERF_RECORD_MISC_USER, false);
>  
>  	/* path      alloc_name  alloc_ext  kmod  comp  name  ext */
> -	T("x.ko.gz", true      , true     , true, true, "[x]", "gz");
> -	T("x.ko.gz", false     , true     , true, true, NULL , "gz");
> -	T("x.ko.gz", true      , false    , true, true, "[x]", NULL);
> -	T("x.ko.gz", false     , false    , true, true, NULL , NULL);
> +	T("x.ko.gz", true      , true     , true, 1   , "[x]", "gz");
> +	T("x.ko.gz", false     , true     , true, 1   , NULL , "gz");
> +	T("x.ko.gz", true      , false    , true, 1   , "[x]", NULL);
> +	T("x.ko.gz", false     , false    , true, 1   , NULL , NULL);
>  	M("x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
>  	M("x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
>  	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 4449a7257340..f5f8babea17c 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -189,10 +189,15 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  	return ret;
>  }
>  
> +enum {
> +	COMP_ID__NONE = 0,
> +};
> +
>  static const struct {
>  	const char *fmt;
>  	int (*decompress)(const char *input, int output);
>  } compressions[] = {
> +	[COMP_ID__NONE] = { 0 },


This broke the build in many places, problems of this kind:

  CC       /tmp/build/perf/util/dso.o
  LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/libperf-in.o
  LD       /tmp/build/perf/scripts/libperf-in.o
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/util/symbol.o
util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
        [COMP_ID__NONE] = { 0 },
                              ^
1 error generated.
  CC       /tmp/build/perf/trace/beauty/fcntl.o
mv: cannot stat '/tmp/build/perf/util/.dso.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/dso.o' failed

If we look just at those that failed, its several gcc versions:

  11     9.91 centos:5                      : FAIL gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12    14.34 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  16    47.50 debian:9                      : FAIL gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  28    53.92 fedora:25                     : FAIL gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  29    60.75 fedora:26                     : FAIL gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  30    90.76 fedora:27                     : FAIL gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  41    12.78 oraclelinux:6                 : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  43    12.85 ubuntu:12.04.5                : FAIL gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  46    45.56 ubuntu:16.04                  : FAIL gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  54    49.60 ubuntu:17.10                  : FAIL gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0

[root@seventh ~]# grep error: /tmp/dm.log/*
/tmp/dm.log/centos:6:util/dso.c:201: error: missing initializer
/tmp/dm.log/centos:6:util/dso.c:201: error: (near initialization for 'compressions[0].decompress')
/tmp/dm.log/debian:9:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
/tmp/dm.log/fedora:25:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
/tmp/dm.log/fedora:26:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
/tmp/dm.log/fedora:27:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
/tmp/dm.log/oraclelinux:6:util/dso.c:201: error: missing initializer
/tmp/dm.log/oraclelinux:6:util/dso.c:201: error: (near initialization for 'compressions[0].decompress')
/tmp/dm.log/ubuntu:12.04.5:util/dso.c:201:2: error: missing initializer [-Werror=missing-field-initializers]
/tmp/dm.log/ubuntu:12.04.5:util/dso.c:201:2: error: (near initialization for 'compressions[0].decompress') [-Werror=missing-field-initializers]
/tmp/dm.log/ubuntu:16.04:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
/tmp/dm.log/ubuntu:16.10:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
/tmp/dm.log/ubuntu:16.10:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
/tmp/dm.log/ubuntu:17.10:util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
[root@seventh ~]#

Trying to fix...



# dm
   1    43.58 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2    47.76 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3    48.40 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4    44.07 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5    47.43 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6    44.54 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   7    36.61 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8    41.03 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9    27.49 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10    29.10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11     9.91 centos:5                      : FAIL gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12    14.34 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13    40.77 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  14    38.91 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  15    38.01 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  16    47.50 debian:9                      : FAIL gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  17   106.91 debian:experimental           : Ok   gcc (Debian 8.2.0-4) 8.2.0
  18    43.17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  19    41.17 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  20    38.28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
  21    40.77 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  22    40.36 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  23    41.30 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  24    41.42 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25    40.67 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26    42.09 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  27    35.26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28    53.92 fedora:25                     : FAIL gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  29    60.75 fedora:26                     : FAIL gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  30    90.76 fedora:27                     : FAIL gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  31   157.29 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5)
  32   148.43 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  33    43.37 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  34    43.06 mageia:5                      : Ok   gcc (GCC) 4.9.2
  35    43.06 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  36    40.29 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  37    39.97 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  38    40.38 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  39    40.92 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  40   157.84 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  41    12.78 oraclelinux:6                 : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  42    39.10 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  43    12.85 ubuntu:12.04.5                : FAIL gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  44    37.24 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  45    36.18 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  46    45.56 ubuntu:16.04                  : FAIL gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  47    32.61 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48    33.76 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49    32.23 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50    32.71 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51    33.16 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52    33.28 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53    70.61 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  54    49.60 ubuntu:17.10                  : FAIL gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  55   111.93 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  56    37.08 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  57    38.00 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  58    27.10 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  59    35.10 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  60    38.07 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  61    38.46 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62    71.15 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  63    31.69 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  64    35.60 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  65    30.86 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  66   105.18 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-1ubuntu2) 8.2.0


>  #ifdef HAVE_ZLIB_SUPPORT
>  	{ "gz", gzip_decompress_to_file },
>  #endif
> @@ -202,15 +207,15 @@ static const struct {
>  	{ NULL, NULL },
>  };
>  
> -static bool is_supported_compression(const char *ext)
> +static int is_supported_compression(const char *ext)
>  {
>  	unsigned i;
>  
> -	for (i = 0; compressions[i].fmt; i++) {
> +	for (i = 1; compressions[i].fmt; i++) {
>  		if (!strcmp(ext, compressions[i].fmt))
> -			return true;
> +			return i;
>  	}
> -	return false;
> +	return COMP_ID__NONE;
>  }
>  
>  bool is_kernel_module(const char *pathname, int cpumode)
> @@ -373,10 +378,9 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
>  		return 0;
>  	}
>  
> -	if (is_supported_compression(ext + 1)) {
> -		m->comp = true;
> +	m->comp = is_supported_compression(ext + 1);
> +	if (m->comp > COMP_ID__NONE)
>  		ext -= 3;
> -	}
>  
>  	/* Check .ko extension only if there's enough name left. */
>  	if (ext > name)
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 870346b333ee..7bde23f6e5a9 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -262,7 +262,7 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
>  struct kmod_path {
>  	char *name;
>  	char *ext;
> -	bool  comp;
> +	int   comp;
>  	bool  kmod;
>  };
>  
> -- 
> 2.17.1
