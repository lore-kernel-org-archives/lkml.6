Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E623BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCC920651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393074AbfAPNQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:16:41 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:45867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393049AbfAPNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:16:41 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLi4W-1h1QSx1A0W-00Hc1d; Wed, 16 Jan 2019 14:16:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org
Subject: [PATCH 2/5] ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
Date:   Wed, 16 Jan 2019 14:15:20 +0100
Message-Id: <20190116131527.2071570-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116131527.2071570-1-arnd@arndb.de>
References: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UPQV1rarTnBHBg01oEuiIWdstTYyflK3S5ifB3xyWAly94nEH9G
 Sb5P1MnawgJO2BU+o9QVohn6ce0wmWAmigZAEtv+ETN769Ul6u5882NGYWNq+uj9yByCOBZ
 2EdAlDq7TmzrYEWPz9mCLW04pIahu6md5Q8azS/iQ84yrWVpRK+mIPoR4fUcHF/zR5slL7P
 LX79nIk+3wW1zN1zU1P+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fCwgsdJipLU=:au9Pyv2jGgUmor+0ymZ+dk
 Lwzi5rYUp2D+6Y+BeDF0mB4PG7OEQb95gSL5P4qrOaRa6Mzmmy/07ILqyfkrUeOsKtpp7U3xS
 CWCef5VDccDrWEaW2iOJXQuvHz0VYQboWRAbXBJZIMIvLq0kTHpLaHoWZAkDblAS5k7KrS9lG
 o28DybRmvqr37Uh4jjDQFD05ieBkBrCe/JqAX6kWNvZGg1jsnbtj0/mYRBp3QT7MgpsUacYNR
 nAAqtELphoTnKlduIZIG4jsYFe7kBVTiADtfjarkkWQnXyXT/qkpt/HjEfih+83589h3H42T/
 2bq325yFvnSFcQ05HM4CdZk+HWg0rno6HFWSfqkbaNcF/ueCKFse3kibP62UJOnesXW3lAI//
 t4Kc6dHToHlfIJgax1Ed8cWYbdseHj7+Wn+JskBuVOPICJ6SXtJnz5TeCPJ/Sskkh3nErHeq+
 0pXQLHT9BQyQErRMnxgem2RkbbzghHhpuvjC3A6mBz/IreClbPQmWCPaGcENe+YM27rYSmDnS
 M7/tgzMtpredgA2+V0BrD3SXUGrfznqrEcv9Fb0GyKt6kyT2bwXZfwy7edDvzavcIY4f45DC9
 wOFGnDh6XNGjvtO4SwtR0SCrdS16FopJ+q+//OqcwbW25RTZN/YY4kLSPUgBLGujzkcQvwRIA
 MlfuidEQHb0IH1fH3hZd2o32OpeYD7FynTEUBErAgrAunozlmwlfU3DFgOJiGIh0Q/wHq65IU
 PYWD6AxUEb0U0yUTCXRnF60tjsaekkmTrbNpcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sys_ipc() and compat_ksys_ipc() functions are meant to only
be used from the system call table, not called by another function.

Introduce ksys_*() interfaces for this purpose, as we have done
for many other system calls.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/kernel/compat_linux.c |  2 +-
 arch/s390/kernel/sys_s390.c     |  2 +-
 include/linux/syscalls.h        |  4 ++++
 ipc/syscall.c                   | 20 ++++++++++++++++----
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 8ac38d51ed7d..a47f6d3c6d5b 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -296,7 +296,7 @@ COMPAT_SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, compat_ulong_t, second,
 {
 	if (call >> 16)		/* hack for backward compatibility */
 		return -EINVAL;
-	return compat_sys_ipc(call, first, second, third, ptr, third);
+	return compat_ksys_ipc(call, first, second, third, ptr, third);
 }
 #endif
 
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 560bdaf8a74f..6aa8fe00b39e 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -74,7 +74,7 @@ SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, unsigned long, second,
 	 * Therefore we can call the generic variant by simply passing the
 	 * third parameter also as fifth parameter.
 	 */
-	return sys_ipc(call, first, second, third, ptr, third);
+	return ksys_ipc(call, first, second, third, ptr, third);
 }
 
 SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..fb63045a0fb6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1185,6 +1185,10 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			      unsigned long prot, unsigned long flags,
 			      unsigned long fd, unsigned long pgoff);
 ssize_t ksys_readahead(int fd, loff_t offset, size_t count);
+int ksys_ipc(unsigned int call, int first, unsigned long second,
+	unsigned long third, void __user * ptr, long fifth);
+int compat_ksys_ipc(u32 call, int first, int second,
+	u32 third, u32 ptr, u32 fifth);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 1ac06e3983c0..3cf8ad703a4d 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -17,8 +17,8 @@
 #include <linux/shm.h>
 #include <linux/uaccess.h>
 
-SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
-		unsigned long, third, void __user *, ptr, long, fifth)
+int ksys_ipc(unsigned int call, int first, unsigned long second,
+	unsigned long third, void __user * ptr, long fifth)
 {
 	int version, ret;
 
@@ -106,6 +106,12 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 		return -ENOSYS;
 	}
 }
+
+SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
+		unsigned long, third, void __user *, ptr, long, fifth)
+{
+	return ksys_ipc(call, first, second, third, ptr, fifth);
+}
 #endif
 
 #ifdef CONFIG_COMPAT
@@ -121,8 +127,8 @@ struct compat_ipc_kludge {
 };
 
 #ifdef CONFIG_ARCH_WANT_OLD_COMPAT_IPC
-COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
-	u32, third, compat_uptr_t, ptr, u32, fifth)
+int compat_ksys_ipc(u32 call, int first, int second,
+	u32 third, compat_uptr_t ptr, u32 fifth)
 {
 	int version;
 	u32 pad;
@@ -195,5 +201,11 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 
 	return -ENOSYS;
 }
+
+COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
+	u32, third, compat_uptr_t, ptr, u32, fifth)
+{
+	return compat_ksys_ipc(call, first, second, third, ptr, fifth);
+}
 #endif
 #endif
-- 
2.20.0

