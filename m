Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF8AECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABA021567
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JeJRsOiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABA021567
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbeITCag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33447 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732769AbeITCae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id d8-v6so6064140edv.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=srrfwcrfXLTOT9msUFLi1TO1mIpR4+CVBqB4Bg5Y33k=;
        b=JeJRsOiFuxoL+2vub+MdKGZClewJchwTWfu5C/jfUE/h3KpGXGt5cNyHZ01/X/eTDD
         3l4Ydyac7rSiSnl+F5wqZPXUBFrRpTOZ6do5AJcv2/6V8hsSb6LSMbwxCoFMjIIVAfff
         2SeT/q0tasO3encaTd9yExKsNWjPYcur4fg7dkdhTfEMnTZVdJe4off0wCn+Vz52kmVo
         +5VAnWHl8lKSWVcfeeBSWQ3fEBpIq9WwIruVuCQJ6Iuw1xmDHWQ5MQWD3sUDqcr6qxoP
         rNnhyctX7lK97/1FAhK4DJHCTmNuJ7a3W3AinM0yj2FoojIJu8c9FBRa/Nv+0VJOnOXG
         4ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=srrfwcrfXLTOT9msUFLi1TO1mIpR4+CVBqB4Bg5Y33k=;
        b=KDHkCR3CjVeaYJmG1ncDduSaGBChTA1TadhmRlVeaG0p1fjgxy2T+MkK73WwFUU+i/
         PebUxos4oaW8BbpkH/mHIa3W6CxMz9QNeEGQD//1azy8yzqStDLOcGZAknoC9TxGci+b
         payHhSvZfr+eATR6wHVgRfIwjfaNW2uHimeB315afaCeT1V39IE2ZzaBTKrf3Gxqfk1R
         ux4S8zd1lpLbI1UOtzJT5Eaqi8wn9ecW4XTdnBKthT6PFaxIICnNpP27bRnnkg4RcD7f
         EOD6jpxKrNH5Y6sOA40A7QjudvYqnOSH5rlu/mM9Coa2LqnIF67dspoDAOcicZJ4riDk
         SpVw==
X-Gm-Message-State: APzg51AO180c8o2d1wQiU2/KLgkuFnr9UAqfXC19QaLcA8UCjOgT46Xj
        yy80Xq7lOG+KhnnrTd9uos3okjeVU/o=
X-Google-Smtp-Source: ANB0VdYPfYw6ydFOiGYHDmtju4SKc2hjX7I7xN26sFIaBAfDK0luqDGTV2Sxpcvx6PbulhLFK45boQ==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr62284016edd.30.1537390252600;
        Wed, 19 Sep 2018 13:50:52 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:51 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 09/20] x86/vdso/timens: Add offsets page in vvar
Date:   Wed, 19 Sep 2018 21:50:26 +0100
Message-Id: <20180919205037.9574-10-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

As modern applications fetch time from vdso without entering the kernel,
it's needed to provide offsets for userspace code.

Allocate a page for timens offsets when constructing time namespace.
As vdso mappings are platform-specific, add Kconfig dependency for arch.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/Kconfig                          |  5 +++++
 arch/x86/Kconfig                      |  1 +
 arch/x86/entry/vdso/vclock_gettime.c  | 26 ++++++++++++++++++++++++++
 arch/x86/entry/vdso/vdso-layout.lds.S |  9 ++++++++-
 arch/x86/entry/vdso/vdso2c.c          |  3 +++
 arch/x86/entry/vdso/vma.c             | 12 ++++++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 init/Kconfig                          |  1 +
 8 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..411df0227a1d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -681,6 +681,11 @@ config HAVE_ARCH_HASH
 config ISA_BUS_API
 	def_bool ISA
 
+config ARCH_HAS_VDSO_TIME_NS
+	bool
+	help
+	 VDSO can add time-ns offsets without entering kernel.
+
 #
 # ABI hall of shame
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..4bcbdd1f1200 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -70,6 +70,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_TIME_NS
 	select ARCH_HAS_ZONE_DEVICE		if X86_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d95c60..0594266740b9 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <linux/timens_offsets.h>
 
 #define gtod (&VVAR(vsyscall_gtod_data))
 
