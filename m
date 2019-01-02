Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCFBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A5821871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXcqIW/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfABPx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:53:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34783 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfABPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:53:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so15356843pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xxQH5NeQq6MvU16ENPdcrPrwdvwf7ju4FD0coaVYm/I=;
        b=hXcqIW/PZNiqYsvCnr2c+6F5zlRLQNgQZwRusjZMocjFC10pdMarvYa10OruYq5Trk
         Y8J1GR15GUtfwpybCrKiGiCi1gz5CDgxBCkbNT1TSy2x/osMg71HagVjGKPSa/vwdpAJ
         nBj+QczX1C+0XHhmykqt0nQphmTARc9Sl0o5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xxQH5NeQq6MvU16ENPdcrPrwdvwf7ju4FD0coaVYm/I=;
        b=LnmvlC5Vr910ko6GWrGjdTN2IF0Y2QKsNeAKbZknmRadlG3ELGKS6wGQsDfTebPt02
         kaRgrA8AgKpLz8CU8F2toUz+JMJ8qiCJN5CLR5fJwoLF0eqQerSzsFNjGVV03iDmxqdH
         p9U/MJbbJHDBtG0e2BQgWcZMLdVMbtBRHdIGu3a15n5AW05C/3563SGXxzf8UsQCDIp/
         5a3FCUmDtRMSKx8+Rt3pGVIJCOVsX6omhe5oxwLM7zEkNiJzY6jqpnUr8bhtsRXJ/u5v
         EvjnCw/Mv/8x7G8pCErKnxPKIJw+hftYfa4hu3cRBavzIHTF08jhJQK3cbCE9K9a9qv3
         GgLQ==
X-Gm-Message-State: AA+aEWZQc3ouDLQREWT60NBIL2T++4BIsORIzKWwtk3bG0PYaPFJ7za/
        ClTdEop9xWuY+9n5i+Byr+dh1Q==
X-Google-Smtp-Source: AFSGD/VXOUjKYvMmoljN0qXNzzjFPdeozM9tOb+Su2mFrpmH1Tnlbvfk3sZlMc3/fCPN/K6ZQSN9Pg==
X-Received: by 2002:a62:4886:: with SMTP id q6mr46198734pfi.182.1546444404102;
        Wed, 02 Jan 2019 07:53:24 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n7sm95242637pff.36.2019.01.02.07.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:53:23 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 2/3] sparc: rename not implemented system call
Date:   Wed,  2 Jan 2019 21:22:52 +0530
Message-Id: <1546444373-21386-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the sparc not implemented system call - sys_nis_syscall to
sys_ni_syscall to unify the system call table implementation across
all architectures.

This is neccessory to do it if we have to keep the scripts in common
location.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/kernel/syscalls/syscall.tbl | 26 +++++++++++++-------------
 arch/sparc/kernel/systbls_32.S         |  1 +
 arch/sparc/kernel/systbls_64.S         |  2 ++
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index c8c77c0..5437fdb 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -20,7 +20,7 @@
 9	common	link			sys_link
 10	common	unlink			sys_unlink
 11	32	execv			sunos_execv
-11	64	execv			sys_nis_syscall
+11	64	execv			sys_ni_syscall
 12	common	chdir			sys_chdir
 13	32    	chown			sys_chown16
 13	64	chown			sys_chown
@@ -29,7 +29,7 @@
 16	32	lchown			sys_lchown16
 16	64	lchown			sys_lchown
 17	common	brk			sys_brk
-18	common	perfctr			sys_nis_syscall
+18	common	perfctr			sys_ni_syscall
 19	common	lseek			sys_lseek			compat_sys_lseek
 20	common	getpid			sys_getpid
 21	common	capget			sys_capget
@@ -43,7 +43,7 @@
 27	common	alarm			sys_alarm
 28	common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
 29	32    	pause			sys_pause
-29	64    	pause			sys_nis_syscall
+29	64    	pause			sys_ni_syscall
 30	common	utime			sys_utime			compat_sys_utime
 31	32    	lchown32		sys_lchown
 32	32    	fchown32		sys_fchown
@@ -214,7 +214,7 @@
 181	common	removexattr		sys_removexattr
 182	common	lremovexattr		sys_lremovexattr
 183	32	sigpending		sys_sigpending			compat_sys_sigpending
