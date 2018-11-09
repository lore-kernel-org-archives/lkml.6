Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE0BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D547820855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="h7nbQGX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D547820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeKJIxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41751 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeKJIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so2964378ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rx+ebopWynv2pOfqIg4NyYDXklKL/npA0QpqYu+ZvK8=;
        b=h7nbQGX/iESnaLlS4Yj7XjQd0DVgwozk6AXiHFyC3wYstW5ijoV2BhZ2Sily9gHS6l
         tKMj2ZUwIQQdhqK4YlvJuoEx8cjOcC+0wCqGy+KXmVtBuzUnyKvjTH0LBVvwzTG/rpRc
         ZNFha+DZiGJ6Li33YIlpTU9gkav6JZ9jNYYxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rx+ebopWynv2pOfqIg4NyYDXklKL/npA0QpqYu+ZvK8=;
        b=dUeT3esO987h9PYZlmspKQ8lfcs5mygezxWcTMSxJbaQNaCxjz4K3K7Fks2kTC+JrQ
         U3HexmUy8EjwFPdi55t/yVhtIhIKM/4NGcVIBRGSv14oY2aFpLhtwsRj5dZClXvYvqjU
         pl/ypAH7SPmMn5iUZyrlvoG/ZwZWUypwwSi0znGrsgQpzTbWlAs2YmhL17/MoObouV5u
         kuVVinaGw5NANlhO/hd+AKRMmG/lyvyVq72SBxo3P/Ldo+wOpYyatqUAGo8RmtVuG49o
         AfcAIhm/NFULedpuFhwz0DAF9hTX/+xDR7rA+7P/hefiYxTQF4BWvYj/bs5UdsJlEu9g
         ItAg==
X-Gm-Message-State: AGRZ1gJHvQCBlhM/oMV9igY1tfKtrFy7VDppmO3TVsiYzDy0KRHfZMAl
        srccrGc/eETAHooTDERnLm9gHT/cI5wg0A==
X-Google-Smtp-Source: AJdET5ciTLQNzw32uP8DaGsYdtsBedlWrdK5u4/fNujfOipOirlmYTUZBgCH5fRRP8IWuUazhFafBQ==
X-Received: by 2002:a2e:9b15:: with SMTP id u21-v6mr6686968lji.29.1541805067090;
        Fri, 09 Nov 2018 15:11:07 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:06 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 06/23] linux/printk.h: use unique identifier for each struct _ddebug
Date:   Sat, 10 Nov 2018 00:10:04 +0100
Message-Id: <20181109231021.11658-7-linux@rasmusvillemoes.dk>
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

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for pr_debug_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/printk.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index d3ba3245531d..70df2c578d40 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -460,7 +460,7 @@ extern int kptr_restrict;
 /* If you are writing a driver, please use dev_dbg instead */
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define pr_debug_ratelimited(fmt, ...)					\
+#define _pr_debug_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -470,6 +470,8 @@ do {									\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
+#define pr_debug_ratelimited(fmt, ...)		\
+	_pr_debug_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define pr_debug_ratelimited(fmt, ...)					\
 	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-- 
2.19.1.6.gbde171bbf5

