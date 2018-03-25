Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeCYSKH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:10:07 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53905 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbeCYSKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:10:04 -0400
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: robin.murphy@arm.com, nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 1/6] bus: arm-cci: use asm unreachable
Date: Sun, 25 Mar 2018 20:09:54 +0200
Message-Id: <20180325180959.28008-2-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180325180959.28008-1-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixing asm and C code is not recommended in a naked function by
gcc and leads to an error when using clang:
  drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
  function is not supported
        unreachable();
        ^

While the function is marked __naked it actually properly return
in asm. There is no need for the unreachable() call.

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Don't add assembly ASM_UNREACHABLE, just drop unreachable()

 drivers/bus/arm-cci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5426c04fe24b..fc2da3a617ac 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -2103,8 +2103,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
 	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
 	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
 	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
-
-	unreachable();
 }
 
 /**
-- 
2.16.2
