Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6C9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FF12081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDfgWaFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FF12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeKAAo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeKAAo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:44:29 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221372080A;
        Wed, 31 Oct 2018 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541000754;
        bh=yXl8bF7fYrnLHhmF/7iWdZlHW0L0sN+2bZRua5HIjPU=;
        h=Date:From:To:Cc:Subject:From;
        b=YDfgWaFpWrDav9qJkSgbTByDruS/KBGT9YTO8loIQydfmyIYvYJUd/1N9s5+bHF0Y
         EvZWoGFgyRT/JCtV4KDHMyRFFWdBDmp3GF1sgxtm/M/i0z8qTckLSmpI0DpXkFsWeA
         zKXSlqYZlVeKPgYevHzVAkqrd3VRX5G83l4eGrvE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B3036142D18; Wed, 31 Oct 2018 12:45:50 -0300 (-03)
Date:   Wed, 31 Oct 2018 12:45:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: arm64 tools build failure wrt smp_load_{acquire,release} expansion
 on gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)
Message-ID: <20181031154550.GA28340@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I noticed the following build failure thare point to:

commit 09d62154f61316f7e97eae3f31ef8770c7e4b386
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Fri Oct 19 15:51:02 2018 +0200

    tools, perf: add and use optimized ring_buffer_{read_head, write_tail} =
helpers

-------------------------

  50 ubuntu:16.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Lin=
aro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
 =20
Works well with:

  59 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Lin=
aro 7.3.0-27ubuntu1~18.04) 7.3.0

And all the other environments I test build :-)

Peter, do you recall something simple that could fix this?

- Arnaldo

[root@seventh linux-perf-tools-build]# cat /tmp/dm.log/ubuntu\:16.04-x-arm6=
4=20
ubuntu:16.04-x-arm64
Downloading http://192.168.86.4/perf/perf-4.19.0.tar.xz...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Cur=
rent
                                 Dload  Upload   Total   Spent    Left  Spe=
ed
100 1388k  100 1388k    0     0  82.9M      0 --:--:-- --:--:-- --:--:-- 90=
=2E3M
e8eb3b801d8447b247f48e501e7d555384950388
Using built-in specs.
COLLECT_GCC=3Daarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc-cross/aarch64-linux-gnu/5/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu/Linaro 5.4=
=2E0-6ubuntu1~16.04.9' --with-bugurl=3Dfile:///usr/share/doc/gcc-5/README.B=
ugs --enable-languages=3Dc,ada,c++,java,go,d,fortran,objc,obj-c++ --prefix=
=3D/usr --program-suffix=3D-5 --enable-shared --enable-linker-build-id --li=
bexecdir=3D/usr/lib --without-included-gettext --enable-threads=3Dposix --l=
ibdir=3D/usr/lib --enable-nls --with-sysroot=3D/ --enable-clocale=3Dgnu --e=
nable-libstdcxx-debug --enable-libstdcxx-time=3Dyes --with-default-libstdcx=
x-abi=3Dnew --enable-gnu-unique-object --disable-libquadmath --enable-plugi=
n --with-system-zlib --disable-browser-plugin --enable-java-awt=3Dgtk --ena=
ble-gtk-cairo --with-java-home=3D/usr/lib/jvm/java-1.5.0-gcj-5-arm64-cross/=
jre --enable-java-home --with-jvm-root-dir=3D/usr/lib/jvm/java-1.5.0-gcj-5-=
arm64-cross --with-jvm-jar-dir=3D/usr/lib/jvm-exports/java-1.5.0-gcj-5-arm6=
4-cross --with-arch-directory=3Daarch64 --with-ecj-jar=3D/usr/share/java/ec=
lipse-ecj.jar --disable-libgcj --enable-multiarch --enable-fix-cortex-a53-8=
43419 --disable-werror --enable-checking=3Drelease --build=3Dx86_64-linux-g=
nu --host=3Dx86_64-linux-gnu --target=3Daarch64-linux-gnu --program-prefix=
=3Daarch64-linux-gnu- --includedir=3D/usr/aarch64-linux-gnu/include
Thread model: posix
gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)=20
make: Entering directory '/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep
sh: 1: command: Illegal option -c

