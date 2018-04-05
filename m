Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeDEJzR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:55:17 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:44170 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeDEJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:53:41 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        x86@kernel.org
Subject: [PATCH 8/8] syscalls/x86: rename struct pt_regs-based sys_*() to __sys_x86_*()
Date: Thu,  5 Apr 2018 11:53:07 +0200
Message-Id: <20180405095307.3730-9-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405095307.3730-1-linux@dominikbrodowski.net>
References: <20180405095307.3730-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it may make sense to name different things differently, I am not so
sure that the additional code is worth it here...

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  49 +--
 arch/x86/entry/syscalls/syscall_64.tbl | 638 +++++++++++++++++----------------
 arch/x86/entry/vsyscall/vsyscall_64.c  |   6 +-
 arch/x86/include/asm/syscall_wrapper.h |  48 ++-
 4 files changed, 381 insertions(+), 360 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7f09a3da0b3d..9b0973a20a65 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -7,13 +7,14 @@
 # The __sys_ia32 and __compat_sys_ia32 stubs are created on-the-fly for
 # sys_*() system calls and compat_sys_*() compat system calls if
 # IA32_EMULATION is defined, and expect struct pt_regs *regs as their only
-# parameter.
+# parameter. The __sys_x86_ stubs below, which are common to x86-64, refer
+# solely to 0-parameter syscalls.
 #
 # The abi is always "i386" for this file.
 #
-0	i386	restart_syscall		sys_restart_syscall
+0	i386	restart_syscall		sys_restart_syscall		__sys_x86_restart_syscall
 1	i386	exit			sys_exit			__sys_ia32_exit
-2	i386	fork			sys_fork
+2	i386	fork			sys_fork			__sys_x86_fork
 3	i386	read			sys_read			__sys_ia32_read
 4	i386	write			sys_write			__sys_ia32_write
 5	i386	open			sys_open			__compat_sys_ia32_open
@@ -31,23 +32,23 @@
 17	i386	break
 18	i386	oldstat			sys_stat			__sys_ia32_stat
 19	i386	lseek			sys_lseek			__compat_sys_ia32_lseek
-20	i386	getpid			sys_getpid
+20	i386	getpid			sys_getpid			__sys_x86_getpid
 21	i386	mount			sys_mount			__compat_sys_ia32_mount
 22	i386	umount			sys_oldumount			__sys_ia32_oldumount
 23	i386	setuid			sys_setuid16			__sys_ia32_setuid16
-24	i386	getuid			sys_getuid16
+24	i386	getuid			sys_getuid16			__sys_x86_getuid16
 25	i386	stime			sys_stime			__compat_sys_ia32_stime
 26	i386	ptrace			sys_ptrace			__compat_sys_ia32_ptrace
 27	i386	alarm			sys_alarm			__sys_ia32_alarm
 28	i386	oldfstat		sys_fstat			__sys_ia32_fstat
-29	i386	pause			sys_pause
+29	i386	pause			sys_pause			__sys_x86_pause
 30	i386	utime			sys_utime			__compat_sys_ia32_utime
 31	i386	stty
 32	i386	gtty
 33	i386	access			sys_access			__sys_ia32_access
 34	i386	nice			sys_nice			__sys_ia32_nice
 35	i386	ftime
-36	i386	sync			sys_sync
+36	i386	sync			sys_sync			__sys_x86_sync
 37	i386	kill			sys_kill			__sys_ia32_kill
 38	i386	rename			sys_rename			__sys_ia32_rename
 39	i386	mkdir			sys_mkdir			__sys_ia32_mkdir
@@ -58,10 +59,10 @@
 44	i386	prof
 45	i386	brk			sys_brk				__sys_ia32_brk
 46	i386	setgid			sys_setgid16			__sys_ia32_setgid16
-47	i386	getgid			sys_getgid16
+47	i386	getgid			sys_getgid16			__sys_x86_getgid16
 48	i386	signal			sys_signal			__sys_ia32_signal
-49	i386	geteuid			sys_geteuid16
-50	i386	getegid			sys_getegid16
+49	i386	geteuid			sys_geteuid16			__sys_x86_geteuid16
+50	i386	getegid			sys_getegid16			__sys_x86_getegid16
 51	i386	acct			sys_acct			__sys_ia32_acct
 52	i386	umount2			sys_umount			__sys_ia32_umount
 53	i386	lock
@@ -75,11 +76,11 @@
 61	i386	chroot			sys_chroot			__sys_ia32_chroot
 62	i386	ustat			sys_ustat			__compat_sys_ia32_ustat
 63	i386	dup2			sys_dup2			__sys_ia32_dup2
-64	i386	getppid			sys_getppid
-65	i386	getpgrp			sys_getpgrp
-66	i386	setsid			sys_setsid
+64	i386	getppid			sys_getppid			__sys_x86_getppid
+65	i386	getpgrp			sys_getpgrp			__sys_x86_getpgrp
+66	i386	setsid			sys_setsid			__sys_x86_setsid
 67	i386	sigaction		sys_sigaction			__compat_sys_ia32_sigaction
-68	i386	sgetmask		sys_sgetmask
+68	i386	sgetmask		sys_sgetmask			__sys_x86_sgetmask
 69	i386	ssetmask		sys_ssetmask			__sys_ia32_ssetmask
 70	i386	setreuid		sys_setreuid16			__sys_ia32_setreuid16
 71	i386	setregid		sys_setregid16			__sys_ia32_setregid16
@@ -122,7 +123,7 @@
 108	i386	fstat			sys_newfstat			__compat_sys_ia32_newfstat
 109	i386	olduname		sys_uname			__sys_ia32_uname
 110	i386	iopl			sys_iopl			__sys_ia32_iopl
-111	i386	vhangup			sys_vhangup
+111	i386	vhangup			sys_vhangup			__sys_x86_vhangup
 112	i386	idle
 113	i386	vm86old			sys_vm86old			sys_ni_syscall
 114	i386	wait4			sys_wait4			__compat_sys_ia32_wait4
