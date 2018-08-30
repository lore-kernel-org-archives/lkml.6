Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD1DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CEF2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CEF2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeH3PJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:09:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44949 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeH3PJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:09:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UB7RVb1731422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 04:07:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UB7Rw11731419;
        Thu, 30 Aug 2018 04:07:27 -0700
Date:   Thu, 30 Aug 2018 04:07:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Uros Bizjak <tipbot@zytor.com>
Message-ID: <tip-26e609eccd37967d3681662433086894830c5d62@git.kernel.org>
Cc:     ubizjak@gmail.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: ubizjak@gmail.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180814165951.13538-1-ubizjak@gmail.com>
References: <20180814165951.13538-1-ubizjak@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/asm: Use CC_SET()/CC_OUT() in
 __gen_sigismember()
Git-Commit-ID: 26e609eccd37967d3681662433086894830c5d62
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

Commit-ID:  26e609eccd37967d3681662433086894830c5d62
Gitweb:     https://git.kernel.org/tip/26e609eccd37967d3681662433086894830c5d62
Author:     Uros Bizjak <ubizjak@gmail.com>
AuthorDate: Tue, 14 Aug 2018 18:59:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 13:02:31 +0200

x86/asm: Use CC_SET()/CC_OUT() in __gen_sigismember()

Replace open-coded set instructions with CC_SET()/CC_OUT().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180814165951.13538-1-ubizjak@gmail.com

---
 arch/x86/include/asm/signal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 5f9012ff52ed..33d3c88a7225 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -39,6 +39,7 @@ extern void do_signal(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
 
+#include <asm/asm.h>
 #include <uapi/asm/sigcontext.h>
 
 #ifdef __i386__
@@ -86,9 +87,9 @@ static inline int __const_sigismember(sigset_t *set, int _sig)
 
 static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
-	unsigned char ret;
-	asm("btl %2,%1\n\tsetc %0"
-	    : "=qm"(ret) : "m"(*set), "Ir"(_sig-1) : "cc");
+	bool ret;
+	asm("btl %2,%1" CC_SET(c)
+	    : CC_OUT(c) (ret) : "m"(*set), "Ir"(_sig-1));
 	return ret;
 }
 
