Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E325C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146B2214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146B2214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQMJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:09:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34600 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeJQMJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:09:28 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 848C0133E9F81;
        Tue, 16 Oct 2018 21:15:46 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:15:45 -0700 (PDT)
Message-Id: <20181016.211545.1487970139012324624.davem@davemloft.net>
To:     acme@redhat.com
CC:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Add Sparc jitdump support.
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Oct 2018 21:15:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 tools/perf/arch/sparc/Makefile | 2 ++
 tools/perf/util/genelf.h       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 7fbca175099e..275dea7ff59a 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,3 +1,5 @@
 ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
+
+PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index de322d51c7fe..b72440bf9a79 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -29,6 +29,12 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__powerpc__)
 #define GEN_ELF_ARCH	EM_PPC
 #define GEN_ELF_CLASS	ELFCLASS32
+#elif defined(__sparc__) && defined(__arch64__)
+#define GEN_ELF_ARCH	EM_SPARCV9
+#define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__sparc__)
+#define GEN_ELF_ARCH	EM_SPARC
+#define GEN_ELF_CLASS	ELFCLASS32
 #else
 #error "unsupported architecture"
 #endif
-- 
2.19.1.328.g5a0cc8aca

