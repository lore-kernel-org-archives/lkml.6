Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B051C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CD32087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8WOz+WG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CD32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJIIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeJIIJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:09:12 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164D921476;
        Tue,  9 Oct 2018 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539046490;
        bh=bBPg5+B7Vfas0dN4aWxafvLyD4hqAb2KQYLBAKYvJIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8WOz+WGW2s6u1eV1azXnDABEqt0zSzjtcgUAWnKL2UM8Eyhf9FsW0vWE6Q0aXghB
         X3k13Gccl37Ql9qeUVU/4tlxr5Nc6kyKdNNdf2tGpFrgfUk/Jn2B9W9RoF4nz1TFoS
         CwDSw9T2vYojbMGfhTyd3+/nwAm8iwDgwJjeVBvg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/12] tools include: Adopt linux/bits.h
Date:   Mon,  8 Oct 2018 21:54:16 -0300
Message-Id: <20181009005427.6607-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we reduce the difference of tools/include/linux/bitops.h to the
original kernel file, include/linux/bitops.h, trying to remove the need
to define BITS_PER_LONG, to avoid clashes with asm/bitsperlong.h.

And the things removed from tools/include/linux/bitops.h are really in
linux/bits.h, so that we can have a copy and then
tools/perf/check_headers.sh will tell us when new stuff gets added to
linux/bits.h so that we can check if it is useful and if any adjustment
needs to be done to the tools/{include,arch}/ copies.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-y1sqyydvfzo0bjjoj4zsl562@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bitops.h |  7 ++-----
 tools/include/linux/bits.h   | 26 ++++++++++++++++++++++++++
 tools/perf/check-headers.sh  |  1 +
 3 files changed, 29 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/linux/bits.h

diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index acc704bd3998..0b0ef3abc966 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -3,8 +3,6 @@
 #define _TOOLS_LINUX_BITOPS_H_
 
 #include <asm/types.h>
-#include <linux/compiler.h>
-
 #ifndef __WORDSIZE
 #define __WORDSIZE (__SIZEOF_LONG__ * 8)
 #endif
@@ -12,10 +10,9 @@
 #ifndef BITS_PER_LONG
 # define BITS_PER_LONG __WORDSIZE
 #endif
+#include <linux/bits.h>
+#include <linux/compiler.h>
 
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BITS_PER_BYTE		8
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
 #define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
new file mode 100644
index 000000000000..2b7b532c1d51
--- /dev/null
+++ b/tools/include/linux/bits.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BITS_H
+#define __LINUX_BITS_H
+#include <asm/bitsperlong.h>
+
+#define BIT(nr)			(1UL << (nr))
+#define BIT_ULL(nr)		(1ULL << (nr))
+#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
+#define BITS_PER_BYTE		8
+
+/*
+ * Create a contiguous bitmask starting at bit position @l and ending at
+ * position @h. For example
+ * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
+ */
+#define GENMASK(h, l) \
+	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+
+#define GENMASK_ULL(h, l) \
+	(((~0ULL) - (1ULL << (l)) + 1) & \
+	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+
+#endif	/* __LINUX_BITS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 466540ee8ea7..c72cc73a6b09 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -14,6 +14,7 @@ include/uapi/linux/sched.h
 include/uapi/linux/stat.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
+include/linux/bits.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
-- 
2.14.4

