Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F4CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C368E2150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368E2150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbeHBOYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:24:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbeHBOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:24:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72CXpV23500584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 05:33:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72CXpV03500581;
        Thu, 2 Aug 2018 05:33:51 -0700
Date:   Thu, 2 Aug 2018 05:33:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Uros Bizjak <tipbot@zytor.com>
Message-ID: <tip-216a37202f10b7d78f2f98e26a6681f367165f05@git.kernel.org>
Cc:     tglx@linutronix.de, ubizjak@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, ubizjak@gmail.com
In-Reply-To: <20180629142844.15200-1-ubizjak@gmail.com>
References: <20180629142844.15200-1-ubizjak@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Use CC_SET()/CC_OUT() instead of open
 coding it
Git-Commit-ID: 216a37202f10b7d78f2f98e26a6681f367165f05
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  216a37202f10b7d78f2f98e26a6681f367165f05
Gitweb:     https://git.kernel.org/tip/216a37202f10b7d78f2f98e26a6681f367165f05
Author:     Uros Bizjak <ubizjak@gmail.com>
AuthorDate: Fri, 29 Jun 2018 16:28:44 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 14:30:42 +0200

x86/boot: Use CC_SET()/CC_OUT() instead of open coding it

Remove open-coded uses of set instructions with CC_SET()/CC_OUT().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180629142844.15200-1-ubizjak@gmail.com

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
 
