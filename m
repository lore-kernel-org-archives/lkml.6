Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeDIKwD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:52:03 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:60822 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeDIKvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:51:55 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCHv2 3/4] syscalls: rename struct pt_regs-based sys_*() to __x64_sys_*()
Date: Mon,  9 Apr 2018 12:51:44 +0200
Message-Id: <20180409105145.5364-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180409105145.5364-1-linux@dominikbrodowski.net>
References: <20180409105145.5364-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rename allows us to have a coherent syscall stub naming convention on
64-bit x86 (0xffffffff prefix removed):

810f0af0 t            kernel_waitid	# common (32/64) kernel helper

<inline>            __do_sys_waitid	# inlined helper doing actual work
810f0be0 t          __se_sys_waitid	# C func calling inlined helper

<inline>     __do_compat_sys_waitid	# inlined helper doing actual work
810f0d80 t   __se_compat_sys_waitid	# compat C func calling inlined helper

810f2080 T         __x64_sys_waitid	# x64 64-bit-ptregs -> C stub
810f20b0 T        __ia32_sys_waitid	# ia32 32-bit-ptregs -> C stub[*]
810f2470 T __ia32_compat_sys_waitid	# ia32 32-bit-ptregs -> compat C stub
810f2490 T  __x32_compat_sys_waitid	# x32 64-bit-ptregs -> compat C stub

    [*] This stub is unused, as the syscall table links
	__ia32_compat_sys_waitid instead of __ia32_sys_waitid as we need
	a compat variant here.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  46 +-
 arch/x86/entry/syscalls/syscall_64.tbl | 638 +++++++++++++------------
 arch/x86/entry/syscalls/syscalltbl.sh  |  14 +-
 arch/x86/entry/vsyscall/vsyscall_64.c  |   6 +-
 arch/x86/include/asm/syscall_wrapper.h |  63 ++-
 5 files changed, 405 insertions(+), 362 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0e6cb1335db2..d6b27dab1b30 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -11,9 +11,9 @@
 #
 # The abi is always "i386" for this file.
 #
-0	i386	restart_syscall		sys_restart_syscall
+0	i386	restart_syscall		sys_restart_syscall		__ia32_sys_restart_syscall
 1	i386	exit			sys_exit			__ia32_sys_exit
-2	i386	fork			sys_fork
+2	i386	fork			sys_fork			__ia32_sys_fork
 3	i386	read			sys_read			__ia32_sys_read
 4	i386	write			sys_write			__ia32_sys_write
 5	i386	open			sys_open			__ia32_compat_sys_open
@@ -31,23 +31,23 @@
 17	i386	break
 18	i386	oldstat			sys_stat			__ia32_sys_stat
 19	i386	lseek			sys_lseek			__ia32_compat_sys_lseek
-20	i386	getpid			sys_getpid
+20	i386	getpid			sys_getpid			__ia32_sys_getpid
 21	i386	mount			sys_mount			__ia32_compat_sys_mount
 22	i386	umount			sys_oldumount			__ia32_sys_oldumount
 23	i386	setuid			sys_setuid16			__ia32_sys_setuid16
-24	i386	getuid			sys_getuid16
+24	i386	getuid			sys_getuid16			__ia32_sys_getuid16
 25	i386	stime			sys_stime			__ia32_compat_sys_stime
 26	i386	ptrace			sys_ptrace			__ia32_compat_sys_ptrace
 27	i386	alarm			sys_alarm			__ia32_sys_alarm
 28	i386	oldfstat		sys_fstat			__ia32_sys_fstat
-29	i386	pause			sys_pause
+29	i386	pause			sys_pause			__ia32_sys_pause
 30	i386	utime			sys_utime			__ia32_compat_sys_utime
 31	i386	stty
 32	i386	gtty
 33	i386	access			sys_access			__ia32_sys_access
 34	i386	nice			sys_nice			__ia32_sys_nice
 35	i386	ftime
-36	i386	sync			sys_sync
+36	i386	sync			sys_sync			__ia32_sys_sync
 37	i386	kill			sys_kill			__ia32_sys_kill
 38	i386	rename			sys_rename			__ia32_sys_rename
 39	i386	mkdir			sys_mkdir			__ia32_sys_mkdir
@@ -58,10 +58,10 @@
 44	i386	prof
 45	i386	brk			sys_brk				__ia32_sys_brk
 46	i386	setgid			sys_setgid16			__ia32_sys_setgid16
