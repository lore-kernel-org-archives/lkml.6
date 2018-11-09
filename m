Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C162C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E728B20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fESCuQgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E728B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeKJIx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36767 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeKJIx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id h192so2511359lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9rDiTAkQphBs7INy3YQuOD94GpEMbHTE0DMqOgYhFc=;
        b=fESCuQgQMkOlPIsjM4Ahr1PBixshOCF1FNLVE0SQ4rmq4QN05H8FDPLYZ3klwJwafV
         qcJ8wS1G1HNOOtew3t5mzrmsIdayEiwdjhjDTa5u+iKYSFPH1RH8J3mAwr1BzpMrmfYH
         JSkLlTWSPVLO0FP9qHWTR2sCvbk5JslwkrNj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9rDiTAkQphBs7INy3YQuOD94GpEMbHTE0DMqOgYhFc=;
        b=MJ+WosV0iWLbaZwvrZqdgbcGoizZX5SQZ+huQX5bRv3z9U6VHQ51HaGIYvoXW0chsT
         VwW3CMJzpa7iVnM5BFsxb6BO5OQHP658BYkfZRZ7L9pCPRCEveORE1K24CsYGr9k35R5
         ds7O2ZXAQbtAu3PoQ1/kUXOHmU/rwYic8E4d2xC2y4I7gWKsy0kgOE/0b0pdfpNUAFgz
         Unz53+Uqmf9fUbRPWWf8yR9UybbIHXTGejKMqMsj3DtG58fXgvIFZ5y+t6utdHf4vbOK
         appgfriJ1I2c0963DfSJNogaRf3miPmINVayk1KGOMOoBPD7t1PnyGho9w/r4GjJP56l
         BjFQ==
X-Gm-Message-State: AGRZ1gLTUJXkD1EsA/gXflw3nbb7Eiau4pDPUO7sJPo9dnOlbQjk/OKm
        CgIOm9n9BtNsVU5cHHMrmE23mwNKnGI7dg==
X-Google-Smtp-Source: AJdET5dNCSfLNxI3ohJVogOg7+B/Hg7Iu6ny/cwpdFIOnH8i+PeSb+Q9gLKdxJC3n0zA6akYKlF8hA==
X-Received: by 2002:a19:1cb:: with SMTP id 194mr6532755lfb.61.1541805073051;
        Fri, 09 Nov 2018 15:11:13 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:12 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 11/23] dynamic_debug: move pr_err from module.c to ddebug_add_module
Date:   Sat, 10 Nov 2018 00:10:09 +0100
Message-Id: <20181109231021.11658-12-linux@rasmusvillemoes.dk>
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

This serves two purposes: First, we get a diagnostic if (though
extremely unlikely), any of the calls of ddebug_add_module for built-in
code fails, effectively disabling dynamic_debug. Second, I want to make
struct _ddebug opaque, and avoid accessing any of its members outside
dynamic_debug.[ch].

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/module.c     | 4 +---
 lib/dynamic_debug.c | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..80ede55db25a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2716,9 +2716,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
 	if (!debug)
 		return;
 #ifdef CONFIG_DYNAMIC_DEBUG
-	if (ddebug_add_module(debug, num, mod->name))
-		pr_err("dynamic debug error adding module: %s\n",
-			debug->modname);
+	ddebug_add_module(debug, num, mod->name);
 #endif
 }
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f1de45a100fa..e90459dca34b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -849,8 +849,10 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	struct ddebug_table *dt;
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
-	if (dt == NULL)
+	if (dt == NULL) {
+		pr_err("error adding module: %s\n", name);
 		return -ENOMEM;
+	}
 	/*
 	 * For built-in modules, name lives in .rodata and is
 	 * immortal. For loaded modules, name points at the name[]
-- 
2.19.1.6.gbde171bbf5