@@ -164,12 +165,12 @@
 150	i386	mlock			sys_mlock			__sys_ia32_mlock
 151	i386	munlock			sys_munlock			__sys_ia32_munlock
 152	i386	mlockall		sys_mlockall			__sys_ia32_mlockall
-153	i386	munlockall		sys_munlockall
+153	i386	munlockall		sys_munlockall			__sys_x86_munlockall
 154	i386	sched_setparam		sys_sched_setparam		__sys_ia32_sched_setparam
 155	i386	sched_getparam		sys_sched_getparam		__sys_ia32_sched_getparam
 156	i386	sched_setscheduler	sys_sched_setscheduler		__sys_ia32_sched_setscheduler
 157	i386	sched_getscheduler	sys_sched_getscheduler		__sys_ia32_sched_getscheduler
-158	i386	sched_yield		sys_sched_yield
+158	i386	sched_yield		sys_sched_yield			__sys_x86_sched_yield
 159	i386	sched_get_priority_max	sys_sched_get_priority_max	__sys_ia32_sched_get_priority_max
 160	i386	sched_get_priority_min	sys_sched_get_priority_min	__sys_ia32_sched_get_priority_min
 161	i386	sched_rr_get_interval	sys_sched_rr_get_interval	__compat_sys_ia32_sched_rr_get_interval
@@ -201,7 +202,7 @@
 187	i386	sendfile		sys_sendfile			__compat_sys_ia32_sendfile
 188	i386	getpmsg
 189	i386	putpmsg
-190	i386	vfork			sys_vfork
+190	i386	vfork			sys_vfork			__sys_x86_vfork
 191	i386	ugetrlimit		sys_getrlimit			__compat_sys_ia32_getrlimit
 192	i386	mmap2			sys_mmap_pgoff			__sys_ia32_mmap_pgoff
 193	i386	truncate64		sys_truncate64			__compat_sys_ia32_x86_truncate64
@@ -210,10 +211,10 @@
 196	i386	lstat64			sys_lstat64			__compat_sys_ia32_x86_lstat64
 197	i386	fstat64			sys_fstat64			__compat_sys_ia32_x86_fstat64
 198	i386	lchown32		sys_lchown			__sys_ia32_lchown
-199	i386	getuid32		sys_getuid
-200	i386	getgid32		sys_getgid
-201	i386	geteuid32		sys_geteuid
-202	i386	getegid32		sys_getegid
+199	i386	getuid32		sys_getuid			__sys_x86_getuid
+200	i386	getgid32		sys_getgid			__sys_x86_getgid
+201	i386	geteuid32		sys_geteuid			__sys_x86_geteuid
+202	i386	getegid32		sys_getegid			__sys_x86_getegid
 203	i386	setreuid32		sys_setreuid			__sys_ia32_setreuid
 204	i386	setregid32		sys_setregid			__sys_ia32_setregid
 205	i386	getgroups32		sys_getgroups			__sys_ia32_getgroups
@@ -235,7 +236,7 @@
 221	i386	fcntl64			sys_fcntl64			__compat_sys_ia32_fcntl64
 # 222 is unused
 # 223 is unused
-224	i386	gettid			sys_gettid
+224	i386	gettid			sys_gettid			__sys_x86_gettid
 225	i386	readahead		sys_readahead			__compat_sys_ia32_x86_readahead
 226	i386	setxattr		sys_setxattr			__sys_ia32_setxattr
 227	i386	lsetxattr		sys_lsetxattr			__sys_ia32_lsetxattr
@@ -302,7 +303,7 @@
 288	i386	keyctl			sys_keyctl			__compat_sys_ia32_keyctl
 289	i386	ioprio_set		sys_ioprio_set			__sys_ia32_ioprio_set
 290	i386	ioprio_get		sys_ioprio_get			__sys_ia32_ioprio_get
-291	i386	inotify_init		sys_inotify_init
+291	i386	inotify_init		sys_inotify_init		__sys_x86_inotify_init
 292	i386	inotify_add_watch	sys_inotify_add_watch		__sys_ia32_inotify_add_watch
 293	i386	inotify_rm_watch	sys_inotify_rm_watch		__sys_ia32_inotify_rm_watch
 294	i386	migrate_pages		sys_migrate_pages		__sys_ia32_migrate_pages
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index a83c0f7f462f..58ff63bb55aa 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -4,341 +4,343 @@
 # The format is:
 # <number> <abi> <name> <entry point>
 #
+# The __sys_x86_x86_*() stubs are created on-the-fly for sys_x86_*() system calls
+#
 # The abi is "common", "64" or "x32" for this file.
 #
