Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FD1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3311620815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="yJXIoeis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfACVsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:48:15 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:54134 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfACVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:48:06 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B08DB5C0DDD;
        Thu,  3 Jan 2019 22:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546552084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nm4UmKZymvFz3g4I1uxh32+ZhB2G26RZTf6BIquMT90=;
        b=yJXIoeisnxddINmwN39ZHj+JAuzeVDTn1UH/6K4YvXOHmGagmySEJzLiI2ct+79pOmhNQL
        NkN7J/DQx+puP8yB+g1pCUlAX6PgQ/MdJLWwlim5nkRVIjagqg+u7U6ZOdP2wO4jKhxD1D
        Gys+/LYDKwV5j0ns1P6pbVvBlQhc9Z0=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/3] ARM: uaccess: use unified assembler language syntax
Date:   Thu,  3 Jan 2019 22:48:14 +0100
Message-Id: <5ef2acc655abfbe8bfa2cd30ecc5c2286b8fdfa3.1546551693.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1546551693.git.stefan@agner.ch>
References: <cover.1546551693.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the conditional infix to a postfix to make sure this inline
assembly is unified syntax. Since gcc assumes non-unified syntax
when emitting ARM instructions, make sure to define the syntax as
unified.

This allows to use LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- Explicitly use unified syntax for inline assembly


 arch/arm/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 6390a40f16e7..a50f9b4e2574 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -86,7 +86,8 @@ static inline void set_fs(mm_segment_t fs)
 #define __range_ok(addr, size) ({ \
 	unsigned long flag, roksum; \
 	__chk_user_ptr(addr);	\
-	__asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
+	__asm__(".syntax unified\n" \
+		"adds %1, %2, %3; sbcscc %1, %1, %0; movcc %0, #0" \
 		: "=&r" (flag), "=&r" (roksum) \
 		: "r" (addr), "Ir" (size), "0" (current_thread_info()->addr_limit) \
 		: "cc"); \
-- 
2.20.1

