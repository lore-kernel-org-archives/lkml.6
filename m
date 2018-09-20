Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE41ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7598721526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMkX9Eli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7598721526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbeITUun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:50:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44152 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733117AbeITUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:50:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so4563393pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZTE6LOy/JOQ1cetKpZQJ0nqYV+b40OK/ubD7KZ7B3oE=;
        b=ZMkX9Eli11mbDuo1MnT5x7G9B9DArZ/hkGhplNlDoC1czIqUi0ufPQ20pBeBqAnftn
         qpYWABFWcn5vQPZoG1QDT+iIw4w4n1Xv9BmqbZmZ+kUxm3I0WsRmuocCbptSYluu0QYn
         G30O8fYzjxa8TkybEAC8Xi/HO6wbGuiOETrb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZTE6LOy/JOQ1cetKpZQJ0nqYV+b40OK/ubD7KZ7B3oE=;
        b=ranNOUkQZC0qE91kbWZ9Sn/Nz+YftwRqz4d8Z1f+4RdHWswFSEeU0oeFZTTCaswkPJ
         LgLplDbyyvuNIdPvd7I3D0KsJJ9rh26k1KUuMYUfdlLWdvy5kEvMTbaCyxXr3htfCq4I
         +P6XZMEuE+evPm3OuO6PiCE98oDpt6soKUby/4odhXd6ZjLcqxURjiFlQYNH//We72Hk
         By4BThyLIu3XG1V945pB7QgNonG2rOas+9EqwwgqNT3pflptdnMA6lJ0nD13B/uCHKBn
         jpmcUY0ZdAJO1EJkt5kORfW4hE/7cIr6GPM7/4xYQEbx6cBdDVGQD0E2PkKq7463LdcD
         Jsrg==
X-Gm-Message-State: APzg51BFJqvAG7z1o38034mHHmbBWNrhI4MsACetZbN6jhlnZ9oBmSMP
        78LzrPjSyrLvyunoQ183rhamdw==
X-Google-Smtp-Source: ANB0Vdbaj51vXRL8kuyrp6Omj6ZHkR5CAgvBMVY4oDx0d1dSe9lmwg0nt/DiyH+5ek9R6yWq48zw5A==
X-Received: by 2002:a63:c114:: with SMTP id w20-v6mr36073152pgf.234.1537456008615;
        Thu, 20 Sep 2018 08:06:48 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.107.142])
        by smtp.gmail.com with ESMTPSA id k64-v6sm36222991pfg.141.2018.09.20.08.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 08:06:48 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 1/5] m68k: Rename system call table file name
Date:   Thu, 20 Sep 2018 20:36:09 +0530
Message-Id: <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system call table entries are present in syscalltable.S. One of
the patch in this patch series will auto-generate the system call
table entries using the system call table generation script and
which'll replace the existig table file.

In order to come up with a common naming convention across all
architecture, we need to change the file name to syscall_table.S.
This change will unify the implementation across all architecture.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/kernel/Makefile        |   2 +-
 arch/m68k/kernel/syscall_table.S | 403 +++++++++++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalltable.S  | 403 ---------------------------------------
 3 files changed, 404 insertions(+), 404 deletions(-)
 create mode 100644 arch/m68k/kernel/syscall_table.S
 delete mode 100644 arch/m68k/kernel/syscalltable.S

diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index dbac7f8..5f40ce6 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -15,7 +15,7 @@ extra-$(CONFIG_SUN3)	:= sun3-head.o
 extra-y			+= vmlinux.lds
 
 obj-y	:= entry.o irq.o module.o process.o ptrace.o
-obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
+obj-y	+= setup.o signal.o sys_m68k.o syscall_table.o time.o traps.o
 
 obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o
 obj-$(CONFIG_MMU_SUN3) += ints.o vectors.o
