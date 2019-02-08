Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9455C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48C020863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="M61Sg1II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBHPC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:02:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:21083 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfBHPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:02:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43wz2619x9z9vBxV;
        Fri,  8 Feb 2019 16:02:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=M61Sg1II; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zHG7QCYHBWWY; Fri,  8 Feb 2019 16:02:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43wz2606Zjz9vBxT;
        Fri,  8 Feb 2019 16:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1549638174; bh=oNW1cjqNraLzYK6Kh8uFIYVP1M6z46QbE9hpGbjPuM4=;
        h=From:Subject:To:Cc:Date:From;
        b=M61Sg1IIWrtqlKJKrthI1aJM1BEbxYs7yYyato/T7F5JpWTmzQThz6qFv0gdEeqIg
         ZXfCt7K9bPUqH/tnq7AxWtgtNx8LkrFWweVMDRelTQoadpaApcSBZRhShZCqpEi3Wh
         cnJWzhxSRKVRIeza3cruB7+y5Kdwdcd/7E3Ibg4Q=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E4948B8DF;
        Fri,  8 Feb 2019 16:02:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id snUdZqBBPijt; Fri,  8 Feb 2019 16:02:55 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BE468B756;
        Fri,  8 Feb 2019 16:02:55 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 49CB4656D3; Fri,  8 Feb 2019 15:02:55 +0000 (UTC)
Message-Id: <59dbb1bc305068dd0fe8e2d5a75c4213e0134549.1549638049.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] tools/selftest/vm: allow choosing mem size and page size in
 map_hugetlb
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Date:   Fri,  8 Feb 2019 15:02:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

map_hugetlb maps 256Mbytes of memory with default hugepage size.

This patch allows the user to pass the size and page shift as an
argument in order to use different size and page size.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 tools/testing/selftests/vm/map_hugetlb.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 9b777fa95f09..5a2d7b8efc40 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -23,6 +23,14 @@
 #define MAP_HUGETLB 0x40000 /* arch specific */
 #endif
 
+#ifndef MAP_HUGE_SHIFT
+#define MAP_HUGE_SHIFT 26
+#endif
+
+#ifndef MAP_HUGE_MASK
+#define MAP_HUGE_MASK 0x3f
+#endif
+
 /* Only ia64 requires this */
 #ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
@@ -58,12 +66,29 @@ static int read_bytes(char *addr)
 	return 0;
 }
 
-int main(void)
+int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t length = LENGTH;
+	int flags = FLAGS;
+	int shift = 0;
+
+	if (argc > 1)
+		length = atol(argv[1]) << 20;
+	if (argc > 2) {
+		shift = atoi(argv[2]);
+		if (shift)
+			flags |= (shift & MAP_HUGE_MASK) << MAP_HUGE_SHIFT;
+	}
+
+	if (shift)
+		printf("%u kB hugepages\n", 1 << shift);
+	else
+		printf("Default size hugepages\n");
+	printf("Mapping %lu Mbytes\n", (unsigned long)length >> 20);
 
-	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, -1, 0);
+	addr = mmap(ADDR, length, PROTECTION, flags, -1, 0);
 	if (addr == MAP_FAILED) {
 		perror("mmap");
 		exit(1);
-- 
2.13.3

