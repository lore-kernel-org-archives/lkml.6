Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02FC37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8636C20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfAUUPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:15:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:55626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbfAUUPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8D96AFFF;
        Mon, 21 Jan 2019 20:15:17 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 13/13] epoll: implement epoll_create2() syscall
Date:   Mon, 21 Jan 2019 21:14:56 +0100
Message-Id: <20190121201456.28338-14-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121201456.28338-1-rpenyaev@suse.de>
References: <20190121201456.28338-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

epoll_create2() is needed to accept EPOLL_USERPOLL flags
and size, i.e. this patch wires up polling from userspace.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 fs/eventpoll.c                         | 8 ++++++++
 include/linux/syscalls.h               | 1 +
 include/uapi/asm-generic/unistd.h      | 4 +++-
 kernel/sys_ni.c                        | 1 +
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 6804c1e84b36..3247f49b1325 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -399,3 +399,4 @@
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
 387	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_signal
+388	i386	epoll_create2		sys_epoll_create2		__ia32_sys_epoll_create2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index aa4b858fa0f1..df7c4f1b4a79 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -344,6 +344,7 @@
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
 335	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
+336	common	epoll_create2		__x64_sys_epoll_create2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index cceeff77bdaf..a759ae591202 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2611,6 +2611,14 @@ static int do_epoll_create(int flags, size_t size)
 	return error;
 }
 
+SYSCALL_DEFINE2(epoll_create2, int, flags, size_t, size)
+{
+	if (size == 0)
+		return -EINVAL;
+
+	return do_epoll_create(flags, size);
+}
+
 SYSCALL_DEFINE1(epoll_create1, int, flags)
 {
 	return do_epoll_create(flags, 0);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5eb2e351675e..249ea00696a8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -345,6 +345,7 @@ asmlinkage long sys_eventfd2(unsigned int count, int flags);
 
 /* fs/eventpoll.c */
 asmlinkage long sys_epoll_create1(int flags);
+asmlinkage long sys_epoll_create2(int flags, size_t size);
 asmlinkage long sys_epoll_ctl(int epfd, int op, int fd,
 				struct epoll_event __user *event);
 asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index b77538af7aca..a4d686280cb7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -742,9 +742,11 @@ __SYSCALL(__NR_rseq, sys_rseq)
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 #define __NR_pidfd_send_signal 295
 __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
+#define __NR_epoll_create2 296
+__SYSCALL(__NR_epoll_create2, sys_epoll_create2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 296
+#define __NR_syscalls 297
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f905f4f9f677..5083bb55fcb2 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -60,6 +60,7 @@ COND_SYSCALL(eventfd2);
 
 /* fs/eventfd.c */
 COND_SYSCALL(epoll_create1);
+COND_SYSCALL(epoll_create2);
 COND_SYSCALL(epoll_ctl);
 COND_SYSCALL(epoll_pwait);
 COND_SYSCALL_COMPAT(epoll_pwait);
-- 
2.19.1