-0	common	read			sys_read
-1	common	write			sys_write
-2	common	open			sys_open
-3	common	close			sys_close
-4	common	stat			sys_newstat
-5	common	fstat			sys_newfstat
-6	common	lstat			sys_newlstat
-7	common	poll			sys_poll
-8	common	lseek			sys_lseek
-9	common	mmap			sys_mmap
-10	common	mprotect		sys_mprotect
-11	common	munmap			sys_munmap
-12	common	brk			sys_brk
-13	64	rt_sigaction		sys_rt_sigaction
-14	common	rt_sigprocmask		sys_rt_sigprocmask
-15	64	rt_sigreturn		sys_rt_sigreturn/ptregs
-16	64	ioctl			sys_ioctl
-17	common	pread64			sys_pread64
-18	common	pwrite64		sys_pwrite64
-19	64	readv			sys_readv
-20	64	writev			sys_writev
-21	common	access			sys_access
-22	common	pipe			sys_pipe
-23	common	select			sys_select
-24	common	sched_yield		sys_sched_yield
-25	common	mremap			sys_mremap
-26	common	msync			sys_msync
-27	common	mincore			sys_mincore
-28	common	madvise			sys_madvise
-29	common	shmget			sys_shmget
-30	common	shmat			sys_shmat
-31	common	shmctl			sys_shmctl
-32	common	dup			sys_dup
-33	common	dup2			sys_dup2
-34	common	pause			sys_pause
-35	common	nanosleep		sys_nanosleep
-36	common	getitimer		sys_getitimer
-37	common	alarm			sys_alarm
-38	common	setitimer		sys_setitimer
-39	common	getpid			sys_getpid
-40	common	sendfile		sys_sendfile64
-41	common	socket			sys_socket
-42	common	connect			sys_connect
-43	common	accept			sys_accept
-44	common	sendto			sys_sendto
-45	64	recvfrom		sys_recvfrom
-46	64	sendmsg			sys_sendmsg
-47	64	recvmsg			sys_recvmsg
-48	common	shutdown		sys_shutdown
-49	common	bind			sys_bind
-50	common	listen			sys_listen
-51	common	getsockname		sys_getsockname
-52	common	getpeername		sys_getpeername
-53	common	socketpair		sys_socketpair
-54	64	setsockopt		sys_setsockopt
-55	64	getsockopt		sys_getsockopt
-56	common	clone			sys_clone/ptregs
-57	common	fork			sys_fork/ptregs
-58	common	vfork			sys_vfork/ptregs
-59	64	execve			sys_execve/ptregs
-60	common	exit			sys_exit
-61	common	wait4			sys_wait4
-62	common	kill			sys_kill
-63	common	uname			sys_newuname
-64	common	semget			sys_semget
-65	common	semop			sys_semop
-66	common	semctl			sys_semctl
-67	common	shmdt			sys_shmdt
-68	common	msgget			sys_msgget
-69	common	msgsnd			sys_msgsnd
-70	common	msgrcv			sys_msgrcv
-71	common	msgctl			sys_msgctl
-72	common	fcntl			sys_fcntl
-73	common	flock			sys_flock
-74	common	fsync			sys_fsync
-75	common	fdatasync		sys_fdatasync
-76	common	truncate		sys_truncate
-77	common	ftruncate		sys_ftruncate
-78	common	getdents		sys_getdents
-79	common	getcwd			sys_getcwd
-80	common	chdir			sys_chdir
-81	common	fchdir			sys_fchdir
-82	common	rename			sys_rename
-83	common	mkdir			sys_mkdir
-84	common	rmdir			sys_rmdir
-85	common	creat			sys_creat
-86	common	link			sys_link
-87	common	unlink			sys_unlink
-88	common	symlink			sys_symlink
-89	common	readlink		sys_readlink
-90	common	chmod			sys_chmod
-91	common	fchmod			sys_fchmod
-92	common	chown			sys_chown
-93	common	fchown			sys_fchown
-94	common	lchown			sys_lchown
-95	common	umask			sys_umask
-96	common	gettimeofday		sys_gettimeofday
-97	common	getrlimit		sys_getrlimit
-98	common	getrusage		sys_getrusage
-99	common	sysinfo			sys_sysinfo
-100	common	times			sys_times
-101	64	ptrace			sys_ptrace
-102	common	getuid			sys_getuid
-103	common	syslog			sys_syslog
-104	common	getgid			sys_getgid
-105	common	setuid			sys_setuid
-106	common	setgid			sys_setgid
-107	common	geteuid			sys_geteuid
-108	common	getegid			sys_getegid
-109	common	setpgid			sys_setpgid
-110	common	getppid			sys_getppid
-111	common	getpgrp			sys_getpgrp
-112	common	setsid			sys_setsid
-113	common	setreuid		sys_setreuid
-114	common	setregid		sys_setregid
-115	common	getgroups		sys_getgroups
-116	common	setgroups		sys_setgroups
-117	common	setresuid		sys_setresuid
-118	common	getresuid		sys_getresuid
-119	common	setresgid		sys_setresgid
-120	common	getresgid		sys_getresgid
-121	common	getpgid			sys_getpgid
-122	common	setfsuid		sys_setfsuid
-123	common	setfsgid		sys_setfsgid
-124	common	getsid			sys_getsid
-125	common	capget			sys_capget
-126	common	capset			sys_capset
-127	64	rt_sigpending		sys_rt_sigpending
-128	64	rt_sigtimedwait		sys_rt_sigtimedwait
-129	64	rt_sigqueueinfo		sys_rt_sigqueueinfo
-130	common	rt_sigsuspend		sys_rt_sigsuspend
-131	64	sigaltstack		sys_sigaltstack
-132	common	utime			sys_utime
-133	common	mknod			sys_mknod
+0	common	read			__sys_x86_read
+1	common	write			__sys_x86_write
+2	common	open			__sys_x86_open
+3	common	close			__sys_x86_close
+4	common	stat			__sys_x86_newstat
+5	common	fstat			__sys_x86_newfstat
+6	common	lstat			__sys_x86_newlstat
+7	common	poll			__sys_x86_poll
+8	common	lseek			__sys_x86_lseek
+9	common	mmap			__sys_x86_mmap
+10	common	mprotect		__sys_x86_mprotect
+11	common	munmap			__sys_x86_munmap
+12	common	brk			__sys_x86_brk
+13	64	rt_sigaction		__sys_x86_rt_sigaction
+14	common	rt_sigprocmask		__sys_x86_rt_sigprocmask
+15	64	rt_sigreturn		__sys_x86_rt_sigreturn/ptregs
+16	64	ioctl			__sys_x86_ioctl
+17	common	pread64			__sys_x86_pread64
+18	common	pwrite64		__sys_x86_pwrite64
+19	64	readv			__sys_x86_readv
+20	64	writev			__sys_x86_writev
+21	common	access			__sys_x86_access
+22	common	pipe			__sys_x86_pipe
+23	common	select			__sys_x86_select
+24	common	sched_yield		__sys_x86_sched_yield
+25	common	mremap			__sys_x86_mremap
+26	common	msync			__sys_x86_msync
+27	common	mincore			__sys_x86_mincore
+28	common	madvise			__sys_x86_madvise
+29	common	shmget			__sys_x86_shmget
+30	common	shmat			__sys_x86_shmat
+31	common	shmctl			__sys_x86_shmctl
+32	common	dup			__sys_x86_dup
+33	common	dup2			__sys_x86_dup2
+34	common	pause			__sys_x86_pause
+35	common	nanosleep		__sys_x86_nanosleep
+36	common	getitimer		__sys_x86_getitimer
+37	common	alarm			__sys_x86_alarm
+38	common	setitimer		__sys_x86_setitimer
+39	common	getpid			__sys_x86_getpid
+40	common	sendfile		__sys_x86_sendfile64
+41	common	socket			__sys_x86_socket
+42	common	connect			__sys_x86_connect
+43	common	accept			__sys_x86_accept
+44	common	sendto			__sys_x86_sendto
+45	64	recvfrom		__sys_x86_recvfrom
+46	64	sendmsg			__sys_x86_sendmsg
+47	64	recvmsg			__sys_x86_recvmsg
+48	common	shutdown		__sys_x86_shutdown
+49	common	bind			__sys_x86_bind
+50	common	listen			__sys_x86_listen
+51	common	getsockname		__sys_x86_getsockname
+52	common	getpeername		__sys_x86_getpeername
+53	common	socketpair		__sys_x86_socketpair
+54	64	setsockopt		__sys_x86_setsockopt
+55	64	getsockopt		__sys_x86_getsockopt
+56	common	clone			__sys_x86_clone/ptregs
+57	common	fork			__sys_x86_fork/ptregs
+58	common	vfork			__sys_x86_vfork/ptregs
+59	64	execve			__sys_x86_execve/ptregs
+60	common	exit			__sys_x86_exit
+61	common	wait4			__sys_x86_wait4
+62	common	kill			__sys_x86_kill
+63	common	uname			__sys_x86_newuname
+64	common	semget			__sys_x86_semget
+65	common	semop			__sys_x86_semop
+66	common	semctl			__sys_x86_semctl
+67	common	shmdt			__sys_x86_shmdt
+68	common	msgget			__sys_x86_msgget
+69	common	msgsnd			__sys_x86_msgsnd
+70	common	msgrcv			__sys_x86_msgrcv
+71	common	msgctl			__sys_x86_msgctl
+72	common	fcntl			__sys_x86_fcntl
+73	common	flock			__sys_x86_flock
+74	common	fsync			__sys_x86_fsync
+75	common	fdatasync		__sys_x86_fdatasync
+76	common	truncate		__sys_x86_truncate
+77	common	ftruncate		__sys_x86_ftruncate
+78	common	getdents		__sys_x86_getdents
+79	common	getcwd			__sys_x86_getcwd
+80	common	chdir			__sys_x86_chdir
+81	common	fchdir			__sys_x86_fchdir
+82	common	rename			__sys_x86_rename
+83	common	mkdir			__sys_x86_mkdir
+84	common	rmdir			__sys_x86_rmdir
+85	common	creat			__sys_x86_creat
+86	common	link			__sys_x86_link
+87	common	unlink			__sys_x86_unlink
+88	common	symlink			__sys_x86_symlink
+89	common	readlink		__sys_x86_readlink
+90	common	chmod			__sys_x86_chmod
+91	common	fchmod			__sys_x86_fchmod
+92	common	chown			__sys_x86_chown
+93	common	fchown			__sys_x86_fchown
+94	common	lchown			__sys_x86_lchown
+95	common	umask			__sys_x86_umask
+96	common	gettimeofday		__sys_x86_gettimeofday
+97	common	getrlimit		__sys_x86_getrlimit
+98	common	getrusage		__sys_x86_getrusage
+99	common	sysinfo			__sys_x86_sysinfo
+100	common	times			__sys_x86_times
+101	64	ptrace			__sys_x86_ptrace
+102	common	getuid			__sys_x86_getuid
+103	common	syslog			__sys_x86_syslog
+104	common	getgid			__sys_x86_getgid
+105	common	setuid			__sys_x86_setuid
+106	common	setgid			__sys_x86_setgid
+107	common	geteuid			__sys_x86_geteuid
+108	common	getegid			__sys_x86_getegid
+109	common	setpgid			__sys_x86_setpgid
+110	common	getppid			__sys_x86_getppid
+111	common	getpgrp			__sys_x86_getpgrp
+112	common	setsid			__sys_x86_setsid
+113	common	setreuid		__sys_x86_setreuid
+114	common	setregid		__sys_x86_setregid
+115	common	getgroups		__sys_x86_getgroups
+116	common	setgroups		__sys_x86_setgroups
+117	common	setresuid		__sys_x86_setresuid
+118	common	getresuid		__sys_x86_getresuid
+119	common	setresgid		__sys_x86_setresgid
+120	common	getresgid		__sys_x86_getresgid
+121	common	getpgid			__sys_x86_getpgid
+122	common	setfsuid		__sys_x86_setfsuid
+123	common	setfsgid		__sys_x86_setfsgid
+124	common	getsid			__sys_x86_getsid
+125	common	capget			__sys_x86_capget
+126	common	capset			__sys_x86_capset
+127	64	rt_sigpending		__sys_x86_rt_sigpending
+128	64	rt_sigtimedwait		__sys_x86_rt_sigtimedwait
+129	64	rt_sigqueueinfo		__sys_x86_rt_sigqueueinfo
+130	common	rt_sigsuspend		__sys_x86_rt_sigsuspend
+131	64	sigaltstack		__sys_x86_sigaltstack
+132	common	utime			__sys_x86_utime
+133	common	mknod			__sys_x86_mknod
 134	64	uselib
