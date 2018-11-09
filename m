Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504CBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9892075C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9892075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbeKJJhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:37:23 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49856 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeKJJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:37:23 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AAE0B72CBF9;
        Sat, 10 Nov 2018 02:54:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 9DB067CD1FF; Sat, 10 Nov 2018 02:54:26 +0300 (MSK)
Date:   Sat, 10 Nov 2018 02:54:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-snps-arc@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13 v3] arc: define syscall_get_arch()
Message-ID: <20181109235426.GD2710@altlinux.org>
Mail-Followup-To: Vineet Gupta <vineet.gupta1@synopsys.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-snps-arc@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20181109031605.GF21511@altlinux.org>
 <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
 <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
 <456a69c6e01a6ab5b1af6d459a249388f8b4c1f5.camel@synopsys.com>
 <C6CF3942-3307-431F-B76C-B550BB48F472@amacapital.net>
 <215d66fd9a197b631973c9ff75943b4c1216b899.camel@synopsys.com>
 <CALCETrXCcBBTzcL_yz3agNhby1huZSn2UGtJ9Soo=8n8_rj1Tg@mail.gmail.com>
 <20181109233342.GC2710@altlinux.org>
 <C2D7FE5348E1B147BCA15975FBA23075013A59253C@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A59253C@us01wembx1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
that use tracehook_report_syscall_entry() in order to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
v3: replaced #ifdefs with IS_ENABLED,
    made LE as default, added BE suffixes variants
v2: defined AUDIT_ARCH_ARCOMPACT, AUDIT_ARCH_ARCOMPACTLE, AUDIT_ARCH_ARCV2,
    and AUDIT_ARCH_ARCV2LE instead of AUDIT_ARCH_ARC,
    updated syscall_get_arch() implementation accordingly.

 arch/arc/include/asm/syscall.h | 10 ++++++++++
 include/uapi/linux/audit.h     |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscall.h
index 29de09804306..10b2e7523bc8 100644
--- a/arch/arc/include/asm/syscall.h
+++ b/arch/arc/include/asm/syscall.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_ARC_SYSCALL_H
 #define _ASM_ARC_SYSCALL_H  1
 
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <asm/unistd.h>
@@ -68,4 +69,13 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+static inline int syscall_get_arch(void)
+{
+	return IS_ENABLED(CONFIG_ISA_ARCOMPACT)
+		? (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
+			? AUDIT_ARCH_ARCOMPACTBE : AUDIT_ARCH_ARCOMPACT)
+		: (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
+			? AUDIT_ARCH_ARCV2BE : AUDIT_ARCH_ARCV2);
+}
+
 #endif
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 818ae690ab79..bedf3bf54c3a 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -375,6 +375,10 @@ enum {
 
 #define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_ARCOMPACT	(EM_ARCOMPACT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_ARCOMPACTBE	(EM_ARCOMPACT)
+#define AUDIT_ARCH_ARCV2	(EM_ARCV2|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_ARCV2BE	(EM_ARCV2)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
 #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
-- 
ldv
