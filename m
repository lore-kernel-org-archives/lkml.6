Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D319BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3F621A15
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hk5IWS5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3F621A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbeHFXJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:09:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40856 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:09:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so6137963plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=4iCJEA3UP8hOOZRRqsKYiSOqErWauh/Xsk0738xT6do=;
        b=hk5IWS5BRt+nJy6ThCQaB8XicqmvReDnDJUu+itoxwaI1vauaCFjL7yN2ZVXKmJOZr
         udaVeYQqOpG92oyPH58rPoKSikvGRk9TloS7+HryDTVYrF65OqIO7fLWBupHFVv3zh8C
         H+Nr+HTb4M0GNznqr8REkqgysVHHcQKJzWdk8EKSoIo03oVwxtRAgSuLheDLjAvQXZ/i
         yLl2YYluSxtqlzR5/lNUZTDlesB4P06EqmXgwn7ZUBntt+eaagN4vHlVYtTCaeFVwKsQ
         sPTOB6uRdk2Vcgv5EBdVgGn3jVCgBYgDHDmIHrM4Hu0mArFybSTBD2JsgGi06qLzZdL+
         O+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=4iCJEA3UP8hOOZRRqsKYiSOqErWauh/Xsk0738xT6do=;
        b=WDE3dqMoXTvifmNxHqLN6T+Vd2GrYKq9sByVrEXE+fmqFxAepRqk0h1gstw1jdVz9G
         IqcxhFsC5Js6kvWnCcovNudvK+Sm5WdIhLKBks66x1KpC8VI95SlgAvKCx6wIqX601ER
         YG4T4XQRSz+u6mjGR5iMJ4QNZvxX0xrNxSKfdfUs5X9V+LR0KUWWmvU84u6Dfp09vrWF
         fGzS3vCbZEUrrXJfMgdBFbHl+jQXsPlm5Q5K3npKlb4CFyFZ481RbKN+VXXbO7co0Gcq
         AmhW/V7mHSfJHPqBNa5uqpik/AKOJNdJZhQ3wByu+d8cLeUs7jA6e9cut5nmCR126FuV
         VaZQ==
X-Gm-Message-State: AOUpUlE5EBHIZsaBLHZEB8OAMNfIOhW85Szd+zEoABFT0r1xARS8SWJc
        NesZW6gpOrxV2lzQXnNCgLLAxw==
X-Google-Smtp-Source: AAOMgpfQg5pJlf70rOmH3jGbRYSPSJp9JIayJnEXA4A9uvRTtc1PPO1liQsG8cS6Vpp2l+r9hOa1qQ==
X-Received: by 2002:a17:902:b944:: with SMTP id h4-v6mr14935937pls.157.1533589133590;
        Mon, 06 Aug 2018 13:58:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p5-v6sm16399921pfn.57.2018.08.06.13.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 13:58:52 -0700 (PDT)
Subject: [PATCH v2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
Date:   Mon,  6 Aug 2018 13:42:58 -0700
Message-Id: <20180806204258.22280-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806204258.22280-1-palmer@sifive.com>
References: <20180804085438.GA15840@infradead.org>
 <20180806204258.22280-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        linux-kernel@vger.kernel.org, Marcus Comstedt <marcus@mc.pp.se>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is expected to be included multiple times in the same file in
order to allow the __SYSCALL macro to generate system call tables.  With
a global include guard we end up missing __NR_riscv_flush_icache in the
syscall table, which results in icache flushes that escape the vDSO call
to not actually do anything.

The fix is to move to per-#define include guards, which allows the
system call tables to actually be populated.  Thanks to Macrus Comstedt
for finding and fixing the bug!

I also went ahead and fixed the SPDX header to use a //-style comment,
which I've been told is the canonical way to do it.

Cc: Marcus Comstedt <marcus@mc.pp.se>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/unistd.h        |  5 +++++
 arch/riscv/include/uapi/asm/syscalls.h | 15 +++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 080fb28061de..508be1780323 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -11,6 +11,11 @@
  *   GNU General Public License for more details.
  */
 
+/*
+ * There is explicitly no include guard here because this file is expected to
+ * included multiple times.  See uapi/asm/syscalls.h for more info.
+ */
+
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 #include <uapi/asm/syscalls.h>
diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/syscalls.h
index 818655b0d535..690beb002d1d 100644
--- a/arch/riscv/include/uapi/asm/syscalls.h
+++ b/arch/riscv/include/uapi/asm/syscalls.h
@@ -1,10 +1,13 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2017 SiFive
+ * Copyright (C) 2017-2018 SiFive
  */
 
-#ifndef _ASM__UAPI__SYSCALLS_H
-#define _ASM__UAPI__SYSCALLS_H
+/*
+ * There is explicitly no include guard here because this file is expected to
+ * be included multiple times in order to define the syscall macros via
+ * __SYSCALL.
+ */
 
 /*
  * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
@@ -20,7 +23,7 @@
  * caller.  We don't currently do anything with the address range, that's just
  * in there for forwards compatibility.
  */
+#ifndef __NR_riscv_flush_icache
 #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
-__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
-
 #endif
+__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
-- 
2.16.4