@@ -38,6 +39,11 @@ extern u8 hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
+#ifdef CONFIG_TIME_NS
+extern u8 timens_page
+	__attribute__((visibility("hidden")));
+#endif
+
 #ifndef BUILD_VDSO32
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -225,6 +231,23 @@ notrace static int __always_inline do_realtime(struct timespec *ts)
 	return mode;
 }
 
+notrace static __always_inline void monotonic_to_ns(struct timespec *ts)
+{
+#ifdef CONFIG_TIME_NS
+	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
+
+	ts->tv_sec += timens->monotonic_time_offset.tv_sec;
+	ts->tv_nsec += timens->monotonic_time_offset.tv_nsec;
+	if (ts->tv_nsec > NSEC_PER_SEC) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	} else if (ts->tv_nsec < 0) {
+		ts->tv_nsec += NSEC_PER_SEC;
+		ts->tv_sec--;
+	}
+#endif
+}
+
 notrace static int __always_inline do_monotonic(struct timespec *ts)
 {
 	unsigned long seq;
@@ -243,6 +266,8 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
+	monotonic_to_ns(ts);
+
 	return mode;
 }
 
@@ -264,6 +289,7 @@ notrace static void do_monotonic_coarse(struct timespec *ts)
 		ts->tv_sec = gtod->monotonic_time_coarse_sec;
 		ts->tv_nsec = gtod->monotonic_time_coarse_nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
+	monotonic_to_ns(ts);
 }
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index acfd5ba7d943..e5c2e9deca03 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -17,6 +17,12 @@
 
 #define NUM_FAKE_SHDRS 13
 
+#ifdef CONFIG_TIME_NS
+# define TIMENS_SZ	PAGE_SIZE
+#else
+# define TIMENS_SZ	0
+#endif
+
 SECTIONS
 {
 	/*
@@ -26,7 +32,7 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 3 * PAGE_SIZE;
+	vvar_start = . - (3 * PAGE_SIZE + TIMENS_SZ);
 	vvar_page = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
@@ -38,6 +44,7 @@ SECTIONS
 
 	pvclock_page = vvar_start + PAGE_SIZE;
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
+	timens_page = vvar_start + 3 * PAGE_SIZE;
 
 	. = SIZEOF_HEADERS;
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 4674f58581a1..6c67cde7fe99 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -76,6 +76,7 @@ enum {
 	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 	sym_VDSO_FAKE_SECTION_TABLE_START,
 	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
@@ -85,6 +86,7 @@ const int special_pages[] = {
 	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 struct vdso_sym {
@@ -98,6 +100,7 @@ struct vdso_sym required_syms[] = {
 	[sym_hpet_page] = {"hpet_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
+	[sym_timens_page] = {"timens_page", true},
 	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
 		"VDSO_FAKE_SECTION_TABLE_START", false
 	},
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8cc0395687b0..0f92227a4a7e 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,6 +14,7 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
+#include <linux/time_namespace.h>
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
@@ -23,6 +24,7 @@
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
+#include <asm/page.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -138,6 +140,16 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			ret = vm_insert_pfn(vma, vmf->address,
 					    vmalloc_to_pfn(tsc_pg));
+	} else if (sym_offset == image->sym_timens_page) {
+		struct time_namespace *ns = current->nsproxy->time_ns;
+		unsigned long pfn;
+
+		if (!ns->offsets)
+			pfn = page_to_pfn(ZERO_PAGE(0));
+		else
+			pfn = page_to_pfn(virt_to_page(ns->offsets));
+
+		ret = vm_insert_pfn(vma, vmf->address, pfn);
 	}
 
 	if (ret == 0 || ret == -EBUSY)
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 27566e57e87d..619322065b8e 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -22,6 +22,7 @@ struct vdso_image {
 	long sym_hpet_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
+	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
diff --git a/init/Kconfig b/init/Kconfig
index dc2b40f7d73f..c9b250475ddb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -929,6 +929,7 @@ config UTS_NS
 
 config TIME_NS
 	bool "TIME namespace"
+	depends on ARCH_HAS_VDSO_TIME_NS
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
-- 
2.13.6