Auto-detecting system features:
=2E..                         dwarf: [ on  ]
=2E..            dwarf_getlocations: [ on  ]
=2E..                         glibc: [ on  ]
=2E..                          gtk2: [ OFF ]
=2E..                      libaudit: [ OFF ]
=2E..                        libbfd: [ OFF ]
=2E..                        libelf: [ on  ]
=2E..                       libnuma: [ OFF ]
=2E..        numa_num_possible_cpus: [ OFF ]
=2E..                       libperl: [ OFF ]
=2E..                     libpython: [ OFF ]
=2E..                      libslang: [ OFF ]
=2E..                     libcrypto: [ OFF ]
=2E..                     libunwind: [ OFF ]
=2E..            libdw-dwarf-unwind: [ on  ]
=2E..                          zlib: [ on  ]
=2E..                          lzma: [ OFF ]
=2E..                     get_cpuid: [ OFF ]
=2E..                           bpf: [ on  ]

Makefile.config:445: No sys/sdt.h found, no SDT events are defined, please =
install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:491: No libunwind found. Please install libunwind-dev[el] >=
=3D 1.1 and/or set LIBUNWIND_DIR
Makefile.config:583: No libcrypto.h found, disables jitted code injection, =
please install libssl-devel or libssl-dev
Makefile.config:598: slang not found, disables TUI support. Please install =
slang-devel, libslang-dev or libslang2-dev
Makefile.config:612: GTK2 not found, disables GTK2 support. Please install =
gtk2-devel or libgtk2.0-dev
Makefile.config:639: Missing perl devel files. Disabling perl scripting sup=
port, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:666: No python interpreter was found: disables Python suppo=
rt - please install python-devel/python-dev
Makefile.config:721: No bfd.h/libbfd found, please install binutils-dev[el]=
/zlib-static/libiberty-dev to gain symbol demangling
Makefile.config:750: No liblzma found, disables xz kernel module decompress=
ion, please install xz-devel/liblzma-dev
Makefile.config:763: No numa.h found, disables 'perf bench numa mem' benchm=
ark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF forma=
t support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:840: No alternatives command found, you need to set JDIR=3D=
 to point to the root of your Java directory
  GEN      /tmp/build/perf/common-cmds.h
  PERF_VERSION =3D 4.19.ge8eb3b8
<SNIP>
  CC       /tmp/build/perf/plugin_sched_switch.o
  CC       /tmp/build/perf/util/annotate.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  CC       /tmp/build/perf/plugin_function.o
  LD       /tmp/build/perf/plugin_kvm-in.o
  CC       /tmp/build/perf/plugin_xen.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  CC       /tmp/build/perf/arch/common.o
  LD       /tmp/build/perf/plugin_function-in.o
  LD       /tmp/build/perf/plugin_xen-in.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/plugin_scsi.o