-47	i386	getgid			sys_getgid16
+47	i386	getgid			sys_getgid16			__ia32_sys_getgid16
 48	i386	signal			sys_signal			__ia32_sys_signal
-49	i386	geteuid			sys_geteuid16
-50	i386	getegid			sys_getegid16
+49	i386	geteuid			sys_geteuid16			__ia32_sys_geteuid16
+50	i386	getegid			sys_getegid16			__ia32_sys_getegid16
 51	i386	acct			sys_acct			__ia32_sys_acct
 52	i386	umount2			sys_umount			__ia32_sys_umount
 53	i386	lock
@@ -75,11 +75,11 @@
 61	i386	chroot			sys_chroot			__ia32_sys_chroot
 62	i386	ustat			sys_ustat			__ia32_compat_sys_ustat
 63	i386	dup2			sys_dup2			__ia32_sys_dup2
-64	i386	getppid			sys_getppid
-65	i386	getpgrp			sys_getpgrp
-66	i386	setsid			sys_setsid
+64	i386	getppid			sys_getppid			__ia32_sys_getppid
+65	i386	getpgrp			sys_getpgrp			__ia32_sys_getpgrp
+66	i386	setsid			sys_setsid			__ia32_sys_setsid
 67	i386	sigaction		sys_sigaction			__ia32_compat_sys_sigaction
-68	i386	sgetmask		sys_sgetmask
+68	i386	sgetmask		sys_sgetmask			__ia32_sys_sgetmask
 69	i386	ssetmask		sys_ssetmask			__ia32_sys_ssetmask
 70	i386	setreuid		sys_setreuid16			__ia32_sys_setreuid16
 71	i386	setregid		sys_setregid16			__ia32_sys_setregid16
@@ -122,7 +122,7 @@
 108	i386	fstat			sys_newfstat			__ia32_compat_sys_newfstat
 109	i386	olduname		sys_uname			__ia32_sys_uname
 110	i386	iopl			sys_iopl			__ia32_sys_iopl
-111	i386	vhangup			sys_vhangup
+111	i386	vhangup			sys_vhangup			__ia32_sys_vhangup
 112	i386	idle
 113	i386	vm86old			sys_vm86old			sys_ni_syscall
 114	i386	wait4			sys_wait4			__ia32_compat_sys_wait4
@@ -164,12 +164,12 @@
 150	i386	mlock			sys_mlock			__ia32_sys_mlock
 151	i386	munlock			sys_munlock			__ia32_sys_munlock
 152	i386	mlockall		sys_mlockall			__ia32_sys_mlockall
-153	i386	munlockall		sys_munlockall
+153	i386	munlockall		sys_munlockall			__ia32_sys_munlockall
 154	i386	sched_setparam		sys_sched_setparam		__ia32_sys_sched_setparam
 155	i386	sched_getparam		sys_sched_getparam		__ia32_sys_sched_getparam
 156	i386	sched_setscheduler	sys_sched_setscheduler		__ia32_sys_sched_setscheduler
 157	i386	sched_getscheduler	sys_sched_getscheduler		__ia32_sys_sched_getscheduler
-158	i386	sched_yield		sys_sched_yield
+158	i386	sched_yield		sys_sched_yield			__ia32_sys_sched_yield
 159	i386	sched_get_priority_max	sys_sched_get_priority_max	__ia32_sys_sched_get_priority_max
 160	i386	sched_get_priority_min	sys_sched_get_priority_min	__ia32_sys_sched_get_priority_min
 161	i386	sched_rr_get_interval	sys_sched_rr_get_interval	__ia32_compat_sys_sched_rr_get_interval
@@ -201,7 +201,7 @@
 187	i386	sendfile		sys_sendfile			__ia32_compat_sys_sendfile
 188	i386	getpmsg
 189	i386	putpmsg
-190	i386	vfork			sys_vfork
+190	i386	vfork			sys_vfork			__ia32_sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			__ia32_compat_sys_getrlimit
 192	i386	mmap2			sys_mmap_pgoff			__ia32_sys_mmap_pgoff
 193	i386	truncate64		sys_truncate64			__ia32_compat_sys_x86_truncate64
@@ -210,10 +210,10 @@
 196	i386	lstat64			sys_lstat64			__ia32_compat_sys_x86_lstat64
 197	i386	fstat64			sys_fstat64			__ia32_compat_sys_x86_fstat64
 198	i386	lchown32		sys_lchown			__ia32_sys_lchown
