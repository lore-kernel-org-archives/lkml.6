Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D9FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0090520854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0090520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIJLB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:01:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64370 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbeIJLB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:01:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 427yKh65RCz9ttC6;
        Mon, 10 Sep 2018 08:08:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ykOD0Hv_CX6p; Mon, 10 Sep 2018 08:08:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 427yKh5NfGz9ttC1;
        Mon, 10 Sep 2018 08:08:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F0D28B786;
        Mon, 10 Sep 2018 08:09:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HZo1TpesSKTh; Mon, 10 Sep 2018 08:09:05 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 002618B74B;
        Mon, 10 Sep 2018 08:09:04 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DD365715BA; Mon, 10 Sep 2018 06:09:04 +0000 (UTC)
Message-Id: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: fix csum_ipv6_magic() on little endian platforms
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jianlin Shi <jishi@redhat.com>, Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org
Date:   Mon, 10 Sep 2018 06:09:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On little endian platforms, csum_ipv6_magic() keeps len and proto in
CPU byte order. This generates a bad results leading to ICMPv6 packets
from other hosts being dropped by powerpc64le platforms.

In order to fix this, len and proto should be converted to network
byte order ie bigendian byte order. However checksumming 0x12345678
and 0x56341278 provide the exact same result so it is enough to
rotate the sum of len and proto by 1 byte.

PPC32 only support bigendian so the fix is needed for PPC64 only

Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
Reported-by: Jianlin Shi <jishi@redhat.com>
Reported-by: Xin Long <lucien.xin@gmail.com>
Cc: <stable@vger.kernel.org> # 4.18+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/checksum_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 886ed94b9c13..2a68c43e13f5 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -443,6 +443,9 @@ _GLOBAL(csum_ipv6_magic)
 	addc	r0, r8, r9
 	ld	r10, 0(r4)
 	ld	r11, 8(r4)
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	rotldi	r5, r5, 8
+#endif
 	adde	r0, r0, r10
 	add	r5, r5, r7
 	adde	r0, r0, r11
-- 
2.13.3

