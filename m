Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDKPJY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:09:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38433 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDKPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:09:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: compat: allow including asm/compat.h for 32-bit
Date: Wed, 11 Apr 2018 17:07:58 +0200
Message-Id: <20180411150829.3881900-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:F0StjCM43m+Fsqz42HCF6xC0y0dwwrU/CJGBLhCOjpPD4UPF/YW
 +gH0pmhKqa7sul7nN9tUYEz89Zv0plWRkL8NZun+lN8iN9KTz/AaVP9fglQL0i/wn/qE3MR
 AUnNfyldEevH35boJ7XWNfsiX9oOwmHKkQ7SRj5QFzoF7zG6CoOBbuMQ4Yvcc4o3BkG/3Y7
 IY30QiJkeL1MNkMj0DPjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wERnXFiNdh8=:yQQ0SySB+fERB38ASa/kE/
 4o3cb9fmKGzaDbTpsg92+o+bDnUnl/PkeGGU2t7fT64Gz1FYzr2F4eRX/0mAPSzMtpDKaJZBd
 pKfK7VA9qVCxLcXnDjeC7RiUacFYpiUkXvV1hhBeNqggOL1TMVb68xCIWCxrMwJoDhNUoIXGi
 exgVFux1AXQ/J4jwcXaBrmY/UHDJXIaqV4r5WjVMqxpFmBMn2y21gC0Y7ZpKewL74to736K58
 zdE7HSmRutE+CiRTHDEOsFgce8YN1ZrlsPjPjMOguOoNO20C/vcfjZ+EuMkh+7v04jZwriGCK
 n86ttZeH7hr10nizYxY5sQWPzQya9Cxb5vF7578HwhW+PPcCImphmzAL5JuNjsTjLuD3kkLww
 nZCFG60QBSu7KtwZaiwHAWRKmdDctYMNtfPECPHDfodsMFSupF4OTG1PIrGjhtS/Gq6gbZ+nT
 ihg3Rjv2LfFlWhHYJ7qsYqxuqlE+86y8Y7vnafYw0sx4JUcWcYmSFCjtfHPb9aL9g04A0iHUj
 o4H1ZTAoFGH45bHLMhuqvFe2daAWx30WElB4PIhnvqi7poKLaysVe1cCqBY1eMk5wjBU68n9p
 sGyoMgU8UzGUNz8s6Gip3REUy0HD4djCVqQaIj4TZez6ohLmSWWHqRZdKwqT8EAo9Playdkdi
 ZOxKH8GxlPJ7XKYTu26vmuxQmpZMWHa+G9b2I2TOqEFPCluT/yfGeFErTP1tbwsGCrZD0RTIR
 jpWPBDWqxSJ957H5VlR1E0useCnoY4NKkGmAgQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have several files on sparc that include linux/compat.h and expect
asm/compat.h not to be included, otherwise we get a build failure.

Since we need to include asm/compat.h for compat time_t handling
on all 32-bit architectures now, this hides some portions of
asm/compat.h in order to let the rest of the file get included.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/compat.h | 4 ++++
 1 file changed, 4 insertions(+)

This is the fix for the y2038 syscall series that missed the 4.17 merge
window. I've now spent two more days doing extra build testing on all
64-bit archtectures building with and without CONFIG_COMPAT, as well
as without CONFIG_64BIT. I did not run into any additional build failures
after this patch, so my plan is to pick that up into my y2038 tree after
-rc1 and send Thomas a pull request a few days later for inclusion
in linux-4.18.

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 161aeacbc9ad..4eb51d2dae98 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -157,6 +157,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 	return (u32)(unsigned long)uptr;
 }
 
+#ifdef CONFIG_COMPAT
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = current_thread_info()->kregs;
@@ -173,6 +174,7 @@ static inline void __user *arch_compat_alloc_user_space(long len)
 
 	return (void __user *) usp;
 }
+#endif
 
 struct compat_ipc64_perm {
 	compat_key_t key;
@@ -232,6 +234,7 @@ struct compat_shmid64_ds {
 	unsigned int	__unused2;
 };
 
+#ifdef CONFIG_COMPAT
 static inline int is_compat_task(void)
 {
 	return test_thread_flag(TIF_32BIT);
@@ -243,5 +246,6 @@ static inline bool in_compat_syscall(void)
 	return pt_regs_trap_type(current_pt_regs()) == 0x110;
 }
 #define in_compat_syscall in_compat_syscall
+#endif
 
 #endif /* _ASM_SPARC64_COMPAT_H */
-- 
2.9.0
