Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001EFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE6220881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VpxmEqZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfA2Kt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:49:59 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:43328 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbfA2Ktz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:49:55 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 0403124E1718;
        Tue, 29 Jan 2019 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548758995; bh=gp9/AEoNo/BmClLhSdVvfGrL9375u+uThQLB9UExYDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpxmEqZiG+jUJPydx/0Aa+URcJ86T+f5XU3KsB3Y1dYOshVmjgco/dc3Di4yVTA+i
         1PBhvRyqRdUUTmi3y0qaD1L1Ec5SC2dxRKFkRZpl9I/Xq4o2zjbXUcWqEpWJ/Ec0wU
         Px2qmYGiEcoa201W6UmvHY73N/XIXAzN3tAayRKu0yJPts3DaVEK8vzZXat6KGNtvr
         8lGjvWCa1Kt0FwxoEIDBXjFaZY/4qK5TENzHDUAPrTwMtYcaIYA9jOQpJAuw0PxeuW
         L9zMdJh08VpNl9zy5rJShoKobpF+RucZvE7B1A4rnfYDR3WjWQFvP/I/u482yTOidn
         7WU7e92h3OoJw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id A473FA0070;
        Tue, 29 Jan 2019 10:49:53 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 5/5] ARCv2: LIB: MEMCPY: fixed and optimised routine
Date:   Tue, 29 Jan 2019 13:49:42 +0300
Message-Id: <20190129104942.31705-6-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise code to use efficient unaligned memory access which is
available on ARCv2. This allows us to really simplify memcpy code
and speed up the code one and a half times (in case of unaligned
source or destination).

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                      |  4 +++
 arch/arc/lib/Makefile                 |  5 +++-
 arch/arc/lib/memcpy-archs-unaligned.S | 46 +++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/lib/memcpy-archs-unaligned.S

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index a1d976c612a6..88f1a3205b8f 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -396,6 +396,10 @@ config ARC_USE_UNALIGNED_MEM_ACCESS
 	  which is disabled by default. Enable unaligned access in
 	  hardware and use it in software.
 
+#dummy symbol for using in makefile
+config ARC_NO_UNALIGNED_MEM_ACCESS
+	def_bool !ARC_USE_UNALIGNED_MEM_ACCESS
+
 config ARC_HAS_LL64
 	bool "Insn: 64bit LDD/STD"
 	help
diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile
index b1656d156097..59cc8b61342e 100644
--- a/arch/arc/lib/Makefile
+++ b/arch/arc/lib/Makefile
@@ -8,4 +8,7 @@
 lib-y	:= strchr-700.o strcpy-700.o strlen.o memcmp.o
 
 lib-$(CONFIG_ISA_ARCOMPACT)	+= memcpy-700.o memset.o strcmp.o
-lib-$(CONFIG_ISA_ARCV2)		+= memcpy-archs.o memset-archs.o strcmp-archs.o
+lib-$(CONFIG_ISA_ARCV2)		+= memset-archs.o strcmp-archs.o
+
+lib-$(CONFIG_ARC_NO_UNALIGNED_MEM_ACCESS)	+= memcpy-archs.o
+lib-$(CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS)	+= memcpy-archs-unaligned.o
diff --git a/arch/arc/lib/memcpy-archs-unaligned.S b/arch/arc/lib/memcpy-archs-unaligned.S
new file mode 100644
index 000000000000..e09b51d4de70
--- /dev/null
+++ b/arch/arc/lib/memcpy-archs-unaligned.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+//
+// ARCv2 memcpy implementation optimized for unaligned memory access using.
+//
+// Copyright (C) 2019 Synopsys
+// Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+
+#include <linux/linkage.h>
+
+#ifdef CONFIG_ARC_HAS_LL64
+# define LOADX(DST,RX)		ldd.ab	DST, [RX, 8]
+# define STOREX(SRC,RX)		std.ab	SRC, [RX, 8]
+# define ZOLSHFT		5
+# define ZOLAND			0x1F
+#else
+# define LOADX(DST,RX)		ld.ab	DST, [RX, 4]
+# define STOREX(SRC,RX)		st.ab	SRC, [RX, 4]
+# define ZOLSHFT		4
+# define ZOLAND			0xF
+#endif
+
+ENTRY_CFI(memcpy)
+	mov	r3, r0		; don;t clobber ret val
+
+	lsr.f	lp_count, r2, ZOLSHFT
+	lpnz	@.Lcopy32_64bytes
+	;; LOOP START
+	LOADX	(r6, r1)
+	LOADX	(r8, r1)
+	LOADX	(r10, r1)
+	LOADX	(r4, r1)
+	STOREX	(r6, r3)
+	STOREX	(r8, r3)
+	STOREX	(r10, r3)
+	STOREX	(r4, r3)
+.Lcopy32_64bytes:
+
+	and.f	lp_count, r2, ZOLAND ;Last remaining 31 bytes
+	lpnz	@.Lcopyremainingbytes
+	;; LOOP START
+	ldb.ab	r5, [r1, 1]
+	stb.ab	r5, [r3, 1]
+.Lcopyremainingbytes:
+
+	j	[blink]
+END_CFI(memcpy)
-- 
2.14.5

