Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76996C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3374520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0Vwo7+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3374520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeLFMZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:25:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38778 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeLFMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so299303wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkvfG/IDbgZMxYwPX5lSFsN5elmH6vlYt7vVIn43a0U=;
        b=a0Vwo7+R9UWJKWhJ5tdXON+TcRVk8bAd3GrGkAupa9U7c521S0OEfq/71bnrAZ7YI9
         qO3e/k1mYl3KHhZ9c+3uOMl2aTRoIRr9SlDaXPW4D8lhbk32Md5fm2bGf9/zOG/6Meus
         zm9A28pu+SVWQtklpcqHi8Gz496+QwhVd5wIpCU6J9hBR5i/FXMe9o6PAjf92B1EtKkE
         wUnBhqf9UhEVYjxuBsO+8OlgbhSabAPKLFgHzoSxcvnZIIVzwQ57/4kGb0byLGwVIbuw
         xb9Pb7kljtzchG8AcB3Q6RRRggT61OjCQ6QMRyg3/B9mgLgiuUws4cV863SNS0HtMxy3
         ebpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkvfG/IDbgZMxYwPX5lSFsN5elmH6vlYt7vVIn43a0U=;
        b=VAsMS4gePG153599UbrvfZD7K6HghA5Im9Q1DloUyIR6/oQ1eWvK92S5ccUlCDonpv
         iW1Y3ZFL/R+5RQKDjmgJtkNeVJ/JOkMF6xY6q/ycy13hw8sr85BpHePAARKU2JpUAvEU
         RFyl8C16RCdbwkA/mW2jMv8p27mpHmtUKyAoLMeoJKMlixV30eOLTfVRx7pMuqPxtYpf
         lfpJ0DamJrlm0rz5Egfkg8JxVP4gmWBhMOwI2GtMxMpwSiOFFGByg7RM2coO1jiFSkem
         H25YohHTC5ujOtvx9KjFx9dsVSHIOrDNsuR9nnj8gYKeFynYqCzC8NX5grG7atcyzlqA
         nR/w==
X-Gm-Message-State: AA+aEWZCr979aauzDP2Vo+mb17GCejzyINlFCdKbnn/PbUcYnx+9TSpr
        ORUBVuspQR06ApLoJpREh6D7Pg==
X-Google-Smtp-Source: AFSGD/W4zA6BXuDW4nuwEjrxAwEtRH7jwb51mwQJbpOgSMlyeciRxEfja88tx3NW2n/I+jUstCLcCg==
X-Received: by 2002:adf:b243:: with SMTP id y3mr10683692wra.184.1544099111278;
        Thu, 06 Dec 2018 04:25:11 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:10 -0800 (PST)
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
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v13 14/25] kasan, arm64: enable top byte ignore for the kernel
Date:   Thu,  6 Dec 2018 13:24:32 +0100
Message-Id: <f51eca084c8cdb2f3a55195fe342dc8953b7aead.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag-based KASAN uses the Top Byte Ignore feature of arm64 CPUs to store a
pointer tag in the top byte of each pointer. This commit enables the
TCR_TBI1 bit, which enables Top Byte Ignore for the kernel, when tag-based
KASAN is used.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/mm/proc.S                   | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 1d7d8da2ef9b..d43b870c39b3 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -291,6 +291,7 @@
 #define TCR_A1			(UL(1) << 22)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
+#define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
 #define TCR_NFD1		(UL(1) << 54)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..d861f208eeb1 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -47,6 +47,12 @@
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define TCR_KASAN_FLAGS TCR_TBI1
+#else
+#define TCR_KASAN_FLAGS 0
+#endif
+
 #define MAIR(attr, mt)	((attr) << ((mt) * 8))
 
 /*
@@ -445,7 +451,7 @@ ENTRY(__cpu_setup)
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
-- 
2.20.0.rc1.387.gf8505762e3-goog

