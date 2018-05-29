Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965740AbeE2SHr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:07:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46265 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936850AbeE2SHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:07:45 -0400
X-Google-Smtp-Source: AB8JxZoj/+kfYUAaoIhWBRskXPkKdMllrxztdxAJZlMoSE261csZdqAg5Cjp47kWetGiVqMTaXQJfEK/dKzDwpbJemA=
MIME-Version: 1.0
References: <CABPqkBRi5T2-hqgywLundiu=w1ekbjdAeKCrzRaUUrMSPSxvFw@mail.gmail.com>
 <20180526121826.GB11944@redhat.com>
In-Reply-To: <20180526121826.GB11944@redhat.com>
From: Stephane Eranian <eranian@google.com>
Date: Tue, 29 May 2018 11:07:32 -0700
Message-ID: <CABPqkBR7-tB2LCEPdCsyCQ9REKcjZSSd-oObn2bvFed5ULCe0w@mail.gmail.com>
Subject: Re: [BUG] perf/inject: crash in pipe mode
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        mingo@elte.hu, Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,
On Sat, May 26, 2018 at 5:18 AM Arnaldo Carvalho de Melo <acme@redhat.com>
wrote:

> Em Fri, May 25, 2018 at 05:19:54PM -0700, Stephane Eranian escreveu:
> >
> > With the latest tip.git perf, if you run
> >
> > $ perf record -a -o - sleep 2 | perf inject -b -i - | perf buildid-list
-i -
> > SEGFAULT in perf inject:

> I'm not being able to reproduce this problem here:

> [root@seventh ~]# perf record -a -o - sleep 2 | perf inject -b -i - 2>
> /dev/null | perf buildid-list -i - | wc -l
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.000 MB - ]
> 1038
> [root@seventh ~]# perf --version
> perf version 4.17.rc5.g615aaf
> [root@seventh ~]#

> This is with my private perf/core branch, lets see with tip.git/master

I resync'd my tip.git and the problem has disappeared.
All okay then.
Thanks for checking.