-199	i386	getuid32		sys_getuid
-200	i386	getgid32		sys_getgid
-201	i386	geteuid32		sys_geteuid
-202	i386	getegid32		sys_getegid
+199	i386	getuid32		sys_getuid			__ia32_sys_getuid
+200	i386	getgid32		sys_getgid			__ia32_sys_getgid
+201	i386	geteuid32		sys_geteuid			__ia32_sys_geteuid
+202	i386	getegid32		sys_getegid			__ia32_sys_getegid
 203	i386	setreuid32		sys_setreuid			__ia32_sys_setreuid
 204	i386	setregid32		sys_setregid			__ia32_sys_setregid
 205	i386	getgroups32		sys_getgroups			__ia32_sys_getgroups
@@ -235,7 +235,7 @@
 221	i386	fcntl64			sys_fcntl64			__ia32_compat_sys_fcntl64
 # 222 is unused
 # 223 is unused
-224	i386	gettid			sys_gettid
+224	i386	gettid			sys_gettid			__ia32_sys_gettid
 225	i386	readahead		sys_readahead			__ia32_compat_sys_x86_readahead
 226	i386	setxattr		sys_setxattr			__ia32_sys_setxattr
 227	i386	lsetxattr		sys_lsetxattr			__ia32_sys_lsetxattr
@@ -302,7 +302,7 @@
 288	i386	keyctl			sys_keyctl			__ia32_compat_sys_keyctl
 289	i386	ioprio_set		sys_ioprio_set			__ia32_sys_ioprio_set
 290	i386	ioprio_get		sys_ioprio_get			__ia32_sys_ioprio_get
-291	i386	inotify_init		sys_inotify_init
+291	i386	inotify_init		sys_inotify_init		__ia32_sys_inotify_init
 292	i386	inotify_add_watch	sys_inotify_add_watch		__ia32_sys_inotify_add_watch
 293	i386	inotify_rm_watch	sys_inotify_rm_watch		__ia32_sys_inotify_rm_watch
 294	i386	migrate_pages		sys_migrate_pages		__ia32_sys_migrate_pages
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 73f4951fc2fa..4dfe42666d0c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -4,341 +4,343 @@
 # The format is:
 # <number> <abi> <name> <entry point>
 #
