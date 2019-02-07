Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA8C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FB721872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="a800tihM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBGJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:47:23 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:53590 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfBGJq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:46:57 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6:0:5054:ff:fe4f:85bd])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 19F065C2075;
        Thu,  7 Feb 2019 10:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549532816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9JIjm2XShART9bRtAJa3PQf/5iayYwLOgmQZvNMPZ8=;
        b=a800tihMN7/H5PzVHaI5hn2PY5vShg2fdM6OQWBc7+/YK2zx7fj8Yr6yA4Cd4xYQIOWhuG
        IhF4PKc+Gl2B5c1JCae6XttVbdE2KHxureXgj46X8CLiiZKfN2FFx29le3+wZ34OM43Vvn
        pwharhwHIrFLFlgAsIvky+xdjDWBe8E=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 4/5] ARM: use unified assembler in c files
Date:   Thu,  7 Feb 2019 10:48:28 +0100
Message-Id: <fed4850fb5d8a8ca874affa05d8d116d53e25b88.1549532513.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549532513.git.stefan@agner.ch>
References: <cover.1549532513.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unified assembler syntax (UAL) in inline assembler. Divided
syntax is considered depricated. This will also allow to build
the kernel using LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mm/copypage-v4mc.c | 2 +-
 arch/arm/mm/copypage-v4wb.c | 2 +-
 arch/arm/mm/copypage-v4wt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index b03202cddddb..b19c7ad1a6de 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -56,7 +56,7 @@ static void mc_copy_user_page(void *from, void *to)
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	ldmiane	%0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ "
 	: "+&r" (from), "+&r" (to), "=&r" (tmp)
 	: "2" (PAGE_SIZE / 64)
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index cd3e165afeed..6e3c9b69dd25 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -38,7 +38,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index 8614572e1296..4a40fa1cbc2a 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -34,7 +34,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
-- 
2.20.1

