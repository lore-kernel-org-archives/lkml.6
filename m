Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E9BC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FD721A13
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OTp+BqMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FD721A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeHKSno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:43:44 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54560 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeHKSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:43:44 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2CD5610C087E;
        Sat, 11 Aug 2018 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534003745; bh=6oMecutyGk97An4ahqNcn/BG17MCKYXdRN1ejPwkub8=;
        h=From:To:Cc:Subject:Date:From;
        b=OTp+BqMRvfi7cU4mbfGExK2ATNU+Y3/QyliMhEIhxFY6LfqYGEzZmjpE1CXtMfZPk
         d4QRkZiqueWAXkxZSF7eaRK0A9ElVHgbSKSZysIiN2Mh5uUvJanlAPJdc/rpl2NLnR
         D7i/OxcI7c0T4imUA9LNk/i2pj1v1r8UMGOfMSrl4U2FGzeUVYT5lIBsiZMDA6KBew
         ra5CIdzJCg+MPCinMD2cLxvq8dYakx026cO9gGDTRpHmVnBAK52T4UR8fwZeo7ST5C
         HWCbPmDZiZLHz5nsA4bu6wWKtUfv+JBpTz+ysff1Z2qFXk851s/LDdghD4ji3scMUn
         Ah5430pm3TFGA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8FF053D01;
        Sat, 11 Aug 2018 09:09:02 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: atomic64: fix atomic64_add_unless function
Date:   Sat, 11 Aug 2018 19:08:56 +0300
Message-Id: <20180811160856.24936-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of 'atomic64_add_unless' function
(and hence 'atomic64_inc_not_zero') return incorrect value
if lover 32 bits of compared 64-bit number are equal and
higher 32 bits aren't.

For in following example atomic64_add_unless must return '1'
but it actually returns '0':
--------->8---------
atomic64_t val = ATOMIC64_INIT(0x4444000000000000LL);
int ret = atomic64_add_unless(&val, 1LL, 0LL)
--------->8---------

This happens because we write '0' to returned variable regardless
of higher 32 bits comparison result.

So fix it.

NOTE:
 this change was tested with atomic64_test.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 11859287c52a..e840cb1763b2 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -578,11 +578,11 @@ static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 
 	__asm__ __volatile__(
 	"1:	llockd  %0, [%2]	\n"
-	"	mov	%1, 1		\n"
 	"	brne	%L0, %L4, 2f	# continue to add since v != u \n"
 	"	breq.d	%H0, %H4, 3f	# return since v == u \n"
 	"	mov	%1, 0		\n"
 	"2:				\n"
+	"	mov	%1, 1		\n"
 	"	add.f   %L0, %L0, %L3	\n"
 	"	adc     %H0, %H0, %H3	\n"
 	"	scondd  %0, [%2]	\n"
-- 
2.14.4

