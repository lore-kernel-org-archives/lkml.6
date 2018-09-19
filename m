Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD28AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C9821524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MOdHFXiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C9821524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbeITDo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43197 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeITDo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id z27-v6so6147383edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UoBATMlLiphiO4fBYy7pZc/Q/hO4r+d5OoEnXv60dX0=;
        b=MOdHFXiVNFphi0EmPYkUv58hle7enqd+AdXbhbu4inZgX6QstmZg3HtY0V9xxJUV5O
         HxsJhbmgBeWofxhh9/A1pz8dVG5VVXn8xDbEg5N+MdnsNGWcQmvVs6ChvZ0FOurt93Xt
         mYTgYdvQGocKhMuDzeXpe7sxXP07sEwg1uWZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UoBATMlLiphiO4fBYy7pZc/Q/hO4r+d5OoEnXv60dX0=;
        b=H1PdxaDkSYPpwZqyn314YJCXb4BvrTMJHIkO0NTdBCtqUntIH9sZC/6wlcWwyn1Nip
         HRZctb8nP+LFL0jT0YJHdJQ91d1Y3vy2VjAeQ9f/n9xbKrzjY0/SDTUqP0QKIk1qDKfb
         vL0Y08Q+Jm4Tgcn88R5aqgdIhlZGvc7bIZE9wlJ6WezLi9W+UshiZlbB6acq7I1ee41d
         S368EG5yYXJtPaktjUadC9mC0VfW8scIEcIlwrjiBTAngTV4ZKfE+5rFaUw8Fq0HINs2
         OQ6rGbpsSmJEmlwNBaUjnmgEAiCF18c2mx046MuJFvR9RuQQedFEjYFEiPjDqOfo29OW
         xqyg==
X-Gm-Message-State: APzg51BAcTIJuZ/C6n560i1LRk+AazGpIXfFziD3VUE8ovqA/EFF/WN0
        ehVEGOI0iFbJKXa4xw8PBEmuoFa24LVjEpMn
X-Google-Smtp-Source: ANB0VdabyS26APduB6/JyTDGhbqE8ZJWDAdksm+hWYvgaIsEDqwtJ4rLZIPVxPVqdbGHvF7kOhYyHg==
X-Received: by 2002:a50:9297:: with SMTP id k23-v6mr63646772eda.180.1537394699918;
        Wed, 19 Sep 2018 15:04:59 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:59 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 08/22] dynamic_debug: don't duplicate modname in ddebug_add_module
Date:   Thu, 20 Sep 2018 00:04:30 +0200
Message-Id: <20180919220444.23190-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
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
2.16.4

