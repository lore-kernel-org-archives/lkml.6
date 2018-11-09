Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19454C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB53120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB53120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeKIQpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:45:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47705 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeKIQpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:45:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42rrlb1CN4z9ty8r;
        Fri,  9 Nov 2018 08:05:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SMJXeHEkxyHE; Fri,  9 Nov 2018 08:05:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42rrlb0kTwz9ttBy;
        Fri,  9 Nov 2018 08:05:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CF5E8B878;
        Fri,  9 Nov 2018 08:05:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2S0QATzhOeK8; Fri,  9 Nov 2018 08:05:52 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FA248B756;
        Fri,  9 Nov 2018 08:05:52 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DE637699D2; Fri,  9 Nov 2018 07:05:51 +0000 (UTC)
Message-Id: <ca27a073c872e243be1d17a89afb4b4aeb9a298b.1541714054.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lkdtm: do not depend on CONFIG_BLOCK
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  9 Nov 2018 07:05:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most parts of lkdtm don't require CONFIG_BLOCK.

This patch limits dependency to CONFIG_BLOCK in order to give embedded
platforms which don't select CONFIG_BLOCK the opportunity to use LKDTM.

Fixes: fddd9cf82c9f ("make LKDTM depend on BLOCK")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/misc/lkdtm/core.c | 7 ++++++-
 lib/Kconfig.debug         | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..bc76756b7eda 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -40,9 +40,12 @@
 #include <linux/interrupt.h>
 #include <linux/hrtimer.h>
 #include <linux/slab.h>
-#include <scsi/scsi_cmnd.h>
 #include <linux/debugfs.h>
 
+#ifdef CONFIG_BLOCK
+#include <scsi/scsi_cmnd.h>
+#endif
+
 #ifdef CONFIG_IDE
 #include <linux/ide.h>
 #endif
@@ -101,7 +104,9 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
+# ifdef CONFIG_BLOCK
 	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
+# endif
 # ifdef CONFIG_IDE
 	CRASHPOINT("IDE_CORE_CP",	 "generic_ide_ioctl"),
 # endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..0dd65b4b2ad2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1685,7 +1685,6 @@ if RUNTIME_TESTING_MENU
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on DEBUG_FS
-	depends on BLOCK
 	help
 	This module enables testing of the different dumping mechanisms by
 	inducing system failures at predefined crash points.
-- 
2.13.3

