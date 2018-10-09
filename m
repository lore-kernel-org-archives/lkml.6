Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25529C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056620835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e34y7uTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E056620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJIShA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40857 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJISg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so1319348edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpI9C9cAotX3nj8y5pIFi8JfUs0lkIoRNOT0l40fByE=;
        b=e34y7uTm8jShjNOW10FJBZ0xQCDSjslMJQZs0VUme9zLH0AmNBU7Laqwckmgd/6YOg
         5H7ZSrRUQpD725uu3gRXAiLCvCXqYJ/gabZxizuNyOZSnG2CHY9c6ZCqvgMclJaR5+LT
         /r5Y6TGvtZoBlefUQzDBDedUwFMgq1SRj4QTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpI9C9cAotX3nj8y5pIFi8JfUs0lkIoRNOT0l40fByE=;
        b=UMxe81L/lB4YSIlk2h6u1mVgB+pgiGYpFH1iJCtO/zzF4vd/R7pD2613WZ40XdaDyT
         /OFxWavFNpU9UUeG4y3nK9+zG0wyuI43m/HSCsWHG1uP4FI80H8n3h3TgIWAue3adjKJ
         wLnUooPMfpIy0LDpNnsskC3XbMx4onDE331+VTKgTRZJO2BpDPL83K69Kl184M6eaz9V
         fA2adllgthkHM0aVxp7Evjiz5ocROknppDCa+HiNTYtR/bzIxXCoxTaThtpgIsuAY0Ll
         oh9TPQat1LZUvYaGjDnsBpY/mUziebD+UR1E0WvFCtdOQ8RSWBkOrPcJNb2U67aIcdNB
         lf/Q==
X-Gm-Message-State: ABuFfoj2+ctVUNmLqtwDnahsyRdpCVNshPv/0AtIB5a9L2My1sz5K0PI
        yHJlCxFt/iSGAdvkCKMRaE0FWA==
X-Google-Smtp-Source: ACcGV62H+3DbexvlQCdV0BVeRJsrv6hFuKXSrGeDXTFhRvAPmO1TzwoKBlIXg/+hyxCHx1GTURr1Sg==
X-Received: by 2002:a50:aebb:: with SMTP id e56-v6mr34344583edd.16.1539084028446;
        Tue, 09 Oct 2018 04:20:28 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:27 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 08/23] dynamic_debug: don't duplicate modname in ddebug_add_module
Date:   Tue,  9 Oct 2018 13:19:58 +0200
Message-Id: <20181009112013.14238-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
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
2.19.1.3.g1d92a00e68