In file included from /git/linux/tools/include/asm/barrier.h:8:0,
                 from util/../perf-sys.h:11,
                 from util/../perf.h:18,
                 from util/symbol.h:9,
                 from util/sort.h:12,
                 from util/annotate.c:14:
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_read=
_head':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_writ=
e_tail':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
  LD       /tmp/build/perf/plugin_scsi-in.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_jbd2.so
  MKDIR    /tmp/build/perf/arch/arm64/util/
  MKDIR    /tmp/build/perf/ui/
  LINK     /tmp/build/perf/plugin_hrtimer.so
  CC       /tmp/build/perf/arch/arm64/util/header.o
  CC       /tmp/build/perf/ui/helpline.o
  LINK     /tmp/build/perf/plugin_kmem.so
  LINK     /tmp/build/perf/plugin_kvm.so
  LINK     /tmp/build/perf/plugin_mac80211.so
  LINK     /tmp/build/perf/plugin_sched_switch.so
  LINK     /tmp/build/perf/plugin_function.so
  MKDIR    /tmp/build/perf/arch/arm64/util/
  CC       /tmp/build/perf/arch/arm64/util/sym-handling.o
  CC       /tmp/build/perf/ui/progress.o
  LINK     /tmp/build/perf/plugin_xen.so
  LINK     /tmp/build/perf/plugin_scsi.so
  LINK     /tmp/build/perf/plugin_cfg80211.so
  MKDIR    /tmp/build/perf/arch/arm64/tests/
  CC       /tmp/build/perf/arch/arm64/tests/regs_load.o
  CC       /tmp/build/perf/ui/util.o
  MKDIR    /tmp/build/perf/arch/arm64/tests/
  CC       /tmp/build/perf/arch/arm64/tests/dwarf-unwind.o
  CC       /tmp/build/perf/arch/arm64/util/dwarf-regs.o
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/arch/arm64/util/unwind-libdw.o
  CC       /tmp/build/perf/arch/arm64/tests/arch-tests.o
  LD       /tmp/build/perf/arch/arm64/tests/libperf-in.o
  MKDIR    /tmp/build/perf/arch/arm64/util/../../arm/util/
  CC       /tmp/build/perf/arch/arm64/util/../../arm/util/pmu.o
In file included from /git/linux/tools/include/asm/barrier.h:8:0,
                 from ui/../util/../perf-sys.h:11,
                 from ui/../util/../perf.h:18,
                 from ui/../util/callchain.h:5,
                 from ui/../util/hist.h:7,
                 from ui/hist.c:6:
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_read=
_head':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_writ=
e_tail':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
  MKDIR    /tmp/build/perf/arch/arm64/util/../../arm/util/
  CC       /tmp/build/perf/arch/arm64/util/../../arm/util/auxtrace.o
  CC       /tmp/build/perf/arch/arm64/util/../../arm/util/cs-etm.o
In file included from /git/linux/tools/include/asm/barrier.h:8:0,
                 from /git/linux/tools/perf/util/include/../../util/../perf=
-sys.h:11,
                 from /git/linux/tools/perf/util/include/../../util/../perf=
=2Eh:18,
                 from /git/linux/tools/perf/util/include/../../util/auxtrac=
e.h:28,
                 from arch/arm64/util/../../arm/util/auxtrace.c:10:
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_read=
_head':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_writ=
e_tail':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
In file included from /git/linux/tools/include/asm/barrier.h:8:0,
                 from /git/linux/tools/perf/util/include/../../util/../perf=
-sys.h:11,
                 from /git/linux/tools/perf/util/include/../../util/../perf=
=2Eh:18,
                 from /git/linux/tools/perf/util/include/../../util/symbol.=
h:9,
                 from /git/linux/tools/perf/util/include/../../util/evsel.h=
:11,
                 from arch/arm64/util/../../arm/util/cs-etm.h:10,
                 from arch/arm64/util/../../arm/util/cs-etm.c:15:
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_read=
_head':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_writ=
e_tail':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/arch/arm64/util/../../arm/util/.auxtrace.o=
=2Etmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/per=
f/arch/arm64/util/../../arm/util/auxtrace.o' failed
make[6]: *** [/tmp/build/perf/arch/arm64/util/../../arm/util/auxtrace.o] Er=
ror 1
make[6]: *** Waiting for unfinished jobs....
  MKDIR    /tmp/build/perf/scripts/
  LD       /tmp/build/perf/scripts/libperf-in.o
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/trace/beauty/fcntl.o
  CC       /tmp/build/perf/trace/beauty/flock.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/arch/arm64/util/../../arm/util/.cs-etm.o.t=
