Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0AC20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBVOnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:43:24 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:51429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBVOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:43:23 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLA6k-1ggD7c2B8s-00IEXc; Fri, 22 Feb 2019 15:43:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     natechancellor@gmail.com, ndesaulniers@google.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: avoid clang warning about self-assignment
Date:   Fri, 22 Feb 2019 15:42:23 +0100
Message-Id: <20190222144301.3516708-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3vMyVhA/NmVqE8rVfJt7N/FIr5UNMdS5rMFHSOEzM3LfFmczuSG
 EzAhqToaSsNSdgXGQsijk7viVCnMc7EEKtj1uIaDoFTYr8f16BtiaZ/FdzEenc+spaitemW
 +E61FF0sTXICXZQaJwFD3iiKxXLaNf9E+YwRfuVvxArXKSh09EJfik25dgqHLqzC9Pkhema
 GiviClDZF+/BliRAHNftg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pUS0q+W4c4E=:E90vViuwwtsZ9RWcqz+rmP
 X+CtVWP0w8KbG6uCQiAEFb8tJdRb9yg9x72I8fXOyzTKUzO0ngS6EduS+17FyD3sh7Yqzs8ei
 9cNqtjRpaaUtOpoTGSVmTzcqHWBaoyU7XF6vmy2DoCl8hXoB9MHThBVXDnynh+nZPWF4hLCIL
 KoMQUOCARFPR7ewCyAKlOXD/jB49Miz1HVe1Ktq3s9A8Td04/i+BdfXm71sBLyhLFEVx+vJ+C
 rfEbz9/9idvSn/gdmiCIo1LQrqawsdT5CLyWmM1KTXBtififY1juoNujhgx/1JWxfdbBoxZcY
 CVZSttvrLRel0O1BbtRiBRVAzFPxC5Iaq3TKWBGGMKnPosflrx5dHY4hq4jxH+4yQizpiVvYe
 +1Uxw89GKpIcsbNqJtC+XgytymnUB0GROoXamayNUI2gCCaQFFt5ogiyeHv7HQ59oecG0yzcz
 unHt4ecf1ynVcQWwDjV5MPYR6zHO20i+pntYYiGnJast5JoimOhxXbuEWL0W4IDO8fuNFVoFa
 EYQTxYZQ8T+WHlgCghuJW3O4DED8M8WmgljPt6bcs4r07acH26kupzy2k7tJZ1XaMjkSpbbL/
 i4jiDys7460v7AGGaAO6zu/Fw4htWneuDzcg4N2nemNL6NdEDXIxPe+X2gCrdUVsLs3tokhq6
 LKVC5QcRE5ZhTTb0ke2LIRTPPdd7zR6mPkNfw26E6PSJGN3g8FvCONrgrEpLvd0E3wqux4Eks
 LrMqSATVcEFs48lJ7QOZGL7TJFyy3oC7jKwZRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building a preprocessed source file for arm64 now always produces
a warning with clang because of the page_to_virt() macro assigning
a variable to itself.

Adding a new temporary variable avoids this issue.

Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/memory.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b01ef0180a03..290195168bb3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -312,8 +312,9 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define page_to_virt(page)	({					\
 	unsigned long __addr =						\
 		((__page_to_voff(page)) | PAGE_OFFSET);			\
-	__addr = __tag_set(__addr, page_kasan_tag(page));		\
-	((void *)__addr);						\
+	unsigned long __addr_tag =					\
+		 __tag_set(__addr, page_kasan_tag(page));		\
+	((void *)__addr_tag);						\
 })
 
 #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
-- 
2.20.0

