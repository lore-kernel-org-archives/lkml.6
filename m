Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B01C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6A92083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6A92083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dei.uc.pt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIBAjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 20:39:24 -0400
Received: from smtp.dei.uc.pt ([193.137.203.253]:47968 "EHLO smtp.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeIBAjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 20:39:24 -0400
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Sep 2018 20:39:23 EDT
Received: from localhost.localdomain (bl28-130-220.dsl.telepac.pt [37.189.130.220] (may be forged))
        (user=sneves@dei.uc.pt mech=LOGIN bits=0)
        by smtp.dei.uc.pt (8.15.2/8.15.2) with ESMTPSA id w81KF2lU030121
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Sep 2018 21:15:14 +0100
From:   Samuel Neves <sneves@dei.uc.pt>
To:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Samuel Neves <sneves@dei.uc.pt>, x86@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] x86/vdso: fix lsl operand order
Date:   Sat,  1 Sep 2018 21:14:52 +0100
Message-Id: <20180901201452.27828-1-sneves@dei.uc.pt>
X-Mailer: git-send-email 2.17.1
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: w81KF2lU030121
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-60.1, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, L_SMTP_AUTH -50.00)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the __getcpu function, lsl was using the wrong target
and destination registers. Luckily, the compiler tends to
choose %eax for both variables, so it has been working
so far.

Cc: x86@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
---
 arch/x86/include/asm/vgtod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fb856c9f0449..53748541c487 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -93,7 +93,7 @@ static inline unsigned int __getcpu(void)
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[p],%[seg]",
+	alternative_io ("lsl %[seg],%[p]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
 			[p] "=a" (p), [seg] "r" (__PER_CPU_SEG));
-- 
2.17.1