mp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/per=
f/arch/arm64/util/../../arm/util/cs-etm.o' failed
make[6]: *** [/tmp/build/perf/arch/arm64/util/../../arm/util/cs-etm.o] Erro=
r 1
/git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
make[5]: *** [util] Error 2
/git/linux/tools/build/Makefile.build:139: recipe for target 'arm64' failed
make[4]: *** [arm64] Error 2
/git/linux/tools/build/Makefile.build:139: recipe for target 'arch' failed
make[3]: *** [arch] Error 2
make[3]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/trace/beauty/kcmp.o
  CC       /tmp/build/perf/trace/beauty/mount_flags.o
  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/trace/beauty/prctl.o
  CC       /tmp/build/perf/trace/beauty/sockaddr.o
  CC       /tmp/build/perf/trace/beauty/socket.o
  CC       /tmp/build/perf/trace/beauty/statx.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  LD       /tmp/build/perf/trace/beauty/libperf-in.o
  CC       /tmp/build/perf/builtin-bench.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.annotate.o.tmp': No such file or dir=
ectory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/per=
f/util/annotate.o' failed
make[4]: *** [/tmp/build/perf/util/annotate.o] Error 1
/git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
make[3]: *** [util] Error 2
  LINK     /tmp/build/perf/pmu-events/jevents
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
  CC       /tmp/build/perf/builtin-annotate.o
  CC       /tmp/build/perf/builtin-config.o
In file included from /git/linux/tools/include/asm/barrier.h:8:0,
                 from util/../perf-sys.h:11,
                 from util/../perf.h:18,
                 from util/symbol.h:9,
                 from builtin-annotate.c:16:
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_read=
_head':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_writ=
e_tail':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
  CC       /tmp/build/perf/builtin-diff.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/ui/.hist.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/per=
f/ui/hist.o' failed
make[4]: *** [/tmp/build/perf/ui/hist.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/builtin-evlist.o
In file included from /git/linux/tools/include/asm/barrier.h:8:0,
                 from util/../perf-sys.h:11,
                 from util/../perf.h:18,
                 from util/event.h:9,
                 from util/debug.h:9,
                 from builtin-diff.c:10:
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_read=
_head':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_writ=
e_tail':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
In file included from /git/linux/tools/include/asm/barrier.h:8:0,
                 from perf-sys.h:11,
                 from perf.h:18,
                 from builtin-evlist.c:12:
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_read=
_head':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:56:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u;  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:58:9: note: in expansion of ma=
cro 'smp_load_acquire'
  return smp_load_acquire(&base->data_head);
         ^
/git/linux/tools/include/linux/ring_buffer.h: In function 'ring_buffer_writ=
e_tail':
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
/git/linux/tools/include/asm/../../arch/arm64/include/asm/barrier.h:19:8: e=
rror: dereferencing type-punned pointer will break strict-aliasing rules [-=
Werror=3Dstrict-aliasing]
  union { typeof(*p) __val; char __c[1]; } __u =3D  \
        ^
/git/linux/tools/include/linux/ring_buffer.h:70:2: note: in expansion of ma=
cro 'smp_store_release'
  smp_store_release(&base->data_tail, tail);
  ^
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/.builtin-annotate.o.tmp': No such file or =
directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/per=
f/builtin-annotate.o' failed
make[3]: *** [/tmp/build/perf/builtin-annotate.o] Error 1
make[3]: *** Waiting for unfinished jobs....
/git/linux/tools/build/Makefile.build:139: recipe for target 'ui' failed
make[3]: *** [ui] Error 2
Makefile.perf:650: recipe for target '/tmp/build/perf/libperf-in.o' failed
make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/.builtin-evlist.o.tmp': No such file or di=
rectory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/per=
f/builtin-evlist.o' failed
make[3]: *** [/tmp/build/perf/builtin-evlist.o] Error 1
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/.builtin-diff.o.tmp': No such file or dire=
ctory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/per=
f/builtin-diff.o' failed
make[3]: *** [/tmp/build/perf/builtin-diff.o] Error 1
Makefile.perf:522: recipe for target '/tmp/build/perf/perf-in.o' failed
make[2]: *** [/tmp/build/perf/perf-in.o] Error 2
Makefile.perf:206: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
make: Leaving directory '/git/linux/tools/perf'
[root@seventh linux-perf-tools-build]#=20