-135	common	personality		sys_personality
-136	common	ustat			sys_ustat
-137	common	statfs			sys_statfs
-138	common	fstatfs			sys_fstatfs
-139	common	sysfs			sys_sysfs
-140	common	getpriority		sys_getpriority
-141	common	setpriority		sys_setpriority
-142	common	sched_setparam		sys_sched_setparam
-143	common	sched_getparam		sys_sched_getparam
-144	common	sched_setscheduler	sys_sched_setscheduler
-145	common	sched_getscheduler	sys_sched_getscheduler
-146	common	sched_get_priority_max	sys_sched_get_priority_max
-147	common	sched_get_priority_min	sys_sched_get_priority_min
-148	common	sched_rr_get_interval	sys_sched_rr_get_interval
-149	common	mlock			sys_mlock
-150	common	munlock			sys_munlock
-151	common	mlockall		sys_mlockall
-152	common	munlockall		sys_munlockall
-153	common	vhangup			sys_vhangup
-154	common	modify_ldt		sys_modify_ldt
-155	common	pivot_root		sys_pivot_root
-156	64	_sysctl			sys_sysctl
-157	common	prctl			sys_prctl
-158	common	arch_prctl		sys_arch_prctl
-159	common	adjtimex		sys_adjtimex
-160	common	setrlimit		sys_setrlimit
-161	common	chroot			sys_chroot
-162	common	sync			sys_sync
-163	common	acct			sys_acct
-164	common	settimeofday		sys_settimeofday
-165	common	mount			sys_mount
-166	common	umount2			sys_umount
-167	common	swapon			sys_swapon
-168	common	swapoff			sys_swapoff
-169	common	reboot			sys_reboot
-170	common	sethostname		sys_sethostname
-171	common	setdomainname		sys_setdomainname
-172	common	iopl			sys_iopl/ptregs
-173	common	ioperm			sys_ioperm
+135	common	personality		__sys_x86_personality
+136	common	ustat			__sys_x86_ustat
+137	common	statfs			__sys_x86_statfs
+138	common	fstatfs			__sys_x86_fstatfs
+139	common	sysfs			__sys_x86_sysfs
+140	common	getpriority		__sys_x86_getpriority
+141	common	setpriority		__sys_x86_setpriority
+142	common	sched_setparam		__sys_x86_sched_setparam
+143	common	sched_getparam		__sys_x86_sched_getparam
+144	common	sched_setscheduler	__sys_x86_sched_setscheduler
+145	common	sched_getscheduler	__sys_x86_sched_getscheduler
+146	common	sched_get_priority_max	__sys_x86_sched_get_priority_max
+147	common	sched_get_priority_min	__sys_x86_sched_get_priority_min
+148	common	sched_rr_get_interval	__sys_x86_sched_rr_get_interval
+149	common	mlock			__sys_x86_mlock
+150	common	munlock			__sys_x86_munlock
+151	common	mlockall		__sys_x86_mlockall
+152	common	munlockall		__sys_x86_munlockall
+153	common	vhangup			__sys_x86_vhangup
+154	common	modify_ldt		__sys_x86_modify_ldt
+155	common	pivot_root		__sys_x86_pivot_root
+156	64	_sysctl			__sys_x86_sysctl
+157	common	prctl			__sys_x86_prctl
+158	common	arch_prctl		__sys_x86_arch_prctl
+159	common	adjtimex		__sys_x86_adjtimex
+160	common	setrlimit		__sys_x86_setrlimit
+161	common	chroot			__sys_x86_chroot
+162	common	sync			__sys_x86_sync
+163	common	acct			__sys_x86_acct
+164	common	settimeofday		__sys_x86_settimeofday
+165	common	mount			__sys_x86_mount
+166	common	umount2			__sys_x86_umount
+167	common	swapon			__sys_x86_swapon
+168	common	swapoff			__sys_x86_swapoff
+169	common	reboot			__sys_x86_reboot
+170	common	sethostname		__sys_x86_sethostname
+171	common	setdomainname		__sys_x86_setdomainname
+172	common	iopl			__sys_x86_iopl/ptregs
+173	common	ioperm			__sys_x86_ioperm
 174	64	create_module
