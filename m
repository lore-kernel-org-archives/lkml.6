Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95987C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4647427F3B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvIywzug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4647427F3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeF2O3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:29:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36378 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeF2O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:29:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so9052809wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1N+04Ic2OsNBUmOIWeshT9OytxHXapMpCHr/Ww1+1jI=;
        b=EvIywzugSVRG1pxLfNniOKj4IoT4Wubw9KubVwIq+R68705Zs5YkvWjUjQGw0EB1lx
         qxgaTqJzs8zwne4TaecvQSeiptSioSLBcMTC2wYILsEVfqDut5Qth2LUKQAh0JXIJNDu
         drKi2QcLOCBco961RGdicIdTEvOkHO17gnovGUujSHnVCK5enRopo8dB4/15NcyKBRvt
         XaglaHWFLdszH5ufVUQFNfcoNyABGyUgr+H2qIfbFvJ8cUIGnaTcvnmQlpFqoiQkhOFa
         J8r9IrcnghA9LRBXfX5x/RDVimhbnaQaVXjSROo0XmErzzWq9jkWAyWo2+BVr5qEYOGw
         T18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1N+04Ic2OsNBUmOIWeshT9OytxHXapMpCHr/Ww1+1jI=;
        b=aXxfQ2a2lSlxGj7IFcA9nQfIw4p5XUoPSRHyCATlU9XQ0/R6XEEpgSGQvX5NucQi4x
         9+s1nWtARZNNBx2A86PDi9cYRWt7+I15CWkeBbGQIIKkmw4uVcHDNofxOYK11ta7bW85
         TiZs8TaIRxdxG6ZQ/clxNYyWpXSIVQlrUB9FSBetd/cZyESC0JM5IyHf/zlQ6I/7QjVm
         jf2BsRU1TAsBfIrVInM3xNAgaxZOPDLolGSgCXnQgGyiCExtZbcPzgJZX8W3zY7BR7JK
         2z6P2CotTgk7gbTvWh1MUqxdTuD66mwcTysBMMPrr75i2MsNddOD/i+iHK2aZ/ZhoDQM
         p5Pg==
X-Gm-Message-State: APt69E0xgfYCmXqv38tYI8ELTmpMpXOHJD/k9nD2T6smKoHa7iaEsTH/
        +hVMxtq+NYQLdIQ9TnBBKkT1yQ==
X-Google-Smtp-Source: AAOMgpfZffnZMLZ70IbfHmc2inZf9/L/ryKPpBDMcp/Eojn107b02sXHynGosQI7RHGZqeeASodLdA==
X-Received: by 2002:adf:a0b3:: with SMTP id m48-v6mr12138265wrm.125.1530282547283;
        Fri, 29 Jun 2018 07:29:07 -0700 (PDT)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id s124-v6sm1930484wmf.47.2018.06.29.07.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 07:29:06 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86, asm, boot: Use CC_SET()/CC_OUT() in arch/x86/boot/
Date:   Fri, 29 Jun 2018 16:28:44 +0200
Message-Id: <20180629142844.15200-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove open-coded uses of set instructions to use CC_SET()/CC_OUT() in arch/x86/boot/.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/boot/bitops.h | 3 ++-
 arch/x86/boot/string.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 0d41d68131cc..2e1382486e91 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -17,6 +17,7 @@
 #define _LINUX_BITOPS_H		/* Inhibit inclusion of <linux/bitops.h> */
 
 #include <linux/types.h>
+#include <asm/asm.h>
 
 static inline bool constant_test_bit(int nr, const void *addr)
 {
@@ -28,7 +29,7 @@ static inline bool variable_test_bit(int nr, const void *addr)
 	bool v;
 	const u32 *p = (const u32 *)addr;
 
-	asm("btl %2,%1; setc %0" : "=qm" (v) : "m" (*p), "Ir" (nr));
+	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
 	return v;
 }
 
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 16f49123d747..c4428a176973 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/types.h>
+#include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
 
@@ -28,8 +29,8 @@
 int memcmp(const void *s1, const void *s2, size_t len)
 {
 	bool diff;
-	asm("repe; cmpsb; setnz %0"
-	    : "=qm" (diff), "+D" (s1), "+S" (s2), "+c" (len));
+	asm("repe; cmpsb" CC_SET(nz)
+	    : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 
-- 
2.17.1