diff --git a/arch/m68k/kernel/syscall_table.S b/arch/m68k/kernel/syscall_table.S
new file mode 100644
index 0000000..2c8402e
--- /dev/null
+++ b/arch/m68k/kernel/syscall_table.S
@@ -0,0 +1,403 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2002, Greg Ungerer (gerg@snapgear.com)
+ *
+ *  Based on older entry.S files, the following copyrights apply:
+ *
+ *  Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>,
+ *                      Kenneth Albanowski <kjahds@kjahds.com>,
+ *  Copyright (C) 2000  Lineo Inc. (www.lineo.com) 
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ *  Linux/m68k support by Hamish Macdonald
+ */
+
+#include <linux/linkage.h>
+
+#ifndef CONFIG_MMU
+#define sys_mmap2		sys_mmap_pgoff
+#endif
+
+.section .rodata
+ALIGN
+ENTRY(sys_call_table)
+	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
+	.long sys_exit
+	.long __sys_fork
+	.long sys_read
+	.long sys_write
+	.long sys_open			/* 5 */
+	.long sys_close
+	.long sys_waitpid
+	.long sys_creat
+	.long sys_link
+	.long sys_unlink		/* 10 */
+	.long sys_execve
+	.long sys_chdir
+	.long sys_time
+	.long sys_mknod
+	.long sys_chmod			/* 15 */
+	.long sys_chown16
+	.long sys_ni_syscall		/* old break syscall holder */
+	.long sys_stat
+	.long sys_lseek
+	.long sys_getpid		/* 20 */
+	.long sys_mount
+	.long sys_oldumount
+	.long sys_setuid16
+	.long sys_getuid16
+	.long sys_stime			/* 25 */
+	.long sys_ptrace
+	.long sys_alarm
+	.long sys_fstat
+	.long sys_pause
+	.long sys_utime			/* 30 */
+	.long sys_ni_syscall		/* old stty syscall holder */
+	.long sys_ni_syscall		/* old gtty syscall holder */
+	.long sys_access
+	.long sys_nice
+	.long sys_ni_syscall		/* 35 - old ftime syscall holder */
+	.long sys_sync
+	.long sys_kill
+	.long sys_rename
+	.long sys_mkdir
+	.long sys_rmdir			/* 40 */
+	.long sys_dup
+	.long sys_pipe
+	.long sys_times
+	.long sys_ni_syscall		/* old prof syscall holder */
+	.long sys_brk			/* 45 */
+	.long sys_setgid16
+	.long sys_getgid16
+	.long sys_signal
+	.long sys_geteuid16
+	.long sys_getegid16		/* 50 */
+	.long sys_acct
+	.long sys_umount		/* recycled never used phys() */
+	.long sys_ni_syscall		/* old lock syscall holder */
+	.long sys_ioctl
+	.long sys_fcntl			/* 55 */
+	.long sys_ni_syscall		/* old mpx syscall holder */
+	.long sys_setpgid
+	.long sys_ni_syscall		/* old ulimit syscall holder */
+	.long sys_ni_syscall
+	.long sys_umask			/* 60 */
+	.long sys_chroot
+	.long sys_ustat
+	.long sys_dup2
+	.long sys_getppid
+	.long sys_getpgrp		/* 65 */
+	.long sys_setsid
+	.long sys_sigaction
+	.long sys_sgetmask
+	.long sys_ssetmask
+	.long sys_setreuid16		/* 70 */
+	.long sys_setregid16
+	.long sys_sigsuspend
+	.long sys_sigpending
+	.long sys_sethostname
+	.long sys_setrlimit		/* 75 */
+	.long sys_old_getrlimit
+	.long sys_getrusage
+	.long sys_gettimeofday
+	.long sys_settimeofday
+	.long sys_getgroups16		/* 80 */
+	.long sys_setgroups16
+	.long sys_old_select
+	.long sys_symlink
+	.long sys_lstat
+	.long sys_readlink		/* 85 */
+	.long sys_uselib
+	.long sys_swapon
+	.long sys_reboot
+	.long sys_old_readdir
+	.long sys_old_mmap		/* 90 */
+	.long sys_munmap
+	.long sys_truncate
+	.long sys_ftruncate
+	.long sys_fchmod
+	.long sys_fchown16		/* 95 */
+	.long sys_getpriority
+	.long sys_setpriority
+	.long sys_ni_syscall		/* old profil syscall holder */
+	.long sys_statfs
+	.long sys_fstatfs		/* 100 */
+	.long sys_ni_syscall		/* ioperm for i386 */
+	.long sys_socketcall
+	.long sys_syslog
+	.long sys_setitimer
+	.long sys_getitimer		/* 105 */
+	.long sys_newstat
+	.long sys_newlstat
+	.long sys_newfstat
+	.long sys_ni_syscall
+	.long sys_ni_syscall		/* 110 - iopl for i386 */
+	.long sys_vhangup
+	.long sys_ni_syscall		/* obsolete idle() syscall */
+	.long sys_ni_syscall		/* vm86old for i386 */
+	.long sys_wait4
+	.long sys_swapoff		/* 115 */
+	.long sys_sysinfo
+	.long sys_ipc
+	.long sys_fsync
+	.long sys_sigreturn
+	.long __sys_clone		/* 120 */
+	.long sys_setdomainname
+	.long sys_newuname
+	.long sys_cacheflush		/* modify_ldt for i386 */
+	.long sys_adjtimex
+	.long sys_mprotect		/* 125 */
+	.long sys_sigprocmask
+	.long sys_ni_syscall		/* old "create_module" */
+	.long sys_init_module
+	.long sys_delete_module
+	.long sys_ni_syscall		/* 130 - old "get_kernel_syms" */
+	.long sys_quotactl
+	.long sys_getpgid
+	.long sys_fchdir
+	.long sys_bdflush
+	.long sys_sysfs			/* 135 */
+	.long sys_personality
+	.long sys_ni_syscall		/* for afs_syscall */
+	.long sys_setfsuid16
+	.long sys_setfsgid16
+	.long sys_llseek		/* 140 */
+	.long sys_getdents
+	.long sys_select
+	.long sys_flock
+	.long sys_msync
+	.long sys_readv			/* 145 */
+	.long sys_writev
+	.long sys_getsid
+	.long sys_fdatasync
+	.long sys_sysctl
+	.long sys_mlock			/* 150 */
+	.long sys_munlock
+	.long sys_mlockall
+	.long sys_munlockall
+	.long sys_sched_setparam
+	.long sys_sched_getparam	/* 155 */
+	.long sys_sched_setscheduler
+	.long sys_sched_getscheduler
+	.long sys_sched_yield
+	.long sys_sched_get_priority_max
+	.long sys_sched_get_priority_min  /* 160 */
+	.long sys_sched_rr_get_interval
+	.long sys_nanosleep
+	.long sys_mremap
+	.long sys_setresuid16
+	.long sys_getresuid16		/* 165 */
+	.long sys_getpagesize
+	.long sys_ni_syscall		/* old "query_module" */
+	.long sys_poll
+	.long sys_ni_syscall		/* old nfsservctl */
+	.long sys_setresgid16		/* 170 */
+	.long sys_getresgid16
+	.long sys_prctl
+	.long sys_rt_sigreturn
+	.long sys_rt_sigaction
+	.long sys_rt_sigprocmask	/* 175 */
+	.long sys_rt_sigpending
+	.long sys_rt_sigtimedwait
+	.long sys_rt_sigqueueinfo
+	.long sys_rt_sigsuspend
+	.long sys_pread64		/* 180 */
+	.long sys_pwrite64
+	.long sys_lchown16
+	.long sys_getcwd
+	.long sys_capget
+	.long sys_capset		/* 185 */
+	.long sys_sigaltstack
+	.long sys_sendfile
+	.long sys_ni_syscall		/* streams1 */
+	.long sys_ni_syscall		/* streams2 */
+	.long __sys_vfork		/* 190 */
+	.long sys_getrlimit
+	.long sys_mmap2
+	.long sys_truncate64
+	.long sys_ftruncate64
+	.long sys_stat64		/* 195 */
+	.long sys_lstat64
+	.long sys_fstat64
+	.long sys_chown
+	.long sys_getuid
+	.long sys_getgid		/* 200 */
+	.long sys_geteuid
+	.long sys_getegid
+	.long sys_setreuid
+	.long sys_setregid
+	.long sys_getgroups		/* 205 */
+	.long sys_setgroups
+	.long sys_fchown
+	.long sys_setresuid
+	.long sys_getresuid
+	.long sys_setresgid		/* 210 */
+	.long sys_getresgid
+	.long sys_lchown
+	.long sys_setuid
+	.long sys_setgid
+	.long sys_setfsuid		/* 215 */
+	.long sys_setfsgid
+	.long sys_pivot_root
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_getdents64		/* 220 */
+	.long sys_gettid
+	.long sys_tkill
+	.long sys_setxattr
+	.long sys_lsetxattr
+	.long sys_fsetxattr		/* 225 */
+	.long sys_getxattr
+	.long sys_lgetxattr
+	.long sys_fgetxattr
+	.long sys_listxattr
+	.long sys_llistxattr		/* 230 */
+	.long sys_flistxattr
+	.long sys_removexattr
+	.long sys_lremovexattr
+	.long sys_fremovexattr
+	.long sys_futex			/* 235 */
+	.long sys_sendfile64
+	.long sys_mincore
+	.long sys_madvise
+	.long sys_fcntl64
+	.long sys_readahead		/* 240 */
+	.long sys_io_setup
+	.long sys_io_destroy
+	.long sys_io_getevents
+	.long sys_io_submit
+	.long sys_io_cancel		/* 245 */
+	.long sys_fadvise64
+	.long sys_exit_group
+	.long sys_lookup_dcookie
+	.long sys_epoll_create
+	.long sys_epoll_ctl		/* 250 */
+	.long sys_epoll_wait
+	.long sys_remap_file_pages
+	.long sys_set_tid_address
+	.long sys_timer_create
+	.long sys_timer_settime		/* 255 */
+	.long sys_timer_gettime
+	.long sys_timer_getoverrun
+	.long sys_timer_delete
+	.long sys_clock_settime
+	.long sys_clock_gettime		/* 260 */
+	.long sys_clock_getres
+	.long sys_clock_nanosleep
+	.long sys_statfs64
+	.long sys_fstatfs64
+	.long sys_tgkill		/* 265 */
+	.long sys_utimes
+	.long sys_fadvise64_64
+	.long sys_mbind
+	.long sys_get_mempolicy
+	.long sys_set_mempolicy		/* 270 */
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive
+	.long sys_mq_notify		/* 275 */
+	.long sys_mq_getsetattr
+	.long sys_waitid
+	.long sys_ni_syscall		/* for sys_vserver */
+	.long sys_add_key
+	.long sys_request_key		/* 280 */
+	.long sys_keyctl
+	.long sys_ioprio_set
+	.long sys_ioprio_get
+	.long sys_inotify_init
+	.long sys_inotify_add_watch	/* 285 */
+	.long sys_inotify_rm_watch
+	.long sys_migrate_pages
+	.long sys_openat
+	.long sys_mkdirat
+	.long sys_mknodat		/* 290 */
+	.long sys_fchownat
+	.long sys_futimesat
+	.long sys_fstatat64
+	.long sys_unlinkat
+	.long sys_renameat		/* 295 */
+	.long sys_linkat
+	.long sys_symlinkat
+	.long sys_readlinkat
+	.long sys_fchmodat
+	.long sys_faccessat		/* 300 */
+	.long sys_pselect6
+	.long sys_ppoll
+	.long sys_unshare
+	.long sys_set_robust_list
+	.long sys_get_robust_list	/* 305 */
+	.long sys_splice
+	.long sys_sync_file_range
+	.long sys_tee
+	.long sys_vmsplice
+	.long sys_move_pages		/* 310 */
+	.long sys_sched_setaffinity
+	.long sys_sched_getaffinity
+	.long sys_kexec_load
+	.long sys_getcpu
+	.long sys_epoll_pwait		/* 315 */
+	.long sys_utimensat
+	.long sys_signalfd
+	.long sys_timerfd_create
+	.long sys_eventfd
+	.long sys_fallocate		/* 320 */
+	.long sys_timerfd_settime
+	.long sys_timerfd_gettime
+	.long sys_signalfd4
+	.long sys_eventfd2
+	.long sys_epoll_create1		/* 325 */
+	.long sys_dup3
+	.long sys_pipe2
+	.long sys_inotify_init1
+	.long sys_preadv
+	.long sys_pwritev		/* 330 */
+	.long sys_rt_tgsigqueueinfo
+	.long sys_perf_event_open
+	.long sys_get_thread_area
+	.long sys_set_thread_area
+	.long sys_atomic_cmpxchg_32	/* 335 */
+	.long sys_atomic_barrier
+	.long sys_fanotify_init
+	.long sys_fanotify_mark
+	.long sys_prlimit64
+	.long sys_name_to_handle_at	/* 340 */
+	.long sys_open_by_handle_at
+	.long sys_clock_adjtime
+	.long sys_syncfs
+	.long sys_setns
+	.long sys_process_vm_readv	/* 345 */
+	.long sys_process_vm_writev
+	.long sys_kcmp
+	.long sys_finit_module
+	.long sys_sched_setattr
+	.long sys_sched_getattr		/* 350 */
+	.long sys_renameat2
+	.long sys_getrandom
+	.long sys_memfd_create
+	.long sys_bpf
+	.long sys_execveat		/* 355 */
+	.long sys_socket
+	.long sys_socketpair
+	.long sys_bind
+	.long sys_connect
+	.long sys_listen		/* 360 */
+	.long sys_accept4
+	.long sys_getsockopt
+	.long sys_setsockopt
+	.long sys_getsockname
+	.long sys_getpeername		/* 365 */
+	.long sys_sendto
+	.long sys_sendmsg
+	.long sys_recvfrom
+	.long sys_recvmsg
+	.long sys_shutdown		/* 370 */
+	.long sys_recvmmsg
+	.long sys_sendmmsg
+	.long sys_userfaultfd
+	.long sys_membarrier
+	.long sys_mlock2		/* 375 */
+	.long sys_copy_file_range
+	.long sys_preadv2
+	.long sys_pwritev2
+	.long sys_statx
diff --git a/arch/m68k/kernel/syscalltable.S b/arch/m68k/kernel/syscalltable.S
deleted file mode 100644
index 2c8402e..0000000
--- a/arch/m68k/kernel/syscalltable.S
+++ /dev/null
@@ -1,403 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright (C) 2002, Greg Ungerer (gerg@snapgear.com)
- *
- *  Based on older entry.S files, the following copyrights apply:
- *
- *  Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>,
- *                      Kenneth Albanowski <kjahds@kjahds.com>,
- *  Copyright (C) 2000  Lineo Inc. (www.lineo.com) 
- *  Copyright (C) 1991, 1992  Linus Torvalds
- *
- *  Linux/m68k support by Hamish Macdonald
- */
-
-#include <linux/linkage.h>
-
-#ifndef CONFIG_MMU
-#define sys_mmap2		sys_mmap_pgoff
-#endif
-
-.section .rodata
-ALIGN
-ENTRY(sys_call_table)
-	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
-	.long sys_exit
-	.long __sys_fork
-	.long sys_read
-	.long sys_write
-	.long sys_open			/* 5 */
-	.long sys_close
-	.long sys_waitpid
-	.long sys_creat
-	.long sys_link
-	.long sys_unlink		/* 10 */
-	.long sys_execve
-	.long sys_chdir
-	.long sys_time
-	.long sys_mknod
-	.long sys_chmod			/* 15 */
-	.long sys_chown16
-	.long sys_ni_syscall		/* old break syscall holder */
-	.long sys_stat
-	.long sys_lseek
-	.long sys_getpid		/* 20 */
-	.long sys_mount
-	.long sys_oldumount
-	.long sys_setuid16
-	.long sys_getuid16
-	.long sys_stime			/* 25 */
-	.long sys_ptrace
-	.long sys_alarm
-	.long sys_fstat
-	.long sys_pause
-	.long sys_utime			/* 30 */
-	.long sys_ni_syscall		/* old stty syscall holder */
-	.long sys_ni_syscall		/* old gtty syscall holder */
-	.long sys_access
-	.long sys_nice
-	.long sys_ni_syscall		/* 35 - old ftime syscall holder */
-	.long sys_sync
-	.long sys_kill
-	.long sys_rename
-	.long sys_mkdir
-	.long sys_rmdir			/* 40 */
-	.long sys_dup
-	.long sys_pipe
-	.long sys_times
-	.long sys_ni_syscall		/* old prof syscall holder */
-	.long sys_brk			/* 45 */
-	.long sys_setgid16
-	.long sys_getgid16
-	.long sys_signal
-	.long sys_geteuid16
-	.long sys_getegid16		/* 50 */
-	.long sys_acct
-	.long sys_umount		/* recycled never used phys() */
-	.long sys_ni_syscall		/* old lock syscall holder */
-	.long sys_ioctl
-	.long sys_fcntl			/* 55 */
-	.long sys_ni_syscall		/* old mpx syscall holder */
-	.long sys_setpgid
-	.long sys_ni_syscall		/* old ulimit syscall holder */
-	.long sys_ni_syscall
-	.long sys_umask			/* 60 */
-	.long sys_chroot
-	.long sys_ustat
-	.long sys_dup2
-	.long sys_getppid
-	.long sys_getpgrp		/* 65 */
-	.long sys_setsid
-	.long sys_sigaction
-	.long sys_sgetmask
-	.long sys_ssetmask
-	.long sys_setreuid16		/* 70 */
-	.long sys_setregid16
-	.long sys_sigsuspend
-	.long sys_sigpending
-	.long sys_sethostname
-	.long sys_setrlimit		/* 75 */
-	.long sys_old_getrlimit
-	.long sys_getrusage
-	.long sys_gettimeofday
-	.long sys_settimeofday
-	.long sys_getgroups16		/* 80 */
-	.long sys_setgroups16
-	.long sys_old_select
-	.long sys_symlink
-	.long sys_lstat
-	.long sys_readlink		/* 85 */
-	.long sys_uselib
-	.long sys_swapon
-	.long sys_reboot
-	.long sys_old_readdir
-	.long sys_old_mmap		/* 90 */
-	.long sys_munmap
-	.long sys_truncate
-	.long sys_ftruncate
-	.long sys_fchmod
-	.long sys_fchown16		/* 95 */
-	.long sys_getpriority
-	.long sys_setpriority
-	.long sys_ni_syscall		/* old profil syscall holder */
-	.long sys_statfs
-	.long sys_fstatfs		/* 100 */
-	.long sys_ni_syscall		/* ioperm for i386 */
-	.long sys_socketcall
-	.long sys_syslog
-	.long sys_setitimer
-	.long sys_getitimer		/* 105 */
-	.long sys_newstat
-	.long sys_newlstat
-	.long sys_newfstat
-	.long sys_ni_syscall
-	.long sys_ni_syscall		/* 110 - iopl for i386 */
-	.long sys_vhangup
-	.long sys_ni_syscall		/* obsolete idle() syscall */
-	.long sys_ni_syscall		/* vm86old for i386 */
-	.long sys_wait4
-	.long sys_swapoff		/* 115 */
-	.long sys_sysinfo
-	.long sys_ipc
-	.long sys_fsync
-	.long sys_sigreturn
-	.long __sys_clone		/* 120 */
-	.long sys_setdomainname
-	.long sys_newuname
-	.long sys_cacheflush		/* modify_ldt for i386 */
-	.long sys_adjtimex
-	.long sys_mprotect		/* 125 */
-	.long sys_sigprocmask
-	.long sys_ni_syscall		/* old "create_module" */
-	.long sys_init_module
-	.long sys_delete_module
-	.long sys_ni_syscall		/* 130 - old "get_kernel_syms" */
-	.long sys_quotactl
-	.long sys_getpgid
-	.long sys_fchdir
-	.long sys_bdflush
-	.long sys_sysfs			/* 135 */
-	.long sys_personality
-	.long sys_ni_syscall		/* for afs_syscall */
-	.long sys_setfsuid16
-	.long sys_setfsgid16
-	.long sys_llseek		/* 140 */
-	.long sys_getdents
-	.long sys_select
-	.long sys_flock
-	.long sys_msync
-	.long sys_readv			/* 145 */
-	.long sys_writev
-	.long sys_getsid
-	.long sys_fdatasync
-	.long sys_sysctl
-	.long sys_mlock			/* 150 */
-	.long sys_munlock
-	.long sys_mlockall
-	.long sys_munlockall
-	.long sys_sched_setparam
-	.long sys_sched_getparam	/* 155 */
-	.long sys_sched_setscheduler
-	.long sys_sched_getscheduler
-	.long sys_sched_yield
-	.long sys_sched_get_priority_max
-	.long sys_sched_get_priority_min  /* 160 */
-	.long sys_sched_rr_get_interval
-	.long sys_nanosleep
-	.long sys_mremap
-	.long sys_setresuid16
-	.long sys_getresuid16		/* 165 */
-	.long sys_getpagesize
-	.long sys_ni_syscall		/* old "query_module" */
-	.long sys_poll
-	.long sys_ni_syscall		/* old nfsservctl */
-	.long sys_setresgid16		/* 170 */
-	.long sys_getresgid16
-	.long sys_prctl
-	.long sys_rt_sigreturn
-	.long sys_rt_sigaction
-	.long sys_rt_sigprocmask	/* 175 */
-	.long sys_rt_sigpending
-	.long sys_rt_sigtimedwait
-	.long sys_rt_sigqueueinfo
-	.long sys_rt_sigsuspend
-	.long sys_pread64		/* 180 */
-	.long sys_pwrite64
-	.long sys_lchown16
-	.long sys_getcwd
-	.long sys_capget
-	.long sys_capset		/* 185 */
-	.long sys_sigaltstack
-	.long sys_sendfile
-	.long sys_ni_syscall		/* streams1 */
-	.long sys_ni_syscall		/* streams2 */
-	.long __sys_vfork		/* 190 */
-	.long sys_getrlimit
-	.long sys_mmap2
-	.long sys_truncate64
-	.long sys_ftruncate64
-	.long sys_stat64		/* 195 */
-	.long sys_lstat64
-	.long sys_fstat64
-	.long sys_chown
-	.long sys_getuid
-	.long sys_getgid		/* 200 */
-	.long sys_geteuid
-	.long sys_getegid
-	.long sys_setreuid
-	.long sys_setregid
-	.long sys_getgroups		/* 205 */
-	.long sys_setgroups
-	.long sys_fchown
-	.long sys_setresuid
-	.long sys_getresuid
-	.long sys_setresgid		/* 210 */
-	.long sys_getresgid
-	.long sys_lchown
-	.long sys_setuid
-	.long sys_setgid
-	.long sys_setfsuid		/* 215 */
-	.long sys_setfsgid
-	.long sys_pivot_root
-	.long sys_ni_syscall
-	.long sys_ni_syscall
-	.long sys_getdents64		/* 220 */
-	.long sys_gettid
-	.long sys_tkill
-	.long sys_setxattr
-	.long sys_lsetxattr
-	.long sys_fsetxattr		/* 225 */
-	.long sys_getxattr
-	.long sys_lgetxattr
-	.long sys_fgetxattr
-	.long sys_listxattr
-	.long sys_llistxattr		/* 230 */
-	.long sys_flistxattr
-	.long sys_removexattr
-	.long sys_lremovexattr
-	.long sys_fremovexattr
-	.long sys_futex			/* 235 */
-	.long sys_sendfile64
-	.long sys_mincore
-	.long sys_madvise
-	.long sys_fcntl64
-	.long sys_readahead		/* 240 */
-	.long sys_io_setup
-	.long sys_io_destroy
-	.long sys_io_getevents
-	.long sys_io_submit
-	.long sys_io_cancel		/* 245 */
-	.long sys_fadvise64
-	.long sys_exit_group
-	.long sys_lookup_dcookie
-	.long sys_epoll_create
-	.long sys_epoll_ctl		/* 250 */
-	.long sys_epoll_wait
-	.long sys_remap_file_pages
-	.long sys_set_tid_address
-	.long sys_timer_create
-	.long sys_timer_settime		/* 255 */
-	.long sys_timer_gettime
-	.long sys_timer_getoverrun
-	.long sys_timer_delete
-	.long sys_clock_settime
-	.long sys_clock_gettime		/* 260 */
-	.long sys_clock_getres
-	.long sys_clock_nanosleep
-	.long sys_statfs64
-	.long sys_fstatfs64
-	.long sys_tgkill		/* 265 */
-	.long sys_utimes
-	.long sys_fadvise64_64
-	.long sys_mbind
-	.long sys_get_mempolicy
-	.long sys_set_mempolicy		/* 270 */
-	.long sys_mq_open
-	.long sys_mq_unlink
-	.long sys_mq_timedsend
-	.long sys_mq_timedreceive
-	.long sys_mq_notify		/* 275 */
-	.long sys_mq_getsetattr
-	.long sys_waitid
-	.long sys_ni_syscall		/* for sys_vserver */
-	.long sys_add_key
-	.long sys_request_key		/* 280 */
-	.long sys_keyctl
-	.long sys_ioprio_set
-	.long sys_ioprio_get
-	.long sys_inotify_init
-	.long sys_inotify_add_watch	/* 285 */
-	.long sys_inotify_rm_watch
-	.long sys_migrate_pages
-	.long sys_openat
-	.long sys_mkdirat
-	.long sys_mknodat		/* 290 */
-	.long sys_fchownat
-	.long sys_futimesat
-	.long sys_fstatat64
-	.long sys_unlinkat
-	.long sys_renameat		/* 295 */
-	.long sys_linkat
-	.long sys_symlinkat
-	.long sys_readlinkat
-	.long sys_fchmodat
-	.long sys_faccessat		/* 300 */
-	.long sys_pselect6
-	.long sys_ppoll
-	.long sys_unshare
-	.long sys_set_robust_list
-	.long sys_get_robust_list	/* 305 */
-	.long sys_splice
-	.long sys_sync_file_range
-	.long sys_tee
-	.long sys_vmsplice
-	.long sys_move_pages		/* 310 */
-	.long sys_sched_setaffinity
-	.long sys_sched_getaffinity
-	.long sys_kexec_load
-	.long sys_getcpu
-	.long sys_epoll_pwait		/* 315 */
-	.long sys_utimensat
-	.long sys_signalfd
-	.long sys_timerfd_create
-	.long sys_eventfd
-	.long sys_fallocate		/* 320 */
-	.long sys_timerfd_settime
-	.long sys_timerfd_gettime
-	.long sys_signalfd4
-	.long sys_eventfd2
-	.long sys_epoll_create1		/* 325 */
-	.long sys_dup3
-	.long sys_pipe2
-	.long sys_inotify_init1
-	.long sys_preadv
-	.long sys_pwritev		/* 330 */
-	.long sys_rt_tgsigqueueinfo
-	.long sys_perf_event_open
-	.long sys_get_thread_area
-	.long sys_set_thread_area
-	.long sys_atomic_cmpxchg_32	/* 335 */
-	.long sys_atomic_barrier
-	.long sys_fanotify_init
-	.long sys_fanotify_mark
-	.long sys_prlimit64
-	.long sys_name_to_handle_at	/* 340 */
-	.long sys_open_by_handle_at
-	.long sys_clock_adjtime
-	.long sys_syncfs
-	.long sys_setns
-	.long sys_process_vm_readv	/* 345 */
-	.long sys_process_vm_writev
-	.long sys_kcmp
-	.long sys_finit_module
-	.long sys_sched_setattr
-	.long sys_sched_getattr		/* 350 */
-	.long sys_renameat2
-	.long sys_getrandom
-	.long sys_memfd_create
-	.long sys_bpf
-	.long sys_execveat		/* 355 */
-	.long sys_socket
-	.long sys_socketpair
-	.long sys_bind
-	.long sys_connect
-	.long sys_listen		/* 360 */
-	.long sys_accept4
-	.long sys_getsockopt
-	.long sys_setsockopt
-	.long sys_getsockname
-	.long sys_getpeername		/* 365 */
-	.long sys_sendto
-	.long sys_sendmsg
-	.long sys_recvfrom
-	.long sys_recvmsg
-	.long sys_shutdown		/* 370 */
-	.long sys_recvmmsg
-	.long sys_sendmmsg
-	.long sys_userfaultfd
-	.long sys_membarrier
-	.long sys_mlock2		/* 375 */
-	.long sys_copy_file_range
-	.long sys_preadv2
-	.long sys_pwritev2
-	.long sys_statx
-- 
1.9.1

