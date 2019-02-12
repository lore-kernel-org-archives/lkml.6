Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D37C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90B222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZAymKtUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfBLVmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38444 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbfBLVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so170255edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRAvZY427BeWnfwN52p0DcZ8qFl6EsGJHOqGPiKPVgE=;
        b=ZAymKtUBHGcflGFAIJEWHkIuMam3ptzayG/EiKIGqeRIczwRVnX4n4j/0KRBB269eb
         e7pdJQGTpIFl+/FCqS+VtMApVuoD6dUwIHDTLBZNi6Mh3MGDg1pOPJnOhfqobwDg/ZF1
         1amIYF6jBDmixiEvcBSui+WQY4ylFEokARKmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRAvZY427BeWnfwN52p0DcZ8qFl6EsGJHOqGPiKPVgE=;
        b=TpYcb7Llk7Ag+PifVQgDEhSStC8ZLIp7SleZw0TZwef4x4tryXeS15rsWuMygLldzU
         4MxcJR4H3cIPSchtifAQ8WZlAewhjmaangOWvKgoTXqBYlcuYHUnXqPsBi66sC5JjcLb
         ggg2t0l1J63yXaBgzVeynifs2Zj+UAkbyQ+o8uCh+dHFlOl2yKON/ZQu6aaQ0JiVMe4S
         pDoNPLf1cNUs4SXIRclRyhdrzI2FpFPltPGX9kS37bYTUShikTuT+rp9dLYllaWLZt2T
         3Jut3VscIbfc3BLkgP0/8RyyFU4lNcHQ7Xmuf8/rPnJTLKK5R/U+awdvwHR77tEdlhO4
         TZmA==
X-Gm-Message-State: AHQUAuaIPO3Ht/tR0iYeIbguvodiPU0BKTdiwtSp0U3zuswj8iN3vqke
        TYBPiGq6dswPdPDMoqsb4IIxa+Md6oSZVKH1
X-Google-Smtp-Source: AHgI3Ib582A2lt0keKYLQiL7rEV1+wbi+I8OYMgih7pdus4j86c30NN1nzxYd7/yPCl6/Agqj+TNxw==
X-Received: by 2002:a17:906:8cf:: with SMTP id o15mr4311685eje.124.1550007722133;
        Tue, 12 Feb 2019 13:42:02 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:01 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 05/14] dynamic_debug: don't duplicate modname in ddebug_add_module
Date:   Tue, 12 Feb 2019 22:41:41 +0100
Message-Id: <20190212214150.4807-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For built-in modules, we're already reusing the passed-in string via
kstrdup_const(). But for actual modules (i.e. when we're called from
dynamic_debug_setup in module.c), the passed-in string (which points
at the name[] array inside struct module) is also
guaranteed to live at least as long as the struct ddebug_table, since
free_module() calls ddebug_remove_module().

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dbf2b457e47e..8274c4ea75e0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -847,17 +847,17 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 			     const char *name)
 {
 	struct ddebug_table *dt;
-	const char *new_name;
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL)
 		return -ENOMEM;
-	new_name = kstrdup_const(name, GFP_KERNEL);
-	if (new_name == NULL) {
-		kfree(dt);
-		return -ENOMEM;
-	}
-	dt->mod_name = new_name;
+	/*
+	 * For built-in modules, name lives in .rodata and is
+	 * immortal. For loaded modules, name points at the name[]
+	 * member of struct module, which lives at least as long as
+	 * this struct ddebug_table.
+	 */
+	dt->mod_name = name;
 	dt->num_ddebugs = n;
 	dt->ddebugs = tab;
 
@@ -913,7 +913,6 @@ int ddebug_dyndbg_module_param_cb(char *param, char *val, const char *module)
 static void ddebug_table_free(struct ddebug_table *dt)
 {
 	list_del_init(&dt->link);
-	kfree_const(dt->mod_name);
 	kfree(dt);
 }
 
-- 
2.20.1

