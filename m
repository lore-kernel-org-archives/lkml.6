Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC9C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D099B20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D099B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeLDVYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:24:08 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeLDVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:24:05 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1g3U-1hVr8c2Txw-011z3G; Tue, 04 Dec 2018 22:23:54 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     firoz.khan@linaro.org
Cc:     y2038@lists.linaro.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: split compat syscall table out from native table
Date:   Tue,  4 Dec 2018 22:23:07 +0100
Message-Id: <20181204212340.3915309-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
References: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
X-Provags-ID: V03:K1:ZivU5sOtOGpvDROJTPzC3cFFUPED1oKW1AZPSkRrG/FCNsI6ycM
 jjrNujJjd2p+OwP+pG02TnUfEYAH601nUI6m9yt/MeolUQHcCflniE4TV7DsknVpDSHunLG
 vifhgRA6fUkcl4BnthmsZ3nU8dgUqUsYLviHorZkE5cVSmm897Jp9xzVNZyOHpWdji3Duim
 An7RuQOsAXMwxohY2CtBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hf4vrmoC6nc=:vypGEd1o8AY7d7KwJ2UbdX
 wa0dHginCoT8xL5IRtQpi+SqJhReosWynypauUPdJuRDdscnREEFyytOyX8R0w2UcqDGJJdnp
 +Xw8XSRu4VGLgzmhGLcm2BAF5R0uCBt7nCRhpLWqDBQ+E/jM1k4M5WTw/L3VCsL0SWi1Hb5C/
 isnwtj3yUjuK1DUzwTLvWnjMZ7Nd1p+BEqDgGsCX4ZW6hoMPAHLlcQ8Y40kvLVAQ0khNYK0f9
 1Gsy2MQpXL3ivhzix8eJMO7s/rFbxRFGjWntopUMiGtCpLN5sAgRV1Etjs7CKfQJZfyk84dBa
 9qzsveamUVTOhuZXna8PuuCT+qnQ8Ry+c7dzj3hSdg0M8NPrH5m9B8NMMiRhuJcRynN4tAIRl
 rI8ICpZWvI4vlPMY5WfhKJqMbGq5xjou8S/5xogdX0YuftwZ0hkrtZKGdjUdGa5mRKN9AN3rb
 7UhKDHpgoK5uc8gvLlBGp8lkiUMdIHBnvJ12Fpe5il5TrC1Y5LWAGWEm5zIBMZJwYNV4FVPHp
 zwmG7DEUpuQadnWA4rz9C4HzIjKAHJgp1BQCFvKQD5VVHzhjCwz1xIkf0DPd67Zgj8YVsHl1H
 qjlS3sA2q1ZTwzxR+CeUpyyhQHajUWfa21ym5n07HTiLWCO4aHMj90YLEXvQPEdvBXOiQreNb
 dJb3vjAz9X8VoVYB6I7lifNwnAX5zwyrDvN91jpWSZQO5BdJhLgpNG/G9elvY+Zs1sW6sKKpd
 1L/wIno4Zz9oM+SbMq6eWuXpC9xLVgmsFjcmjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC uses a syscall table with native and compat calls interleaved,
which is a slightly simpler way to define two matching tables.

As we move to having the tables generated, that advantage is no longer
important, but the interleaved table gets in the way of using the
same scripts as on the other architectures.

Split out a new compat_sys_call_table symbol that contains all the
compat calls, and leave the main table for the native calls, to more
closely match the method we use everywhere else.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is completely untested, it's just for illustration and to
get comments about whether this is a good idea.

Firoz, can you try to get this working?
---
 arch/powerpc/include/asm/syscall.h |  3 +--
 arch/powerpc/kernel/entry_64.S     |  7 ++++--
 arch/powerpc/kernel/systbl.S       | 37 ++++++++++++++++++++++++------
 arch/powerpc/kernel/vdso.c         |  7 ++++--
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index ab9f3f0a8637..1a0e7a8b1c81 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -18,9 +18,8 @@
 #include <linux/thread_info.h>
 
 /* ftrace syscalls requires exporting the sys_call_table */
-#ifdef CONFIG_FTRACE_SYSCALLS
 extern const unsigned long sys_call_table[];
-#endif /* CONFIG_FTRACE_SYSCALLS */
+extern const unsigned long compat_sys_call_table[];
 
 static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693adff2a..5574d92646f1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -54,6 +54,9 @@
 SYS_CALL_TABLE:
 	.tc sys_call_table[TC],sys_call_table
 
+COMPAT_SYS_CALL_TABLE:
+	.tc compat_sys_call_table[TC],compat_sys_call_table
+
 /* This value is used to mark exception frames on the stack. */
 exception_marker:
 	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
@@ -173,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r11,SYS_CALL_TABLE@toc(2)
 	andis.	r10,r10,_TIF_32BIT@h
 	beq	15f
-	addi	r11,r11,8	/* use 32-bit syscall entries */
+	ld	r11,COMPAT_SYS_CALL_TABLE@toc(2)
 	clrldi	r3,r3,32
 	clrldi	r4,r4,32
 	clrldi	r5,r5,32
@@ -181,7 +184,7 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r7,r7,32
 	clrldi	r8,r8,32
 15:
-	slwi	r0,r0,4
+	slwi	r0,r0,3
 
 	barrier_nospec_asm
 	/*
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 919a32746ede..883b8e36964c 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -17,13 +17,13 @@
 #include <asm/ppc_asm.h>
 
 #ifdef CONFIG_PPC64
-#define SYSCALL(func)		.8byte	DOTSYM(sys_##func),DOTSYM(sys_##func)
-#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
-#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
-#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
-#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
-#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
-#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f),DOTSYM(f3264)
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f)
 #else
 #define SYSCALL(func)		.long	sys_##func
 #define COMPAT_SYS(func)	.long	sys_##func
@@ -48,3 +48,26 @@
 sys_call_table:
 
 #include <asm/systbl.h>
+
+#undef SYSCALL
+#undef COMPAT_SYS
+#undef PPC_SYS
+#undef OLDSYS
+#undef SYS32ONLY
+#undef PPC64ONLY
+#undef SYSX
+
+#ifdef CONFIG_COMPAT
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(compat_sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(compat_sys_##func)
+#define PPC64ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f3264)
+
+.globl compat_sys_call_table
+compat_sys_call_table:
+
+#include <asm/systbl.h>
+#endif
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 65b3bdb99f0b..7725a9714736 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -671,15 +671,18 @@ static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
 	extern unsigned long *sys_call_table;
+#ifdef CONFIG_PPC64
+	extern unsigned long *compat_sys_call_table;
+#endif
 	extern unsigned long sys_ni_syscall;
 
 
 	for (i = 0; i < NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
-		if (sys_call_table[i*2] != sys_ni_syscall)
+		if (sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
-		if (sys_call_table[i*2+1] != sys_ni_syscall)
+		if (compat_sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #else /* CONFIG_PPC64 */
-- 
2.18.0

