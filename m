Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9C3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB58206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IKGzNkdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB58206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbeITDpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34058 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbeITDpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so6189256eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSCg/80tkc3VizwDOMpy701dVmGb5mOTF3fco9aut6Y=;
        b=IKGzNkdxmkY8G0PcVHnBrO0bcQj6Q8Cu2caGnD6CowOohVO9qbJ65dYm2277SGATrK
         KGkqtWCFVfwlu8SPv4fFT7ydmL+CRBlz+R12ab5c0nhDYxT6cIlVOtCyQ1ExlwmXwXtF
         kdTKp5E5ANlYYTtwC15uPb7lFM7MzFnxWdX2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSCg/80tkc3VizwDOMpy701dVmGb5mOTF3fco9aut6Y=;
        b=fXY7MopvXFZBL/bEyaW17e4pkNzmkC/yB5CJJCG61T7vIrYWa98OUY5Fxk0Pi6qfTC
         Hnn6dIxPpfjLM18oOsbagfLQ4NQ29US3aWaekaTuXwDhIOUnLUQZqR/w03Sixzrl1I4d
         Jpwe2w0lnDVMV71JrkS6hYfMkZoPgPNTHG7j79j/j5IrtuekmswnLkcJ1RQV6WBGBn9/
         LCvrUrmzGhvGYoOz5d/avjQxnPn7H05ZYpxizxfVdvx9HtjFo1pnywexSf2eOqzVd3qK
         w3p1Ymb6p+L+w/9CLTx7PHij891WfFt22azgru+LX4ODd8A4Hjo+MUWbGqSM9/36TLwg
         s16g==
X-Gm-Message-State: APzg51BQwD4+ekaMBXqVyMfpEp6j22ELjZ/Uv1TiOn3DIekJ8GQD1dhC
        koEscWBGQQNIj235zftFlmG6Zw==
X-Google-Smtp-Source: ANB0VdZAkk/B63wpSceUuXVKw20rg/1DkQdKRLos4wputBzJvXn9sbSDf/VHiuMgnQoXIDfZx2zZFw==
X-Received: by 2002:a50:f315:: with SMTP id p21-v6mr60595668edm.233.1537394717840;
        Wed, 19 Sep 2018 15:05:17 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:17 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 18/22] dynamic_debug: introduce accessors for string members of struct _ddebug
Date:   Thu, 20 Sep 2018 00:04:40 +0200
Message-Id: <20180919220444.23190-19-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we introduce compact versions of these pointers (a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS), all access to these members must
go via appropriate accessors. This just mass-converts dynamic_debug.c to
use the new accessors.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 51 ++++++++++++++++++++++++++++++++++-----------------
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
2.16.4

