Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C18DC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ADA222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gT6iLXdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfBLUCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:02:17 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:43834 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbfBLUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:02:01 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 197985C0E6D;
        Tue, 12 Feb 2019 21:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1550001718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PDJlT11jb85GGKJHyPtJki8m65dii11XEoaId/97eQ=;
        b=gT6iLXdo1z0oce1QJuhyBajiKHaYASrK4Y/BW8qNzmd0JlFNh/1TCkVFkXHMMgIRGea2yd
        UvqnvtvjOW23hxHmkmow97YRQNpN3sHWwZWgc/kwwNsVAzrLY3Rrux2Ay5l2QRL+8CvCQu
        2ozbN4Tdc1WhmmeTty6gA/Q9mLic0nE=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH v3 5/5] ARM: warn if divided syntax assembler is used
Date:   Tue, 12 Feb 2019 21:02:01 +0100
Message-Id: <447621a6c829e37d30f589653fe4a0ade36ac52a.1550001435.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550001435.git.stefan@agner.ch>
References: <cover.1550001435.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the -mno-warn-deprecated assembler flag to make sure the GNU
assembler warns in case non-unified syntax is used.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Remove AFLAGS_NOWARN from CFLAGS_ISA

 arch/arm/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a0d08a3c9d33..9561325c5201 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -112,19 +112,16 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
-# Accept old syntax despite ".syntax unified"
-AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
-
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
-CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
+CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
 KBUILD_CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
 else
-CFLAGS_ISA	:=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
+CFLAGS_ISA	:=$(call cc-option,-marm,)
 AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
-- 
2.20.1

