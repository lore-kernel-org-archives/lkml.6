Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16BFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6224C20877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6224C20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbeGKMMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:12:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59334 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKMMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:12:31 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MFOee-1fpH821VW0-00EJpZ; Wed, 11 Jul 2018 14:08:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ia64: use asm-generic/io.h
Date:   Wed, 11 Jul 2018 14:08:05 +0200
Message-Id: <20180711120824.3882108-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:0O5ipnYJOrcVpf3YZJ5qHfPDb9qRq7llKIN1cHiJv0RHNzxs2k+
 aIfnikcCyeiuX/TFKfUXC468MqA+ykG491GQS2nT9kVxqugrZZrota3OgoGtrBUUPdR4lmC
 fg9VT3NAaWHsoMDlKDFRZsNUSWZhci6miVjAYwZ6JFdVzpfZQPkmkaGktZet7fizrw22cYh
 CxqmB8agInPBshtxSzvPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LxRVDpJQnzc=:MEVQgcPKAqSrb/BRzFyKtA
 gXIghciRc4EZz+B8lB6Jn+wm9xW+axDpONu4p/Mb5R55wbbz1q5Ks+6Cy4M1mWkTxJwlotnlU
 NSV18mp2agctCOXvoiQjE20t+ZQRjXL/JSXMCT86KKeJp5wQze6pwZxatfKpH9mAt9SyeV2mD
 34boMdOkgDAijA3/6vaHPoSPvBxg6gGGa0hhYkWeem9R8A/0aq8Ys9Zvzeg/TBzGrJ5S5+bf3
 63YqTSNhXQDXvQWa+VSKOEhw3/wmSQsVCBm89a4ATz+cq5kBAnpr0sp5YNK4WRFqNaSqGyZL+
 K7zEBHHI03r1TieoeiBreFZJI9OVYxJ/RK2TxkrxTaT+tV6mgNQ2q81GceqYx3d0hIldls6IF
 yeA9diRM2Tmyib1vn+/8yEjc2yU64VFIwhpYiUF3V/XkEBwG+PMeP9S6g7wVaeb+k/hhd8AEa
 nUCfK6HGoXus0YCb6lgVMtOZ3lATOgSYq4kgi6Eb+MGEOaeD67IwxFXoP+nEUVtUBZBd4K/RD
 egmFyDrK/ReKRCOmB1TL0QyvlrChF4vG93zY33u/alaHnWg7ZWRbEsMhL0G4wJ3JU5sETDMzx
 a1eF6HjpKGGsmpYwhNPfCznnE1a5KwwHShJJznV4Eo4UGWuF8C4W6fvAZMPTZ2CTvOjyukJbg
 Szvl9BwtBPMn/AuEl1xKydfZNbOZQiq3SF9HLq1WL3X0YHpHYrhQYviKVlXded9aiJho=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm-generic/io.h provides a generic implementation of all I/O accessors,
which the architectures can override.

Since ia64 does not provide readsl/writesl etc, any driver using those
fails to build, and including asm-generic/io.h will provide the
missing interfaces, as well as any other future interfaces that get
added there. We need to #define a couple of symbols to themselves
in the ia64 to ensure that we use the ia64 specific version of those
rather than the generic one.

There should be no other effect than adding {read,write}s{b,w,l}()
as well as {in,out}s{b,w,l}_p(), which were also not provided
by ia64 but are provided by the generic header for historic reasons.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/asm/io.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index fb0651961e2c..6f952171abf9 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -83,12 +83,14 @@ virt_to_phys (volatile void *address)
 {
 	return (unsigned long) address - PAGE_OFFSET;
 }
+#define virt_to_phys virt_to_phys
 
 static inline void*
 phys_to_virt (unsigned long address)
 {
 	return (void *) (address + PAGE_OFFSET);
 }
+#define phys_to_virt phys_to_virt
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern u64 kern_mem_attribute (unsigned long phys_addr, unsigned long size);
@@ -433,9 +435,11 @@ static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned lo
 {
 	return ioremap(phys_addr, size);
 }
+#define ioremap ioremap
+#define ioremap_nocache ioremap_nocache
 #define ioremap_cache ioremap_cache
 #define ioremap_uc ioremap_nocache
-
+#define iounmap iounmap
 
 /*
  * String version of IO memory access ops:
@@ -444,6 +448,13 @@ extern void memcpy_fromio(void *dst, const volatile void __iomem *src, long n);
 extern void memcpy_toio(volatile void __iomem *dst, const void *src, long n);
 extern void memset_io(volatile void __iomem *s, int c, long n);
 
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
+#define memset_io memset_io
+#define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
+#define xlate_dev_mem_ptr xlate_dev_mem_ptr
+#include <asm-generic/io.h>
+
 # endif /* __KERNEL__ */
 
 #endif /* _ASM_IA64_IO_H */
-- 
2.9.0

