Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeDLA3p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 20:29:45 -0400
Received: from foss.arm.com ([217.140.101.70]:55844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeDLA3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 20:29:43 -0400
Date: Wed, 11 Apr 2018 19:29:40 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, <kernel-team@lge.com>
Subject: Re: [PATCH] Revert
 "perf machine: Fix paranoid check in machine__set_kernel_mmap()"
Message-Id: <20180411192940.de8143a80bd9e5d98d87f6ec@arm.com>
In-Reply-To: <20180411233109.GA6320@sejong>
References: <20180215122635.24029-1-jolsa@kernel.org>
        <20180215122635.24029-7-jolsa@kernel.org>
        <20180219022036.GB1583@sejong>
        <20180219100140.GA17630@krava>
        <20180219101936.GD1583@sejong>
        <20180219104917.GA19365@krava>
        <20180219121817.GC14978@kernel.org>
        <20180411180752.b64c4d105222fb22c159b852@arm.com>
        <20180411233109.GA6320@sejong>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 08:31:09 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,

Hi,

> On Wed, Apr 11, 2018 at 06:07:52PM -0500, Kim Phillips wrote:
> > ---
> > It's not clear to me what the specific intent of the original commit
> > was, thus the revert.
> 
> Hmm.. maybe your kernel map has non-zero start and zero end.  I

On x86, the first line in /proc/kallsyms is:

0000000000000000 A irq_stack_union

On arm64, it's:

ffff200008080000 t _head

Another arm64 box has:

ffff000008080000 t _head

(neither have RANDOMIZE_BASE set FWIW)

> thought it was just from an old or invalid data.  But now I think that

It would be good to know what that was, yes.

> overflow can create it..  could you please show me the mmap event?
> 
>   $ perf script --show-mmap-events

Here you go:

         swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff200008080000(0xdffff7f7ffff) @ 0xffff200008080000]: x [kernel.kallsyms]_text
         swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff2000021e0000(0x18000) @ 0]: x /lib/modules/4.16.0+/kernel/drivers/bus/arm-ccn.ko
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xaaaab6364000(0x160000) @ 0 00:26 996379 625769152]: r-xp /usr/lib/systemd/systemd
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e1f9000(0x4000) @ 0 00:26 931300 625769152]: r-xp /usr/lib64/libuuid.so.1.3.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e21b000(0x40000) @ 0 00:26 948512 625769152]: r-xp /usr/lib64/libblkid.so.1.1.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e27d000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e2b9000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e2da000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e32b000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e492000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e4c7000(0x49000) @ 0 00:26 960295 625769152]: r-xp /usr/lib64/libmount.so.1.1.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e529000(0xf000) @ 0 00:26 653333 625769152]: r-xp /lib64/libapparmor.so.1.3.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e54a000(0x14000) @ 0 00:26 931353 625769152]: r-xp /usr/lib64/libkmod.so.2.2.7
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e57b000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e59c000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e5ed000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e60e000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e62f000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e672000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1/1: [0xffff8e6a0000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xaaaae4dbe000(0xc5000) @ 0 00:26 163364 625769152]: r-xp /usr/sbin/ntpd
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5c32000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5c53000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5c86000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5cc7000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5cef000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5d20000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5d41000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb5ea7000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb6098000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb6149000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb616a000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1002/1002: [0xffffb6198000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xaaaae4dbe000(0xc5000) @ 0 00:26 163364 625769152]: r-xp /usr/sbin/ntpd
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5bde000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5c11000(0x5000) @ 0 00:26 931005 625769152]: r-xp /lib64/libnss_dns-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5c32000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5c53000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5c86000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5cc7000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5cef000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5d20000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5d41000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb5ea7000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb6098000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb6149000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb616a000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            ntpd     0 [000]     0.000000: PERF_RECORD_MMAP2 1003/1003: [0xffffb6198000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xaaaabb5e1000(0xa000) @ 0 00:26 171689 625769152]: r-xp /usr/lib/postfix/master
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff988e6000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff9890d000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff9892e000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98954000(0x14000) @ 0 00:26 976314 625769152]: r-xp /lib64/libgcc_s.so.1
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98985000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98a36000(0x180000) @ 0 00:26 976359 625769152]: r-xp /usr/lib64/libstdc++.so.6.0.24
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98bfc000(0x16e000) @ 0 00:26 150445 625769152]: r-xp /usr/lib64/libicuuc.so.52.1
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98d91000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98db2000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98de5000(0x156000) @ 0 00:26 123918 625769152]: r-xp /usr/lib64/libdb-4.8.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff98f58000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff990be000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff990f3000(0x41000) @ 0 00:26 171685 625769152]: r-xp /usr/lib/postfix/libpostfix-util.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff99156000(0x43000) @ 0 00:26 171682 625769152]: r-xp /usr/lib/postfix/libpostfix-global.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff991b8000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
          master     0 [000]     0.000000: PERF_RECORD_MMAP2 1086/1086: [0xffff991e6000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xaaaad7514000(0x10000) @ 0 00:26 171830 625769152]: r-xp /usr/lib/postfix/qmgr
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff98de5000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff98e0c000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff98e2d000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff98e52000(0x14000) @ 0 00:26 976314 625769152]: r-xp /lib64/libgcc_s.so.1
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff98e84000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff98f35000(0x180000) @ 0 00:26 976359 625769152]: r-xp /usr/lib64/libstdc++.so.6.0.24
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff990fb000(0x16e000) @ 0 00:26 150445 625769152]: r-xp /usr/lib64/libicuuc.so.52.1
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff99290000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff992b1000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff992e4000(0x156000) @ 0 00:26 123918 625769152]: r-xp /usr/lib64/libdb-4.8.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff99457000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff995bd000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff995f2000(0x41000) @ 0 00:26 171685 625769152]: r-xp /usr/lib/postfix/libpostfix-util.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff99655000(0x43000) @ 0 00:26 171682 625769152]: r-xp /usr/lib/postfix/libpostfix-global.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff996b7000(0xa000) @ 0 00:26 171683 625769152]: r-xp /usr/lib/postfix/libpostfix-master.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff996d8000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            qmgr     0 [000]     0.000000: PERF_RECORD_MMAP2 1088/1088: [0xffff99706000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xaaaac7981000(0x10000) @ 0 00:26 163944 625769152]: r-xp /usr/sbin/cron
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3b55000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3b7c000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3b9d000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3bd0000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3c53000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3c74000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3cc5000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3e2b000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3e66000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3e87000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3eca000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            cron     0 [000]     0.000000: PERF_RECORD_MMAP2 1101/1101: [0xffffa3ef8000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xaaaabf99e000(0x160000) @ 0 00:26 996379 625769152]: r-xp /usr/lib/systemd/systemd
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa999a000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa99c1000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa99e2000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9a15000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9a39000(0x4000) @ 0 00:26 931300 625769152]: r-xp /usr/lib64/libuuid.so.1.3.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9a5b000(0x40000) @ 0 00:26 948512 625769152]: r-xp /usr/lib64/libblkid.so.1.1.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9abd000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9af9000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9b1a000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9b6b000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9cd2000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9d07000(0x49000) @ 0 00:26 960295 625769152]: r-xp /usr/lib64/libmount.so.1.1.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9d69000(0xf000) @ 0 00:26 653333 625769152]: r-xp /lib64/libapparmor.so.1.3.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9d8a000(0x14000) @ 0 00:26 931353 625769152]: r-xp /usr/lib64/libkmod.so.2.2.7
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9dbb000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9ddc000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9e2d000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9e4e000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9e6f000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9eb2000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 1153/1153: [0xffffa9ee0000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xaaaab6364000(0x160000) @ 0 00:26 996379 625769152]: r-xp /usr/lib/systemd/systemd
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dd1a000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dd3b000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dd5c000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dd7d000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dd9e000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8ddbf000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dde0000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8de11000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dec5000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8df06000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8df39000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8dfea000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e04b000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e06c000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e08d000(0x4000) @ 0 00:26 931124 625769152]: r-xp /lib64/security/pam_selinux.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e0ae000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e0fd000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e14a000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e171000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e192000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e1c5000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e1f9000(0x4000) @ 0 00:26 931300 625769152]: r-xp /usr/lib64/libuuid.so.1.3.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e21b000(0x40000) @ 0 00:26 948512 625769152]: r-xp /usr/lib64/libblkid.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e27d000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e2b9000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e2da000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e32b000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e492000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e4c7000(0x49000) @ 0 00:26 960295 625769152]: r-xp /usr/lib64/libmount.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e529000(0xf000) @ 0 00:26 653333 625769152]: r-xp /lib64/libapparmor.so.1.3.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e54a000(0x14000) @ 0 00:26 931353 625769152]: r-xp /usr/lib64/libkmod.so.2.2.7
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e57b000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e59c000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e5ed000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e60e000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e62f000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e672000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 1154/1154: [0xffff8e6a0000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xaaaabe3a5000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3eb3000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3ed4000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3ef5000(0x3000) @ 0 00:26 931109 625769152]: r-xp /lib64/security/pam_lastlog.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3f16000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3f37000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3f58000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3fa9000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3fca000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb3ffb000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb40af000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb40f0000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb41a1000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb41c2000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb41e3000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4244000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4265000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4286000(0x2000) @ 0 00:26 931113 625769152]: r-xp /lib64/security/pam_loginuid.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb42a7000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb42cc000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb42ed000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb431a000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb434b000(0x2000) @ 0 00:26 931118 625769152]: r-xp /lib64/security/pam_nologin.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb437c000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb43a3000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb43c4000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb43f7000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb441c000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4451000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4484000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb44a6000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb44c7000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4509000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb455b000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb457c000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb46e2000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4704000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb47e7000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4849000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4898000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb48c9000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb48ea000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4adb000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4b1e000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4b3f000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4b7a000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18656/18656: [0xffffb4ba8000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xaaaabe3a5000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3eb3000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3ed4000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3ef5000(0x3000) @ 0 00:26 931109 625769152]: r-xp /lib64/security/pam_lastlog.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3f16000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3f37000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3f58000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3fa9000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3fca000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb3ffb000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb40af000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb40f0000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb41a1000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb41c2000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb41e3000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4244000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4265000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4286000(0x2000) @ 0 00:26 931113 625769152]: r-xp /lib64/security/pam_loginuid.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb42a7000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb42cc000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb42ed000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb431a000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb434b000(0x2000) @ 0 00:26 931118 625769152]: r-xp /lib64/security/pam_nologin.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb437c000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb43a3000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb43c4000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb43f7000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb441c000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4451000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4484000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb44a6000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb44c7000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4509000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb455b000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb457c000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb46e2000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4704000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb47e7000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4849000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4898000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb48c9000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb48ea000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4adb000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4b1e000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4b3f000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4b7a000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18658/18658: [0xffffb4ba8000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0x400000(0xaf000) @ 0 00:26 129038 625769152]: r-xp /bin/bash
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff93662000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff93689000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff936aa000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff936dd000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff93883000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff939e9000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff93a0a000(0x2c000) @ 0 00:26 996745 625769152]: r-xp /lib64/libtinfo.so.5.9
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff93a50000(0x44000) @ 0 00:26 128536 625769152]: r-xp /lib64/libreadline.so.6.3
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff93ab8000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18659/18659: [0xffff93ae6000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xaaaacebe2000(0x21000) @ 0 00:26 148746 625769152]: r-xp /usr/bin/sudo
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c085000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c0a6000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c0c7000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c0e8000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c11d000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c13e000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c18f000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c1b0000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c1e1000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c295000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c2d6000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c387000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c3a8000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c3c9000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c42a000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c44b000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c46c000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c491000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c4b2000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c501000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c52e000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c57f000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c770000(0x5a000) @ 0 00:26 931333 625769152]: r-xp /lib64/libssl.so.1.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c7e7000(0x1b000) @ 0 00:26 127929 625769152]: r-xp /usr/lib64/libsasl2.so.3.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c818000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c84b000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c87c000(0xe000) @ 0 00:26 128217 625769152]: r-xp /usr/lib64/liblber-2.4.so.2.10.7
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c89d000(0x49000) @ 0 00:26 128219 625769152]: r-xp /usr/lib64/libldap-2.4.so.2.10.7
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c8ff000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c920000(0x5e000) @ 0 00:26 148754 625769152]: r-xp /usr/lib/sudo/sudoers.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c994000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c9bb000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9c9dc000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9ca0f000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9cbb7000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9cbd8000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9cc29000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9cd8f000(0x13000) @ 0 00:26 148751 625769152]: r-xp /usr/lib/sudo/libsudo_util.so.0.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9cdc0000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9cde1000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9ce24000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9ce5f000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 18783/18783: [0xffff9ce8d000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xaaaac90ce000(0x7000) @ 0 00:26 960767 625769152]: r-xp /usr/bin/su
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85485000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff854a6000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff854c7000(0x4000) @ 0 00:26 931136 625769152]: r-xp /lib64/security/pam_xauth.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff854e8000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85509000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff8553e000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff8558f000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff855b0000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff855e1000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85695000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff856d6000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85709000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff857ba000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff857db000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff857fc000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff8585d000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff8587e000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff8589f000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff858d0000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff858f5000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85916000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85965000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85992000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff859c3000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85a14000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85a57000(0x2000) @ 0 00:26 931122 625769152]: r-xp /lib64/security/pam_rootok.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85a88000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85aaf000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85ad0000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85b03000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85caa000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85ccb000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85d06000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85e6c000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85e8d000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85eae000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
              su     0 [000]     0.000000: PERF_RECORD_MMAP2 18784/18784: [0xffff85edc000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0x400000(0xaf000) @ 0 00:26 129038 625769152]: r-xp /bin/bash
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb77f1000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb7818000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb7839000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb786c000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb788d000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb79f3000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb7a14000(0x2c000) @ 0 00:26 996745 625769152]: r-xp /lib64/libtinfo.so.5.9
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb7a5a000(0x44000) @ 0 00:26 128536 625769152]: r-xp /lib64/libreadline.so.6.3
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb7ac2000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 18785/18785: [0xffffb7af0000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xaaaad6745000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9ba67000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9ba8e000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9baaf000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bae2000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bb07000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bb3c000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bb6f000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bb91000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bbb2000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bbf4000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bc46000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bc67000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bdcd000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bdef000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bed2000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bf34000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bf83000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bfb4000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9bfd5000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9c1c6000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9c209000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9c22a000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9c265000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 18953/18953: [0xffff9c293000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xaaaac8285000(0x21000) @ 0 00:26 148746 625769152]: r-xp /usr/bin/sudo
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0a25000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0a46000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0a67000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0a88000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0abd000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0ade000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0b2f000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0b50000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0b81000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0c35000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0c76000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0d27000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0d48000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0d69000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0dca000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0deb000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0e0c000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0e31000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0e52000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0ea1000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0ece000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa0f1f000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa1110000(0x5a000) @ 0 00:26 931333 625769152]: r-xp /lib64/libssl.so.1.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa1187000(0x1b000) @ 0 00:26 127929 625769152]: r-xp /usr/lib64/libsasl2.so.3.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa11b8000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa11eb000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa121c000(0xe000) @ 0 00:26 128217 625769152]: r-xp /usr/lib64/liblber-2.4.so.2.10.7
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa123d000(0x49000) @ 0 00:26 128219 625769152]: r-xp /usr/lib64/libldap-2.4.so.2.10.7
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa129f000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa12c0000(0x5e000) @ 0 00:26 148754 625769152]: r-xp /usr/lib/sudo/sudoers.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa1334000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa135b000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa137c000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa13af000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa1557000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa1578000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa15c9000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa172f000(0x13000) @ 0 00:26 148751 625769152]: r-xp /usr/lib/sudo/libsudo_util.so.0.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa1760000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa1781000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa17c4000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa17ff000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sudo     0 [000]     0.000000: PERF_RECORD_MMAP2 23581/23581: [0xffffa182d000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0x400000(0x50a000) @ 0 00:26 1220014 625769152]: r-xp /home/kim/git/linux-perf-acme-urgent/tools/perf/perf.good
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93105000(0xf000) @ 0 00:26 123277 625769152]: r-xp /usr/lib64/libbz2.so.1.0.6
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93127000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff9328d000(0xb000) @ 0 00:26 122960 625769152]: r-xp /usr/lib64/libnuma.so.1
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff932b3000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff932f4000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93325000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93375000(0x176000) @ 0 00:26 654556 625769152]: r-xp /usr/lib/perl5/5.18.2/aarch64-linux-thread-multi/CORE/libperl.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff9350b000(0xf7000) @ 0 00:26 432344 625769152]: r-xp /usr/lib64/libslang.so.2.2.4
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93698000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff9388a000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff938c5000(0x3d000) @ 0 00:26 123704 625769152]: r-xp /usr/lib64/libdw-0.158.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93916000(0x15000) @ 0 00:26 123195 625769152]: r-xp /usr/lib64/libelf-0.158.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93947000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93968000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93a19000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93a3a000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93a6f000(0x9000) @ 0 00:26 430868 625769152]: r-xp /lib64/libunwind.so.8.0.1
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93ac6000(0xe000) @ 0 00:26 430870 625769152]: r-xp /usr/lib64/libunwind-aarch64.so.8.0.1
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93b1d000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23582/23582: [0xffff93b4b000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0x400000(0x50a000) @ 0 00:26 1220014 625769152]: r-xp /home/kim/git/linux-perf-acme-urgent/tools/perf/perf.good
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93105000(0xf000) @ 0 00:26 123277 625769152]: r-xp /usr/lib64/libbz2.so.1.0.6
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93127000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff9328d000(0xb000) @ 0 00:26 122960 625769152]: r-xp /usr/lib64/libnuma.so.1
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff932b3000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff932f4000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93325000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93375000(0x176000) @ 0 00:26 654556 625769152]: r-xp /usr/lib/perl5/5.18.2/aarch64-linux-thread-multi/CORE/libperl.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff9350b000(0xf7000) @ 0 00:26 432344 625769152]: r-xp /usr/lib64/libslang.so.2.2.4
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93698000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff9388a000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff938c5000(0x3d000) @ 0 00:26 123704 625769152]: r-xp /usr/lib64/libdw-0.158.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93916000(0x15000) @ 0 00:26 123195 625769152]: r-xp /usr/lib64/libelf-0.158.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93947000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93968000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93a19000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93a3a000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93a6f000(0x9000) @ 0 00:26 430868 625769152]: r-xp /lib64/libunwind.so.8.0.1
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93ac6000(0xe000) @ 0 00:26 430870 625769152]: r-xp /usr/lib64/libunwind-aarch64.so.8.0.1
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93b1d000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
       perf.good     0 [000]     0.000000: PERF_RECORD_MMAP2 23583/23583: [0xffff93b4b000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xaaaadc7aa000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cbe1000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cc02000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cc23000(0x3000) @ 0 00:26 931109 625769152]: r-xp /lib64/security/pam_lastlog.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cc44000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cc65000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cc86000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8ccd7000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8ccf8000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cd29000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cddd000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8ce1e000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cecf000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cef0000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cf11000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cf72000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cf93000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cfb4000(0x2000) @ 0 00:26 931113 625769152]: r-xp /lib64/security/pam_loginuid.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cfd5000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8cffa000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d01b000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d048000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d079000(0x2000) @ 0 00:26 931118 625769152]: r-xp /lib64/security/pam_nologin.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d0aa000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d0d1000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d0f2000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d125000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d14a000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d17f000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d1b2000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d1d4000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d1f5000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d237000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d289000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d2aa000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d410000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d432000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d515000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d577000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d5c6000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d5f7000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d618000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d809000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d84c000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d86d000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d8a8000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 27025/27025: [0xffff8d8d6000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xaaaab1e10000(0x160000) @ 0 00:26 996379 625769152]: r-xp /usr/lib/systemd/systemd
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9b80b000(0x4000) @ 0 00:26 931300 625769152]: r-xp /usr/lib64/libuuid.so.1.3.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9b82d000(0x40000) @ 0 00:26 948512 625769152]: r-xp /usr/lib64/libblkid.so.1.1.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9b88f000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9b8cb000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9b8ec000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9b93d000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9baa4000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bad9000(0x49000) @ 0 00:26 960295 625769152]: r-xp /usr/lib64/libmount.so.1.1.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bb3b000(0xf000) @ 0 00:26 653333 625769152]: r-xp /lib64/libapparmor.so.1.3.0
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bb5c000(0x14000) @ 0 00:26 931353 625769152]: r-xp /usr/lib64/libkmod.so.2.2.7
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bb8d000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bbae000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bbff000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bc20000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bc41000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bc84000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
         systemd     0 [000]     0.000000: PERF_RECORD_MMAP2 27030/27030: [0xffff9bcb2000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xaaaab6364000(0x160000) @ 0 00:26 996379 625769152]: r-xp /usr/lib/systemd/systemd
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8dd1a000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8dd41000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8dd62000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8dd83000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8dda4000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8ddc5000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8dde6000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8de07000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8de28000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8de49000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8de7a000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8df2e000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8df6f000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8dfa2000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e053000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e0b4000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e0d5000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e0f6000(0x4000) @ 0 00:26 931124 625769152]: r-xp /lib64/security/pam_selinux.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e117000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e14a000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e199000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e1f9000(0x4000) @ 0 00:26 931300 625769152]: r-xp /usr/lib64/libuuid.so.1.3.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e21b000(0x40000) @ 0 00:26 948512 625769152]: r-xp /usr/lib64/libblkid.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e27d000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e2b9000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e2da000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e32b000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e492000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e4c7000(0x49000) @ 0 00:26 960295 625769152]: r-xp /usr/lib64/libmount.so.1.1.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e529000(0xf000) @ 0 00:26 653333 625769152]: r-xp /lib64/libapparmor.so.1.3.0
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e54a000(0x14000) @ 0 00:26 931353 625769152]: r-xp /usr/lib64/libkmod.so.2.2.7
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e57b000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e59c000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e5ed000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e60e000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e62f000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e672000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
        (sd-pam)     0 [000]     0.000000: PERF_RECORD_MMAP2 27031/27031: [0xffff8e6a0000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0x400000(0xaf000) @ 0 00:26 129038 625769152]: r-xp /bin/bash
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff84787000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff847ae000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff847cf000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff84802000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff849a8000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff84b0e000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff84b2f000(0x2c000) @ 0 00:26 996745 625769152]: r-xp /lib64/libtinfo.so.5.9
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff84b75000(0x44000) @ 0 00:26 128536 625769152]: r-xp /lib64/libreadline.so.6.3
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff84bdd000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 27034/27034: [0xffff84c0b000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0x400000(0x26d000) @ 0 00:26 342325 625769152]: r-xp /usr/bin/ddd.org
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff7fffc000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff8002f000(0x5000) @ 0 00:26 931005 625769152]: r-xp /lib64/libnss_dns-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80050000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80071000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff800a4000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff800d1000(0x2000) @ 0 00:26 952958 625769152]: r-xp /usr/lib64/gconv/ISO8859-1.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff800f2000(0x5000) @ 0 00:26 126959 625769152]: r-xp /usr/lib64/libXfixes.so.3.1.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80113000(0xa000) @ 0 00:26 127450 625769152]: r-xp /usr/lib64/libXcursor.so.1.0.2
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80134000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff801ab000(0xf000) @ 0 00:26 123277 625769152]: r-xp /usr/lib64/libbz2.so.1.0.6
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff801cc000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80201000(0x22000) @ 0 00:26 127974 625769152]: r-xp /usr/lib64/libexpat.so.1.6.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80243000(0x4000) @ 0 00:26 931300 625769152]: r-xp /usr/lib64/libuuid.so.1.3.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80264000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80295000(0x9000) @ 0 00:26 126943 625769152]: r-xp /usr/lib64/libXrender.so.1.3.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff802b7000(0x8f000) @ 0 00:26 123756 625769152]: r-xp /usr/lib64/libfreetype.so.6.12.3
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80368000(0x3c000) @ 0 00:26 133419 625769152]: r-xp /usr/lib64/libfontconfig.so.1.8.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff803b9000(0x3000) @ 0 00:26 123462 625769152]: r-xp /usr/lib64/libXau.so.6.0.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff803db000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff803fc000(0x1e000) @ 0 00:26 931280 625769152]: r-xp /usr/lib64/libxcb.so.1.1.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff8042d000(0x17000) @ 0 00:26 123472 625769152]: r-xp /usr/lib64/libICE.so.6.3.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80463000(0x7000) @ 0 00:26 123750 625769152]: r-xp /usr/lib64/libSM.so.6.0.1
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80484000(0x38000) @ 0 00:26 123518 625769152]: r-xp /usr/lib64/libpng16.so.16.8.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff804d5000(0x41000) @ 0 00:26 978677 625769152]: r-xp /usr/lib64/libjpeg.so.8.1.2
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80537000(0x14000) @ 0 00:26 134496 625769152]: r-xp /usr/lib64/libXft.so.2.3.2
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80568000(0x8000) @ 0 00:26 335224 625769152]: r-xp /usr/lib64/libXp.so.6.2.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80589000(0x13000) @ 0 00:26 126963 625769152]: r-xp /usr/lib64/libXext.so.6.4.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff805bb000(0x19000) @ 0 00:26 341882 625769152]: r-xp /usr/lib64/libXmu.so.6.2.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff805ec000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80752000(0x14000) @ 0 00:26 976314 625769152]: r-xp /lib64/libgcc_s.so.1
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80783000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80834000(0x180000) @ 0 00:26 976359 625769152]: r-xp /usr/lib64/libstdc++.so.6.0.24
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff809d9000(0x2c000) @ 0 00:26 996745 625769152]: r-xp /lib64/libtinfo.so.5.9
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80a1f000(0x133000) @ 0 00:26 123990 625769152]: r-xp /usr/lib64/libX11.so.6.3.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80b74000(0x5d000) @ 0 00:26 126937 625769152]: r-xp /usr/lib64/libXt.so.6.0.0
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80be9000(0x281000) @ 0 00:26 342070 625769152]: r-xp /usr/lib64/libXm.so.4.0.4
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80eaf000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
         ddd.org     0 [000]     0.000000: PERF_RECORD_MMAP2 27753/27753: [0xffff80edd000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0x400000(0x83d000) @ 0 00:26 653102 625769152]: r-xp /usr/bin/gdb
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6351000(0x3000) @ 0 00:26 953010 625769152]: r-xp /usr/lib64/gconv/UTF-32.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa641c000(0x7000) @ 0 00:26 931023 625769152]: r-xp /lib64/libthread_db-1.0.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa643d000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6464000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6485000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa64b8000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa64d9000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa64fa000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa654b000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa658c000(0x1aa000) @ 0 00:26 141091 625769152]: r-xp /usr/lib64/librpm.so.3.2.1
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6a8f000(0x15000) @ 0 00:26 123195 625769152]: r-xp /usr/lib64/libelf-0.158.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6ac0000(0xf000) @ 0 00:26 123277 625769152]: r-xp /usr/lib64/libbz2.so.1.0.6
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6ae1000(0x30000) @ 0 00:26 127940 625769152]: r-xp /usr/lib64/liblua.so.5.1
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6b32000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6b53000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6b74000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6bb7000(0xb000) @ 0 00:26 122878 625769152]: r-xp /usr/lib64/libpopt.so.0.0.0
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa6bd8000(0x4a000) @ 0 00:26 141095 625769152]: r-xp /usr/lib64/librpmio.so.3.2.1
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa7dbe000(0x3000) @ 0 00:26 132124 625769152]: r-xp /usr/lib64/python2.7/lib-dynload/_heapq.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa7de0000(0x9000) @ 0 00:26 132157 625769152]: r-xp /usr/lib64/python2.7/lib-dynload/operator.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa7e02000(0x7000) @ 0 00:26 132118 625769152]: r-xp /usr/lib64/python2.7/lib-dynload/_collections.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa7e74000(0xb000) @ 0 00:26 132152 625769152]: r-xp /usr/lib64/python2.7/lib-dynload/itertools.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa7fc9000(0x2000) @ 0 00:26 952958 625769152]: r-xp /usr/lib64/gconv/ISO8859-1.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa806a000(0x4000) @ 0 00:26 132128 625769152]: r-xp /usr/lib64/python2.7/lib-dynload/_locale.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa820a000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa822b000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa827a000(0x9000) @ 0 00:26 931345 625769152]: r-xp /usr/lib64/libltdl.so.7.3.0
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa829c000(0x6c000) @ 0 00:26 123119 625769152]: r-xp /usr/lib64/libgmp.so.10.1.3
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8325000(0x10b000) @ 0 00:26 334564 625769152]: r-xp /usr/lib64/libunistring.so.0.1.2
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8447000(0x7000) @ 0 00:26 123156 625769152]: r-xp /usr/lib64/libffi.so.4.0.1
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8469000(0x25000) @ 0 00:26 335230 625769152]: r-xp /usr/lib64/libgc.so.1.0.3
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa855e000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa86c4000(0x22000) @ 0 00:26 127974 625769152]: r-xp /usr/lib64/libexpat.so.1.6.0
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8706000(0x1bb000) @ 0 00:26 122851 625769152]: r-xp /usr/lib64/libpython2.7.so.1.0
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8934000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa89e5000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8a1a000(0x15c000) @ 0 00:26 341341 625769152]: r-xp /usr/lib64/libguile-2.0.so.22.7.0
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8bc5000(0x2c000) @ 0 00:26 996745 625769152]: r-xp /lib64/libtinfo.so.5.9
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8c0b000(0x33000) @ 0 00:26 996743 625769152]: r-xp /lib64/libncursesw.so.5.9
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8c5c000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8c7d000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8cae000(0x44000) @ 0 00:26 128536 625769152]: r-xp /lib64/libreadline.so.6.3
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8d16000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
             gdb     0 [000]     0.000000: PERF_RECORD_MMAP2 27756/27756: [0xffffa8d44000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0x400000(0x509000) @ 0 00:26 1135726 625769152]: r-xp /home/kim/git/linux-perf-acme-urgent/tools/perf/perf (deleted)
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbecb7000(0xf000) @ 0 00:26 123277 625769152]: r-xp /usr/lib64/libbz2.so.1.0.6
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbecd9000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbee3f000(0xb000) @ 0 00:26 122960 625769152]: r-xp /usr/lib64/libnuma.so.1
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbee65000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbeea6000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbeed7000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbef27000(0x176000) @ 0 00:26 654556 625769152]: r-xp /usr/lib/perl5/5.18.2/aarch64-linux-thread-multi/CORE/libperl.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf0bd000(0xf7000) @ 0 00:26 432344 625769152]: r-xp /usr/lib64/libslang.so.2.2.4
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf24a000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf43c000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf477000(0x3d000) @ 0 00:26 123704 625769152]: r-xp /usr/lib64/libdw-0.158.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf4c8000(0x15000) @ 0 00:26 123195 625769152]: r-xp /usr/lib64/libelf-0.158.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf4f9000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf51a000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf5cb000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf5ec000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf621000(0x9000) @ 0 00:26 430868 625769152]: r-xp /lib64/libunwind.so.8.0.1
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf678000(0xe000) @ 0 00:26 430870 625769152]: r-xp /usr/lib64/libunwind-aarch64.so.8.0.1
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf6cf000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28059/28059: [0xffffbf6fd000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0x400000(0x509000) @ 0 00:26 1135726 625769152]: r-xp /home/kim/git/linux-perf-acme-urgent/tools/perf/perf (deleted)
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbecb7000(0xf000) @ 0 00:26 123277 625769152]: r-xp /usr/lib64/libbz2.so.1.0.6
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbecd9000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbee3f000(0xb000) @ 0 00:26 122960 625769152]: r-xp /usr/lib64/libnuma.so.1
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbee65000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbeea6000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbeed7000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbef27000(0x176000) @ 0 00:26 654556 625769152]: r-xp /usr/lib/perl5/5.18.2/aarch64-linux-thread-multi/CORE/libperl.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf0bd000(0xf7000) @ 0 00:26 432344 625769152]: r-xp /usr/lib64/libslang.so.2.2.4
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf24a000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf43c000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf477000(0x3d000) @ 0 00:26 123704 625769152]: r-xp /usr/lib64/libdw-0.158.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf4c8000(0x15000) @ 0 00:26 123195 625769152]: r-xp /usr/lib64/libelf-0.158.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf4f9000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf51a000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf5cb000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf5ec000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf621000(0x9000) @ 0 00:26 430868 625769152]: r-xp /lib64/libunwind.so.8.0.1
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf678000(0xe000) @ 0 00:26 430870 625769152]: r-xp /usr/lib64/libunwind-aarch64.so.8.0.1
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf6cf000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            perf     0 [000]     0.000000: PERF_RECORD_MMAP2 28060/28060: [0xffffbf6fd000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xaaaab01f6000(0x3000) @ 0 00:26 171692 625769152]: r-xp /usr/lib/postfix/pickup
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaed16000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaed3d000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaed5e000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaed83000(0x14000) @ 0 00:26 976314 625769152]: r-xp /lib64/libgcc_s.so.1
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaedb5000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaee66000(0x180000) @ 0 00:26 976359 625769152]: r-xp /usr/lib64/libstdc++.so.6.0.24
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf02c000(0x16e000) @ 0 00:26 150445 625769152]: r-xp /usr/lib64/libicuuc.so.52.1
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf1c1000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf1e2000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf215000(0x156000) @ 0 00:26 123918 625769152]: r-xp /usr/lib64/libdb-4.8.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf388000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf4ee000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf523000(0x41000) @ 0 00:26 171685 625769152]: r-xp /usr/lib/postfix/libpostfix-util.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf586000(0x43000) @ 0 00:26 171682 625769152]: r-xp /usr/lib/postfix/libpostfix-global.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf5e8000(0xa000) @ 0 00:26 171683 625769152]: r-xp /usr/lib/postfix/libpostfix-master.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf609000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
          pickup     0 [000]     0.000000: PERF_RECORD_MMAP2 28218/28218: [0xffffaf637000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xaaaaea4f7000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91cda000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91cfb000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91d1c000(0x3000) @ 0 00:26 931109 625769152]: r-xp /lib64/security/pam_lastlog.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91d3d000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91d5e000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91d7f000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91dd0000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91df1000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91e22000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91ed6000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91f17000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91fc8000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff91fe9000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff9200a000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff9206b000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff9208c000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff920ad000(0x2000) @ 0 00:26 931113 625769152]: r-xp /lib64/security/pam_loginuid.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff920ce000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff920f3000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92114000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92141000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92172000(0x2000) @ 0 00:26 931118 625769152]: r-xp /lib64/security/pam_nologin.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff921a3000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff921ca000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff921eb000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff9221e000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92243000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92278000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff922ab000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff922cd000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff922ee000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92330000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92382000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff923a3000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92509000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff9252b000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff9260e000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92670000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff926bf000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff926f0000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92711000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92902000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92945000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff92966000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff929a1000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32376/32376: [0xffff929cf000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xaaaaea4f7000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91cda000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91cfb000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91d1c000(0x3000) @ 0 00:26 931109 625769152]: r-xp /lib64/security/pam_lastlog.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91d3d000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91d5e000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91d7f000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91dd0000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91df1000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91e22000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91ed6000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91f17000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91fc8000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff91fe9000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff9200a000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff9206b000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff9208c000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff920ad000(0x2000) @ 0 00:26 931113 625769152]: r-xp /lib64/security/pam_loginuid.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff920ce000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff920f3000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92114000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92141000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92172000(0x2000) @ 0 00:26 931118 625769152]: r-xp /lib64/security/pam_nologin.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff921a3000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff921ca000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff921eb000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff9221e000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92243000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92278000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff922ab000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff922cd000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff922ee000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92330000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92382000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff923a3000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92509000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff9252b000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff9260e000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92670000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff926bf000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff926f0000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92711000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92902000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92945000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff92966000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff929a1000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 32378/32378: [0xffff929cf000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0x400000(0xaf000) @ 0 00:26 129038 625769152]: r-xp /bin/bash
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa179d000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa17c4000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa17e5000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa1818000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa19be000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa1b24000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa1b45000(0x2c000) @ 0 00:26 996745 625769152]: r-xp /lib64/libtinfo.so.5.9
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa1b8b000(0x44000) @ 0 00:26 128536 625769152]: r-xp /lib64/libreadline.so.6.3
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa1bf3000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 32379/32379: [0xffffa1c21000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xaaaacdeb0000(0x55000) @ 0 00:26 996396 625769152]: r-xp /usr/lib/systemd/systemd-journald
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa365c000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa367d000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa36af000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa36d0000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa3721000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa3887000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa38bc000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa38dd000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa3991000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa39d2000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa39f3000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa3a36000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
 systemd-journal     0 [000]     0.000000: PERF_RECORD_MMAP2 391/391: [0xffffa3a64000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xaaaad6f1d000(0x6f000) @ 0 00:26 1003638 625769152]: r-xp /usr/lib/systemd/systemd-udevd
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb08ac000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb08d3000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb08f4000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb0927000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1011000(0x4000) @ 0 00:26 931300 625769152]: r-xp /usr/lib64/libuuid.so.1.3.0
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1032000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1054000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1075000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb10c6000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb122c000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1261000(0x14000) @ 0 00:26 931353 625769152]: r-xp /usr/lib64/libkmod.so.2.2.7
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1292000(0x40000) @ 0 00:26 948512 625769152]: r-xp /usr/lib64/libblkid.so.1.1.0
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb12f4000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1315000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1336000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb1379000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
   systemd-udevd     0 [000]     0.000000: PERF_RECORD_MMAP2 419/419: [0xffffb13a7000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xaaaaafcaf000(0x1e000) @ 0 00:26 612246 625769152]: r-xp /usr/sbin/auditd
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbbe60000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbbe87000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbbea8000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbbedb000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbbf08000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbc06e000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbc0a3000(0xa000) @ 0 00:26 122724 625769152]: r-xp /lib64/libwrap.so.0.7.6
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbc0c5000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
          auditd     0 [000]     0.000000: PERF_RECORD_MMAP2 510/510: [0xffffbc0f3000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xaaaadff83000(0x6a000) @ 0 00:26 155405 625769152]: r-xp /bin/dbus-daemon
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbd9e7000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbda0e000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbda2f000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbda62000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbda86000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdad8000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdb09000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdb2a000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdbdf000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdc20000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdc53000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdd05000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdd26000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdd47000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdead000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdee2000(0x4000) @ 0 00:26 123269 625769152]: r-xp /usr/lib64/libcap-ng.so.0.0.0
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdf03000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdf3e000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdf81000(0x22000) @ 0 00:26 127974 625769152]: r-xp /usr/lib64/libexpat.so.1.6.0
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbdfc2000(0x83000) @ 0 00:26 978691 625769152]: r-xp /usr/lib64/libsystemd.so.0.13.0
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbe063000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
     dbus-daemon     0 [000]     0.000000: PERF_RECORD_MMAP2 525/525: [0xffffbe091000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0x400000(0x7000) @ 0 00:26 961909 625769152]: r-xp /usr/lib/wicked/bin/wickedd-dhcp6
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff89304000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff89335000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff893e7000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff8941c000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff8943d000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff894f1000(0x3000) @ 0 00:26 930987 625769152]: r-xp /lib64/libanl-2.22.so
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff89512000(0x1d000) @ 0 00:26 122966 625769152]: r-xp /usr/lib64/libnl-3.so.200.18.0
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff89543000(0x4e000) @ 0 00:26 122976 625769152]: r-xp /usr/lib64/libnl-route-3.so.200.18.0
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff895a8000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff8970e000(0x49000) @ 0 00:26 123219 625769152]: r-xp /lib64/libdbus-1.so.3.8.14
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff8976f000(0x15d000) @ 0 00:26 931286 625769152]: r-xp /usr/lib64/libwicked-0.so.6.40.0
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff89910000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
   wickedd-dhcp6     0 [000]     0.000000: PERF_RECORD_MMAP2 526/526: [0xffff8993e000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0x400000(0x8000) @ 0 00:26 961905 625769152]: r-xp /usr/lib/wicked/bin/wickedd-auto4
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3455000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3486000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3538000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb356d000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb358e000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3642000(0x3000) @ 0 00:26 930987 625769152]: r-xp /lib64/libanl-2.22.so
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3663000(0x1d000) @ 0 00:26 122966 625769152]: r-xp /usr/lib64/libnl-3.so.200.18.0
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3694000(0x4e000) @ 0 00:26 122976 625769152]: r-xp /usr/lib64/libnl-route-3.so.200.18.0
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb36f9000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb385f000(0x49000) @ 0 00:26 123219 625769152]: r-xp /lib64/libdbus-1.so.3.8.14
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb38c0000(0x15d000) @ 0 00:26 931286 625769152]: r-xp /usr/lib64/libwicked-0.so.6.40.0
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3a61000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
   wickedd-auto4     0 [000]     0.000000: PERF_RECORD_MMAP2 527/527: [0xffffb3a8f000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xaaaac933f000(0x99000) @ 0 00:26 996398 625769152]: r-xp /usr/lib/systemd/systemd-logind
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7e34000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7e5b000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7e7c000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7eaf000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7ed3000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7ef4000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7f15000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb7f66000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb80cc000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb8101000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb8122000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb8143000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb8164000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb81a7000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
  systemd-logind     0 [000]     0.000000: PERF_RECORD_MMAP2 528/528: [0xffffb81d5000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xaaaabf1ca000(0xf000) @ 0 00:26 163540 625769152]: r-xp /usr/sbin/irqbalance
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd1dd000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd212000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd263000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd3c9000(0xb000) @ 0 00:26 122960 625769152]: r-xp /usr/lib64/libnuma.so.1
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd3ee000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd49f000(0x118000) @ 0 00:26 123573 625769152]: r-xp /usr/lib64/libglib-2.0.so.0.4800.2
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd5d1000(0x4000) @ 0 00:26 123269 625769152]: r-xp /usr/lib64/libcap-ng.so.0.0.0
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd5f2000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
      irqbalance     0 [000]     0.000000: PERF_RECORD_MMAP2 529/529: [0xffffbd620000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0x400000(0x7000) @ 0 00:26 961908 625769152]: r-xp /usr/lib/wicked/bin/wickedd-dhcp4
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb73a7000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb73d8000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb748a000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb74bf000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb74e0000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb7594000(0x3000) @ 0 00:26 930987 625769152]: r-xp /lib64/libanl-2.22.so
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb75b5000(0x1d000) @ 0 00:26 122966 625769152]: r-xp /usr/lib64/libnl-3.so.200.18.0
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb75e6000(0x4e000) @ 0 00:26 122976 625769152]: r-xp /usr/lib64/libnl-route-3.so.200.18.0
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb764b000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb77b1000(0x49000) @ 0 00:26 123219 625769152]: r-xp /lib64/libdbus-1.so.3.8.14
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb7812000(0x15d000) @ 0 00:26 931286 625769152]: r-xp /usr/lib64/libwicked-0.so.6.40.0
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb79b3000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
   wickedd-dhcp4     0 [000]     0.000000: PERF_RECORD_MMAP2 531/531: [0xffffb79e1000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0x400000(0xc000) @ 0 00:26 960782 625769152]: r-xp /usr/sbin/agetty
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0xffff8f552000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0xffff8f579000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0xffff8f59a000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0xffff8f5cd000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0xffff8f63e000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0xffff8f7a4000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 535/535: [0xffff8f7d2000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0x400000(0xc000) @ 0 00:26 960782 625769152]: r-xp /usr/sbin/agetty
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0xffffae74c000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0xffffae773000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0xffffae794000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0xffffae7c7000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0xffffae7e8000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0xffffae94e000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
          agetty     0 [000]     0.000000: PERF_RECORD_MMAP2 536/536: [0xffffae97c000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0x400000(0x4000) @ 0 00:26 961913 625769152]: r-xp /usr/sbin/wickedd
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffa9e30000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffa9e61000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffa9f13000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffa9f48000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffa9f69000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa01d000(0x49000) @ 0 00:26 123219 625769152]: r-xp /lib64/libdbus-1.so.3.8.14
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa07e000(0x3000) @ 0 00:26 930987 625769152]: r-xp /lib64/libanl-2.22.so
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa09f000(0x1d000) @ 0 00:26 122966 625769152]: r-xp /usr/lib64/libnl-3.so.200.18.0
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa0d0000(0x4e000) @ 0 00:26 122976 625769152]: r-xp /usr/lib64/libnl-route-3.so.200.18.0
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa135000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa29b000(0x15d000) @ 0 00:26 931286 625769152]: r-xp /usr/lib64/libwicked-0.so.6.40.0
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa43c000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
         wickedd     0 [000]     0.000000: PERF_RECORD_MMAP2 543/543: [0xffffaa46a000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0x400000(0xd000) @ 0 00:26 961914 625769152]: r-xp /usr/sbin/wickedd-nanny
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff86ece000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff86eff000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff86fb1000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff86fe6000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff87007000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff870bb000(0x3000) @ 0 00:26 930987 625769152]: r-xp /lib64/libanl-2.22.so
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff870dc000(0x1d000) @ 0 00:26 122966 625769152]: r-xp /usr/lib64/libnl-3.so.200.18.0
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff8710d000(0x4e000) @ 0 00:26 122976 625769152]: r-xp /usr/lib64/libnl-route-3.so.200.18.0
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff87172000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff872d8000(0x49000) @ 0 00:26 123219 625769152]: r-xp /lib64/libdbus-1.so.3.8.14
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff87339000(0x15d000) @ 0 00:26 931286 625769152]: r-xp /usr/lib64/libwicked-0.so.6.40.0
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff874da000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
   wickedd-nanny     0 [000]     0.000000: PERF_RECORD_MMAP2 544/544: [0xffff87508000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xaaaab52f4000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa4f05000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa4f26000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa4f47000(0x3000) @ 0 00:26 931109 625769152]: r-xp /lib64/security/pam_lastlog.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa4f68000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa4f89000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa4faa000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa4ffb000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa501c000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa504d000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5101000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5142000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa51f3000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5214000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5235000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5296000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa52b7000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa52d8000(0x2000) @ 0 00:26 931113 625769152]: r-xp /lib64/security/pam_loginuid.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa52f9000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa531e000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa533f000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa536c000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa539d000(0x2000) @ 0 00:26 931118 625769152]: r-xp /lib64/security/pam_nologin.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa53ce000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa53f5000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5416000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5449000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa546e000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa54a3000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa54d6000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa54f8000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5519000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa555b000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa55ad000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa55ce000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5734000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5756000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5839000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa589b000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa58ea000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa591b000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa593c000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5b2d000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5b70000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5b91000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5bcc000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6373/6373: [0xffffa5bfa000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xaaaab52f4000(0xd6000) @ 0 00:26 961857 625769152]: r-xp /usr/sbin/sshd
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa4f05000(0x1000) @ 0 00:26 931098 625769152]: r-xp /lib64/security/pam_deny.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa4f26000(0x1000) @ 0 00:26 931134 625769152]: r-xp /lib64/security/pam_warn.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa4f47000(0x3000) @ 0 00:26 931109 625769152]: r-xp /lib64/security/pam_lastlog.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa4f68000(0x5000) @ 0 00:26 123300 625769152]: r-xp /lib64/libattr.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa4f89000(0x3000) @ 0 00:26 931092 625769152]: r-xp /lib64/libpam_misc.so.0.82.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa4faa000(0x2c000) @ 0 00:26 122824 625769152]: r-xp /usr/lib64/libseccomp.so.2.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa4ffb000(0x8000) @ 0 00:26 123721 625769152]: r-xp /lib64/libacl.so.1.1.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa501c000(0x13000) @ 0 00:26 123088 625769152]: r-xp /usr/lib64/libgpg-error.so.0.22.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa504d000(0x9e000) @ 0 00:26 653339 625769152]: r-xp /usr/lib64/libgcrypt.so.20.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5101000(0x24000) @ 0 00:26 123031 625769152]: r-xp /usr/lib64/liblzma.so.5.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5142000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa51f3000(0x6000) @ 0 00:26 931021 625769152]: r-xp /lib64/librt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5214000(0x4000) @ 0 00:26 123263 625769152]: r-xp /lib64/libcap.so.2.22
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5235000(0x49000) @ 0 00:26 996107 625769152]: r-xp /lib64/security/pam_systemd.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5296000(0x2000) @ 0 00:26 931133 625769152]: r-xp /lib64/security/pam_umask.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa52b7000(0x4000) @ 0 00:26 931110 625769152]: r-xp /lib64/security/pam_limits.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa52d8000(0x2000) @ 0 00:26 931113 625769152]: r-xp /lib64/security/pam_loginuid.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa52f9000(0x9000) @ 0 00:26 133221 625769152]: r-xp /usr/lib64/libcrack.so.2.9.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa531e000(0x3000) @ 0 00:26 931096 625769152]: r-xp /lib64/security/pam_cracklib.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa533f000(0xc000) @ 0 00:26 931273 625769152]: r-xp /lib64/security/pam_unix.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa536c000(0x3000) @ 0 00:26 931100 625769152]: r-xp /lib64/security/pam_env.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa539d000(0x2000) @ 0 00:26 931118 625769152]: r-xp /lib64/security/pam_nologin.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa53ce000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa53f5000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5416000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5449000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa546e000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa54a3000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa54d6000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa54f8000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5519000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa555b000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa55ad000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa55ce000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5734000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5756000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5839000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa589b000(0xb000) @ 0 00:26 930993 625769152]: r-xp /lib64/libcrypt-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa58ea000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa591b000(0x2000) @ 0 00:26 931025 625769152]: r-xp /lib64/libutil-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa593c000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5b2d000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5b70000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5b91000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5bcc000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            sshd     0 [000]     0.000000: PERF_RECORD_MMAP2 6384/6384: [0xffffa5bfa000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0x400000(0xaf000) @ 0 00:26 129038 625769152]: r-xp /bin/bash
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87a54000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87a7b000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87a9c000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87acf000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87c75000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87ddb000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87dfc000(0x2c000) @ 0 00:26 996745 625769152]: r-xp /lib64/libtinfo.so.5.9
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87e42000(0x44000) @ 0 00:26 128536 625769152]: r-xp /lib64/libreadline.so.6.3
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87eaa000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
            bash     0 [000]     0.000000: PERF_RECORD_MMAP2 6386/6386: [0xffff87ed8000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xaaaab971a000(0x61000) @ 0 00:26 424271 625769152]: r-xp /usr/sbin/cupsd
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac762000(0xb000) @ 0 00:26 931007 625769152]: r-xp /lib64/libnss_files-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac789000(0xa000) @ 0 00:26 931011 625769152]: r-xp /lib64/libnss_nis-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac7aa000(0x15000) @ 0 00:26 930999 625769152]: r-xp /lib64/libnsl-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac7dd000(0x7000) @ 0 00:26 931001 625769152]: r-xp /lib64/libnss_compat-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac802000(0x3b000) @ 0 00:26 587843 625769152]: r-xp /usr/lib64/libpcre.so.1.2.7
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac853000(0x24000) @ 0 00:26 123567 625769152]: r-xp /lib64/libselinux.so.1
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac897000(0x13000) @ 0 00:26 931019 625769152]: r-xp /lib64/libresolv-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac8ca000(0x3000) @ 0 00:26 123051 625769152]: r-xp /lib64/libkeyutils.so.1.5
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac8eb000(0xd000) @ 0 00:26 653324 625769152]: r-xp /usr/lib64/libkrb5support.so.0.1
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac90d000(0x3000) @ 0 00:26 123247 625769152]: r-xp /usr/lib64/libcom_err.so.2.1
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac92e000(0x2e000) @ 0 00:26 653312 625769152]: r-xp /usr/lib64/libk5crypto.so.3.1
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffac970000(0xc0000) @ 0 00:26 653322 625769152]: r-xp /usr/lib64/libkrb5.so.3.3
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffaca53000(0x99000) @ 0 00:26 930997 625769152]: r-xp /lib64/libm-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffacb05000(0x17000) @ 0 00:26 587830 625769152]: r-xp /usr/lib64/libaudit.so.1.0.0
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffacb40000(0x14000) @ 0 00:26 122708 625769152]: r-xp /lib64/libz.so.1.2.8
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffacb72000(0x3000) @ 0 00:26 930995 625769152]: r-xp /lib64/libdl-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffacb93000(0x149000) @ 0 00:26 930989 625769152]: r-xp /lib64/libc-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffaccf9000(0x18000) @ 0 00:26 931017 625769152]: r-xp /lib64/libpthread-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffacd2f000(0x43000) @ 0 00:26 653308 625769152]: r-xp /usr/lib64/libgssapi_krb5.so.2.2
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffacd91000(0x81000) @ 0 00:26 156957 625769152]: r-xp /usr/lib64/libcups.so.2
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xfffface33000(0x10000) @ 0 00:26 123711 625769152]: r-xp /usr/lib64/libavahi-client.so.3.2.9
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xfffface54000(0xc000) @ 0 00:26 123287 625769152]: r-xp /usr/lib64/libavahi-common.so.3.5.3
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xfffface75000(0x49000) @ 0 00:26 123219 625769152]: r-xp /lib64/libdbus-1.so.3.8.14
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffaced6000(0xe000) @ 0 00:26 931090 625769152]: r-xp /lib64/libpam.so.0.84.2
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffacef7000(0x1b6000) @ 0 00:26 931332 625769152]: r-xp /lib64/libcrypto.so.1.0.0
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffad0e8000(0x5a000) @ 0 00:26 931333 625769152]: r-xp /lib64/libssl.so.1.0.0
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffad15f000(0x8000) @ 0 00:26 156960 625769152]: r-xp /usr/lib64/libcupsmime.so.1
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffad180000(0x1e000) @ 0 00:26 930982 625769152]: r-xp /lib64/ld-2.22.so
           cupsd     0 [000]     0.000000: PERF_RECORD_MMAP2 990/990: [0xffffad1ae000(0x1000) @ 0 00:00 0 625769152]: r-xp [vdso]
         swapper     0 [000] 179842.413705:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413707:          1 cycles:ppp:  ffff200008370b0c generic_exec_single ([kernel.kallsyms])
         swapper     0 [000] 179842.413718:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413720:          1 cycles:ppp:  ffff200008370b0c generic_exec_single ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413723:          1 cycles:ppp:  ffff200008370b0c generic_exec_single ([kernel.kallsyms])
         swapper     0 [000] 179842.413726:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413727:          4 cycles:ppp:  ffff200008370b0c generic_exec_single ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413731:         34 cycles:ppp:  ffff200008370b0c generic_exec_single ([kernel.kallsyms])
         swapper     0 [000] 179842.413732:          3 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413734:        321 cycles:ppp:  ffff200008370b0c generic_exec_single ([kernel.kallsyms])
         swapper     0 [000] 179842.413738:         14 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413739:       2984 cycles:ppp:  ffff200008370b0c generic_exec_single ([kernel.kallsyms])
         swapper     0 [000] 179842.413744:         85 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [000] 179842.413750:        522 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [000] 179842.413755:       3274 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413766:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413774:      29103 cycles:ppp:            50b494 perf_event__get_comm_ids (/home/kim/git/linux-perf-acme-urgent/tools/perf/perf.good)
         swapper     0 [003] 179842.413775:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413776:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413783:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [003] 179842.413784:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413789:          4 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [003] 179842.413790:          1 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413795:         20 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [000] 179842.413799:      20603 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [003] 179842.413802:          5 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413802:        125 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413810:        766 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [003] 179842.413811:         29 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [002] 179842.413816:       4284 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [003] 179842.413817:        108 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [003] 179842.413822:        459 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
         swapper     0 [003] 179842.413827:       2731 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23582 [001] 179842.413917:     242834 cycles:ppp:  ffff20000809ffa4 unwind_frame ([kernel.kallsyms])
       perf.good 23583 [000] 179842.414036:     133330 cycles:ppp:  ffff2000085c3870 filemap_map_pages ([kernel.kallsyms])
         swapper     0 [003] 179842.414069:      17784 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23583 [000] 179842.414161:     212157 cycles:ppp:  ffff2000086a04dc handle_mm_fault ([kernel.kallsyms])
       perf.good 23582 [001] 179842.414171:     431549 cycles:ppp:  ffff200008749224 kfree ([kernel.kallsyms])
       perf.good 23583 [000] 179842.414287:     213590 cycles:ppp:  ffff20000809feac unwind_frame ([kernel.kallsyms])
       perf.good 23583 [000] 179842.414429:     240337 cycles:ppp:  ffff200009131e14 __crc32c_le ([kernel.kallsyms])
       perf.good 23582 [001] 179842.414449:     471561 cycles:ppp:  ffff200008749b60 kmem_cache_free ([kernel.kallsyms])
       perf.good 23583 [000] 179842.414588:     270161 cycles:ppp:  ffff2000087e2760 de_thread ([kernel.kallsyms])
         swapper     0 [001] 179842.414732:     470634 cycles:ppp:  ffff20000821e010 finish_task_switch ([kernel.kallsyms])
       perf.good 23583 [000] 179842.414765:     295672 cycles:ppp:  ffff200008692df4 zap_pte_range ([kernel.kallsyms])
       perf.good 23583 [000] 179842.414949:     316822 cycles:ppp:  ffff200008749b60 kmem_cache_free ([kernel.kallsyms])
         swapper     0 [002] 179842.414959:      19158 cycles:ppp:  ffff20000808d71c arch_cpu_idle ([kernel.kallsyms])
       perf.good 23583 [000] 179842.415146:     333471 cycles:ppp:  ffff200008749b60 kmem_cache_free ([kernel.kallsyms])
       perf.good 23583 [000] 179842.415350:     348193 cycles:ppp:  ffff200008749b60 kmem_cache_free ([kernel.kallsyms])
           sleep 23583 [000] 179842.415562:     359782 cycles:ppp:  ffff2000086ac1e0 vma_gap_update ([kernel.kallsyms])
           sleep 23583 [000] 179842.415593: PERF_RECORD_MMAP2 23583/23583: [0x400000(0x7000) @ 0 00:26 932020 143948]: r-xp /usr/bin/sleep
           sleep 23583 [000] 179842.415665: PERF_RECORD_MMAP2 23583/23583: [0xffffb5592000(0x32000) @ 0 00:26 930982 143948]: r-xp /lib64/ld-2.22.so
           sleep 23583 [000] 179842.415733: PERF_RECORD_MMAP2 23583/23583: [0xffffb55c0000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
           sleep 23583 [000] 179842.415782:     369947 cycles:ppp:  ffff200008749b60 kmem_cache_free ([kernel.kallsyms])
           sleep 23583 [000] 179842.416004:     378294 cycles:ppp:  ffff2000087f0148 inode_permission ([kernel.kallsyms])
           sleep 23583 [000] 179842.416074: PERF_RECORD_MMAP2 23583/23583: [0xffffb542c000(0x166000) @ 0 00:26 930989 143948]: r-xp /lib64/libc-2.22.so
           sleep 23583 [000] 179842.416230:     384624 cycles:ppp:  ffff2000086474ac __vm_enough_memory ([kernel.kallsyms])
           sleep 23583 [000] 179842.416460:     390904 cycles:ppp:      ffffb544b6dc _init (/lib64/libc-2.22.so)
           sleep 23583 [000] 179842.416693:     396157 cycles:ppp:      ffffb548f11c fopen@@GLIBC_2.17 (/lib64/libc-2.22.so)
           sleep 23583 [000] 179842.416929:     400301 cycles:ppp:  ffff2000080a00dc unwind_frame ([kernel.kallsyms])
           sleep 23583 [000] 179842.417167:     403930 cycles:ppp:  ffff200008311790 __call_rcu ([kernel.kallsyms])
           sleep 23583 [000] 179842.417408:     406969 cycles:ppp:  ffff200008749224 kfree ([kernel.kallsyms])
           sleep 23583 [000] 179842.417647:     409630 cycles:ppp:  ffff20000874e298 kasan_kmalloc ([kernel.kallsyms])
           sleep 23583 [000] 179842.417889:     411541 cycles:ppp:  ffff20000809ff48 unwind_frame ([kernel.kallsyms])
         swapper     0 [001] 179842.450066:     464795 cycles:ppp:  ffff200008082bf0 __do_softirq ([kernel.kallsyms])
         swapper     0 [000] 179842.450088:     413780 cycles:ppp:  ffff200008749224 kfree ([kernel.kallsyms])
         swapper     0 [001] 179842.450227:     273220 cycles:ppp:  ffff200008749b60 kmem_cache_free ([kernel.kallsyms])
     kworker/2:0 28514 [002] 179842.590114:     119279 cycles:ppp:  ffff20000874a270 drain_array ([kernel.kallsyms])
      khugepaged    37 [003] 179842.590122:     138081 cycles:ppp:  ffff200008777f6c hugepage_vma_check ([kernel.kallsyms])
     kworker/2:0 28514 [002] 179842.590168:      94660 cycles:ppp:  ffff20000874a4cc cache_reap ([kernel.kallsyms])
      khugepaged    37 [003] 179842.590194:     121815 cycles:ppp:  ffff2000086cae68 mm_find_pmd ([kernel.kallsyms])
     kworker/2:0 28514 [002] 179842.590224:      94660 cycles:ppp:  ffff20000874a4cc cache_reap ([kernel.kallsyms])
      khugepaged    37 [003] 179842.590265:     121815 cycles:ppp:  ffff2000086ad818 find_vma ([kernel.kallsyms])
            ntpd  1002 [003] 179842.594873:     159868 cycles:ppp:  ffff200008085200 __sys_trace ([kernel.kallsyms])
           sleep 23583 [000] 179843.418069:     258640 cycles:ppp:  ffff200008911678 locks_remove_posix ([kernel.kallsyms])
           sleep 23583 [000] 179843.418203:     226895 cycles:ppp:  ffff2000086ccfbc page_remove_rmap ([kernel.kallsyms])
           sleep 23583 [000] 179843.418337:     226895 cycles:ppp:  ffff200008749b60 kmem_cache_free ([kernel.kallsyms])

Thanks,

Kim