-175	common	init_module		sys_init_module
-176	common	delete_module		sys_delete_module
+175	common	init_module		__sys_x86_init_module
+176	common	delete_module		__sys_x86_delete_module
 177	64	get_kernel_syms
 178	64	query_module
-179	common	quotactl		sys_quotactl
+179	common	quotactl		__sys_x86_quotactl
 180	64	nfsservctl
 181	common	getpmsg
 182	common	putpmsg
 183	common	afs_syscall
 184	common	tuxcall
 185	common	security
-186	common	gettid			sys_gettid
-187	common	readahead		sys_readahead
-188	common	setxattr		sys_setxattr
-189	common	lsetxattr		sys_lsetxattr
-190	common	fsetxattr		sys_fsetxattr
-191	common	getxattr		sys_getxattr
-192	common	lgetxattr		sys_lgetxattr
-193	common	fgetxattr		sys_fgetxattr
-194	common	listxattr		sys_listxattr
-195	common	llistxattr		sys_llistxattr
-196	common	flistxattr		sys_flistxattr
-197	common	removexattr		sys_removexattr
-198	common	lremovexattr		sys_lremovexattr
-199	common	fremovexattr		sys_fremovexattr
-200	common	tkill			sys_tkill
-201	common	time			sys_time
-202	common	futex			sys_futex
-203	common	sched_setaffinity	sys_sched_setaffinity
-204	common	sched_getaffinity	sys_sched_getaffinity
+186	common	gettid			__sys_x86_gettid
+187	common	readahead		__sys_x86_readahead
+188	common	setxattr		__sys_x86_setxattr
+189	common	lsetxattr		__sys_x86_lsetxattr
+190	common	fsetxattr		__sys_x86_fsetxattr
+191	common	getxattr		__sys_x86_getxattr
+192	common	lgetxattr		__sys_x86_lgetxattr
+193	common	fgetxattr		__sys_x86_fgetxattr
+194	common	listxattr		__sys_x86_listxattr
+195	common	llistxattr		__sys_x86_llistxattr
+196	common	flistxattr		__sys_x86_flistxattr
+197	common	removexattr		__sys_x86_removexattr
+198	common	lremovexattr		__sys_x86_lremovexattr
+199	common	fremovexattr		__sys_x86_fremovexattr
+200	common	tkill			__sys_x86_tkill
+201	common	time			__sys_x86_time
+202	common	futex			__sys_x86_futex
+203	common	sched_setaffinity	__sys_x86_sched_setaffinity
+204	common	sched_getaffinity	__sys_x86_sched_getaffinity
 205	64	set_thread_area
