Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C9DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5500320873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GyP/PNdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5500320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeLMJIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:08:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46163 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeLMJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:08:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so781146pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ovqA7q/BYVAxnWyyXEnsQMPs7oV4aZ6Ml07RbG8nye0=;
        b=GyP/PNdn9JmSRK2kIDauz1cZazZwcVHfOiD7jt6TLEHTBmdqy9bOktd0WesPfD46a8
         MMcyfTYkG2gDZqwsTjZOgPlJ48u3HdD5hxxDH1QAtddPBhLTBr5/VMjDsKZYaIetvrts
         bLQHgYDkttAoAh3tfjyHyH/B2iGhsKIGmSIJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ovqA7q/BYVAxnWyyXEnsQMPs7oV4aZ6Ml07RbG8nye0=;
        b=HQNTNi9+nysjNJJSP4KmjwVourNK/Odi1SOy8b6nYA5lYRybetgFGlJS8UqLhnZWN0
         qPWpx0q0ylxhe6AUHK+uCCV0PvjeZZx+FurTpq/yBv1US50C3uQF2HetKw1N1s7DZl8g
         yrfEO8+yHpjrtvTTAGTY/lfY679tFZ+zjjWp4/dcNj2cSHaFer1YcU8J8UTzi+bdApZH
         0zp03b3hvBQr0BMxyNm7vOXgAM7LThGP2HTVFFsYtOhpBAcnqdnKBVG/XiEVi17Hn/1U
         FKJdLyUg+kOXosUJMHAX5TN35a5ySqmF0JOAhSTk17WKgFIpZQuBiOiIcLRBSpyieRC9
         iplg==
X-Gm-Message-State: AA+aEWYgIOhUcW91tUY4RsH07JBmbo+6tq19U7tCf+8pUlLfdUbf7gyh
        UXzG+KAxtX1kM60wn8FJ8BB7Ug==
X-Google-Smtp-Source: AFSGD/W5CzhxlqWZl4I4bAQuZ5nuyRH/SbKABViQd4AkjDovHZoHS78Cwqw3roZDZrGA/LVNRTmqYg==
X-Received: by 2002:a63:4e15:: with SMTP id c21mr21230068pgb.50.1544692112735;
        Thu, 13 Dec 2018 01:08:32 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m11sm1650533pgh.51.2018.12.13.01.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:08:32 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 3/7] mips: rename macros and files from '64' to 'n64'
Date:   Thu, 13 Dec 2018 14:37:35 +0530
Message-Id: <1544692059-9728-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get nanoMIPS support we'll be introducing the p32
ABI, and there's a reasonable chance that the equivalent
p64 ABI may come along in the future. Using 'n64' now would
avoid confusion in that case where we may have 2 different
64-bit ABIs.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h              | 4 ++--
 arch/mips/kernel/Makefile                        | 2 +-
 arch/mips/kernel/ftrace.c                        | 4 ++--
 arch/mips/kernel/{scall64-64.S => scall64-n64.S} | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/mips/kernel/{scall64-64.S => scall64-n64.S} (99%)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index c897195..baea6e4 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -742,8 +742,8 @@
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
-#define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
+#define __NR_N64_Linux			5000
+#define __NR_N64_Linux_syscalls		328
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 210c280..25af613 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -72,7 +72,7 @@ obj-$(CONFIG_IRQ_GT641XX)	+= irq-gt641xx.o
 
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
-obj-$(CONFIG_64BIT)		+= scall64-64.o
+obj-$(CONFIG_64BIT)		+= scall64-n64.o
 obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o ptrace32.o signal32.o
 obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o signal_o32.o
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index b122cbb..d91a6e7 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -403,8 +403,8 @@ unsigned long __init arch_syscall_addr(int nr)
 	if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
 		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
 #endif
-	if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls)
-		return (unsigned long)sys_call_table[nr - __NR_64_Linux];
+	if (nr >= __NR_N64_Linux  && nr <= __NR_N64_Linux + __NR_N64_Linux_syscalls)
+		return (unsigned long)sys_call_table[nr - __NR_N64_Linux];
 #ifdef CONFIG_MIPS32_O32
 	if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
 		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-n64.S
similarity index 99%
rename from arch/mips/kernel/scall64-64.S
rename to arch/mips/kernel/scall64-n64.S
index 358d959..497cd62 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -53,8 +53,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
 	bnez	t0, syscall_trace_entry
 
 syscall_common:
-	dsubu	t2, v0, __NR_64_Linux
-	sltiu   t0, t2, __NR_64_Linux_syscalls + 1
+	dsubu	t2, v0, __NR_N64_Linux
+	sltiu   t0, t2, __NR_N64_Linux_syscalls + 1
 	beqz	t0, illegal_syscall
 
 	dsll	t0, t2, 3		# offset into table
-- 
1.9.1

