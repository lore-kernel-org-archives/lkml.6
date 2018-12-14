Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4409CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F33206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeLNP0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:26:22 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:22001 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNP0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:26:22 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43GZBy6kFyz9v0GY;
        Fri, 14 Dec 2018 16:26:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aNHcfepgQfBH; Fri, 14 Dec 2018 16:26:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43GZBy6CnKz9v0GS;
        Fri, 14 Dec 2018 16:26:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5DF6D8B8EA;
        Fri, 14 Dec 2018 16:26:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cYfTxl_V_xhW; Fri, 14 Dec 2018 16:26:20 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4518B8B8D3;
        Fri, 14 Dec 2018 16:26:20 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 39FA771710; Fri, 14 Dec 2018 15:26:20 +0000 (UTC)
Message-Id: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Dec 2018 15:26:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce lkdtm tests for NULL pointer dereference: check
access or exec at NULL address.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/misc/lkdtm/core.c  |  2 ++
 drivers/misc/lkdtm/lkdtm.h |  2 ++
 drivers/misc/lkdtm/perms.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index bc76756b7eda..36910e1d5c09 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -157,7 +157,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(EXEC_VMALLOC),
 	CRASHTYPE(EXEC_RODATA),
 	CRASHTYPE(EXEC_USERSPACE),
+	CRASHTYPE(EXEC_NULL),
 	CRASHTYPE(ACCESS_USERSPACE),
+	CRASHTYPE(ACCESS_NULL),
 	CRASHTYPE(WRITE_RO),
 	CRASHTYPE(WRITE_RO_AFTER_INIT),
 	CRASHTYPE(WRITE_KERN),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 3c6fd327e166..b69ee004a3f7 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
 void lkdtm_EXEC_VMALLOC(void);
 void lkdtm_EXEC_RODATA(void);
 void lkdtm_EXEC_USERSPACE(void);
+void lkdtm_EXEC_NULL(void);
 void lkdtm_ACCESS_USERSPACE(void);
+void lkdtm_ACCESS_NULL(void);
 
 /* lkdtm_refcount.c */
 void lkdtm_REFCOUNT_INC_OVERFLOW(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index fa54add6375a..62f76d506f04 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -164,6 +164,11 @@ void lkdtm_EXEC_USERSPACE(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+void lkdtm_EXEC_NULL(void)
+{
+	execute_location(NULL, CODE_AS_IS);
+}
+
 void lkdtm_ACCESS_USERSPACE(void)
 {
 	unsigned long user_addr, tmp = 0;
@@ -195,6 +200,19 @@ void lkdtm_ACCESS_USERSPACE(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+void lkdtm_ACCESS_NULL(void)
+{
+	unsigned long tmp;
+	unsigned long *ptr = (unsigned long *)NULL;
+
+	pr_info("attempting bad read at %px\n", ptr);
+	tmp = *ptr;
+	tmp += 0xc0dec0de;
+
+	pr_info("attempting bad write at %px\n", ptr);
+	*ptr = tmp;
+}
+
 void __init lkdtm_perms_init(void)
 {
 	/* Make sure we can write to __ro_after_init values during __init */
-- 
2.13.3