-206	64	io_setup		sys_io_setup
-207	common	io_destroy		sys_io_destroy
-208	common	io_getevents		sys_io_getevents
-209	64	io_submit		sys_io_submit
-210	common	io_cancel		sys_io_cancel
+206	64	io_setup		__sys_x86_io_setup
+207	common	io_destroy		__sys_x86_io_destroy
+208	common	io_getevents		__sys_x86_io_getevents
+209	64	io_submit		__sys_x86_io_submit
+210	common	io_cancel		__sys_x86_io_cancel
 211	64	get_thread_area
-212	common	lookup_dcookie		sys_lookup_dcookie
-213	common	epoll_create		sys_epoll_create
+212	common	lookup_dcookie		__sys_x86_lookup_dcookie
+213	common	epoll_create		__sys_x86_epoll_create
 214	64	epoll_ctl_old
 215	64	epoll_wait_old
-216	common	remap_file_pages	sys_remap_file_pages
-217	common	getdents64		sys_getdents64
-218	common	set_tid_address		sys_set_tid_address
-219	common	restart_syscall		sys_restart_syscall
-220	common	semtimedop		sys_semtimedop
-221	common	fadvise64		sys_fadvise64
-222	64	timer_create		sys_timer_create
-223	common	timer_settime		sys_timer_settime
-224	common	timer_gettime		sys_timer_gettime
-225	common	timer_getoverrun	sys_timer_getoverrun
-226	common	timer_delete		sys_timer_delete
-227	common	clock_settime		sys_clock_settime
-228	common	clock_gettime		sys_clock_gettime
-229	common	clock_getres		sys_clock_getres
-230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
-232	common	epoll_wait		sys_epoll_wait
-233	common	epoll_ctl		sys_epoll_ctl
-234	common	tgkill			sys_tgkill
-235	common	utimes			sys_utimes
+216	common	remap_file_pages	__sys_x86_remap_file_pages
+217	common	getdents64		__sys_x86_getdents64
+218	common	set_tid_address		__sys_x86_set_tid_address
+219	common	restart_syscall		__sys_x86_restart_syscall
+220	common	semtimedop		__sys_x86_semtimedop
+221	common	fadvise64		__sys_x86_fadvise64
+222	64	timer_create		__sys_x86_timer_create
+223	common	timer_settime		__sys_x86_timer_settime
+224	common	timer_gettime		__sys_x86_timer_gettime
+225	common	timer_getoverrun	__sys_x86_timer_getoverrun
+226	common	timer_delete		__sys_x86_timer_delete
+227	common	clock_settime		__sys_x86_clock_settime
+228	common	clock_gettime		__sys_x86_clock_gettime
+229	common	clock_getres		__sys_x86_clock_getres
+230	common	clock_nanosleep		__sys_x86_clock_nanosleep
+231	common	exit_group		__sys_x86_exit_group
+232	common	epoll_wait		__sys_x86_epoll_wait
+233	common	epoll_ctl		__sys_x86_epoll_ctl
+234	common	tgkill			__sys_x86_tgkill
+235	common	utimes			__sys_x86_utimes
 236	64	vserver
