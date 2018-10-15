Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98067C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE772064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="BYfuLSJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE772064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJPGDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:03:50 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38354 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPGDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:03:50 -0400
Received: from trochilidae.toradex.int (unknown [IPv6:2a02:169:3460::525])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9E3EB5C0106;
        Tue, 16 Oct 2018 00:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539641798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=M6JmEVCtUnq7D+ti0w3NkBGcNYQiCg6j51cuvLvMpH8=;
        b=BYfuLSJy1GSO3z8/vmtk9X9mCacyD9ZRyQ+k+W5NRZUQDr009VRB8n9gldKj26RYA+JSx1
        Wk4zkn3L79ZlSGYE4j1hWx9yiTOEwzWZT7RQT8eXUzkzJRPX/GoGevM4qO3SXWtO82mGMH
        cisISckofZSxqTTZrAGVJA0J+bBs53c=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk, ulli.kroll@googlemail.com
Cc:     joel@jms.id.au, nico@linaro.org, arnd@arndb.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands list
Date:   Tue, 16 Oct 2018 00:16:29 +0200
Message-Id: <20181015221629.13924-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When functions incoming parameters are not in input operands list gcc
4.5 does not load the parameters into registers before calling this
function but the inline assembly assumes valid addresses inside this
function. This breaks the code because r0 and r1 are invalid when
execution enters v4wb_copy_user_page ()

Also the constant needs to be used as third input operand so account
for that as well.

This fixes copypage-fa.c what has previously done before for the other
copypage implementations in commit 9a40ac86152c ("ARM: 6164/1: Add kto
and kfrom to input operands list.").

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mm/copypage-fa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
index d130a5ece5d5..ec6501308c60 100644
--- a/arch/arm/mm/copypage-fa.c
+++ b/arch/arm/mm/copypage-fa.c
@@ -22,7 +22,7 @@ fa_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %0				@ 1\n\
+	mov	r2, %2				@ 1\n\
 1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
 	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
@@ -36,7 +36,7 @@ fa_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
 	ldmfd	sp!, {r4, pc}			@ 3"
 	:
-	: "I" (PAGE_SIZE / 32));
+	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
 }
 
 void fa_copy_user_highpage(struct page *to, struct page *from,
-- 
2.19.1

