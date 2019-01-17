Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2BB205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfAQAeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:34:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:47095 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfAQAdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:33:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 16:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="292166062"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.79])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2019 16:33:36 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 17/17] module: Prevent module removal racing with text_poke()
Date:   Wed, 16 Jan 2019 16:32:59 -0800
Message-Id: <20190117003259.23141-18-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

It seems dangerous to allow code modifications to take place
concurrently with module unloading. So take the text_mutex while the
memory of the module is freed.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 kernel/module.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 1af5c8e19086..90cfc4988d98 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,6 +64,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/memory.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -2157,6 +2158,9 @@ static void free_module(struct module *mod)
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
 
+	/* Protect against patching of the module while it is being removed */
+	mutex_lock(&text_mutex);
+
 	/* This may be empty, but that's OK */
 	module_arch_freeing_init(mod);
 	module_memfree(mod->init_layout.base);
@@ -2168,6 +2172,7 @@ static void free_module(struct module *mod)
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
+	mutex_unlock(&text_mutex);
 }
 
 void *__symbol_get(const char *symbol)
-- 
2.17.1