+# The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
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
+0	common	read			__x64_sys_read
+1	common	write			__x64_sys_write
+2	common	open			__x64_sys_open
+3	common	close			__x64_sys_close
+4	common	stat			__x64_sys_newstat
+5	common	fstat			__x64_sys_newfstat
+6	common	lstat			__x64_sys_newlstat
+7	common	poll			__x64_sys_poll
+8	common	lseek			__x64_sys_lseek
+9	common	mmap			__x64_sys_mmap
+10	common	mprotect		__x64_sys_mprotect
+11	common	munmap			__x64_sys_munmap
+12	common	brk			__x64_sys_brk
+13	64	rt_sigaction		__x64_sys_rt_sigaction
+14	common	rt_sigprocmask		__x64_sys_rt_sigprocmask
+15	64	rt_sigreturn		__x64_sys_rt_sigreturn/ptregs
+16	64	ioctl			__x64_sys_ioctl
+17	common	pread64			__x64_sys_pread64
+18	common	pwrite64		__x64_sys_pwrite64
+19	64	readv			__x64_sys_readv
+20	64	writev			__x64_sys_writev
+21	common	access			__x64_sys_access
+22	common	pipe			__x64_sys_pipe
+23	common	select			__x64_sys_select
+24	common	sched_yield		__x64_sys_sched_yield
+25	common	mremap			__x64_sys_mremap
+26	common	msync			__x64_sys_msync
+27	common	mincore			__x64_sys_mincore
+28	common	madvise			__x64_sys_madvise
+29	common	shmget			__x64_sys_shmget
+30	common	shmat			__x64_sys_shmat
+31	common	shmctl			__x64_sys_shmctl
+32	common	dup			__x64_sys_dup
+33	common	dup2			__x64_sys_dup2
+34	common	pause			__x64_sys_pause
+35	common	nanosleep		__x64_sys_nanosleep
+36	common	getitimer		__x64_sys_getitimer
+37	common	alarm			__x64_sys_alarm
+38	common	setitimer		__x64_sys_setitimer
+39	common	getpid			__x64_sys_getpid
+40	common	sendfile		__x64_sys_sendfile64
+41	common	socket			__x64_sys_socket
+42	common	connect			__x64_sys_connect
+43	common	accept			__x64_sys_accept
+44	common	sendto			__x64_sys_sendto
+45	64	recvfrom		__x64_sys_recvfrom
+46	64	sendmsg			__x64_sys_sendmsg
+47	64	recvmsg			__x64_sys_recvmsg
+48	common	shutdown		__x64_sys_shutdown
+49	common	bind			__x64_sys_bind
+50	common	listen			__x64_sys_listen
+51	common	getsockname		__x64_sys_getsockname
+52	common	getpeername		__x64_sys_getpeername
+53	common	socketpair		__x64_sys_socketpair
+54	64	setsockopt		__x64_sys_setsockopt
+55	64	getsockopt		__x64_sys_getsockopt
+56	common	clone			__x64_sys_clone/ptregs
+57	common	fork			__x64_sys_fork/ptregs
+58	common	vfork			__x64_sys_vfork/ptregs
+59	64	execve			__x64_sys_execve/ptregs
+60	common	exit			__x64_sys_exit
+61	common	wait4			__x64_sys_wait4
+62	common	kill			__x64_sys_kill
+63	common	uname			__x64_sys_newuname
+64	common	semget			__x64_sys_semget
+65	common	semop			__x64_sys_semop
+66	common	semctl			__x64_sys_semctl
+67	common	shmdt			__x64_sys_shmdt
+68	common	msgget			__x64_sys_msgget
+69	common	msgsnd			__x64_sys_msgsnd
+70	common	msgrcv			__x64_sys_msgrcv
+71	common	msgctl			__x64_sys_msgctl
+72	common	fcntl			__x64_sys_fcntl
+73	common	flock			__x64_sys_flock
+74	common	fsync			__x64_sys_fsync
+75	common	fdatasync		__x64_sys_fdatasync
+76	common	truncate		__x64_sys_truncate
+77	common	ftruncate		__x64_sys_ftruncate
+78	common	getdents		__x64_sys_getdents
+79	common	getcwd			__x64_sys_getcwd
+80	common	chdir			__x64_sys_chdir
+81	common	fchdir			__x64_sys_fchdir
+82	common	rename			__x64_sys_rename
+83	common	mkdir			__x64_sys_mkdir
+84	common	rmdir			__x64_sys_rmdir
+85	common	creat			__x64_sys_creat
+86	common	link			__x64_sys_link
+87	common	unlink			__x64_sys_unlink
+88	common	symlink			__x64_sys_symlink
+89	common	readlink		__x64_sys_readlink
+90	common	chmod			__x64_sys_chmod
+91	common	fchmod			__x64_sys_fchmod
+92	common	chown			__x64_sys_chown
+93	common	fchown			__x64_sys_fchown
+94	common	lchown			__x64_sys_lchown
+95	common	umask			__x64_sys_umask
+96	common	gettimeofday		__x64_sys_gettimeofday
+97	common	getrlimit		__x64_sys_getrlimit
+98	common	getrusage		__x64_sys_getrusage
+99	common	sysinfo			__x64_sys_sysinfo
+100	common	times			__x64_sys_times
+101	64	ptrace			__x64_sys_ptrace
+102	common	getuid			__x64_sys_getuid
+103	common	syslog			__x64_sys_syslog
+104	common	getgid			__x64_sys_getgid
+105	common	setuid			__x64_sys_setuid
+106	common	setgid			__x64_sys_setgid
+107	common	geteuid			__x64_sys_geteuid
+108	common	getegid			__x64_sys_getegid
+109	common	setpgid			__x64_sys_setpgid
+110	common	getppid			__x64_sys_getppid
+111	common	getpgrp			__x64_sys_getpgrp
+112	common	setsid			__x64_sys_setsid
+113	common	setreuid		__x64_sys_setreuid
+114	common	setregid		__x64_sys_setregid
+115	common	getgroups		__x64_sys_getgroups
+116	common	setgroups		__x64_sys_setgroups
+117	common	setresuid		__x64_sys_setresuid
+118	common	getresuid		__x64_sys_getresuid
+119	common	setresgid		__x64_sys_setresgid
+120	common	getresgid		__x64_sys_getresgid
+121	common	getpgid			__x64_sys_getpgid
+122	common	setfsuid		__x64_sys_setfsuid
+123	common	setfsgid		__x64_sys_setfsgid
+124	common	getsid			__x64_sys_getsid
+125	common	capget			__x64_sys_capget
+126	common	capset			__x64_sys_capset
+127	64	rt_sigpending		__x64_sys_rt_sigpending
+128	64	rt_sigtimedwait		__x64_sys_rt_sigtimedwait
+129	64	rt_sigqueueinfo		__x64_sys_rt_sigqueueinfo
+130	common	rt_sigsuspend		__x64_sys_rt_sigsuspend
+131	64	sigaltstack		__x64_sys_sigaltstack
+132	common	utime			__x64_sys_utime
+133	common	mknod			__x64_sys_mknod
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
+135	common	personality		__x64_sys_personality
+136	common	ustat			__x64_sys_ustat
+137	common	statfs			__x64_sys_statfs
+138	common	fstatfs			__x64_sys_fstatfs
+139	common	sysfs			__x64_sys_sysfs
+140	common	getpriority		__x64_sys_getpriority
+141	common	setpriority		__x64_sys_setpriority
+142	common	sched_setparam		__x64_sys_sched_setparam
+143	common	sched_getparam		__x64_sys_sched_getparam
+144	common	sched_setscheduler	__x64_sys_sched_setscheduler
+145	common	sched_getscheduler	__x64_sys_sched_getscheduler
+146	common	sched_get_priority_max	__x64_sys_sched_get_priority_max
+147	common	sched_get_priority_min	__x64_sys_sched_get_priority_min
+148	common	sched_rr_get_interval	__x64_sys_sched_rr_get_interval
+149	common	mlock			__x64_sys_mlock
+150	common	munlock			__x64_sys_munlock
+151	common	mlockall		__x64_sys_mlockall
+152	common	munlockall		__x64_sys_munlockall
+153	common	vhangup			__x64_sys_vhangup
+154	common	modify_ldt		__x64_sys_modify_ldt
+155	common	pivot_root		__x64_sys_pivot_root
+156	64	_sysctl			__x64_sys_sysctl
+157	common	prctl			__x64_sys_prctl
+158	common	arch_prctl		__x64_sys_arch_prctl
+159	common	adjtimex		__x64_sys_adjtimex
+160	common	setrlimit		__x64_sys_setrlimit
+161	common	chroot			__x64_sys_chroot
+162	common	sync			__x64_sys_sync
+163	common	acct			__x64_sys_acct
+164	common	settimeofday		__x64_sys_settimeofday
+165	common	mount			__x64_sys_mount
+166	common	umount2			__x64_sys_umount
+167	common	swapon			__x64_sys_swapon
+168	common	swapoff			__x64_sys_swapoff
+169	common	reboot			__x64_sys_reboot
+170	common	sethostname		__x64_sys_sethostname
+171	common	setdomainname		__x64_sys_setdomainname
+172	common	iopl			__x64_sys_iopl/ptregs
+173	common	ioperm			__x64_sys_ioperm
 174	64	create_module
