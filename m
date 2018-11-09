Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8112E20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Xh8Ci0j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8112E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeKJIx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46554 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeKJIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so2941704ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/f4Yxjc1mvDKkBELzI582vN0xU3b9y0nV+tANAxnbQ=;
        b=Xh8Ci0j0ZHF3h1+EfNep0irZu0jO1Yv8fuCuFX2IZPcq+cUHE18njE+ZEvQr8LykJL
         iSsOduj7WuKRdZ567wFWZnXmoIhkni/L/oZJ7Y0lDGftCKDYSGgKLzWn1zXK+qds/9QI
         VgW7z/zg9ho+8xzEzI5znJLJf/rO8bdYsnsF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/f4Yxjc1mvDKkBELzI582vN0xU3b9y0nV+tANAxnbQ=;
        b=tDIZJhcucMR6b3A1bHE84iY7r9H25eSOsfUbzHWfTvgm5hrGz13ty3UcFWqtFJ4ItO
         d0NOtOwVNvKZS4U2ubphfLLiZguPANZOir6hlWVHwIMCIeQXXMlXRUjmreCTQkeov1E7
         ReZhSYTZFxRa9q8FVMVy3pFasUQjTBmOxXJQ7cLTbbI1gpQXcBx1UM4TQJ4Ln9Ro7YK7
         3N5kTf7894o5u7zVRi94Tn86GvxiZctaTn6XD9f5EN3zCOMJ0hcH7c50EMMMqqRRkx7T
         +64Qup986EjnH+INq23JQCEI72A60d8b6cZFef189DAMwOJ8Fdpjgei0eJU8mhVE5uJH
         gT2Q==
X-Gm-Message-State: AGRZ1gIEFR+3V9bu9D4oxrW4gB4XQNIAY9SOsCkBQx0qaxNIuBZJdBsV
        UsnaoX1CfcsGuhxzUgXvaEHE/Q==
X-Google-Smtp-Source: AJdET5dfaRd5glplPzLpDHY2kXp0a2rLkRnVM6rH+512q2PFlC2twjUcnpoTjardW4UP6ADlnr2zzw==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr7323955ljc.147.1541805069460;
        Fri, 09 Nov 2018 15:11:09 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:09 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 08/23] dynamic_debug: don't duplicate modname in ddebug_add_module
Date:   Sat, 10 Nov 2018 00:10:06 +0100
Message-Id: <20181109231021.11658-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
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
index c7c96bc7654a..2155e0e23530 100644
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
2.19.1.6.gbde171bbf5

