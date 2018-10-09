Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D136C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FAD214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RMtJ6kwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FAD214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJIShE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43768 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeJIShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so1305118eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gGvzjb4QI7xoIMw64nhyTjBzCVNpNaZnEdCw2Qs3jY=;
        b=RMtJ6kwHRUrY3StaA6JbQJ6N0S8dSUUx3mcwHwBscSzYEBMEq7yday7ghBrDYvWPf7
         jSkTgwZoympVmclX637d84QyYArTZcKPCIpC3yVzGydRqMLf6jSrWmQGuoFdHAXXQhBL
         Cgis/RbaaxxhlfhvAbTZ1SEswjjLMuw3orKLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gGvzjb4QI7xoIMw64nhyTjBzCVNpNaZnEdCw2Qs3jY=;
        b=PldI0Mv+58kIhwVAFDqvsSMOJM4YFlihvAaBZgHyV/ctAYPTKOqQ7AXgPCYkLzpa/j
         9yVT1VQRYTtHcsX7BIZek0j/34I/dQi2OzWHF+x8DEA4lkNVkrY48+0eL3AnfwdOqAmP
         qJ7MNhcafYfTEpfXxG7wLUSuZWOg6jIcPZ23ztGTpOyPTBmimVtgNEWlUn1eZh7HgL45
         kXJM+v2Jm83d2CXpdDkZNcKc7YFwlOlF6Ee60r14MWZ2RCjaTmF8ND+jsu8Kj+OozlRf
         JK6mO25GhtIVbKl1epkaE79R8q0U1vOcCgi1FAN5fsxejxZ7FjlBqGCWBMZ806cCJ0JP
         m68w==
X-Gm-Message-State: ABuFfohs1nJyEj2Fx8x8MIBRKoQI9QdmmhHf7N9uj226jytWBs7sSZFC
        Wn5SXV7bpV7os/uKrJw1ew9dcA==
X-Google-Smtp-Source: ACcGV62A6fc/Eyqmvfu/YXKWHkXOVFLSiV5KD4qL3A8yTU0InRoW79dg+PXLMV6hXl0Tpt/vqyW8ZA==
X-Received: by 2002:a17:906:24c4:: with SMTP id f4-v6mr14749110ejb.117.1539084032561;
        Tue, 09 Oct 2018 04:20:32 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 12/23] dynamic_debug: add static inline stub for ddebug_add_module
Date:   Tue,  9 Oct 2018 13:20:02 +0200
Message-Id: <20181009112013.14238-13-linux@rasmusvillemoes.dk>
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

For symmetry with ddebug_remove_module, and to avoid a bit of ifdeffery
in module.c, move the declaration of ddebug_add_module inside #if
defined(CONFIG_DYNAMIC_DEBUG) and add a corresponding no-op stub in the
#else branch.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 10 ++++++++--
 kernel/module.c               |  2 --
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0a643316597c..6a002b789d51 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -47,10 +47,10 @@ struct _ddebug {
 } __attribute__((aligned(8)));
 
 
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				const char *modname);
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
+int ddebug_add_module(struct _ddebug *tab, unsigned int n,
+				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
@@ -152,6 +152,12 @@ do {								\
 #include <linux/string.h>
 #include <linux/errno.h>
 
+static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
+				    const char *modname)
+{
+	return 0;
+}
+
 static inline int ddebug_remove_module(const char *mod)
 {
 	return 0;
diff --git a/kernel/module.c b/kernel/module.c
index 381f9bf282fe..be2727c5a003 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2715,9 +2715,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
 {
 	if (!debug)
 		return;
-#ifdef CONFIG_DYNAMIC_DEBUG
 	ddebug_add_module(debug, num, mod->name);
-#endif
 }
 
 static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
-- 
2.19.1.3.g1d92a00e68

