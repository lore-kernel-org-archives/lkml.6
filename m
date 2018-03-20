Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeCTXCY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:02:24 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34765 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:02:19 -0400
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/5] bus: arm-cci: use asm unreachable
Date: Wed, 21 Mar 2018 00:02:02 +0100
Message-Id: <20180320230206.25289-2-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320230206.25289-1-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixing asm and C code is not recommended in a naked function by
gcc and leads to an error when using clang:
  drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
  function is not supported
        unreachable();
        ^

Instead of using the unreachable() macro use the assember variant
ASM_UNREACHABLE.  This will no longer emit __builtin_unreachable(),
but since the function is naked and its return type is void it seems
not to have aversive effects.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/bus/arm-cci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5426c04fe24b..ee9da86fec47 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -2084,6 +2084,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
 
 "	mov	r0, #0 \n"
 "	bx	lr \n"
+	ASM_UNREACHABLE
 
 "	.align	2 \n"
 "5:	.word	cpu_port - . \n"
@@ -2103,8 +2104,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
 	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
 	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
 	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
-
-	unreachable();
 }
 
 /**
-- 
2.16.2
