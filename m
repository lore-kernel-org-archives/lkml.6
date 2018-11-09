Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11ECC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1B120855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Wyj73ciJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1B120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeKJIyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34859 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbeKJIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so2978845ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuj1GmscjqkulbuO777d9WEdE6kBKdEBx/moEJcjRm8=;
        b=Wyj73ciJ7TYzFSbEaoK1bBOnt+fj3eyhbbyAzq4JC3lxmBJ0xaYUFCr8XWuFNJo9Tr
         jIjNLRoNJWgKs9l+aUammAPwtnKcLQUnCWyK/Gu9wwrmph86a5Hj1dd/pkNFBN4CoSLS
         8M7jtDFBZAWKnaPe1eRK1QnM2G26JGMLXd4rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuj1GmscjqkulbuO777d9WEdE6kBKdEBx/moEJcjRm8=;
        b=rp3l7Kih6V68LtpM8hqWYLfcQ53CZJprrUEmmjqLFPOk8oUVeSmP0AMZiVIQRjm6pr
         ElgQEXb9Nqg/GBauz8B+ckaTQvbU9Iro5xbBsyQ/dEEywVm3AXs4ziyZ3QB45oKXjboZ
         N1zMGVqomVTfIXHN64CO8EGaL7XhZgT/G3/9rJYUHkz9mhGwB7gT05A49jtNgRCJ3Qbj
         2/Nb3RzF32jilp53mIq6ugnV43VCEkVilPqfGk1+LjHAmtFXlzBBCSar1vM6Pk6nS/Nn
         cQYJ1XBX2Zvp+KI2jPYNZHXsQ6KQfFAY/UIvo2Uf5LY8NlmelqGFTgoSzqXQJ1l1gTDq
         qgdw==
X-Gm-Message-State: AGRZ1gIMEIYxNv8ILhxKt/bcv495TP1Av6IWgNakdl/LmjgIDUAEdGbC
        KzULz0fSsM1Kg4lZWnevSj6bUg==
X-Google-Smtp-Source: AJdET5d6DIjp43IkmekE03J1Hhqn0JYpFOOOc0M30CfbkkWIjJq2dn/Ul4WicM2pr/PlfHrVJDEN1g==
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr6570887ljv.31.1541805081967;
        Fri, 09 Nov 2018 15:11:21 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:21 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 18/23] dynamic_debug: introduce accessors for string members of struct _ddebug
Date:   Sat, 10 Nov 2018 00:10:16 +0100
Message-Id: <20181109231021.11658-19-linux@rasmusvillemoes.dk>
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

When we introduce compact versions of these pointers (a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS), all access to these members must
go via appropriate accessors. This just mass-converts dynamic_debug.c to
use the new accessors.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 51 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e90459dca34b..dbd837f486f9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,6 +37,23 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
+static inline const char *dd_modname(const struct _ddebug *dd)
+{
+	return dd->modname;
+}
+static inline const char *dd_function(const struct _ddebug *dd)
+{
+	return dd->function;
+}
+static inline const char *dd_filename(const struct _ddebug *dd)
+{
+	return dd->filename;
+}
+static inline const char *dd_format(const struct _ddebug *dd)
+{
+	return dd->format;
+}
+
 extern struct _ddebug __start___verbose[];
 extern struct _ddebug __stop___verbose[];
 
@@ -158,21 +175,21 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			/* match against the source filename */
 			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
+			    !match_wildcard(query->filename, dd_filename(dp)) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
+					   kbasename(dd_filename(dp))) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					   trim_prefix(dd_filename(dp))))
 				continue;
 
 			/* match against the function */
 			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
+			    !match_wildcard(query->function, dd_function(dp)))
 				continue;
 
 			/* match against the format */
 			if (query->format &&
-			    !strstr(dp->format, query->format))
+			    !strstr(dd_format(dp), query->format))
 				continue;
 
 			/* match against the line number range */
@@ -197,8 +214,8 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			vpr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
+				 trim_prefix(dd_filename(dp)), dp->lineno,
+				 dt->mod_name, dd_function(dp),
 				 ddebug_describe_flags(dp, flagbuf,
 						       sizeof(flagbuf)));
 		}
@@ -533,10 +550,10 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	pos_after_tid = pos;
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
+				dd_modname(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
+				dd_function(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
@@ -790,10 +807,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(dd_filename(dp)), dp->lineno,
+		   iter->table->mod_name, dd_function(dp),
 		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
-	seq_escape(m, dp->format, "\t\r\n\"");
+	seq_escape(m, dd_format(dp), "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
 	return 0;
@@ -987,20 +1004,20 @@ static int __init dynamic_debug_init(void)
 		return 1;
 	}
 	iter = __start___verbose;
-	modname = iter->modname;
+	modname = dd_modname(iter);
 	iter_start = iter;
 	for (; iter < __stop___verbose; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
+		verbose_bytes += strlen(dd_modname(iter)) + strlen(dd_function(iter))
+			+ strlen(dd_filename(iter)) + strlen(dd_format(iter));
 
-		if (strcmp(modname, iter->modname)) {
+		if (strcmp(modname, dd_modname(iter))) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
-			modname = iter->modname;
+			modname = dd_modname(iter);
 			iter_start = iter;
 		}
 		n++;
-- 
2.19.1.6.gbde171bbf5

