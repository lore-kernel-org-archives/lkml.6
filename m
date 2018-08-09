Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF53C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A812150C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SoOcQ8WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A812150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHIXKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:10:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46592 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHIXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:10:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so3274973pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=5s2EFOPI3Lw2TWRp42epal20VPIJgp5Jq9rU6QSAInk=;
        b=SoOcQ8WZ8GOiNfDd+7yQWXl6a3sYz3CfvtevZBxBHatU5qnSRupt7RpKChYxOu5cJE
         /99hp8atQP2vFGk7yjuT5YTKyrw5E5U+gMWJdlNqE6G+jpRu9DcqkhQhmoeqMnTxXS/d
         4grwqxiynjVZdvW7SKIL8cHBdThM8YXI2jMGsLZAq9nO3RhGwdNNw/Bq58fr6Il4FSZv
         ZTy9LRDWcGuUMLl3GBd3NATv/BaiVY5eWDDu8acGNb+in0/vINsmI3fNDafJ8UcmYWFF
         fgzox5RX+DlM+EmsrjUxxoJiEEiA5Khwm4J7u1aTMunu5TM7mP5UYVJ/iDYSCsDlCf73
         obzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=5s2EFOPI3Lw2TWRp42epal20VPIJgp5Jq9rU6QSAInk=;
        b=gKSd7Dy7c49xJ/2zOzR8DgDeJ2gqw297ORomYCWAe6hpXnfG/eL6xUhCgsD4LPp996
         hbIb5Y6hKz88E/fSLxFgnfRq8DGdsLwaxw7nUwZoC3l1ydXIF7NkRgw3+E5P+EfmS+P3
         Al9TC79rTUAsCZHW8n5PhFgeyMndl6/pklHUnAyTcMZiz2PeGc7BbG/oN7ejLSDIhaHA
         lNT2niNhb4zQk+6YK/Gs8IYalLeFGH9HYO9WGNI3TnfmgoSgUeEqAUinRJb+WyMDewtx
         YN2Ol2gWdqczqdLcmOVfkBDgwNSzZcGbyrgbVQBZrHih6RreTc+JaTWfVwvoFSXKsKiY
         gVVg==
X-Gm-Message-State: AOUpUlE25KBCTn79ppP14d5HDJShOHnFHj9ABpyq0UrXZ9yDP99Pzub6
        0cqCsFppdOijdF+iMagRCYRucQ==
X-Google-Smtp-Source: AA+uWPzJZsJcg80Lbb56G4AodsV1XAEPsQkcZlbgxi/BV8wjRIMw7W/thNcXDsEOEXtOddZNPQqo9g==
X-Received: by 2002:a62:d8c:: with SMTP id 12-v6mr3950776pfn.202.1533847423095;
        Thu, 09 Aug 2018 13:43:43 -0700 (PDT)
Received: from localhost ([96.76.210.210])
        by smtp.gmail.com with ESMTPSA id y27-v6sm19969250pff.181.2018.08.09.13.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:43:42 -0700 (PDT)
Subject: [PATCH v2 2/2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
Date:   Thu,  9 Aug 2018 13:25:24 -0700
Message-Id: <20180809202524.1702-3-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180809202524.1702-1-palmer@sifive.com>
References: <20180809202524.1702-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marcus Comstedt <marcus@mc.pp.se>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net
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
index 080fb28061de..0caea01d5cca 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -11,6 +11,11 @@
  *   GNU General Public License for more details.
  */
 
+/*
+ * There is explicitly no include guard here because this file is expected to
+ * be included multiple times.  See uapi/asm/syscalls.h for more info.
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

