Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B1AC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C3E20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kmbScMng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeL3QIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:08:19 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:38404 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeL3QIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:08:18 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 530AE5C102A;
        Sun, 30 Dec 2018 17:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546186096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4b4Aplok1v5A3OAOr1AuVES09IdBt8fC2qqk06hsBWY=;
        b=kmbScMngcFvaaUOOMOC/F6ghNgSCcDKZ4tYgSzB/BHpQiUTu58j5H0vs3fFiIGzs5Widl0
        zWp8LnAhCKWkhgMESy4znfI7PU8VjrjLls+ZZPY9sEURTyH2W5FBuv1Bo5jO1jbS3+aEMv
        Ds59A0iywCRmPI4KkHgJ6KiT6Rp10Mc=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] ARM: fix argument count to match macro definition
Date:   Sun, 30 Dec 2018 17:08:17 +0100
Message-Id: <e5aa8bda88280b9cc76e52e386b216a4b1eeb557.1546185298.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1546185298.git.stefan@agner.ch>
References: <cover.1546185298.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro str8w takes 10 arguments, abort being the 10th. In this
particular instantiation the abort argument is passed as 11th
argument leading to an error when using LLVM's integrated
assembler:
  <instantiation>:46:47: error: too many positional arguments
    str8w r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
                                                ^
  arch/arm/lib/copy_template.S:277:5: note: while in macro instantiation
  18: forward_copy_shift pull=24 push=8
      ^

The argument is not used in the macro hence this does not change
code generation.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/lib/copy_template.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 652e4d98cd47..2d54491b0e22 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -241,7 +241,7 @@
 		orr	r9, r9, ip, lspush #\push
 		mov	ip, ip, lspull #\pull
 		orr	ip, ip, lr, lspush #\push
-		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
+		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, abort=19f
 		bge	12b
 	PLD(	cmn	r2, #96			)
 	PLD(	bge	13b			)
-- 
2.20.1

