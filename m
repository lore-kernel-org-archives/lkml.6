Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E1C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172ED2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD4hr0Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172ED2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeFUOTU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753008AbeFUOTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:19:18 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46682075E;
        Thu, 21 Jun 2018 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529590758;
        bh=BHu+qS1ZM6EqbOxTKwycElVVIp1N6R6sr/ka9Yy3yaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lD4hr0EmIJG86Y+d8vjnCaYSJLyAOsILcP24thmkIsYOrXAz5z84b/0ZF5M6YFW32
         rpF7Bph9RBQs+GkrQ3QsIeFHFKe1ck/8zfJkDOOhuABEsmdpuBHKBrZNl7hOV20nbq
         nZoU39zFzFqNZ7z4EViwU7xgI9FSD4CDab0BjQ2s=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0DE6C1401E5; Thu, 21 Jun 2018 11:19:16 -0300 (-03)
Date:   Thu, 21 Jun 2018 11:19:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Hendrik =?iso-8859-1?Q?Br=FCckner?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
Message-ID: <20180621141915.GS20477@kernel.org>
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
 <20180620134622.GM20477@kernel.org>
 <20180620194546.364cc109430ac51c5a288739@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620194546.364cc109430ac51c5a288739@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 20, 2018 at 07:45:46PM -0500, Kim Phillips escreveu:
> On Wed, 20 Jun 2018 10:46:22 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Tue, Jun 19, 2018 at 06:49:52PM -0500, Kim Phillips escreveu:
> > > Debian based systems such as Ubuntu have dash as their default shell.
> > > Even if the normal or root user's shell is bash, certain scripts still
> > > call /bin/sh, which points to dash, so we fix this perf test by
> > > rewriting it in a more portable way.
> > 
> > Isn't it better to just make /bin/bash a requirement for these tests?
> 
> Perf is more bug-prone in distributions other than its main developers'
> distributions, and when its own built-in tests start depending on those
> same (primary) distributions' preferences, tests start to get skipped
> on the secondary ones, which start to get subsequently ignored and

That is a valid concern, I test build it on many, many distros, running
'perf test' in all of them was always in the backlog, I guess this is
the time for me to try and have it running on them all, running
privileged containers so that all the tests can run there, perhaps some
will need to be tweaked to skip when running on a container environment,
hopefully not.

For reference, before pushing upstream all these environments are test
built, many with all the devel libraries to exercise building with all
the features present in the codebase, both with and without libelf, with
gcc and when available, with clang as well:

   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 7.3.0-15) 7.3.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-15) 7.3.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.3.0-20) 7.3.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:28                     : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  31 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18.0.7)
  40 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  41 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  42 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  44 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  45 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  53 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  54 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  55 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

So I'll try running it on the non-cross-builds (x-something) containers,
because so far I'm just running these on x86_64 as the host machine.

> become acceptable to testers, which is a whole pattern I'd like to
> avoid if at all possible.  I'd eventually like to see the real perf run

Agreed.

> on Android, for example, and adding bash to Android is nontrivial,
> AFAICT.

Fair enough.
 
> > I think the alternative is cryptic :-\
> 
> I think that's because of the fake array stuff, which technically isn't
> needed by design.  How about something like the following?

Thanks for trying to address my concern, looking...
 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 263057039693..d5cceaeba42d 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -14,20 +14,21 @@ libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1
>  nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>  
>  trace_libc_inet_pton_backtrace() {
> +       newline='\n'
>         idx=0
> -       expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
> -       expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> +       expected="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
> +       expected="${expected}${newline}.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
>         case "$(uname -m)" in
>         s390x)
>                 eventattr='call-graph=dwarf,max-stack=4'
> -               expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -               expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -               expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +               expected="${expected}${newline}gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> +               expected="${expected}${newline}(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> +               expected="${expected}${newline}main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
>                 ;;
>         *)
>                 eventattr='max-stack=3'
> -               expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> -               expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +               expected="${expected}${newline}getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> +               expected="${expected}${newline}.*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
>                 ;;
>         esac
>  
> @@ -35,14 +36,16 @@ trace_libc_inet_pton_backtrace() {
>  
>         perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
>         perf script -i $file | while read line ; do
> +               [ -z "${line}" ] && break
>                 echo $line
> -               echo "$line" | egrep -q "${expected[$idx]}"
> +               idx=$((idx + 1))
> +               first="$(echo ${expected} | head -$idx | tail -1)"
> +               [ -z "${first}" ] && break
> +               echo "$line" | egrep -q "$first"
>                 if [ $? -ne 0 ] ; then
> -                       printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
> +                       printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${first}" "$line"
>                         exit 1
>                 fi
> -               let idx+=1
> -               [ -z "${expected[$idx]}" ] && break
>         done
>  
>         # If any statements are executed from this point onwards,
> 
> Thanks,
> 
> Kim
