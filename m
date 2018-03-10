Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbeCJUoH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 15:44:07 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44510 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeCJUoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 15:44:05 -0500
X-Google-Smtp-Source: AG47ELsvB4cMzUWbR5iJxroFZ4YxrQNGSsm2xRaPwZ4RGDYXqHaH5rU/9Ex6L6k/u0wfT3UwRuds2w==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: fujitsu-laptop: Revert UNSUPPORTED_CMD back to an int
Date: Sat, 10 Mar 2018 21:43:53 +0100
Message-Id: <20180310204353.9584-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNSUPPORTED_CMD was previously 0x80000000 (int), but commit 819cddae7cfa
("platform/x86: fujitsu-laptop: Clean up constants") changed it into an
unsigned long due to BIT() being used to define it.  As call_fext_func()
returns an int, 0x80000000 would get type promoted when compared to an
unsigned long, which on a 64-bit system would cause it to become
0xffffffff80000000 due to sign extension.  This causes one logical
condition in fujitsu-laptop to always be true and another one to always
be false on 64-bit systems.  Fix this by reverting UNSUPPORTED_CMD back
to an int.

This patch fixes the following smatch warnings:

drivers/platform/x86/fujitsu-laptop.c:763 acpi_fujitsu_laptop_leds_register() warn: always true condition '(call_fext_func(device, ((1 << (12)) | (1 << (0))), 2, (1 << (16)), 0) != (1 << (31))) => (s32min-s32max != 2147483648)'
drivers/platform/x86/fujitsu-laptop.c:816 acpi_fujitsu_laptop_add() warn: impossible condition '(priv->flags_supported == (1 << (31))) => (0-2147483647,18446744071562067968-u64max == 2147483648)'

Fixes: 819cddae7cfa ("platform/x86: fujitsu-laptop: Clean up constants")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
This fixes a bug introduced by a commit queued for 4.17, so it needs to
be applied on top of for-next.

 drivers/platform/x86/fujitsu-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 13bcdfea5349..6f4a55a53ced 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -85,7 +85,7 @@
 #define FUNC_BACKLIGHT			(BIT(12) | BIT(2))
 
 /* FUNC interface - responses */
-#define UNSUPPORTED_CMD			BIT(31)
+#define UNSUPPORTED_CMD			0x80000000
 
 /* FUNC interface - status flags */
 #define FLAG_RFKILL			BIT(5)
-- 
2.16.2