-183	64	sigpending		sys_nis_syscall
+183	64	sigpending		sys_ni_syscall
 184	common	query_module		sys_ni_syscall
 185	common	setpgid			sys_setpgid
 186	common	fremovexattr		sys_fremovexattr
@@ -233,15 +233,15 @@
 196	common	ioprio_set		sys_ioprio_set
 197	common	getppid			sys_getppid
 198	32	sigaction		sys_sparc_sigaction		compat_sys_sparc_sigaction
-198	64	sigaction		sys_nis_syscall
+198	64	sigaction		sys_ni_syscall
 199	common	sgetmask		sys_sgetmask
 200	common	ssetmask		sys_ssetmask
 201	32	sigsuspend		sys_sigsuspend
-201	64	sigsuspend		sys_nis_syscall
+201	64	sigsuspend		sys_ni_syscall
 202	common	oldlstat		sys_newlstat			compat_sys_newlstat
 203	common	uselib			sys_uselib
 204	32	readdir			sys_old_readdir			compat_sys_old_readdir
-204	64	readdir			sys_nis_syscall
+204	64	readdir			sys_ni_syscall
 205	common	readahead		sys_readahead			compat_sys_readahead
 206	common	socketcall		sys_socketcall			sys32_socketcall
 207	common	syslog			sys_syslog
@@ -255,19 +255,19 @@
 215	32	ipc			sys_ipc				compat_sys_ipc
 215	64	ipc			sys_sparc_ipc
 216	32	sigreturn		sys_sigreturn			sys32_sigreturn
-216	64	sigreturn		sys_nis_syscall
+216	64	sigreturn		sys_ni_syscall
 217	common	clone			sys_clone
 218	common	ioprio_get		sys_ioprio_get
 219	common	adjtimex		sys_adjtimex			compat_sys_adjtimex
 220	32	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
-220	64	sigprocmask		sys_nis_syscall
+220	64	sigprocmask		sys_ni_syscall
 221	common	create_module		sys_ni_syscall
 222	common	delete_module		sys_delete_module
 223	common	get_kernel_syms		sys_ni_syscall
 224	common	getpgid			sys_getpgid
 225	common	bdflush			sys_bdflush
 226	common	sysfs			sys_sysfs
-227	common	afs_syscall		sys_nis_syscall
+227	common	afs_syscall		sys_ni_syscall
 228	common	setfsuid		sys_setfsuid16
 229	common	setfsgid		sys_setfsgid16
 230	common	_newselect		sys_select			compat_sys_select
@@ -295,8 +295,8 @@
 251	common	_sysctl			sys_sysctl			compat_sys_sysctl
 252	common	getsid			sys_getsid
 253	common	fdatasync		sys_fdatasync
-254	32	nfsservctl		sys_ni_syscall			sys_nis_syscall
-254	64	nfsservctl		sys_nis_syscall
+254	32	nfsservctl		sys_ni_syscall			sys_ni_syscall
+254	64	nfsservctl		sys_ni_syscall
 255	common	sync_file_range		sys_sync_file_range		compat_sys_sync_file_range
 256	common	clock_settime		sys_clock_settime		compat_sys_clock_settime
 257	common	clock_gettime		sys_clock_gettime		compat_sys_clock_gettime
@@ -310,7 +310,7 @@
 265	common	timer_delete		sys_timer_delete
 266	common	timer_create		sys_timer_create		compat_sys_timer_create
 # 267 was vserver
-267	common	vserver			sys_nis_syscall
+267	common	vserver			sys_ni_syscall
 268	common	io_setup		sys_io_setup			compat_sys_io_setup
 269	common	io_destroy		sys_io_destroy
 270	common	io_submit		sys_io_submit			compat_sys_io_submit
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 391a49a..121a1a0 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -14,5 +14,6 @@
 	.align 4
 	.globl sys_call_table
 sys_call_table:
+#define sys_nis_syscall	sys_ni_syscall
 #include <asm/syscall_table_32.h>	/* 32-bit native syscalls */
 #undef __SYSCALL
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 08ce7cb..7d861d6 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -10,6 +10,8 @@
  * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
  */
 
+#define sys_nis_syscall	sys_ni_syscall
+
 #define __SYSCALL(nr, entry)	.word entry
 	.text
 	.align	4
-- 
1.9.1

