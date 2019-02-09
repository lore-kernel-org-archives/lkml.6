Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43809C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078DB218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lGGiXXUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfBIXJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 18:09:16 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:59104 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBIXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 18:09:16 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9982E5C24EB;
        Sun, 10 Feb 2019 00:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549753754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrAPW/N746G+3mkN2kaRzvoA3N5aYGgPiNo+V6l9Z30=;
        b=lGGiXXUotnFH793oxVQ4ybMrzshMJMglKRUdXE3D9vcuToSJOLCAiPqjxdp9q+eDiBI1if
        /Z+M3ofjZf2mk2R+boRjXkQs0rGRFdpNQOMiaAnaBC9gpxxP8hjP3QchpWfaIbcqM6D0Mi
        SWU8OgsjheQFNawMH4splFnwpauTXhI=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 1/5] ARM: use unified assembler in macros
Date:   Sun, 10 Feb 2019 00:08:58 +0100
Message-Id: <8d47f3b81158fb75ce1a4013d90c00c3ea5dde66.1549753425.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549753425.git.stefan@agner.ch>
References: <cover.1549753425.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unified assembler syntax (UAL) in macros. Divided syntax is
considered deprecated. This will also allow to build the kernel
using LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Remove excessive null tokens

 arch/arm/lib/copy_from_user.S | 2 +-
 arch/arm/lib/copy_to_user.S   | 2 +-
 arch/arm/lib/memcpy.S         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 0d4c189c7f4f..6a3419e2c6d8 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -91,7 +91,7 @@
 	.endm
 
 	.macro str1b ptr reg cond=al abort
-	str\cond\()b \reg, [\ptr], #1
+	strb\cond \reg, [\ptr], #1
 	.endm
 
 	.macro enter reg1 reg2
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 97a6ff4b7e3c..c7d08096e354 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -49,7 +49,7 @@
 	.endm
 
 	.macro ldr1b ptr reg cond=al abort
-	ldr\cond\()b \reg, [\ptr], #1
+	ldrb\cond \reg, [\ptr], #1
 	.endm
 
 #ifdef CONFIG_CPU_USE_DOMAINS
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index 64111bd4440b..4a6997bb4404 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -30,7 +30,7 @@
 	.endm
 
 	.macro ldr1b ptr reg cond=al abort
-	ldr\cond\()b \reg, [\ptr], #1
+	ldrb\cond \reg, [\ptr], #1
 	.endm
 
 	.macro str1w ptr reg abort
@@ -42,7 +42,7 @@
 	.endm
 
 	.macro str1b ptr reg cond=al abort
-	str\cond\()b \reg, [\ptr], #1
+	strb\cond \reg, [\ptr], #1
 	.endm
 
 	.macro enter reg1 reg2
-- 
2.20.1

