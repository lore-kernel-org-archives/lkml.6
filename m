Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1DC20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DqK5Ig91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1DC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeLMPnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:43:03 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:36980 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLMPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:43:02 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3100524E09A1;
        Thu, 13 Dec 2018 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544715782; bh=7tASyAVQySDEh0uRDpTStWPhqTXJnQrKKFgtCmkxmqE=;
        h=From:To:Cc:Subject:Date:From;
        b=DqK5Ig91Fq+QrkLnASCBdELeU4gRaHlAnnKHDsNbuPoTJSJprJWeRl+eT76lJ3WkR
         qQYrfhk2arVPy4M2eTb2MewSaIRon26RAyLZ/ji5L19hEKkN1gIrM02ghCZRn1U5Xf
         +hLJNVatwjfT6DKRxFOwiZ8TNMN63BpWTLe0YI/1+bISEm2UeeXj8N7SCV2oMatGVQ
         FkLckcf3bq+jsAbdeEpO4dm+haS7snoqv3NDZ/erS4HofNbBhQmb68wOO8BBDOCq5q
         GhZsOKTenCt2GlJk5m9ZjqkqQVZGTgpC3E86VE/G76UuTnsIt+e46SnzEc1eI5+Oj/
         6qzUM88xfegEQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 03E603DB2;
        Thu, 13 Dec 2018 07:42:59 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: fix __ffs return value to avoid build warnings
Date:   Thu, 13 Dec 2018 18:42:57 +0300
Message-Id: <20181213154257.23033-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __ffs return value from 'int' to 'unsigned long' as it
is done in other implementations (like asm-generic, x86, etc...)
to avoid build-time warnings in places where type is strictly
checked.

As __ffs may return values in [0-31] interval changing return
type to unsigned is valid.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/bitops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 8da87feec59a..99e6d8948f4a 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -340,7 +340,7 @@ static inline __attribute__ ((const)) int __fls(unsigned long x)
 /*
  * __ffs: Similar to ffs, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __ffs(unsigned long word)
+static inline __attribute__ ((const)) unsigned long __ffs(unsigned long word)
 {
 	if (!word)
 		return word;
@@ -400,9 +400,9 @@ static inline __attribute__ ((const)) int ffs(unsigned long x)
 /*
  * __ffs: Similar to ffs, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __ffs(unsigned long x)
+static inline __attribute__ ((const)) unsigned long __ffs(unsigned long x)
 {
-	int n;
+	unsigned long n;
 
 	asm volatile(
 	"	ffs.f	%0, %1		\n"  /* 0:31; 31(Z) if src 0 */
-- 
2.14.5