-175	common	init_module		sys_init_module
-176	common	delete_module		sys_delete_module
+175	common	init_module		__x64_sys_init_module
+176	common	delete_module		__x64_sys_delete_module
 177	64	get_kernel_syms
 178	64	query_module
-179	common	quotactl		sys_quotactl
+179	common	quotactl		__x64_sys_quotactl
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
+186	common	gettid			__x64_sys_gettid
+187	common	readahead		__x64_sys_readahead
+188	common	setxattr		__x64_sys_setxattr
+189	common	lsetxattr		__x64_sys_lsetxattr
+190	common	fsetxattr		__x64_sys_fsetxattr
+191	common	getxattr		__x64_sys_getxattr
+192	common	lgetxattr		__x64_sys_lgetxattr
+193	common	fgetxattr		__x64_sys_fgetxattr
+194	common	listxattr		__x64_sys_listxattr
+195	common	llistxattr		__x64_sys_llistxattr
+196	common	flistxattr		__x64_sys_flistxattr
+197	common	removexattr		__x64_sys_removexattr
+198	common	lremovexattr		__x64_sys_lremovexattr
+199	common	fremovexattr		__x64_sys_fremovexattr
+200	common	tkill			__x64_sys_tkill
+201	common	time			__x64_sys_time
+202	common	futex			__x64_sys_futex
+203	common	sched_setaffinity	__x64_sys_sched_setaffinity
+204	common	sched_getaffinity	__x64_sys_sched_getaffinity
 205	64	set_thread_area
