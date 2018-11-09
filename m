Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FB8C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D8320827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VwZSJQEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D8320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeKJIyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41765 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbeKJIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so2964791ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkq8utA7Ha/L6fJm/lqS9H9PW/cIto5ldwTA35g3l4Q=;
        b=VwZSJQEPyAv6S2f4gAD7zFb6qfBBq0YvX+/xxM6YRjT/a3dBh2x1QyWDCR0khSX0HS
         6sYdqHaKgIYZvliuULkrXJTY70QYIZ5hhIoQRA6KcHuXFcdSSfHZuxsfyfud8kMJ49XA
         X0k+UPJBN5E1cXIXDnjU0hXHGqi2Y0P9lgjVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkq8utA7Ha/L6fJm/lqS9H9PW/cIto5ldwTA35g3l4Q=;
        b=p8XVqb5pGtn4GvFAcTcSO0mudOq00RP+IAOwXRfsY4TJgDYAAG7gBlmXpjDZDq0MQV
         g0KFyrDo10Yu4fH9WBqdl6dmSuZKl3m6e1DGsIefHPQiU0kzQ0HNMNUz/ki2C3VW19lA
         5qpFvWiWEDb1VWBTGfmO+ryfEpyZrpZV/diNooeLnc/Lvyy7mmOCC76V6btCgCyaS+cx
         6LQNr3GWXYwRi1lv+CaEZsuYVoHaZki+1qBcoB0L6nwgICJr09NcyEIImCpwlo9ywYGH
         sKn6o1/7EGOVzRtu9ku8Rte9lVG64Of0FkYV9QjMSd3X7FPDGsHNV90laTDHScqqkOsJ
         BcTg==
X-Gm-Message-State: AGRZ1gI2ty6aDSby2Q0NWvG3rVUuKgFI2T/NxtQuLlJ6qXcjcAgtzUwd
        SRr6pJwoJcanpiDbtxS9wl3ZVQ==
X-Google-Smtp-Source: AJdET5eQn66GzZ2nyBKSSUuhU5i38JbGdeq27b0dSEULrAIJj/V4WxIk1bmIIgeaGVA3OSWlrFPPFA==
X-Received: by 2002:a2e:917:: with SMTP id 23-v6mr2662810ljj.1.1541805083226;
        Fri, 09 Nov 2018 15:11:23 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:22 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 19/23] dynamic_debug: drop use of bitfields in struct _ddebug
Date:   Sat, 10 Nov 2018 00:10:17 +0100
Message-Id: <20181109231021.11658-20-linux@rasmusvillemoes.dk>
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

Properly initializing a struct containing bitfields in assembly is
hard. Instead, merge lineno and flags to a single unsigned int, which we
mask manually. This should not cause any worse code than what gcc would
need to generate for accessing the bitfields anyway.

Actually, on 64 bit, there is a four byte hole after these fields, so we
could just give flags and lineno each their own u32. But I don't think
that's worth the ifdeffery.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 12 ++++------
 lib/dynamic_debug.c           | 44 +++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b9424097df37..e1be30e8422b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -20,7 +20,6 @@ struct _ddebug {
 	const char *function;
 	const char *filename;
 	const char *format;
-	unsigned int lineno:18;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -37,7 +36,7 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	unsigned int flags:8;
+	unsigned int flags_lineno; /* flags in lower 8 bits, lineno in upper 24 */
 #ifdef HAVE_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
@@ -46,7 +45,7 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-
+#define _DPRINTK_FLAGS_LINENO_INIT (((unsigned)__LINE__ << 8) | _DPRINTK_FLAGS_DEFAULT)
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 int ddebug_add_module(struct _ddebug *tab, unsigned int n,
@@ -78,8 +77,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
-		.lineno = __LINE__,				\
-		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		.flags_lineno = _DPRINTK_FLAGS_LINENO_INIT,	\
 		_DPRINTK_KEY_INIT				\
 	}
 
@@ -104,10 +102,10 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	likely(descriptor.flags_lineno & _DPRINTK_FLAGS_PRINT)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	unlikely(descriptor.flags_lineno & _DPRINTK_FLAGS_PRINT)
 #endif
 
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dbd837f486f9..9d4c840ff0de 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -53,6 +53,18 @@ static inline const char *dd_format(const struct _ddebug *dd)
 {
 	return dd->format;
 }
+static inline unsigned dd_lineno(const struct _ddebug *dd)
+{
+	return dd->flags_lineno >> 8;
+}
+static inline unsigned dd_flags(const struct _ddebug *dd)
+{
+	return dd->flags_lineno & 0xff;
+}
+static inline void dd_set_flags(struct _ddebug *dd, unsigned newflags)
+{
+	dd->flags_lineno = (dd_lineno(dd) << 8) | newflags;
+}
 
 extern struct _ddebug __start___verbose[];
 extern struct _ddebug __stop___verbose[];
@@ -111,7 +123,7 @@ static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
 
 	BUG_ON(maxlen < 6);
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (dp->flags & opt_array[i].flag)
+		if (dd_flags(dp) & opt_array[i].flag)
 			*p++ = opt_array[i].opt_char;
 	if (p == buf)
 		*p++ = '_';
@@ -157,7 +169,7 @@ static int ddebug_change(const struct ddebug_query *query,
 {
 	int i;
 	struct ddebug_table *dt;
-	unsigned int newflags;
+	unsigned int newflags, oldflags;
 	unsigned int nfound = 0;
 	char flagbuf[10];
 
@@ -194,27 +206,28 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			/* match against the line number range */
 			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
+			    dd_lineno(dp) < query->first_lineno)
 				continue;
 			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			    dd_lineno(dp) > query->last_lineno)
 				continue;
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | flags;
-			if (newflags == dp->flags)
+			oldflags = dd_flags(dp);
+			newflags = (oldflags & mask) | flags;
+			if (newflags == oldflags)
 				continue;
 #ifdef HAVE_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
+			if (oldflags & _DPRINTK_FLAGS_PRINT) {
 				if (!(flags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
 			} else if (flags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
-			dp->flags = newflags;
+			dd_set_flags(dp, newflags);
 			vpr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dd_filename(dp)), dp->lineno,
+				 trim_prefix(dd_filename(dp)), dd_lineno(dp),
 				 dt->mod_name, dd_function(dp),
 				 ddebug_describe_flags(dp, flagbuf,
 						       sizeof(flagbuf)));
@@ -537,10 +550,11 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
+	unsigned flags = dd_flags(desc);
 
 	*buf = '\0';
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -548,15 +562,15 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				dd_modname(desc));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				dd_function(desc));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
-				desc->lineno);
+				dd_lineno(desc));
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
@@ -807,7 +821,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dd_filename(dp)), dp->lineno,
+		   trim_prefix(dd_filename(dp)), dd_lineno(dp),
 		   iter->table->mod_name, dd_function(dp),
 		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
 	seq_escape(m, dd_format(dp), "\t\r\n\"");
-- 
2.19.1.6.gbde171bbf5

