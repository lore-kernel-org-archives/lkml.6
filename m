Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05208C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul87aooq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF1320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbeFTRkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:40:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38639 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754604AbeFTRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:40:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so985929wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3JRyQhTdC+u2oogyIrlq2ZoH/8cj6t0szX7aMWVFrqI=;
        b=ul87aooq1BZG/ua2mVfhzy4uN/qXMn1UhnfPhLPsnejOFWAGkdptsDs3M1oTmI1nAl
         C21Guh3/JlIPOD09uCLOi/BPVDdoVIByJeGnb5+0zYUBeO6K0u2ykMy0COZIgmOz1RLu
         Zxb22xpZgwMuVJmAHzA/tiOzc8lJ9vj2KFxeTCFLKLfgUpo+M+Tm1wglu7mRA2K0TqbF
         hvnFePrjRgmAQEcYRrMUgCtAycpp9xYn8sBFpPHZv1KPp5HCnPdX3LCPU/yxR8qpU4IX
         TouAVK6EgxY9z8IBnh4SoOd7uxcao0fDK+ctG8NFDPZ/DgOTBe6PYuJ0kohJsQdfPC9g
         TxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3JRyQhTdC+u2oogyIrlq2ZoH/8cj6t0szX7aMWVFrqI=;
        b=R5N+w2Pqu84iARbQHDdzzyo59NB0koM7Z6HhFxpAWZpdRZ0oyrDmo/nHcSTZz+auXg
         iLU/Q8ho9Kddk6WLL5j7gQ65/tud41cgLh0nn7ElVBwvPeAl2IiW05oF/wr409ctMO8t
         RrBGmzntu4olBrUGqRfhhRBZ2PYNMeSMkKlOcB9ZaYbClUT9TMqnkJC6YN+q9PEpe+t/
         wdeSWsdIXkaAa7SxLBddq5kOTQ0a0gNLUccc4hnPzVxwow8lXR/MThOAajt8x+vTVlh1
         7ZguO0Jk/o7bFMRh39lA55lP8NT+vTnnAom/CtUNHq60hB/Fl94s5Y/C9BLYmv9ZIqVV
         XnGA==
X-Gm-Message-State: APt69E2Re6G4XDZ5Rrymv/3iXwovrSnymE2mJCB6vzIlLgBh87tMmhG0
        cynPpALnKhArxnsLBoTZlJc7iw==
X-Google-Smtp-Source: ADUXVKIVlEK10pHjqrgIg6B9IiEh/Scv3BRLQ1sYbPsfzIp6woFogpBtw12wTtllSZMEyn06q6NkAA==
X-Received: by 2002:a1c:4787:: with SMTP id m7-v6mr2601468wmi.92.1529516416725;
        Wed, 20 Jun 2018 10:40:16 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id f18-v6sm4388598wro.1.2018.06.20.10.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:40:15 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 06/17] khwasan, arm64: untag virt address in __kimg_to_phys and _virt_addr_is_linear
Date:   Wed, 20 Jun 2018 19:39:52 +0200
Message-Id: <44b51b47d2d0517332f37c39cb7ea0016dcf032e.1529515183.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529515183.git.andreyknvl@google.com>
References: <cover.1529515183.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
(which is used by virt_addr_valid) assume that the top byte of the address
is 0xff, which isn't always the case with KHWASAN enabled.

The solution is to reset the tag in those macros.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6d084431b7f7..e9e054dfb1fc 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -92,6 +92,13 @@
 #define KASAN_THREAD_SHIFT	0
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define KASAN_TAG_SHIFTED(tag)		((unsigned long)(tag) << 56)
+#define KASAN_SET_TAG(addr, tag)	(((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
+						KASAN_TAG_SHIFTED(tag))
+#define KASAN_RESET_TAG(addr)		KASAN_SET_TAG(addr, 0xff)
+#endif
+
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
@@ -225,7 +232,12 @@ static inline unsigned long kaslr_offset(void)
 #define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
 
 #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+
+#ifdef CONFIG_KASAN_HW
+#define __kimg_to_phys(addr)	(KASAN_RESET_TAG(addr) - kimage_voffset)
+#else
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
+#endif
 
 #define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
@@ -301,7 +313,13 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define _virt_addr_is_linear(kaddr)	(KASAN_RESET_TAG((u64)(kaddr)) >= \
+						PAGE_OFFSET)
+#else
 #define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
+#endif
+
 #define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
 					 _virt_addr_valid(kaddr))
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