-206	64	io_setup		sys_io_setup
-207	common	io_destroy		sys_io_destroy
-208	common	io_getevents		sys_io_getevents
-209	64	io_submit		sys_io_submit
-210	common	io_cancel		sys_io_cancel
+206	64	io_setup		__x64_sys_io_setup
+207	common	io_destroy		__x64_sys_io_destroy
+208	common	io_getevents		__x64_sys_io_getevents
+209	64	io_submit		__x64_sys_io_submit
+210	common	io_cancel		__x64_sys_io_cancel
 211	64	get_thread_area
-212	common	lookup_dcookie		sys_lookup_dcookie
-213	common	epoll_create		sys_epoll_create
+212	common	lookup_dcookie		__x64_sys_lookup_dcookie
+213	common	epoll_create		__x64_sys_epoll_create
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
+216	common	remap_file_pages	__x64_sys_remap_file_pages
+217	common	getdents64		__x64_sys_getdents64
+218	common	set_tid_address		__x64_sys_set_tid_address
+219	common	restart_syscall		__x64_sys_restart_syscall
+220	common	semtimedop		__x64_sys_semtimedop
+221	common	fadvise64		__x64_sys_fadvise64
+222	64	timer_create		__x64_sys_timer_create
+223	common	timer_settime		__x64_sys_timer_settime
+224	common	timer_gettime		__x64_sys_timer_gettime
+225	common	timer_getoverrun	__x64_sys_timer_getoverrun
+226	common	timer_delete		__x64_sys_timer_delete
+227	common	clock_settime		__x64_sys_clock_settime
+228	common	clock_gettime		__x64_sys_clock_gettime
+229	common	clock_getres		__x64_sys_clock_getres
+230	common	clock_nanosleep		__x64_sys_clock_nanosleep
+231	common	exit_group		__x64_sys_exit_group
+232	common	epoll_wait		__x64_sys_epoll_wait
+233	common	epoll_ctl		__x64_sys_epoll_ctl
+234	common	tgkill			__x64_sys_tgkill
+235	common	utimes			__x64_sys_utimes
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
+237	common	mbind			__x64_sys_mbind
+238	common	set_mempolicy		__x64_sys_set_mempolicy
+239	common	get_mempolicy		__x64_sys_get_mempolicy
+240	common	mq_open			__x64_sys_mq_open
+241	common	mq_unlink		__x64_sys_mq_unlink
+242	common	mq_timedsend		__x64_sys_mq_timedsend
+243	common	mq_timedreceive		__x64_sys_mq_timedreceive
+244	64	mq_notify		__x64_sys_mq_notify
+245	common	mq_getsetattr		__x64_sys_mq_getsetattr
+246	64	kexec_load		__x64_sys_kexec_load
+247	64	waitid			__x64_sys_waitid
+248	common	add_key			__x64_sys_add_key
+249	common	request_key		__x64_sys_request_key
+250	common	keyctl			__x64_sys_keyctl
+251	common	ioprio_set		__x64_sys_ioprio_set
+252	common	ioprio_get		__x64_sys_ioprio_get
+253	common	inotify_init		__x64_sys_inotify_init
+254	common	inotify_add_watch	__x64_sys_inotify_add_watch
+255	common	inotify_rm_watch	__x64_sys_inotify_rm_watch
+256	common	migrate_pages		__x64_sys_migrate_pages
+257	common	openat			__x64_sys_openat
+258	common	mkdirat			__x64_sys_mkdirat
+259	common	mknodat			__x64_sys_mknodat
+260	common	fchownat		__x64_sys_fchownat
+261	common	futimesat		__x64_sys_futimesat
+262	common	newfstatat		__x64_sys_newfstatat
+263	common	unlinkat		__x64_sys_unlinkat
+264	common	renameat		__x64_sys_renameat
+265	common	linkat			__x64_sys_linkat
+266	common	symlinkat		__x64_sys_symlinkat
+267	common	readlinkat		__x64_sys_readlinkat
+268	common	fchmodat		__x64_sys_fchmodat
+269	common	faccessat		__x64_sys_faccessat
+270	common	pselect6		__x64_sys_pselect6
+271	common	ppoll			__x64_sys_ppoll
+272	common	unshare			__x64_sys_unshare
+273	64	set_robust_list		__x64_sys_set_robust_list
+274	64	get_robust_list		__x64_sys_get_robust_list
+275	common	splice			__x64_sys_splice
+276	common	tee			__x64_sys_tee
+277	common	sync_file_range		__x64_sys_sync_file_range
+278	64	vmsplice		__x64_sys_vmsplice
+279	64	move_pages		__x64_sys_move_pages
+280	common	utimensat		__x64_sys_utimensat
+281	common	epoll_pwait		__x64_sys_epoll_pwait
+282	common	signalfd		__x64_sys_signalfd
+283	common	timerfd_create		__x64_sys_timerfd_create
+284	common	eventfd			__x64_sys_eventfd
+285	common	fallocate		__x64_sys_fallocate
+286	common	timerfd_settime		__x64_sys_timerfd_settime
+287	common	timerfd_gettime		__x64_sys_timerfd_gettime
+288	common	accept4			__x64_sys_accept4
+289	common	signalfd4		__x64_sys_signalfd4
+290	common	eventfd2		__x64_sys_eventfd2
+291	common	epoll_create1		__x64_sys_epoll_create1
+292	common	dup3			__x64_sys_dup3
+293	common	pipe2			__x64_sys_pipe2
+294	common	inotify_init1		__x64_sys_inotify_init1
+295	64	preadv			__x64_sys_preadv
+296	64	pwritev			__x64_sys_pwritev
+297	64	rt_tgsigqueueinfo	__x64_sys_rt_tgsigqueueinfo
+298	common	perf_event_open		__x64_sys_perf_event_open
+299	64	recvmmsg		__x64_sys_recvmmsg
+300	common	fanotify_init		__x64_sys_fanotify_init
+301	common	fanotify_mark		__x64_sys_fanotify_mark
+302	common	prlimit64		__x64_sys_prlimit64
+303	common	name_to_handle_at	__x64_sys_name_to_handle_at
+304	common	open_by_handle_at	__x64_sys_open_by_handle_at
+305	common	clock_adjtime		__x64_sys_clock_adjtime
+306	common	syncfs			__x64_sys_syncfs
+307	64	sendmmsg		__x64_sys_sendmmsg
+308	common	setns			__x64_sys_setns
+309	common	getcpu			__x64_sys_getcpu
+310	64	process_vm_readv	__x64_sys_process_vm_readv
+311	64	process_vm_writev	__x64_sys_process_vm_writev
+312	common	kcmp			__x64_sys_kcmp
+313	common	finit_module		__x64_sys_finit_module
+314	common	sched_setattr		__x64_sys_sched_setattr
+315	common	sched_getattr		__x64_sys_sched_getattr
+316	common	renameat2		__x64_sys_renameat2
+317	common	seccomp			__x64_sys_seccomp
+318	common	getrandom		__x64_sys_getrandom
+319	common	memfd_create		__x64_sys_memfd_create
+320	common	kexec_file_load		__x64_sys_kexec_file_load
+321	common	bpf			__x64_sys_bpf
+322	64	execveat		__x64_sys_execveat/ptregs
+323	common	userfaultfd		__x64_sys_userfaultfd
+324	common	membarrier		__x64_sys_membarrier
+325	common	mlock2			__x64_sys_mlock2
+326	common	copy_file_range		__x64_sys_copy_file_range
+327	64	preadv2			__x64_sys_preadv2
+328	64	pwritev2		__x64_sys_pwritev2
+329	common	pkey_mprotect		__x64_sys_pkey_mprotect
+330	common	pkey_alloc		__x64_sys_pkey_alloc
+331	common	pkey_free		__x64_sys_pkey_free
+332	common	statx			__x64_sys_statx
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index d71ef4bd3615..94fcd1951aca 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -25,15 +25,27 @@ emit() {
     nr="$2"
     entry="$3"
     compat="$4"
+    umlentry=""
 
     if [ "$abi" = "64" -a -n "$compat" ]; then
 	echo "a compat entry for a 64-bit syscall makes no sense" >&2
 	exit 1
     fi
 
+    # For CONFIG_UML, we need to strip the __x64_sys prefix
+    if [ "$abi" = "64" -a "${entry}" != "${entry#__x64_sys}" ]; then
+	    umlentry="sys${entry#__x64_sys}"
+    fi
+
     if [ -z "$compat" ]; then
-	if [ -n "$entry" ]; then
+	if [ -n "$entry" -a -z "$umlentry" ]; then
 	    syscall_macro "$abi" "$nr" "$entry"
+	elif [ -n "$umlentry" ]; then # implies -n "$entry"
+	    echo "#ifdef CONFIG_X86"
+	    syscall_macro "$abi" "$nr" "$entry"
+	    echo "#else /* CONFIG_UML */"
+	    syscall_macro "$abi" "$nr" "$umlentry"
+	    echo "#endif"
 	fi
     else
 	echo "#ifdef CONFIG_X86_32"
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 20b3d4a88ee4..70b7845434cb 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -229,12 +229,12 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	switch (vsyscall_nr) {
 	case 0:
 		/* this decodes regs->di and regs->si on its own */
-		ret = sys_gettimeofday(regs);
+		ret = __x64_sys_gettimeofday(regs);
 		break;
 
 	case 1:
 		/* this decodes regs->di on its own */
-		ret = sys_time(regs);
+		ret = __x64_sys_time(regs);
 		break;
 
 	case 2:
@@ -242,7 +242,7 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 		orig_dx = regs->dx;
 		regs->dx = 0;
 		/* this decodes regs->di, regs->si and regs->dx on its own */
-		ret = sys_getcpu(regs);
+		ret = __x64_sys_getcpu(regs);
 		regs->dx = orig_dx;
 		break;
 	}
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 8d0951cfc2d4..a598013e08e9 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -44,12 +44,23 @@
 		return __se_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}
 