-237	common	mbind			sys_mbind
-238	common	set_mempolicy		sys_set_mempolicy
-239	common	get_mempolicy		sys_get_mempolicy
-240	common	mq_open			sys_mq_open
-241	common	mq_unlink		sys_mq_unlink
-242	common	mq_timedsend		sys_mq_timedsend
-243	common	mq_timedreceive		sys_mq_timedreceive
-244	64	mq_notify		sys_mq_notify
-245	common	mq_getsetattr		sys_mq_getsetattr
-246	64	kexec_load		sys_kexec_load
-247	64	waitid			sys_waitid
-248	common	add_key			sys_add_key
-249	common	request_key		sys_request_key
-250	common	keyctl			sys_keyctl
-251	common	ioprio_set		sys_ioprio_set
-252	common	ioprio_get		sys_ioprio_get
-253	common	inotify_init		sys_inotify_init
-254	common	inotify_add_watch	sys_inotify_add_watch
-255	common	inotify_rm_watch	sys_inotify_rm_watch
-256	common	migrate_pages		sys_migrate_pages
-257	common	openat			sys_openat
-258	common	mkdirat			sys_mkdirat
-259	common	mknodat			sys_mknodat
-260	common	fchownat		sys_fchownat
-261	common	futimesat		sys_futimesat
-262	common	newfstatat		sys_newfstatat
-263	common	unlinkat		sys_unlinkat
-264	common	renameat		sys_renameat
-265	common	linkat			sys_linkat
-266	common	symlinkat		sys_symlinkat
-267	common	readlinkat		sys_readlinkat
-268	common	fchmodat		sys_fchmodat
-269	common	faccessat		sys_faccessat
-270	common	pselect6		sys_pselect6
-271	common	ppoll			sys_ppoll
-272	common	unshare			sys_unshare
-273	64	set_robust_list		sys_set_robust_list
-274	64	get_robust_list		sys_get_robust_list
-275	common	splice			sys_splice
-276	common	tee			sys_tee
-277	common	sync_file_range		sys_sync_file_range
-278	64	vmsplice		sys_vmsplice
-279	64	move_pages		sys_move_pages
-280	common	utimensat		sys_utimensat
-281	common	epoll_pwait		sys_epoll_pwait
-282	common	signalfd		sys_signalfd
-283	common	timerfd_create		sys_timerfd_create
-284	common	eventfd			sys_eventfd
-285	common	fallocate		sys_fallocate
-286	common	timerfd_settime		sys_timerfd_settime
-287	common	timerfd_gettime		sys_timerfd_gettime
-288	common	accept4			sys_accept4
-289	common	signalfd4		sys_signalfd4
-290	common	eventfd2		sys_eventfd2
-291	common	epoll_create1		sys_epoll_create1
-292	common	dup3			sys_dup3
-293	common	pipe2			sys_pipe2
-294	common	inotify_init1		sys_inotify_init1
-295	64	preadv			sys_preadv
-296	64	pwritev			sys_pwritev
-297	64	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
-298	common	perf_event_open		sys_perf_event_open
-299	64	recvmmsg		sys_recvmmsg
-300	common	fanotify_init		sys_fanotify_init
-301	common	fanotify_mark		sys_fanotify_mark
-302	common	prlimit64		sys_prlimit64
-303	common	name_to_handle_at	sys_name_to_handle_at
-304	common	open_by_handle_at	sys_open_by_handle_at
-305	common	clock_adjtime		sys_clock_adjtime
-306	common	syncfs			sys_syncfs
-307	64	sendmmsg		sys_sendmmsg
-308	common	setns			sys_setns
-309	common	getcpu			sys_getcpu
-310	64	process_vm_readv	sys_process_vm_readv
-311	64	process_vm_writev	sys_process_vm_writev
-312	common	kcmp			sys_kcmp
-313	common	finit_module		sys_finit_module
-314	common	sched_setattr		sys_sched_setattr
-315	common	sched_getattr		sys_sched_getattr
-316	common	renameat2		sys_renameat2
-317	common	seccomp			sys_seccomp
-318	common	getrandom		sys_getrandom
-319	common	memfd_create		sys_memfd_create
-320	common	kexec_file_load		sys_kexec_file_load
-321	common	bpf			sys_bpf
-322	64	execveat		sys_execveat/ptregs
-323	common	userfaultfd		sys_userfaultfd
-324	common	membarrier		sys_membarrier
-325	common	mlock2			sys_mlock2
-326	common	copy_file_range		sys_copy_file_range
-327	64	preadv2			sys_preadv2
-328	64	pwritev2		sys_pwritev2
-329	common	pkey_mprotect		sys_pkey_mprotect
-330	common	pkey_alloc		sys_pkey_alloc
-331	common	pkey_free		sys_pkey_free
-332	common	statx			sys_statx
+237	common	mbind			__sys_x86_mbind
+238	common	set_mempolicy		__sys_x86_set_mempolicy
+239	common	get_mempolicy		__sys_x86_get_mempolicy
+240	common	mq_open			__sys_x86_mq_open
+241	common	mq_unlink		__sys_x86_mq_unlink
+242	common	mq_timedsend		__sys_x86_mq_timedsend
+243	common	mq_timedreceive		__sys_x86_mq_timedreceive
+244	64	mq_notify		__sys_x86_mq_notify
+245	common	mq_getsetattr		__sys_x86_mq_getsetattr
+246	64	kexec_load		__sys_x86_kexec_load
+247	64	waitid			__sys_x86_waitid
+248	common	add_key			__sys_x86_add_key
+249	common	request_key		__sys_x86_request_key
+250	common	keyctl			__sys_x86_keyctl
+251	common	ioprio_set		__sys_x86_ioprio_set
+252	common	ioprio_get		__sys_x86_ioprio_get
+253	common	inotify_init		__sys_x86_inotify_init
+254	common	inotify_add_watch	__sys_x86_inotify_add_watch
+255	common	inotify_rm_watch	__sys_x86_inotify_rm_watch
+256	common	migrate_pages		__sys_x86_migrate_pages
+257	common	openat			__sys_x86_openat
+258	common	mkdirat			__sys_x86_mkdirat
+259	common	mknodat			__sys_x86_mknodat
+260	common	fchownat		__sys_x86_fchownat
+261	common	futimesat		__sys_x86_futimesat
+262	common	newfstatat		__sys_x86_newfstatat
+263	common	unlinkat		__sys_x86_unlinkat
+264	common	renameat		__sys_x86_renameat
+265	common	linkat			__sys_x86_linkat
+266	common	symlinkat		__sys_x86_symlinkat
+267	common	readlinkat		__sys_x86_readlinkat
+268	common	fchmodat		__sys_x86_fchmodat
+269	common	faccessat		__sys_x86_faccessat
+270	common	pselect6		__sys_x86_pselect6
+271	common	ppoll			__sys_x86_ppoll
+272	common	unshare			__sys_x86_unshare
+273	64	set_robust_list		__sys_x86_set_robust_list
+274	64	get_robust_list		__sys_x86_get_robust_list
+275	common	splice			__sys_x86_splice
+276	common	tee			__sys_x86_tee
+277	common	sync_file_range		__sys_x86_sync_file_range
+278	64	vmsplice		__sys_x86_vmsplice
+279	64	move_pages		__sys_x86_move_pages
+280	common	utimensat		__sys_x86_utimensat
+281	common	epoll_pwait		__sys_x86_epoll_pwait
+282	common	signalfd		__sys_x86_signalfd
+283	common	timerfd_create		__sys_x86_timerfd_create
+284	common	eventfd			__sys_x86_eventfd
+285	common	fallocate		__sys_x86_fallocate
+286	common	timerfd_settime		__sys_x86_timerfd_settime
+287	common	timerfd_gettime		__sys_x86_timerfd_gettime
+288	common	accept4			__sys_x86_accept4
+289	common	signalfd4		__sys_x86_signalfd4
+290	common	eventfd2		__sys_x86_eventfd2
+291	common	epoll_create1		__sys_x86_epoll_create1
+292	common	dup3			__sys_x86_dup3
+293	common	pipe2			__sys_x86_pipe2
+294	common	inotify_init1		__sys_x86_inotify_init1
+295	64	preadv			__sys_x86_preadv
+296	64	pwritev			__sys_x86_pwritev
+297	64	rt_tgsigqueueinfo	__sys_x86_rt_tgsigqueueinfo
+298	common	perf_event_open		__sys_x86_perf_event_open
+299	64	recvmmsg		__sys_x86_recvmmsg
+300	common	fanotify_init		__sys_x86_fanotify_init
+301	common	fanotify_mark		__sys_x86_fanotify_mark
+302	common	prlimit64		__sys_x86_prlimit64
+303	common	name_to_handle_at	__sys_x86_name_to_handle_at
+304	common	open_by_handle_at	__sys_x86_open_by_handle_at
+305	common	clock_adjtime		__sys_x86_clock_adjtime
+306	common	syncfs			__sys_x86_syncfs
+307	64	sendmmsg		__sys_x86_sendmmsg
+308	common	setns			__sys_x86_setns
+309	common	getcpu			__sys_x86_getcpu
+310	64	process_vm_readv	__sys_x86_process_vm_readv
+311	64	process_vm_writev	__sys_x86_process_vm_writev
+312	common	kcmp			__sys_x86_kcmp
+313	common	finit_module		__sys_x86_finit_module
+314	common	sched_setattr		__sys_x86_sched_setattr
+315	common	sched_getattr		__sys_x86_sched_getattr
+316	common	renameat2		__sys_x86_renameat2
+317	common	seccomp			__sys_x86_seccomp
+318	common	getrandom		__sys_x86_getrandom
+319	common	memfd_create		__sys_x86_memfd_create
+320	common	kexec_file_load		__sys_x86_kexec_file_load
+321	common	bpf			__sys_x86_bpf
+322	64	execveat		__sys_x86_execveat/ptregs
+323	common	userfaultfd		__sys_x86_userfaultfd
+324	common	membarrier		__sys_x86_membarrier
+325	common	mlock2			__sys_x86_mlock2
+326	common	copy_file_range		__sys_x86_copy_file_range
+327	64	preadv2			__sys_x86_preadv2
+328	64	pwritev2		__sys_x86_pwritev2
+329	common	pkey_mprotect		__sys_x86_pkey_mprotect
+330	common	pkey_alloc		__sys_x86_pkey_alloc
+331	common	pkey_free		__sys_x86_pkey_free
+332	common	statx			__sys_x86_statx
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 20b3d4a88ee4..6da86e0a8a9c 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -229,12 +229,12 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	switch (vsyscall_nr) {
 	case 0:
 		/* this decodes regs->di and regs->si on its own */
-		ret = sys_gettimeofday(regs);
+		ret = __sys_x86_gettimeofday(regs);
 		break;
 
 	case 1:
 		/* this decodes regs->di on its own */
-		ret = sys_time(regs);
+		ret = __sys_x86_time(regs);
 		break;
 
 	case 2:
@@ -242,7 +242,7 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 		orig_dx = regs->dx;
 		regs->dx = 0;
 		/* this decodes regs->di, regs->si and regs->dx on its own */
-		ret = sys_getcpu(regs);
+		ret = __sys_x86_getcpu(regs);
 		regs->dx = orig_dx;
 		break;
 	}
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 49d7e4970110..5159c10314e4 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -45,11 +45,11 @@
 	}
 
 #define COND_SYSCALL(name)						\
