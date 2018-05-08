Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeEHLcS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:32:18 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41022 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754490AbeEHLcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:32:16 -0400
From: Stefan Agner <stefan@agner.ch>
To: arm@kernel.org, arnd@arndb.de
Cc: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [RESEND PATCH v2] bus: arm-cci: use asm unreachable
Date: Tue,  8 May 2018 13:32:11 +0200
Message-Id: <20180508113211.7026-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         ASN(0.00)[asn:3303, ipnet:217.192.0.0/15, country:CH];
         ARC_NA(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         BAYES_HAM(-3.00)[100.00%];
         FROM_EQ_ENVFROM(0.00)[];
         TO_DN_SOME(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCVD_TLS_ALL(0.00)[]
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
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/bus/arm-cci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 443e4c3fd357..b8184a903583 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -371,8 +371,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
 	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
 	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
 	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
-
-	unreachable();
 }
 
 /**
-- 
2.17.0
