Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAA320815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="TYA9x5Pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfACVsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:48:06 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:54156 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfACVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:48:06 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id CA7F05C0DDF;
        Thu,  3 Jan 2019 22:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546552084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51xr4xYeiDI4RYE/PzJ1r3c7j9DrlQRWm/NtP3kFLMo=;
        b=TYA9x5Pbx82LwyMAxfQFwLLbyerlqWRVh6xzfBxrmlh0atGvPW3XcVQsq/y2JumNzAfNWt
        CrI/k3g0KviFz4yPmJ3bpS5PPO4RCqSgg0m7bnXUT6HvQx1fSYo3Ic+rj6rd+oeRLah9yI
        75rzeDJ1Tv2q5z8ZZMuV7DxF6z7B57s=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 3/3] ARM: spinlock: use unified assembler language syntax
Date:   Thu,  3 Jan 2019 22:48:15 +0100
Message-Id: <ad0fbab91f337ec99e3a2a3d60886a785da34366.1546551693.git.stefan@agner.ch>
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


 arch/arm/include/asm/spinlock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 099c78fcf62d..8f009e788ad4 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -210,11 +210,12 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 
 	prefetchw(&rw->lock);
 	__asm__ __volatile__(
+"	.syntax unified\n"
 "1:	ldrex	%0, [%2]\n"
 "	adds	%0, %0, #1\n"
 "	strexpl	%1, %0, [%2]\n"
 	WFE("mi")
-"	rsbpls	%0, %1, #0\n"
+"	rsbspl	%0, %1, #0\n"
 "	bmi	1b"
 	: "=&r" (tmp), "=&r" (tmp2)
 	: "r" (&rw->lock)
-- 
2.20.1