+/*
+ * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
+ * named __ia32_sys_*()
+ */
+#define SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long __x64_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
+	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);	\
+	asmlinkage long __x64_sys_##sname(void)
+
 #define COND_SYSCALL(name)						\
-	cond_syscall(sys_##name);					\
+	cond_syscall(__x64_sys_##name);					\
 	cond_syscall(__ia32_sys_##name)
 
 #define SYS_NI(name)							\
-	SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers);			\
+	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
 	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
@@ -81,8 +92,7 @@
 /*
  * Compat means IA32_EMULATION and/or X86_X32. As they use a different
  * mapping of registers to parameters, we need to generate stubs for each
- * of them. There is no need to implement COMPAT_SYSCALL_DEFINE0, as it is
- * unused on x86.
+ * of them.
  */
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
@@ -114,13 +124,13 @@
 /*
  * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
  * struct pt_regs *regs as the only argument of the syscall stub named
- * sys_*(). It decodes just the registers it needs and passes them on to
+ * __x64_sys_*(). It decodes just the registers it needs and passes them on to
  * the __se_sys_*() wrapper performing sign extension and then to the
  * __do_sys_*() function doing the actual job. These wrappers and functions
  * are inlined (at least in very most cases), meaning that the assembly looks
  * as follows (slightly re-ordered for better readability):
  *
- * <sys_recv>:			<-- syscall with 4 parameters
+ * <__x64_sys_recv>:		<-- syscall with 4 parameters
  *	callq	<__fentry__>
  *
  *	mov	0x70(%rdi),%rdi	<-- decode regs->di
@@ -143,18 +153,13 @@
  * If IA32_EMULATION is enabled, this macro generates an additional wrapper
  * named __ia32_sys_*() which decodes the struct pt_regs *regs according
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
+	asmlinkage long __x64_sys##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__x64_sys##name, ERRNO);			\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	asmlinkage long sys##name(const struct pt_regs *regs)		\
+	asmlinkage long __x64_sys##name(const struct pt_regs *regs)	\
 	{								\
 		return __se_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}								\
@@ -168,13 +173,37 @@
 	}								\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
+/*
+ * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
+ * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
+ * hurt, we only need to re-define it here to keep the naming congruent to
+ * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
+ * macros to work correctly.
+ */
+#ifndef SYSCALL_DEFINE0
+#define SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long __x64_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
+	asmlinkage long __x64_sys_##sname(void)
+#endif
+
+#ifndef COND_SYSCALL
+#define COND_SYSCALL(name) cond_syscall(__x64_sys_##name)
+#endif
+
+#ifndef SYS_NI
+#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
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
+asmlinkage long __x64_sys_getcpu(const struct pt_regs *regs);
+asmlinkage long __x64_sys_gettimeofday(const struct pt_regs *regs);
+asmlinkage long __x64_sys_time(const struct pt_regs *regs);
 
 #endif /* _ASM_X86_SYSCALL_WRAPPER_H */
-- 
2.17.0
