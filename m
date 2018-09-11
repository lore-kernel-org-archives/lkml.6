Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE8BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6F32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSUynq2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6F32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeIKROw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbeIKROv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:14:51 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B7520866;
        Tue, 11 Sep 2018 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536668147;
        bh=MdU61opRYk4WHKG0ieJDVLm7PwVcrwhswW9oGQyDz70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSUynq2SAY5qP6ATJA0ztwvGM2sX0T4GncEeADjXt/tuX5teaiUl9seS23qvp9yxv
         JMGJDA+P4jRUfbjcWeVPAKEbHJf+Dl1rUmLTaEv7xmMbIlMYygp181/oGaAWs4FIKH
         tH2D58s0dJsNVc5vWncDRm+BGNVU3pz0c+tYv8SU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 92711140260; Tue, 11 Sep 2018 09:15:43 -0300 (-03)
Date:   Tue, 11 Sep 2018 09:15:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180911121543.GB22689@kernel.org>
References: <20180910172903.GB15516@kernel.org>
 <20180911122218.0d2eb3f9@cakuba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911122218.0d2eb3f9@cakuba>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 11, 2018 at 12:22:18PM +0200, Jakub Kicinski escreveu:
> On Mon, 10 Sep 2018 14:29:03 -0300, Arnaldo Carvalho de Melo wrote:
> > After lunch I'll work on a patch to fix this, 
 
> Hi Arnaldo!
 
> Any luck?

Well, we need to apply the patch below and make tools/lib/str_error_r.c
live in a library that libbpf and perf is linked to.

We have tools/lib/api/ that I think we should make libbpf link against
it, so perf would as well, and even when perf is not linked with libbpf,
those symbols would be available.

The patch below, as-is, is enough for tools/perf/, as it already
statically links with libapi, but we need to do it properly as a library
as stated above.

I'm a bit busy right now, so may take me a bit more time, help in having
libapi used by libbpf would be welcome.

While looking at this I noticed that we should get
tools/perf/check_headers.sh and move it outside perf so that libbpf can
use that mechanism instead of the old ad-hoc series of diffs in its
Makefile, that Jiri forgot to convert to check_headers.

For reference, this is how it looks like now, the builds that take more
time (second column, in seconds, i5 + NVMe) is because it builds with
both gcc and clang, with and without libelf. ClearLinux is failing for
an unrelated problem, its a recent container, also the
ubuntu:18.04-x-i686 cross build is another unrelated problem, something
related to atomics.

Only the alpine (musl libc) are regressions due to the strerror_r
oddity.

- Arnaldo

  # dm
   1     5.15 alpine:3.4                    : FAIL gcc (Alpine 5.3.0) 5.3.0
   2     5.08 alpine:3.5                    : FAIL gcc (Alpine 6.2.1) 6.2.1 20160822
   3     6.40 alpine:3.6                    : FAIL gcc (Alpine 6.3.0) 6.3.0
   4     5.38 alpine:3.7                    : FAIL gcc (Alpine 6.4.0) 6.4.0
   5     5.44 alpine:3.8                    : FAIL gcc (Alpine 6.4.0) 6.4.0
   6     5.69 alpine:edge                   : FAIL gcc (Alpine 6.4.0) 6.4.0
   7    37.14 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8    43.81 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9    28.93 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10    29.89 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11    22.19 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12    35.31 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13    40.22 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  14    23.39 clearlinux:latest             : FAIL gcc (Clear Linux OS for Intel Architecture) 8.2.0
  15    36.10 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  16    41.81 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  17    97.56 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18   108.83 debian:experimental           : Ok   gcc (Debian 8.2.0-4) 8.2.0
  19    40.88 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  20    41.05 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  21    36.59 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
  22    41.20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  23    39.76 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24    41.85 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25    42.56 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26    41.62 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  27    43.09 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  28    36.13 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29   119.56 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  30   136.89 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  31   136.21 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  32   155.74 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5)
  33   163.56 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20180801 (Red Hat 8.2.1-2)
  34    40.91 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  35    43.49 mageia:5                      : Ok   gcc (GCC) 4.9.2
  36    43.53 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  37    41.78 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  38    40.90 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  39    41.82 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  40    42.54 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  41   137.82 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  42    33.51 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  43    39.50 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  44    32.46 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  45    37.82 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  46    34.76 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  47    93.53 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  48    34.76 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49    33.89 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50    34.44 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51    33.90 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52    34.16 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53    32.89 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54   100.14 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  55   107.62 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  56   111.93 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  57    36.09 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  58    36.57 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  59     4.90 ubuntu:18.04-x-i686           : FAIL i686-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  60    27.67 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  61    36.20 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62    39.75 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  63    40.01 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  64    68.19 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  65    34.25 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  66    36.44 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  67    31.68 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  68   104.31 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-4ubuntu1) 8.2.0
  #
