Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D642CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E1F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kYQHWMMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfANPRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:17:13 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:32902 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:17:07 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6D39B10C1375;
        Mon, 14 Jan 2019 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547479027; bh=Th0aMmoqXykae17QutbAQZjcPAwhC62MQIBQ8R0lB2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYQHWMMnBA1fUitDAFQoT96nU9FmUy1p+rF98351Ox9SHT7FX8Q8egq3npLDDPLFE
         /XVkM/vipiF9syWAgQYv1gTAKEsn+FzEBW1eegyM26oAAUKKSO8fMLNXwiy8QeXdPE
         +w906TSEX4CXBWc0jcHwH1sLcbg+DqMfj569v0TcwZQTB0hRRL7ZYXn3in3v0KxxFW
         ZkHxTbGFrtBvRG7sK7NCrcRy9bApxih2FRdXN4KRWQ9/hzXZvqjcY/zndScFrIqOV0
         H6atkCZHR2Advt0b180iTm3frlwISaVMWaU0DAqojVhe2qlNalTcjaluxm6ju7BJGM
         QrqDOWHv4pstQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id C497758B3;
        Mon, 14 Jan 2019 07:17:05 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/2] ARCv2: LIB: memset: move st instruction series to macros
Date:   Mon, 14 Jan 2019 18:16:49 +0300
Message-Id: <20190114151649.32726-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190114151649.32726-1-Eugeniy.Paltsev@synopsys.com>
References: <20190114151649.32726-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move store 32 byte instruction series to macros to make code
more readable.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/lib/memset-archs.S | 63 +++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/arch/arc/lib/memset-archs.S b/arch/arc/lib/memset-archs.S
index c7717832336f..4a0d562d23cd 100644
--- a/arch/arc/lib/memset-archs.S
+++ b/arch/arc/lib/memset-archs.S
@@ -31,6 +31,24 @@
 # endif
 #endif /* L1_CACHE_SHIFT!=6 */
 
+.macro MEMSET_32BYTE		val, adr
+#ifdef CONFIG_ARC_HAS_LL64
+	std.ab	\val, [\adr, 8]
+	std.ab	\val, [\adr, 8]
+	std.ab	\val, [\adr, 8]
+	std.ab	\val, [\adr, 8]
+#else
+	st.ab	\val, [\adr, 4]
+	st.ab	\val, [\adr, 4]
+	st.ab	\val, [\adr, 4]
+	st.ab	\val, [\adr, 4]
+	st.ab	\val, [\adr, 4]
+	st.ab	\val, [\adr, 4]
+	st.ab	\val, [\adr, 4]
+	st.ab	\val, [\adr, 4]
+#endif
+.endm
+
 ENTRY_CFI(memset)
 	PREFETCHW_INSTR([r0])	; Prefetch the first write location
 	mov.f	0, r2
@@ -70,53 +88,14 @@ ENTRY_CFI(memset)
 	lpnz	@.Lset64bytes
 	;; LOOP START
 	PREALLOC_INSTR([r3, 64]) ;Prefetch the next write location
-#ifdef CONFIG_ARC_HAS_LL64
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-#else
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-#endif
+	MEMSET_32BYTE	r4, r3
+	MEMSET_32BYTE	r4, r3
 .Lset64bytes:
 
 	lsr.f	lp_count, r2, 5 ;Last remaining  max 124 bytes
 	lpnz	.Lset32bytes
 	;; LOOP START
-#ifdef CONFIG_ARC_HAS_LL64
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-	std.ab	r4, [r3, 8]
-#else
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-	st.ab	r4, [r3, 4]
-#endif
+	MEMSET_32BYTE	r4, r3
 .Lset32bytes:
 
 	and.f	lp_count, r2, 0x1F ;Last remaining 31 bytes
-- 
2.14.5

