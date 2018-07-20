Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F51ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3BF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1ANFNuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3BF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeGTPzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731792AbeGTPzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:55:39 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370BC20647;
        Fri, 20 Jul 2018 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532099216;
        bh=zfYRt/U/D9/tpNmWUyffvYaUQYKWO61EVnQpjOUmgPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1ANFNuQti0omTcbvLdNq9venbXhzxCqmqxLhTbfxyjQZ/8RLNpbkPd3mZczZkynx
         2f25Ef9bb/CO9ynzAyMUk18euKCK+CSfNuhirpPFAoti0oRvLpJ/u7P1RuosgKGt/o
         fpvUS5Mn0r1Sc/bPMcXI98wVHLd9VUhFHJGQaml4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C20B0140260; Fri, 20 Jul 2018 12:06:53 -0300 (-03)
Date:   Fri, 20 Jul 2018 12:06:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf arm64: Generate system call table from
 asm/unistd.h
Message-ID: <20180720150653.GD4329@kernel.org>
References: <20180706163443.22626f5e9e10e5bab5e5c662@arm.com>
 <20180718155752.GA1814@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180718155752.GA1814@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 18, 2018 at 12:57:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 06, 2018 at 04:34:43PM -0500, Kim Phillips escreveu:
> > This should speed up accessing new system calls introduced with the
> > kernel rather than waiting for libaudit updates to include them.
> >=20
> > Using the existing other arch scripts resulted in this error:
> >=20
> > tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: 25: printf: __NR326=
4_ftruncate: expected numeric value
> >=20
> > because, unlike other arches, asm-generic's unistd.h does things like:
> >=20
> >  #define __NR_ftruncate __NR3264_ftruncate
> >=20
> > Turning the scripts printf's %d into a %s resulted in this in the
> > generated syscalls.c file:
> >=20
> >     static const char *syscalltbl_arm64[] =3D {
> >             [__NR3264_ftruncate] =3D "ftruncate",
> >=20
> > So we use the host C compiler to fold the macros, and print them out
> > from within a temporary C program, in order to get the correct output:
> >=20
> >     static const char *syscalltbl_arm64[] =3D {
> >             [46] =3D "ftruncate",
> >=20
>=20
> One of my containers, ubuntu:14.04.4-x-linaro-arm64, that build perf in
> a cross-build env, failed to build, please take a look if what is in the
> output below is enough for you to find the problem, perhaps you forgot
> to add the new files grabbed from the kernel sources to the
> tools/perf/MANIFEST file that is used to create the tarball that is then
> used to test build it? I'll check that later, in a hurry right now.

Shouldn't be the MANIFEST file, as it gets the whole trees of
directories containing the files you added in this series, possibly
something related to cross building or a header file with that same name
taking precedence, still have to verify, have you had the chance to look
at this?

- Arnaldo
=20
> Thanks,
>=20
> - Arnaldo
>=20
> ubuntu:14.04.4-x-linaro-arm64
> Downloading http://192.168.86.4/perf/perf-4.18.0-rc4.tar.xz...
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  C=
urrent
>                                  Dload  Upload   Total   Spent    Left  S=
peed
>   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:-- =
    0100 1338k  100 1338k    0     0  73.8M      0 --:--:-- --:--:-- --:--:=
-- 87.1M
> 608df4c7ac9a7bde0129d08d7a16a0ea76e0dd23
> Using built-in specs.
> COLLECT_GCC=3D/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu/bin/aarc=
h64-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=3D/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu/=
bin/../libexec/gcc/aarch64-linux-gnu/5.5.0/lto-wrapper
> Target: aarch64-linux-gnu
> Configured with: '/home/tcwg-buildslave/workspace/tcwg-make-release/build=
er_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/snapshots/gc=
c.git~linaro-5.5-2017.10/configure' SHELL=3D/bin/bash --with-mpc=3D/home/tc=
wg-buildslave/workspace/tcwg-make-release/builder_arch/amd64/label/tcwg-x86=
_64-build/target/aarch64-linux-gnu/_build/builds/destdir/x86_64-unknown-lin=
ux-gnu --with-mpfr=3D/home/tcwg-buildslave/workspace/tcwg-make-release/buil=
der_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/buil=
ds/destdir/x86_64-unknown-linux-gnu --with-gmp=3D/home/tcwg-buildslave/work=
space/tcwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/a=
arch64-linux-gnu/_build/builds/destdir/x86_64-unknown-linux-gnu --with-gnu-=
as --with-gnu-ld --disable-libmudflap --enable-lto --enable-shared --withou=
t-included-gettext --enable-nls --disable-sjlj-exceptions --enable-gnu-uniq=
ue-object --enable-linker-build-id --disable-libstdcxx-pch --enable-c99 --e=
nable-clocale=3Dgnu --enable-libstdcxx-debug --enable-long-long --with-cloo=
g=3Dno --with-ppl=3Dno --with-isl=3Dno --disable-multilib --enable-fix-cort=
ex-a53-835769 --enable-fix-cortex-a53-843419 --with-arch=3Darmv8-a --enable=
-threads=3Dposix --enable-multiarch --enable-libstdcxx-time=3Dyes --with-bu=
ild-sysroot=3D/home/tcwg-buildslave/workspace/tcwg-make-release/builder_arc=
h/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/sysroots/aa=
rch64-linux-gnu --with-sysroot=3D/home/tcwg-buildslave/workspace/tcwg-make-=
release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu=
/_build/builds/destdir/x86_64-unknown-linux-gnu/aarch64-linux-gnu/libc --en=
able-checking=3Drelease --disable-bootstrap --enable-languages=3Dc,c++,fort=
ran,lto --build=3Dx86_64-unknown-linux-gnu --host=3Dx86_64-unknown-linux-gn=
u --target=3Daarch64-linux-gnu --prefix=3D/home/tcwg-buildslave/workspace/t=
cwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-=
linux-gnu/_build/builds/destdir/x86_64-unknown-linux-gnu
> Thread model: posix
> gcc version 5.5.0 (Linaro GCC 5.5-2017.10)=20
> make: Entering directory `/git/linux/tools/perf'
>   BUILD:   Doing 'make -j4' parallel build
>   HOSTCC   /tmp/build/perf/fixdep.o
>   HOSTLD   /tmp/build/perf/fixdep-in.o
>   LINK     /tmp/build/perf/fixdep
> sh: 1: command: Illegal option -c
>=20
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ OFF ]
> ...                      libaudit: [ OFF ]
> ...                        libbfd: [ OFF ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ OFF ]
> ...        numa_num_possible_cpus: [ OFF ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                      libslang: [ OFF ]
> ...                     libcrypto: [ OFF ]
> ...                     libunwind: [ OFF ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ OFF ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ on  ]
>=20
> Makefile.config:445: No sys/sdt.h found, no SDT events are defined, pleas=
e install systemtap-sdt-devel or systemtap-sdt-dev
> Makefile.config:491: No libunwind found. Please install libunwind-dev[el]=
 >=3D 1.1 and/or set LIBUNWIND_DIR
> Makefile.config:583: No libcrypto.h found, disables jitted code injection=
, please install libssl-devel or libssl-dev
> Makefile.config:598: slang not found, disables TUI support. Please instal=
l slang-devel, libslang-dev or libslang2-dev
> Makefile.config:612: GTK2 not found, disables GTK2 support. Please instal=
l gtk2-devel or libgtk2.0-dev
> Makefile.config:639: Missing perl devel files. Disabling perl scripting s=
upport, please install perl-ExtUtils-Embed/libperl-dev
> Makefile.config:666: No python interpreter was found: disables Python sup=
port - please install python-devel/python-dev
> Makefile.config:721: No bfd.h/libbfd found, please install binutils-dev[e=
l]/zlib-static/libiberty-dev to gain symbol demangling
> Makefile.config:750: No liblzma found, disables xz kernel module decompre=
ssion, please install xz-devel/liblzma-dev
> Makefile.config:763: No numa.h found, disables 'perf bench numa mem' benc=
hmark, please install numactl-devel/libnuma-devel/libnuma-dev
> Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF for=
mat support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:840: No alternatives command found, you need to set JDIR=
=3D to point to the root of your Java directory
>   GEN      /tmp/build/perf/common-cmds.h
>   PERF_VERSION =3D 4.18.rc4.g608df4c7
> <stdin>: In function 'main':
> <stdin>:257:38: error: '__NR_getrandom' undeclared (first use in this fun=
ction)
> <stdin>:257:38: note: each undeclared identifier is reported only once fo=
r each function it appears in
> <stdin>:258:41: error: '__NR_memfd_create' undeclared (first use in this =
function)
> <stdin>:259:32: error: '__NR_bpf' undeclared (first use in this function)
> <stdin>:260:37: error: '__NR_execveat' undeclared (first use in this func=
tion)
> /git/linux/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: 46: /git/l=
inux/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: /tmp/create-table-=
iJLXMb: Permission denied
>   CC       /tmp/build/perf/event-parse.o
>   MKDIR    /tmp/build/perf/fd/
>   CC       /tmp/build/perf/fd/array.o
>   MKDIR    /tmp/build/perf/fs/
>   CC       /tmp/build/perf/fs/fs.o
>   MKDIR    /tmp/build/perf/fd/
>   LD       /tmp/build/perf/fd/libapi-in.o
>   MKDIR    /tmp/build/perf/fs/
>   CC       /tmp/build/perf/fs/tracing_path.o
>   CC       /tmp/build/perf/event-plugin.o
>   MKDIR    /tmp/build/perf/fs/
>   LD       /tmp/build/perf/fs/libapi-in.o
>   CC       /tmp/build/perf/cpu.o
>   CC       /tmp/build/perf/trace-seq.o
>   CC       /tmp/build/perf/debug.o
>   CC       /tmp/build/perf/str_error_r.o
>   CC       /tmp/build/perf/parse-filter.o
>   LD       /tmp/build/perf/libapi-in.o
>   AR       /tmp/build/perf/libapi.a
>   CC       /tmp/build/perf/parse-utils.o
>   CC       /tmp/build/perf/exec-cmd.o
>   MKDIR    /tmp/build/perf/pmu-events/
>   HOSTCC   /tmp/build/perf/pmu-events/json.o
>   CC       /tmp/build/perf/libbpf.o
>   CC       /tmp/build/perf/kbuffer-parse.o
>   MKDIR    /tmp/build/perf/pmu-events/
>   CC       /tmp/build/perf/help.o
>   HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
>   LD       /tmp/build/perf/libtraceevent-in.o
>   LINK     /tmp/build/perf/libtraceevent.a
>   MKDIR    /tmp/build/perf/pmu-events/
>   HOSTCC   /tmp/build/perf/pmu-events/jevents.o
>   CC       /tmp/build/perf/bpf.o
>   CC       /tmp/build/perf/nlattr.o
>   MKDIR    /tmp/build/perf/pmu-events/
>   HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
>   CC       /tmp/build/perf/pager.o
>   CC       /tmp/build/perf/plugin_jbd2.o
>   CC       /tmp/build/perf/plugin_hrtimer.o
>   CC       /tmp/build/perf/btf.o
>   LD       /tmp/build/perf/plugin_jbd2-in.o
>   LD       /tmp/build/perf/plugin_hrtimer-in.o
>   CC       /tmp/build/perf/parse-options.o
>   CC       /tmp/build/perf/plugin_kmem.o
>   GEN      perf-archive
>   CC       /tmp/build/perf/plugin_kvm.o
>   LD       /tmp/build/perf/libbpf-in.o
>   LINK     /tmp/build/perf/libbpf.a
>   LD       /tmp/build/perf/plugin_kmem-in.o
>   CC       /tmp/build/perf/plugin_mac80211.o
>   CC       /tmp/build/perf/plugin_sched_switch.o
>   LD       /tmp/build/perf/plugin_kvm-in.o
>   CC       /tmp/build/perf/plugin_function.o
>   LD       /tmp/build/perf/plugin_mac80211-in.o
>   LD       /tmp/build/perf/plugin_sched_switch-in.o
>   CC       /tmp/build/perf/plugin_xen.o
>   CC       /tmp/build/perf/plugin_scsi.o
>   LD       /tmp/build/perf/plugin_function-in.o
>   CC       /tmp/build/perf/plugin_cfg80211.o
>   LD       /tmp/build/perf/plugin_xen-in.o
>   GEN      perf-with-kcore
>   CC       /tmp/build/perf/run-command.o
>   LD       /tmp/build/perf/plugin_scsi-in.o
>   LD       /tmp/build/perf/plugin_cfg80211-in.o
>   CC       /tmp/build/perf/sigchain.o
>   LINK     /tmp/build/perf/plugin_jbd2.so
>   LINK     /tmp/build/perf/plugin_hrtimer.so
>   LINK     /tmp/build/perf/plugin_kmem.so
>   LINK     /tmp/build/perf/plugin_kvm.so
>   LINK     /tmp/build/perf/plugin_mac80211.so
>   LINK     /tmp/build/perf/plugin_sched_switch.so
>   CC       /tmp/build/perf/subcmd-config.o
>   LINK     /tmp/build/perf/plugin_function.so
>   LINK     /tmp/build/perf/plugin_xen.so
>   LINK     /tmp/build/perf/plugin_scsi.so
>   LINK     /tmp/build/perf/plugin_cfg80211.so
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/annotate.o
>   CC       /tmp/build/perf/arch/common.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/block-range.o
>   LD       /tmp/build/perf/libsubcmd-in.o
>   AR       /tmp/build/perf/libsubcmd.a
>   MKDIR    /tmp/build/perf/arch/arm64/util/
>   CC       /tmp/build/perf/arch/arm64/util/header.o
>   MKDIR    /tmp/build/perf/arch/arm64/tests/
>   CC       /tmp/build/perf/arch/arm64/tests/regs_load.o
>   MKDIR    /tmp/build/perf/arch/arm64/tests/
>   CC       /tmp/build/perf/arch/arm64/tests/dwarf-unwind.o
>   MKDIR    /tmp/build/perf/arch/arm64/util/
>   CC       /tmp/build/perf/arch/arm64/util/sym-handling.o
>   MKDIR    /tmp/build/perf/arch/arm64/util/
>   CC       /tmp/build/perf/arch/arm64/util/dwarf-regs.o
>   MKDIR    /tmp/build/perf/arch/arm64/tests/
>   CC       /tmp/build/perf/arch/arm64/tests/arch-tests.o
>   MKDIR    /tmp/build/perf/util/
>   MKDIR    /tmp/build/perf/arch/arm64/util/
>   CC       /tmp/build/perf/arch/arm64/util/unwind-libdw.o
>   CC       /tmp/build/perf/util/build-id.o
>   MKDIR    /tmp/build/perf/arch/arm64/tests/
>   LD       /tmp/build/perf/arch/arm64/tests/libperf-in.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/config.o
>   MKDIR    /tmp/build/perf/arch/arm64/util/../../arm/util/
>   CC       /tmp/build/perf/arch/arm64/util/../../arm/util/pmu.o
>   MKDIR    /tmp/build/perf/arch/arm64/util/../../arm/util/
>   CC       /tmp/build/perf/arch/arm64/util/../../arm/util/auxtrace.o
>   MKDIR    /tmp/build/perf/arch/arm64/util/../../arm/util/
>   CC       /tmp/build/perf/arch/arm64/util/../../arm/util/cs-etm.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/ctype.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/db-export.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/env.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/event.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/evlist.o
>   MKDIR    /tmp/build/perf/arch/arm64/util/
>   CC       /tmp/build/perf/arch/arm64/util/arm-spe.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/evsel.o
>   MKDIR    /tmp/build/perf/arch/arm64/util/
>   LD       /tmp/build/perf/arch/arm64/util/libperf-in.o
>   LD       /tmp/build/perf/arch/arm64/libperf-in.o
>   LD       /tmp/build/perf/arch/libperf-in.o
>   MKDIR    /tmp/build/perf/ui/
>   CC       /tmp/build/perf/ui/setup.o
>   MKDIR    /tmp/build/perf/ui/
>   CC       /tmp/build/perf/ui/helpline.o
>   MKDIR    /tmp/build/perf/ui/
>   CC       /tmp/build/perf/ui/progress.o
>   MKDIR    /tmp/build/perf/ui/
>   CC       /tmp/build/perf/ui/util.o
>   MKDIR    /tmp/build/perf/ui/
>   CC       /tmp/build/perf/ui/hist.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/evsel_fprintf.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/find_bit.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/kallsyms.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/levenshtein.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/llvm-utils.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/mmap.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/memswap.o
>   CC       /tmp/build/perf/builtin-bench.o
>   LINK     /tmp/build/perf/pmu-events/jevents
>   MKDIR    /tmp/build/perf/scripts/
>   LD       /tmp/build/perf/scripts/libperf-in.o
>   CC       /tmp/build/perf/trace/beauty/clone.o
>   CC       /tmp/build/perf/builtin-annotate.o
>   CC       /tmp/build/perf/trace/beauty/fcntl.o
>   CC       /tmp/build/perf/trace/beauty/flock.o
>   CC       /tmp/build/perf/trace/beauty/kcmp.o
>   MKDIR    /tmp/build/perf/util/
>   BISON    /tmp/build/perf/util/parse-events-bison.c
>   CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
>   CC       /tmp/build/perf/builtin-config.o
>   CC       /tmp/build/perf/trace/beauty/prctl.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/perf_regs.o
>   MKDIR    /tmp/build/perf/ui/stdio/
>   CC       /tmp/build/perf/ui/stdio/hist.o
>   CC       /tmp/build/perf/trace/beauty/statx.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/path.o
>   CC       /tmp/build/perf/builtin-diff.o
>   LD       /tmp/build/perf/trace/beauty/libperf-in.o
>   GEN      /tmp/build/perf/libtraceevent-dynamic-list
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/print_binary.o
>   GEN      /tmp/build/perf/pmu-events/pmu-events.c
>   CC       /tmp/build/perf/pmu-events/pmu-events.o
>   LD       /tmp/build/perf/pmu-events/pmu-events-in.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/rbtree.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/libstring.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/bitmap.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/hweight.o
>   MKDIR    /tmp/build/perf/util/
>   MKDIR    /tmp/build/perf/ui/
>   CC       /tmp/build/perf/builtin-evlist.o
>   CC       /tmp/build/perf/util/smt.o
>   LD       /tmp/build/perf/ui/libperf-in.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/strbuf.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/string.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/strlist.o
>   CC       /tmp/build/perf/builtin-ftrace.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/strfilter.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/top.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/usage.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/dso.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/symbol.o
>   CC       /tmp/build/perf/builtin-help.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/symbol_fprintf.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/color.o
>   CC       /tmp/build/perf/builtin-sched.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/metricgroup.o
>   CC       /tmp/build/perf/builtin-buildid-list.o
>   CC       /tmp/build/perf/builtin-buildid-cache.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/header.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/callchain.o
>   CC       /tmp/build/perf/builtin-kallsyms.o
>   CC       /tmp/build/perf/builtin-list.o
>   CC       /tmp/build/perf/builtin-record.o
>   CC       /tmp/build/perf/builtin-report.o
>   CC       /tmp/build/perf/builtin-stat.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/values.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/debug.o
>   CC       /tmp/build/perf/builtin-timechart.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/machine.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/map.o
>   CC       /tmp/build/perf/builtin-top.o
>   CC       /tmp/build/perf/builtin-script.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/pstack.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/session.o
>   MKDIR    /tmp/build/perf/util/
>   CC       /tmp/build/perf/util/syscalltbl.o
> util/syscalltbl.c:43:38:SYSCALLTBL_ARM64_MAX_ID' undeclared here (not in =
a function)
>  const int syscalltbl_native_max_id =3D SYSCALLTBL_ARM64_MAX_ID;
> mv: cannot stat '/tmp/build/perf/util/.syscalltbl.o.tmp': No such file or=
 directory
> make[4]: *** [/tmp/build/perf/util/syscalltbl.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   CC       /tmp/build/perf/builtin-kmem.o
>   CC       /tmp/build/perf/builtin-lock.o
>   CC       /tmp/build/perf/builtin-kvm.o
> make[3]: *** [util] Error 2
> make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC       /tmp/build/perf/builtin-inject.o
>   CC       /tmp/build/perf/builtin-mem.o
>   CC       /tmp/build/perf/builtin-data.o
>   CC       /tmp/build/perf/builtin-version.o
>   CC       /tmp/build/perf/builtin-c2c.o
>   CC       /tmp/build/perf/builtin-trace.o
>   CC       /tmp/build/perf/builtin-probe.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/sched-messaging.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/builtin-test.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/sched-pipe.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/parse-events.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/mem-functions.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/futex-hash.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/futex-wake.o
>   CC       /tmp/build/perf/perf.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/futex-wake-parallel.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/futex-requeue.o
>   MKDIR    /tmp/build/perf/bench/
>   CC       /tmp/build/perf/bench/futex-lock-pi.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/dso-data.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/attr.o
>   MKDIR    /tmp/build/perf/bench/
>   LD       /tmp/build/perf/bench/perf-in.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/openat-syscall.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/mmap-basic.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/perf-record.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/evsel-tp-sched.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/fdarray.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/pmu.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/hists_common.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/hists_link.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/hists_filter.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/hists_output.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/hists_cumulate.o
>   MKDIR    /tmp/build/perf/tests/
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/bp_signal.o
>   CC       /tmp/build/perf/tests/python-use.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/bp_signal_overflow.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/bp_account.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/task-exit.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/sw-clock.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/mmap-thread-lookup.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/thread-mg-share.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/switch-tracking.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/keep-tracking.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/code-reading.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/sample-parsing.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/kmod-path.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/thread-map.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/llvm.o
>   MKDIR    /tmp/build/perf/tests/
>   MKDIR    /tmp/build/perf/tests/
>   MKDIR    /tmp/build/perf/tests/
>   MKDIR    /tmp/build/perf/tests/
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/bpf.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/topology.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/mem.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/cpumap.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/stat.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/event_update.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/event-times.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/expr.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/backward-ring-buffer.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/sdt.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/is_printable_array.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/bitmap.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/perf-hooks.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/clang.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/unit_number__scnprintf.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/mem2node.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/dwarf-unwind.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/llvm-src-base.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/llvm-src-kbuild.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/llvm-src-prologue.o
>   MKDIR    /tmp/build/perf/tests/
>   CC       /tmp/build/perf/tests/llvm-src-relocation.o
>   MKDIR    /tmp/build/perf/tests/
>   LD       /tmp/build/perf/tests/perf-in.o
>   LD       /tmp/build/perf/perf-in.o
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> make: Leaving directory `/git/linux/tools/perf'
