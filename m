Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A727C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6621773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547127671;
	bh=2skcZmn5Hir+DwrUAGWpiDEwIcic/jEqamdotvoyD1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fYS1y34NfcBfKiivvkODCToI7JBiyxOKlbtjxHv1Lcyp54Ui0HAWE22vjtQmtCkRP
	 tqg4gi62aqUFuwApleB1g4//GHhC4nDtw08klaTwbjvde+iKAnkobWFG6gJt1KB+wG
	 2wqy20Xgzeio6PM2KZFm99iE4ZGMkrI9gk5ikv5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfAJNlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbfAJNlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:41:10 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C32214C6;
        Thu, 10 Jan 2019 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547127668;
        bh=2skcZmn5Hir+DwrUAGWpiDEwIcic/jEqamdotvoyD1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZ00d93DcFzOmXUqmeeqFRYBYH4vBnZpgVXxt508mhmaF3Xyry6CwuFx/TtKzvgit
         bsLAauxfbbs4NVEE7V3EqbdC73ffazrVPcIw3yOla4YERo/GZhHiUtsb5LR/sJscnX
         4CRNYoraa4rchJTsZCykG3o0OaQO6C1IWEAbPfOk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3ADE140355; Thu, 10 Jan 2019 10:41:04 -0300 (-03)
Date:   Thu, 10 Jan 2019 10:41:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf powerpc: Rework syscall table generation
Message-ID: <20190110134104.GD22483@kernel.org>
References: <20190110094936.3132-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110094936.3132-1-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2019 at 03:19:35PM +0530, Ravi Bangoria escreveu:
> Commit aff850393200 ("powerpc: add system call table generation support")
> changed how systemcall table is generated for powerpc. Incorporate these
> changes into perf as well.

Thanks, applied and performed the following tests, noted on the commit
log message:

Committer testing:

  $ podman run --entrypoint=/bin/sh --privileged -v /home/acme/git:/git --rm -ti docker.io/acmel/linux-perf-tools-build-ubuntu:18.04-x-powerpc64
  perfbuilder@d7a7af166a80:/git/perf$ head -2 /etc/os-release 
  NAME="Ubuntu"
  VERSION="18.04.1 LTS (Bionic Beaver)"
  perfbuilder@d7a7af166a80:/git/perf$
  perfbuilder@d7a7af166a80:/git/perf$ make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- -C /git/linux/tools/perf O=/tmp/build/perf
  make: Entering directory '/git/linux/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
    HOSTCC   /tmp/build/perf/fixdep.o
    HOSTLD   /tmp/build/perf/fixdep-in.o
    LINK     /tmp/build/perf/fixdep
  
  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ OFF ]
  ...                      libaudit: [ OFF ]
  ...                        libbfd: [ OFF ]
  ...                        libelf: [ on  ]
  ...                       libnuma: [ OFF ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ OFF ]
  ...                     libpython: [ OFF ]
  ...                      libslang: [ OFF ]
  ...                     libcrypto: [ OFF ]
  ...                     libunwind: [ OFF ]
  ...            libdw-dwarf-unwind: [ on  ]
  ...                          zlib: [ on  ]
  ...                          lzma: [ OFF ]
  ...                     get_cpuid: [ OFF ]
  ...                           bpf: [ on  ]
  
  Makefile.config:445: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
  Makefile.config:491: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
  Makefile.config:583: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
  Makefile.config:598: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
  Makefile.config:612: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
  Makefile.config:639: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
  Makefile.config:666: No python interpreter was found: disables Python support - please install python-devel/python-dev
  Makefile.config:721: No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling
  Makefile.config:750: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
  Makefile.config:763: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
  Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
  Makefile.config:840: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
    GEN      /tmp/build/perf/common-cmds.h
  <SNIP>
    CC       /tmp/build/perf/util/syscalltbl.o
  <SNIP>
    LD       /tmp/build/perf/libperf-in.o
    AR       /tmp/build/perf/libperf.a
    LINK     /tmp/build/perf/perf
  make: Leaving directory '/git/linux/tools/perf'
  perfbuilder@d7a7af166a80:/git/perf$ head /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_64.c 
  static const char *syscalltbl_powerpc_64[] = {
  	[0] = "restart_syscall",
  	[1] = "exit",
  	[2] = "fork",
  	[3] = "read",
  	[4] = "write",
  	[5] = "open",
  	[6] = "close",
  	[7] = "waitpid",
  	[8] = "creat",
  perfbuilder@d7a7af166a80:/git/perf$ tail /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_64.c 
  	[381] = "pwritev2",
  	[382] = "kexec_file_load",
  	[383] = "statx",
  	[384] = "pkey_alloc",
  	[385] = "pkey_free",
  	[386] = "pkey_mprotect",
  	[387] = "rseq",
  	[388] = "io_pgetevents",
  };
  #define SYSCALLTBL_POWERPC_64_MAX_ID 388
  perfbuilder@d7a7af166a80:/git/perf$ head /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c 
  static const char *syscalltbl_powerpc_32[] = {
  	[0] = "restart_syscall",
  	[1] = "exit",
  	[2] = "fork",
  	[3] = "read",
  	[4] = "write",
  	[5] = "open",
  	[6] = "close",
  	[7] = "waitpid",
  	[8] = "creat",
  perfbuilder@d7a7af166a80:/git/perf$ tail /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c 
  	[381] = "pwritev2",
  	[382] = "kexec_file_load",
  	[383] = "statx",
  	[384] = "pkey_alloc",
  	[385] = "pkey_free",
  	[386] = "pkey_mprotect",
  	[387] = "rseq",
  	[388] = "io_pgetevents",
  };
  #define SYSCALLTBL_POWERPC_32_MAX_ID 388
  perfbuilder@d7a7af166a80:/git/perf$ 
