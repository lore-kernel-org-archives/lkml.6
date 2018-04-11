Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935049AbeDKTF2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:05:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38580 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934973AbeDKTFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:05:21 -0400
X-Google-Smtp-Source: AIpwx4+0UcdkmF52o14asE3ohg189GIrg9P4vqttVPZ8jQxD/eiAX0DmYY4A31WtqMvvCbUEtbwzuw==
From: Mathieu Malaterre <malat@debian.org>
To: Jessica Yu <jeyu@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/module: silence a gcc warning
Date: Wed, 11 Apr 2018 21:05:09 +0200
Message-Id: <20180411190509.24995-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8c8ef42aee8f ("module: include other structures in module version
check"), the function `struct_module` was renamed to `module_layout` but no
prototype was added to `include/linux/module.h`. Remove warning triggered
at W=1:

  kernel/module.c:4378:6: warning: no previous prototype for ‘module_layout’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/module.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index d44df9b2c131..28046e8b7e9d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -786,6 +786,14 @@ extern int module_sysfs_initialized;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
+#ifdef CONFIG_MODVERSIONS
+void module_layout(struct module *mod,
+		   struct modversion_info *ver,
+		   struct kernel_param *kp,
+		   struct kernel_symbol *ks,
+		   struct tracepoint * const *tp);
+#endif /* CONFIG_MODVERSIONS */
+
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
 
 #define __MODULE_STRING(x) __stringify(x)
-- 
2.11.0