> [acme@seventh perf]$ git checkout -b tip-master tip/master
> Branch tip-master set up to track remote branch master from tip.
> Switched to a new branch 'tip-master'
> [acme@seventh perf]$ rm -rf /tmp/build/perf/ ; mkdir -p /tmp/build/perf ;
make -C tools/perf O=/tmp/build/perf install-bin
> [root@seventh ~]# perf --version
> perf version 4.17.rc6.g99a7f2
> [root@seventh ~]#
> [root@seventh ~]# perf record -a -o - sleep 2 | perf inject -b -i - 2>
/dev/null | perf buildid-list -i - | wc -l
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.000 MB - ]
> 1038
> [root@seventh ~]#
> [acme@seventh perf]$ git log --oneline -5
> 99a7f2c81712 (HEAD -> tip-master, tip/master) Merge branch 'perf/core'
> 861410270ab5 (tip/perf/core, jouet/perf/core, acme/perf/core) Merge tag
> 'perf-core-for-mingo-4.18-20180523' of
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
> dc0a16dd9952 Merge branch 'x86/pti'
> 88a582678aa9 Merge branch 'linus'
> bee797529d7c (torvalds/master) Merge tag 'mfd-fixes-4.17' of
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
> [acme@seventh perf]$
> [acme@seventh perf]$ perf version --build-options
> perf version 4.17.rc6.g99a7f2
>                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
>           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> [acme@seventh perf]$
> [acme@seventh perf]$ ldd ~/bin/perf
>          linux-vdso.so.1 (0x00007fff2095f000)
>          libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8
(0x00007fd0e7f01000)
>          libunwind.so.8 => /lib64/libunwind.so.8 (0x00007fd0e7ce7000)
>          liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fd0e7ac1000)
>          libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fd0e78a3000)
>          librt.so.1 => /lib64/librt.so.1 (0x00007fd0e769b000)
>          libm.so.6 => /lib64/libm.so.6 (0x00007fd0e7350000)
>          libdl.so.2 => /lib64/libdl.so.2 (0x00007fd0e714c000)
>          libelf.so.1 => /lib64/libelf.so.1 (0x00007fd0e6f34000)
>          libdw.so.1 => /lib64/libdw.so.1 (0x00007fd0e6cec000)
>          libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007fd0e6864000)
>          libslang.so.2 => /lib64/libslang.so.2 (0x00007fd0e639e000)
>          libperl.so.5.26 => /lib64/libperl.so.5.26 (0x00007fd0e5f97000)
>          libresolv.so.2 => /lib64/libresolv.so.2 (0x00007fd0e5d80000)
>          libnsl.so.1 => /lib64/libnsl.so.1 (0x00007fd0e5b68000)
>          libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007fd0e5932000)
>          libutil.so.1 => /lib64/libutil.so.1 (0x00007fd0e572f000)
>          libc.so.6 => /lib64/libc.so.6 (0x00007fd0e5379000)
/lib64/ld-linux-x86-64.so.2 (0x00007fd0e8120000)
>          libpython2.7.so.1.0 => /lib64/libpython2.7.so.1.0
(0x00007fd0e4f3a000)
>          libz.so.1 => /lib64/libz.so.1 (0x00007fd0e4d23000)
>          libnuma.so.1 => /lib64/libnuma.so.1 (0x00007fd0e4b18000)
>          libbabeltrace-ctf.so.1 => /lib64/libbabeltrace-ctf.so.1
(0x00007fd0e48c8000)
>          libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fd0e46b1000)
>          libbz2.so.1 => /lib64/libbz2.so.1 (0x00007fd0e44a0000)
>          libfreebl3.so => /lib64/libfreebl3.so (0x00007fd0e429d000)
>          libbabeltrace.so.1 => /lib64/libbabeltrace.so.1
(0x00007fd0e4090000)
>          libpopt.so.0 => /lib64/libpopt.so.0 (0x00007fd0e3e83000)
>          libuuid.so.1 => /lib64/libuuid.so.1 (0x00007fd0e3c7e000)
>          libgmodule-2.0.so.0 => /lib64/libgmodule-2.0.so.0
(0x00007fd0e3a7a000)
>          libglib-2.0.so.0 => /lib64/libglib-2.0.so.0 (0x00007fd0e3766000)
>          libpcre.so.1 => /lib64/libpcre.so.1 (0x00007fd0e34f4000)
> [acme@seventh perf]$
> [root@seventh ~]# cat /etc/fedora-release
> Fedora release 27 (Twenty Seven)
> [root@seventh ~]#

> > free_dup_event (oe=0x555555d25b88, oe=0x555555d25b88,
> > event=0x3030310931303031) at util/ordered-events.c:86
> > 86 oe->cur_alloc_size -= event->header.size;
> > (gdb) bt
> > #0  free_dup_event (oe=0x555555d25b88, oe=0x555555d25b88,
> > event=0x3030310931303031) at util/ordered-events.c:86
> > #1  ordered_events__free (oe=oe@entry=0x555555d25b88) at
> > util/ordered-events.c:310
> > #2  0x00005555557964f8 in __perf_session__process_pipe_events
> > (session=0x555555d1f910) at util/session.c:1778
> > #3  perf_session__process_events (session=session@entry=0x555555d1f910)
at
> > util/session.c:1958
> > #4  0x00005555556ef9b2 in __cmd_inject (inject=0x7fffffffda40) at
> > builtin-inject.c:697
> > #5  cmd_inject (argc=<optimized out>, argv=<optimized out>) at
> > builtin-inject.c:871
> > #6  0x000055555572e8b1 in run_builtin (p=0x555555be8f98 <commands+600>,
> > argc=4, argv=0x7fffffffe460) at perf.c:303
> > #7  0x000055555572ebae in handle_internal_command (argc=4,
> > argv=0x7fffffffe460) at perf.c:355
> > #8  0x00005555556ae1e1 in run_argv (argcp=<synthetic pointer>,
> > argv=<synthetic pointer>) at perf.c:399
> > #9  main (argc=<optimized out>, argv=0x7fffffffe460) at perf.c:521
> >
> > In general I think the pipe mode is not very well tested. I think it
could
> > be made the default file format. I believe perf can
> > autodetect file vs. pipe mode perf.data using the header.size field.
This
> > would simplify a few things inside perf and ensure
> > the pipe mode format is well tested.
