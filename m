Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76987C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4511920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4511920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeLEIwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:52:19 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:46460 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbeLEIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:52:15 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 5 Dec 2018 00:52:04 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 45F6D41396;
        Wed,  5 Dec 2018 00:52:05 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux_dti@icloud.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v7 14/14] module: Prevent module removal racing with text_poke()
Date:   Tue, 4 Dec 2018 17:34:08 -0800
Message-ID: <20181205013408.47725-15-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205013408.47725-1-namit@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems dangerous to allow code modifications to take place
concurrently with module unloading. So take the text_mutex while the
memory of the module is freed.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/module.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 57c5b23746e7..b45754961143 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,6 +64,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/memory.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -2181,6 +2182,9 @@ static void free_module(struct module *mod)
 	synchronize_sched();
 	mutex_unlock(&module_mutex);
 
+	/* Protect against patching of the module while it is being removed */
+	mutex_lock(&text_mutex);
+
 	/* This may be empty, but that's OK */
 	module_restore_mappings(&mod->init_layout);
 	module_arch_freeing_init(mod);
@@ -2194,6 +2198,7 @@ static void free_module(struct module *mod)
 	/* Finally, free the core (containing the module structure) */
 	module_restore_mappings(&mod->core_layout);
 	module_memfree(mod->core_layout.base);
+	mutex_unlock(&text_mutex);
 }
 
 void *__symbol_get(const char *symbol)
-- 
2.17.1

