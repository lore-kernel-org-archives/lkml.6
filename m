Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ql2MFgpRGltFAgAAmS7hNA
	; Fri, 08 Jun 2018 09:48:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 45754606FA; Fri,  8 Jun 2018 09:48:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B5DFF60290;
	Fri,  8 Jun 2018 09:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5DFF60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeFHJsz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:48:55 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:32806 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeFHJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:48:54 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id w9or1x00F3XaVaC069orKp; Fri, 08 Jun 2018 11:48:52 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fRE0p-0003Dk-3R; Fri, 08 Jun 2018 11:48:51 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fRE0p-0005YZ-6a; Fri, 08 Jun 2018 11:48:51 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] media: fsl-viu: Use proper check for presence of {out,in}_be32()
Date: Fri,  8 Jun 2018 11:48:48 +0200
Message-Id: <1528451328-21316-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compile-testing on m68k or microblaze:

    drivers/media/platform/fsl-viu.c:41:1: warning: "out_be32" redefined
    drivers/media/platform/fsl-viu.c:42:1: warning: "in_be32" redefined

Fix this by replacing the check for PowerPC by checks for the presence
of {out,in}_be32().

As PowerPC implements the be32 accessors using inline functions instead
of macros, identity definions are added for all accessors to make the
above checks work.

Fixes: 29d750686331a1a9 ("media: fsl-viu: allow building it with COMPILE_TEST")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested on m68k, microblaze, and powerpc.
Assembler output before/after compared for powerpc.
---
 arch/powerpc/include/asm/io.h    | 14 ++++++++++++++
 drivers/media/platform/fsl-viu.c |  4 +++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index e0331e7545685c5f..3741183ae09349f1 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -222,6 +222,20 @@ static inline void out_be64(volatile u64 __iomem *addr, u64 val)
 #endif
 #endif /* __powerpc64__ */
 
+#define in_be16 in_be16
+#define in_be32 in_be32
+#define in_be64 in_be64
+#define in_le16 in_le16
+#define in_le32 in_le32
+#define in_le64 in_le64
+
+#define out_be16 out_be16
+#define out_be32 out_be32
+#define out_be64 out_be64
+#define out_le16 out_le16
+#define out_le32 out_le32
+#define out_le64 out_le64
+
 /*
  * Low level IO stream instructions are defined out of line for now
  */
diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index e41510ce69a40815..5d5e030c9c980647 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -37,8 +37,10 @@
 #define VIU_VERSION		"0.5.1"
 
 /* Allow building this driver with COMPILE_TEST */
-#ifndef CONFIG_PPC
+#ifndef out_be32
 #define out_be32(v, a)	iowrite32be(a, (void __iomem *)v)
+#endif
+#ifndef in_be32
 #define in_be32(a)	ioread32be((void __iomem *)a)
 #endif
 
-- 
2.7.4
