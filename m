Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE4C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CD221C17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kevNxDa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CD221C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeHIH2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:28:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36222 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbeHIH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:28:55 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so2028242plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JB11ex8zsM2HeAfsGO5Q4scG3VHxHYY3+zD5HpvhLNk=;
        b=kevNxDa9liyY1m59oWUT0bdGQqjMul8JMJOY/qVXtQWwocy+Kfz7aFJGxhm8pthifU
         fHiYkUnaxf0yPQls4ZJD+OZZE+SmeV0oDdpCADwOtzET0ptyd96tzi2PH7R0h9gxVoiR
         d43OMqDMdBizz1YHR4UEXuSWkionJHLO14Zz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JB11ex8zsM2HeAfsGO5Q4scG3VHxHYY3+zD5HpvhLNk=;
        b=SJerbTvHbnVi0swkjY4jSzMct4TGytMxUrLLrzCQzYMuKHSuDQSIx0y9qkuE5/3iVH
         YGQHpyoyFaMMsN/ru4uWnypPATyfWzUQgncsAntC+VOvRErMNHouB+cQu5UL8cjjFQgu
         gaCGhB+hiPuKOUkM0ZZifH0GmOuRh5zY7RtxViJhW9spDri5T/sQ594aAppJcpNS2e+N
         IlF2WEP48Q+T5E1tUaEbQULmZA5l3Q+wn3ICJrdV4AKqucbcGfc2c1ydZoJGRAqagsbJ
         aMsdu5/U9DqsdjQJU/9FrTVl0b9QiyxphuRluwtEHc6XnE5krbv31vhGa7SV3Eim37HG
         1lFQ==
X-Gm-Message-State: AOUpUlHyx/BwWbjJVDMap6bAqrbVJ8HMMUo1hT7MR+Kf/tPM0QZq1I33
        DJB7X8//hBEukjJMz1e2FUT8Qcb6pu4=
X-Google-Smtp-Source: AA+uWPzKPNqDWVJIMYLTJAbh9OgQ9sr2m8eU0ApXxHWKBHq3pZSsfpq0iwYcFE09LeXsodT2oyS+eA==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr595588pla.131.1533791156839;
        Wed, 08 Aug 2018 22:05:56 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id c1-v6sm6919419pfi.142.2018.08.08.22.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:05:56 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 3/5] ia64: Replaced the system call table entry from entry.S
Date:   Thu,  9 Aug 2018 10:35:13 +0530
Message-Id: <1533791115-3681-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533791115-3681-1-git-send-email-firoz.khan@linaro.org>
References: <1533791115-3681-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In IA64, system call table entries are the part of entry.S file. We
need to keep it in a seperate file so that one of the patch in this
patch seriers does have a system call table generation script which
can seperatly handle system call table entries.

Replaced the system call table from entry.S to new file - syscall.S,
and this change will unify the implementation across all the
architecture and to simplify the implementation for system call
table generation using the script.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/kernel/entry.S   | 333 +-------------------------------------------
 arch/ia64/kernel/syscall.S | 334 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 335 insertions(+), 332 deletions(-)
 create mode 100644 arch/ia64/kernel/syscall.S

diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index f40d9fd..cf463a6 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -1426,335 +1426,4 @@ END(ftrace_stub)
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
-	.rodata
-	.align 8
-	.globl sys_call_table
-sys_call_table:
-	data8 sys_ni_syscall		//  This must be sys_ni_syscall!  See ivt.S.
-	data8 sys_exit				// 1025
-	data8 sys_read
-	data8 sys_write
-	data8 sys_open
-	data8 sys_close
-	data8 sys_creat				// 1030
-	data8 sys_link
-	data8 sys_unlink
-	data8 ia64_execve
-	data8 sys_chdir
-	data8 sys_fchdir			// 1035
-	data8 sys_utimes
-	data8 sys_mknod
-	data8 sys_chmod
-	data8 sys_chown
-	data8 sys_lseek				// 1040
-	data8 sys_getpid
-	data8 sys_getppid
-	data8 sys_mount
-	data8 sys_umount
-	data8 sys_setuid			// 1045
-	data8 sys_getuid
-	data8 sys_geteuid
-	data8 sys_ptrace
-	data8 sys_access
-	data8 sys_sync				// 1050
-	data8 sys_fsync
-	data8 sys_fdatasync
-	data8 sys_kill
-	data8 sys_rename
-	data8 sys_mkdir				// 1055
-	data8 sys_rmdir
-	data8 sys_dup
-	data8 sys_ia64_pipe
-	data8 sys_times
-	data8 ia64_brk				// 1060
-	data8 sys_setgid
-	data8 sys_getgid
-	data8 sys_getegid
-	data8 sys_acct
-	data8 sys_ioctl				// 1065
-	data8 sys_fcntl
-	data8 sys_umask
-	data8 sys_chroot
-	data8 sys_ustat
-	data8 sys_dup2				// 1070
-	data8 sys_setreuid
-	data8 sys_setregid
-	data8 sys_getresuid
-	data8 sys_setresuid
-	data8 sys_getresgid			// 1075
-	data8 sys_setresgid
-	data8 sys_getgroups
-	data8 sys_setgroups
-	data8 sys_getpgid
-	data8 sys_setpgid			// 1080
-	data8 sys_setsid
-	data8 sys_getsid
-	data8 sys_sethostname
-	data8 sys_setrlimit
-	data8 sys_getrlimit			// 1085
-	data8 sys_getrusage
-	data8 sys_gettimeofday
-	data8 sys_settimeofday
-	data8 sys_select
-	data8 sys_poll				// 1090
-	data8 sys_symlink
-	data8 sys_readlink
-	data8 sys_uselib
-	data8 sys_swapon
-	data8 sys_swapoff			// 1095
-	data8 sys_reboot
-	data8 sys_truncate
-	data8 sys_ftruncate
-	data8 sys_fchmod
-	data8 sys_fchown			// 1100
-	data8 ia64_getpriority
-	data8 sys_setpriority
-	data8 sys_statfs
-	data8 sys_fstatfs
-	data8 sys_gettid			// 1105
-	data8 sys_semget
-	data8 sys_semop
-	data8 sys_semctl
-	data8 sys_msgget
-	data8 sys_msgsnd			// 1110
-	data8 sys_msgrcv
-	data8 sys_msgctl
-	data8 sys_shmget
-	data8 sys_shmat
-	data8 sys_shmdt				// 1115
-	data8 sys_shmctl
-	data8 sys_syslog
-	data8 sys_setitimer
-	data8 sys_getitimer
-	data8 sys_ni_syscall			// 1120		/* was: ia64_oldstat */
-	data8 sys_ni_syscall					/* was: ia64_oldlstat */
-	data8 sys_ni_syscall					/* was: ia64_oldfstat */
-	data8 sys_vhangup
-	data8 sys_lchown
-	data8 sys_remap_file_pages		// 1125
-	data8 sys_wait4
-	data8 sys_sysinfo
-	data8 sys_clone
-	data8 sys_setdomainname
-	data8 sys_newuname			// 1130
-	data8 sys_adjtimex
-	data8 sys_ni_syscall					/* was: ia64_create_module */
-	data8 sys_init_module
-	data8 sys_delete_module
-	data8 sys_ni_syscall			// 1135		/* was: sys_get_kernel_syms */
-	data8 sys_ni_syscall					/* was: sys_query_module */
-	data8 sys_quotactl
-	data8 sys_bdflush
-	data8 sys_sysfs
-	data8 sys_personality			// 1140
-	data8 sys_ni_syscall		// sys_afs_syscall
-	data8 sys_setfsuid
-	data8 sys_setfsgid
-	data8 sys_getdents
-	data8 sys_flock				// 1145
-	data8 sys_readv
-	data8 sys_writev
-	data8 sys_pread64
-	data8 sys_pwrite64
-	data8 sys_sysctl			// 1150
-	data8 sys_mmap
-	data8 sys_munmap
-	data8 sys_mlock
-	data8 sys_mlockall
-	data8 sys_mprotect			// 1155
-	data8 ia64_mremap
-	data8 sys_msync
-	data8 sys_munlock
-	data8 sys_munlockall
-	data8 sys_sched_getparam		// 1160
-	data8 sys_sched_setparam
-	data8 sys_sched_getscheduler
-	data8 sys_sched_setscheduler
-	data8 sys_sched_yield
-	data8 sys_sched_get_priority_max	// 1165
-	data8 sys_sched_get_priority_min
-	data8 sys_sched_rr_get_interval
-	data8 sys_nanosleep
-	data8 sys_ni_syscall			// old nfsservctl
-	data8 sys_prctl				// 1170
-	data8 sys_getpagesize
-	data8 sys_mmap2
-	data8 sys_pciconfig_read
-	data8 sys_pciconfig_write
-	data8 sys_perfmonctl			// 1175
-	data8 sys_sigaltstack
-	data8 sys_rt_sigaction
-	data8 sys_rt_sigpending
-	data8 sys_rt_sigprocmask
-	data8 sys_rt_sigqueueinfo		// 1180
-	data8 sys_rt_sigreturn
-	data8 sys_rt_sigsuspend
-	data8 sys_rt_sigtimedwait
-	data8 sys_getcwd
-	data8 sys_capget			// 1185
-	data8 sys_capset
-	data8 sys_sendfile64
-	data8 sys_ni_syscall		// sys_getpmsg (STREAMS)
-	data8 sys_ni_syscall		// sys_putpmsg (STREAMS)
-	data8 sys_socket			// 1190
-	data8 sys_bind
-	data8 sys_connect
-	data8 sys_listen
-	data8 sys_accept
-	data8 sys_getsockname			// 1195
-	data8 sys_getpeername
-	data8 sys_socketpair
-	data8 sys_send
-	data8 sys_sendto
-	data8 sys_recv				// 1200
-	data8 sys_recvfrom
-	data8 sys_shutdown
-	data8 sys_setsockopt
-	data8 sys_getsockopt
-	data8 sys_sendmsg			// 1205
-	data8 sys_recvmsg
-	data8 sys_pivot_root
-	data8 sys_mincore
-	data8 sys_madvise
-	data8 sys_newstat			// 1210
-	data8 sys_newlstat
-	data8 sys_newfstat
-	data8 sys_clone2
-	data8 sys_getdents64
-	data8 sys_getunwind			// 1215
-	data8 sys_readahead
-	data8 sys_setxattr
-	data8 sys_lsetxattr
-	data8 sys_fsetxattr
-	data8 sys_getxattr			// 1220
-	data8 sys_lgetxattr
-	data8 sys_fgetxattr
-	data8 sys_listxattr
-	data8 sys_llistxattr
-	data8 sys_flistxattr			// 1225
-	data8 sys_removexattr
-	data8 sys_lremovexattr
-	data8 sys_fremovexattr
-	data8 sys_tkill
-	data8 sys_futex				// 1230
-	data8 sys_sched_setaffinity
-	data8 sys_sched_getaffinity
-	data8 sys_set_tid_address
-	data8 sys_fadvise64_64
-	data8 sys_tgkill 			// 1235
-	data8 sys_exit_group
-	data8 sys_lookup_dcookie
-	data8 sys_io_setup
-	data8 sys_io_destroy
-	data8 sys_io_getevents			// 1240
-	data8 sys_io_submit
-	data8 sys_io_cancel
-	data8 sys_epoll_create
-	data8 sys_epoll_ctl
-	data8 sys_epoll_wait			// 1245
-	data8 sys_restart_syscall
-	data8 sys_semtimedop
-	data8 sys_timer_create
-	data8 sys_timer_settime
-	data8 sys_timer_gettime			// 1250
-	data8 sys_timer_getoverrun
-	data8 sys_timer_delete
-	data8 sys_clock_settime
-	data8 sys_clock_gettime
-	data8 sys_clock_getres			// 1255
-	data8 sys_clock_nanosleep
-	data8 sys_fstatfs64
-	data8 sys_statfs64
-	data8 sys_mbind
-	data8 sys_get_mempolicy			// 1260
-	data8 sys_set_mempolicy
-	data8 sys_mq_open
-	data8 sys_mq_unlink
-	data8 sys_mq_timedsend
-	data8 sys_mq_timedreceive		// 1265
-	data8 sys_mq_notify
-	data8 sys_mq_getsetattr
-	data8 sys_kexec_load
-	data8 sys_ni_syscall			// reserved for vserver
-	data8 sys_waitid			// 1270
-	data8 sys_add_key
-	data8 sys_request_key
-	data8 sys_keyctl
-	data8 sys_ioprio_set
-	data8 sys_ioprio_get			// 1275
-	data8 sys_move_pages
-	data8 sys_inotify_init
-	data8 sys_inotify_add_watch
-	data8 sys_inotify_rm_watch
-	data8 sys_migrate_pages			// 1280
-	data8 sys_openat
-	data8 sys_mkdirat
-	data8 sys_mknodat
-	data8 sys_fchownat
-	data8 sys_futimesat			// 1285
-	data8 sys_newfstatat
-	data8 sys_unlinkat
-	data8 sys_renameat
-	data8 sys_linkat
-	data8 sys_symlinkat			// 1290
-	data8 sys_readlinkat
-	data8 sys_fchmodat
-	data8 sys_faccessat
-	data8 sys_pselect6
-	data8 sys_ppoll				// 1295
-	data8 sys_unshare
-	data8 sys_splice
-	data8 sys_set_robust_list
-	data8 sys_get_robust_list
-	data8 sys_sync_file_range		// 1300
-	data8 sys_tee
-	data8 sys_vmsplice
-	data8 sys_fallocate
-	data8 sys_getcpu
-	data8 sys_epoll_pwait			// 1305
-	data8 sys_utimensat
-	data8 sys_signalfd
-	data8 sys_ni_syscall
-	data8 sys_eventfd
-	data8 sys_timerfd_create		// 1310
-	data8 sys_timerfd_settime
-	data8 sys_timerfd_gettime
-	data8 sys_signalfd4
-	data8 sys_eventfd2
-	data8 sys_epoll_create1			// 1315
-	data8 sys_dup3
-	data8 sys_pipe2
-	data8 sys_inotify_init1
-	data8 sys_preadv
-	data8 sys_pwritev			// 1320
-	data8 sys_rt_tgsigqueueinfo
-	data8 sys_recvmmsg
-	data8 sys_fanotify_init
-	data8 sys_fanotify_mark
-	data8 sys_prlimit64			// 1325
-	data8 sys_name_to_handle_at
-	data8 sys_open_by_handle_at
-	data8 sys_clock_adjtime
-	data8 sys_syncfs
-	data8 sys_setns				// 1330
-	data8 sys_sendmmsg
-	data8 sys_process_vm_readv
-	data8 sys_process_vm_writev
-	data8 sys_accept4
-	data8 sys_finit_module			// 1335
-	data8 sys_sched_setattr
-	data8 sys_sched_getattr
-	data8 sys_renameat2
-	data8 sys_getrandom
-	data8 sys_memfd_create			// 1340
-	data8 sys_bpf
-	data8 sys_execveat
-	data8 sys_userfaultfd
-	data8 sys_membarrier
-	data8 sys_kcmp				// 1345
-	data8 sys_mlock2
-	data8 sys_copy_file_range
-	data8 sys_preadv2
-	data8 sys_pwritev2
-
-	.org sys_call_table + 8*__NR_syscalls	// guard against failures to increase __NR_syscalls
+#include "syscall.S"
diff --git a/arch/ia64/kernel/syscall.S b/arch/ia64/kernel/syscall.S
new file mode 100644
index 0000000..970e0e6
--- /dev/null
+++ b/arch/ia64/kernel/syscall.S
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.rodata
+	.align 8
+	.globl sys_call_table
+sys_call_table:
+	data8 sys_ni_syscall		//  This must be sys_ni_syscall!  See ivt.S.
+	data8 sys_exit				// 1025
+	data8 sys_read
+	data8 sys_write
+	data8 sys_open
+	data8 sys_close
+	data8 sys_creat				// 1030
+	data8 sys_link
+	data8 sys_unlink
+	data8 ia64_execve
+	data8 sys_chdir
+	data8 sys_fchdir			// 1035
+	data8 sys_utimes
+	data8 sys_mknod
+	data8 sys_chmod
+	data8 sys_chown
+	data8 sys_lseek				// 1040
+	data8 sys_getpid
+	data8 sys_getppid
+	data8 sys_mount
+	data8 sys_umount
+	data8 sys_setuid			// 1045
+	data8 sys_getuid
+	data8 sys_geteuid
+	data8 sys_ptrace
+	data8 sys_access
+	data8 sys_sync				// 1050
+	data8 sys_fsync
+	data8 sys_fdatasync
+	data8 sys_kill
+	data8 sys_rename
+	data8 sys_mkdir				// 1055
+	data8 sys_rmdir
+	data8 sys_dup
+	data8 sys_ia64_pipe
+	data8 sys_times
+	data8 ia64_brk				// 1060
+	data8 sys_setgid
+	data8 sys_getgid
+	data8 sys_getegid
+	data8 sys_acct
+	data8 sys_ioctl				// 1065
+	data8 sys_fcntl
+	data8 sys_umask
+	data8 sys_chroot
+	data8 sys_ustat
+	data8 sys_dup2				// 1070
+	data8 sys_setreuid
+	data8 sys_setregid
+	data8 sys_getresuid
+	data8 sys_setresuid
+	data8 sys_getresgid			// 1075
+	data8 sys_setresgid
+	data8 sys_getgroups
+	data8 sys_setgroups
+	data8 sys_getpgid
+	data8 sys_setpgid			// 1080
+	data8 sys_setsid
+	data8 sys_getsid
+	data8 sys_sethostname
+	data8 sys_setrlimit
+	data8 sys_getrlimit			// 1085
+	data8 sys_getrusage
+	data8 sys_gettimeofday
+	data8 sys_settimeofday
+	data8 sys_select
+	data8 sys_poll				// 1090
+	data8 sys_symlink
+	data8 sys_readlink
+	data8 sys_uselib
+	data8 sys_swapon
+	data8 sys_swapoff			// 1095
+	data8 sys_reboot
+	data8 sys_truncate
+	data8 sys_ftruncate
+	data8 sys_fchmod
+	data8 sys_fchown			// 1100
+	data8 ia64_getpriority
+	data8 sys_setpriority
+	data8 sys_statfs
+	data8 sys_fstatfs
+	data8 sys_gettid			// 1105
+	data8 sys_semget
+	data8 sys_semop
+	data8 sys_semctl
+	data8 sys_msgget
+	data8 sys_msgsnd			// 1110
+	data8 sys_msgrcv
+	data8 sys_msgctl
+	data8 sys_shmget
+	data8 sys_shmat
+	data8 sys_shmdt				// 1115
+	data8 sys_shmctl
+	data8 sys_syslog
+	data8 sys_setitimer
+	data8 sys_getitimer
+	data8 sys_ni_syscall			// 1120		/* was: ia64_oldstat */
+	data8 sys_ni_syscall					/* was: ia64_oldlstat */
+	data8 sys_ni_syscall					/* was: ia64_oldfstat */
+	data8 sys_vhangup
+	data8 sys_lchown
+	data8 sys_remap_file_pages		// 1125
+	data8 sys_wait4
+	data8 sys_sysinfo
+	data8 sys_clone
+	data8 sys_setdomainname
+	data8 sys_newuname			// 1130
+	data8 sys_adjtimex
+	data8 sys_ni_syscall					/* was: ia64_create_module */
+	data8 sys_init_module
+	data8 sys_delete_module
+	data8 sys_ni_syscall			// 1135		/* was: sys_get_kernel_syms */
+	data8 sys_ni_syscall					/* was: sys_query_module */
+	data8 sys_quotactl
+	data8 sys_bdflush
+	data8 sys_sysfs
+	data8 sys_personality			// 1140
+	data8 sys_ni_syscall		// sys_afs_syscall
+	data8 sys_setfsuid
+	data8 sys_setfsgid
+	data8 sys_getdents
+	data8 sys_flock				// 1145
+	data8 sys_readv
+	data8 sys_writev
+	data8 sys_pread64
+	data8 sys_pwrite64
+	data8 sys_sysctl			// 1150
+	data8 sys_mmap
+	data8 sys_munmap
+	data8 sys_mlock
+	data8 sys_mlockall
+	data8 sys_mprotect			// 1155
+	data8 ia64_mremap
+	data8 sys_msync
+	data8 sys_munlock
+	data8 sys_munlockall
+	data8 sys_sched_getparam		// 1160
+	data8 sys_sched_setparam
+	data8 sys_sched_getscheduler
+	data8 sys_sched_setscheduler
+	data8 sys_sched_yield
+	data8 sys_sched_get_priority_max	// 1165
+	data8 sys_sched_get_priority_min
+	data8 sys_sched_rr_get_interval
+	data8 sys_nanosleep
+	data8 sys_ni_syscall			// old nfsservctl
+	data8 sys_prctl				// 1170
+	data8 sys_getpagesize
+	data8 sys_mmap2
+	data8 sys_pciconfig_read
+	data8 sys_pciconfig_write
+	data8 sys_perfmonctl			// 1175
+	data8 sys_sigaltstack
+	data8 sys_rt_sigaction
+	data8 sys_rt_sigpending
+	data8 sys_rt_sigprocmask
+	data8 sys_rt_sigqueueinfo		// 1180
+	data8 sys_rt_sigreturn
+	data8 sys_rt_sigsuspend
+	data8 sys_rt_sigtimedwait
+	data8 sys_getcwd
+	data8 sys_capget			// 1185
+	data8 sys_capset
+	data8 sys_sendfile64
+	data8 sys_ni_syscall		// sys_getpmsg (STREAMS)
+	data8 sys_ni_syscall		// sys_putpmsg (STREAMS)
+	data8 sys_socket			// 1190
+	data8 sys_bind
+	data8 sys_connect
+	data8 sys_listen
+	data8 sys_accept
+	data8 sys_getsockname			// 1195
+	data8 sys_getpeername
+	data8 sys_socketpair
+	data8 sys_send
+	data8 sys_sendto
+	data8 sys_recv				// 1200
+	data8 sys_recvfrom
+	data8 sys_shutdown
+	data8 sys_setsockopt
+	data8 sys_getsockopt
+	data8 sys_sendmsg			// 1205
+	data8 sys_recvmsg
+	data8 sys_pivot_root
+	data8 sys_mincore
+	data8 sys_madvise
+	data8 sys_newstat			// 1210
+	data8 sys_newlstat
+	data8 sys_newfstat
+	data8 sys_clone2
+	data8 sys_getdents64
+	data8 sys_getunwind			// 1215
+	data8 sys_readahead
+	data8 sys_setxattr
+	data8 sys_lsetxattr
+	data8 sys_fsetxattr
+	data8 sys_getxattr			// 1220
+	data8 sys_lgetxattr
+	data8 sys_fgetxattr
+	data8 sys_listxattr
+	data8 sys_llistxattr
+	data8 sys_flistxattr			// 1225
+	data8 sys_removexattr
+	data8 sys_lremovexattr
+	data8 sys_fremovexattr
+	data8 sys_tkill
+	data8 sys_futex				// 1230
+	data8 sys_sched_setaffinity
+	data8 sys_sched_getaffinity
+	data8 sys_set_tid_address
+	data8 sys_fadvise64_64
+	data8 sys_tgkill 			// 1235
+	data8 sys_exit_group
+	data8 sys_lookup_dcookie
+	data8 sys_io_setup
+	data8 sys_io_destroy
+	data8 sys_io_getevents			// 1240
+	data8 sys_io_submit
+	data8 sys_io_cancel
+	data8 sys_epoll_create
+	data8 sys_epoll_ctl
+	data8 sys_epoll_wait			// 1245
+	data8 sys_restart_syscall
+	data8 sys_semtimedop
+	data8 sys_timer_create
+	data8 sys_timer_settime
+	data8 sys_timer_gettime			// 1250
+	data8 sys_timer_getoverrun
+	data8 sys_timer_delete
+	data8 sys_clock_settime
+	data8 sys_clock_gettime
+	data8 sys_clock_getres			// 1255
+	data8 sys_clock_nanosleep
+	data8 sys_fstatfs64
+	data8 sys_statfs64
+	data8 sys_mbind
+	data8 sys_get_mempolicy			// 1260
+	data8 sys_set_mempolicy
+	data8 sys_mq_open
+	data8 sys_mq_unlink
+	data8 sys_mq_timedsend
+	data8 sys_mq_timedreceive		// 1265
+	data8 sys_mq_notify
+	data8 sys_mq_getsetattr
+	data8 sys_kexec_load
+	data8 sys_ni_syscall			// reserved for vserver
+	data8 sys_waitid			// 1270
+	data8 sys_add_key
+	data8 sys_request_key
+	data8 sys_keyctl
+	data8 sys_ioprio_set
+	data8 sys_ioprio_get			// 1275
+	data8 sys_move_pages
+	data8 sys_inotify_init
+	data8 sys_inotify_add_watch
+	data8 sys_inotify_rm_watch
+	data8 sys_migrate_pages			// 1280
+	data8 sys_openat
+	data8 sys_mkdirat
+	data8 sys_mknodat
+	data8 sys_fchownat
+	data8 sys_futimesat			// 1285
+	data8 sys_newfstatat
+	data8 sys_unlinkat
+	data8 sys_renameat
+	data8 sys_linkat
+	data8 sys_symlinkat			// 1290
+	data8 sys_readlinkat
+	data8 sys_fchmodat
+	data8 sys_faccessat
+	data8 sys_pselect6
+	data8 sys_ppoll				// 1295
+	data8 sys_unshare
+	data8 sys_splice
+	data8 sys_set_robust_list
+	data8 sys_get_robust_list
+	data8 sys_sync_file_range		// 1300
+	data8 sys_tee
+	data8 sys_vmsplice
+	data8 sys_fallocate
+	data8 sys_getcpu
+	data8 sys_epoll_pwait			// 1305
+	data8 sys_utimensat
+	data8 sys_signalfd
+	data8 sys_ni_syscall
+	data8 sys_eventfd
+	data8 sys_timerfd_create		// 1310
+	data8 sys_timerfd_settime
+	data8 sys_timerfd_gettime
+	data8 sys_signalfd4
+	data8 sys_eventfd2
+	data8 sys_epoll_create1			// 1315
+	data8 sys_dup3
+	data8 sys_pipe2
+	data8 sys_inotify_init1
+	data8 sys_preadv
+	data8 sys_pwritev			// 1320
+	data8 sys_rt_tgsigqueueinfo
+	data8 sys_recvmmsg
+	data8 sys_fanotify_init
+	data8 sys_fanotify_mark
+	data8 sys_prlimit64			// 1325
+	data8 sys_name_to_handle_at
+	data8 sys_open_by_handle_at
+	data8 sys_clock_adjtime
+	data8 sys_syncfs
+	data8 sys_setns				// 1330
+	data8 sys_sendmmsg
+	data8 sys_process_vm_readv
+	data8 sys_process_vm_writev
+	data8 sys_accept4
+	data8 sys_finit_module			// 1335
+	data8 sys_sched_setattr
+	data8 sys_sched_getattr
+	data8 sys_renameat2
+	data8 sys_getrandom
+	data8 sys_memfd_create			// 1340
+	data8 sys_bpf
+	data8 sys_execveat
+	data8 sys_userfaultfd
+	data8 sys_membarrier
+	data8 sys_kcmp				// 1345
+	data8 sys_mlock2
+	data8 sys_copy_file_range
+	data8 sys_preadv2
+	data8 sys_pwritev2
+
+	.org sys_call_table + 8*__NR_syscalls	// guard against failures to increase NR_syscalls
-- 
1.9.1