-	cond_syscall(sys_##name);					\
+	cond_syscall(__sys_x86_##name);					\
 	cond_syscall(__sys_ia32_##name)
 
 #define SYS_NI(name)							\
-	SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers);			\
+	SYSCALL_ALIAS(__sys_x86_##name, sys_ni_posix_timers);		\
 	SYSCALL_ALIAS(__sys_ia32_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
@@ -114,12 +114,12 @@
 /*
  * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
  * struct pt_regs *regs as the only argument of the syscall stub named
- * sys_*(). It decodes just the registers it needs and passes them on to
+ * __sys_x86_*(). It decodes just the registers it needs and passes them on to
  * the SyS_*() wrapper and then to the SYSC_*() function doing the actual job.
  * These wrappers and functions are inlined, meaning that the assembly looks
  * as follows (slightly re-ordered):
  *
- * <sys_recv>:			<-- syscall with 4 parameters
+ * <__sys_x86_recv>:		<-- syscall with 4 parameters
  *	callq	<__fentry__>
  *
  *	mov	0x70(%rdi),%rdi	<-- decode regs->di
@@ -142,18 +142,13 @@
  * If IA32_EMULATION is enabled, this macro generates an additional wrapper
  * named __sys_ia32_*() which decodes the struct pt_regs *regs according
  * to the i386 calling convention (bx, cx, dx, si, di, bp).
- *
- * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
- * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
- * hurt, there is no need to override it, or to define it differently for
- * IA32_EMULATION.
  */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
-	asmlinkage long sys##name(const struct pt_regs *regs);		\
-	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
+	asmlinkage long __sys_x86##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__sys_x86##name, ERRNO);			\
 	static long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
-	asmlinkage long sys##name(const struct pt_regs *regs)		\
+	asmlinkage long __sys_x86##name(const struct pt_regs *regs)	\
 	{								\
 		return SyS##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}								\
@@ -167,13 +162,36 @@
 	}								\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
+
+/*
+ * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
+ * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
+ * hurt, we only need to re-define it here to keep the naming congruent to
+ * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
+ * macros to work correctly
+ */
+#define SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long __sys_x86_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__sys_x86_##sname, ERRNO);	\
+	asmlinkage long __sys_x86_##sname(void)
+
+#ifndef COND_SYSCALL
+#define COND_SYSCALL(name) cond_syscall(__sys_x86_##name)
+#endif
+
+#ifndef SYS_NI
+#define SYS_NI(name) SYSCALL_ALIAS(__sys_x86_##name, sys_ni_posix_timers);
+#endif
+
+
 /*
  * For VSYSCALLS, we need to declare these three syscalls with the new
  * pt_regs-based calling convention for in-kernel use.
  */
 struct pt_regs;
-asmlinkage long sys_getcpu(const struct pt_regs *regs);		/* di,si,dx */
-asmlinkage long sys_gettimeofday(const struct pt_regs *regs);	/* di,si */
-asmlinkage long sys_time(const struct pt_regs *regs);		/* di */
+asmlinkage long __sys_x86_getcpu(const struct pt_regs *regs);
+asmlinkage long __sys_x86_gettimeofday(const struct pt_regs *regs);
+asmlinkage long __sys_x86_time(const struct pt_regs *regs);
 
 #endif /* _ASM_X86_SYSCALL_WRAPPER_H */
-- 
2.16.3
