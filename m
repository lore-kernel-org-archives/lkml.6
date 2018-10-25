Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F91BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89B72082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89B72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJYOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:18:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeJYOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:18:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9P5jxJW3842797
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Oct 2018 22:45:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9P5jw7w3842794;
        Wed, 24 Oct 2018 22:45:58 -0700
Date:   Wed, 24 Oct 2018 22:45:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-33823f4d63f7a010653d219800539409a78ef4be@git.kernel.org>
Cc:     torvalds@linux-foundation.org, brgerst@gmail.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        dvlasenk@redhat.com, ashok.raj@intel.com, bp@alien8.de,
        fenghua.yu@intel.com, tglx@linutronix.de, ravi.v.shankar@intel.com,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org
Reply-To: ravi.v.shankar@intel.com, mingo@kernel.org, peterz@infradead.org,
          hpa@zytor.com, fenghua.yu@intel.com, tglx@linutronix.de,
          bp@alien8.de, dvlasenk@redhat.com, ashok.raj@intel.com,
          linux-kernel@vger.kernel.org, brgerst@gmail.com,
          luto@amacapital.net, torvalds@linux-foundation.org
In-Reply-To: <1540418237-125817-2-git-send-email-fenghua.yu@intel.com>
References: <1540418237-125817-2-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpufeatures: Enumerate MOVDIRI instruction
Git-Commit-ID: 33823f4d63f7a010653d219800539409a78ef4be
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

Commit-ID:  33823f4d63f7a010653d219800539409a78ef4be
Gitweb:     https://git.kernel.org/tip/33823f4d63f7a010653d219800539409a78ef4be
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Wed, 24 Oct 2018 14:57:16 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Oct 2018 07:42:48 +0200

x86/cpufeatures: Enumerate MOVDIRI instruction

MOVDIRI moves doubleword or quadword from register to memory through
direct store which is implemented by using write combining (WC) for
writing data directly into memory without caching the data.

Programmable agents can handle streaming offload (e.g. high speed packet
processing in network). Hardware implements a doorbell (tail pointer)
register that is updated by software when adding new work-elements to
the streaming offload work-queue.

MOVDIRI can be used as the doorbell write which is a 4-byte or 8-byte
uncachable write to MMIO. MOVDIRI has lower overhead than other ways
to write the doorbell.

Availability of the MOVDIRI instruction is indicated by the presence of
the CPUID feature flag MOVDIRI(CPUID.0x07.0x0:ECX[bit 27]).

Please check the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference for more details on the CPUID
feature MOVDIRI flag.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1540418237-125817-2-git-send-email-fenghua.yu@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 89a048c2faec..90934ee7b79a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -331,6 +331,7 @@
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
+#define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
