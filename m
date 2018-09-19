Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6327EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1916A21523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Moqdm828"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1916A21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbeITDq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:46:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37973 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733065AbeITDoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33-v6so6182562edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PK3LkoNJia1hIoJZkFXKIO0xhNkQIyjxNK31kURH6Mw=;
        b=Moqdm828naAmPBT2vX7cIx5Z4pVA0aPZUt6vxZOidum2nS2hNzfTGZFxvMZ4ySPU7J
         ScA2wrHxJH/F4vAU61JNgX8Ww464Ou94MOgc0t2heogCtlmRdnvXUcrlE8RTdkyFUlpk
         UnnDYWGutFzvOcMIkkJdoi6pwDJxBUeF4jxTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PK3LkoNJia1hIoJZkFXKIO0xhNkQIyjxNK31kURH6Mw=;
        b=jGalTCDvZqqIaMECGSY4kr3zJOgSMryLIAkx8+1o/pOO2XHWBMRzq2nPMw4SjAleLm
         6hfY1Jo7Ema5q03IMMRQxglXPQ5QUkyXdBYMRUk8va3HhncXgNJspa1rb0Z9WMqDI66i
         JzrhbshBlwf5ue/lh+efHtMmmfk5xf05QvQb87yxWxJhuz3GiSwqJkGUNqydBE+CH4Dx
         Ch1E96DtKMIfWUQtjTpA5E+s2p2NzatLAf3IyrGepMP1FGEd4Ulqstt3+RYpi+DFJVn6
         UdkiWPIMEKaPejEPwhWzRED741s5UbZyoYBfvlHzbTgV26qwtvQlaZLCCCaWZjsxl20l
         N3+Q==
X-Gm-Message-State: APzg51AQ+Kj5OAjTUjDV0N1EDzY+RbU1tkQUwUIo7Gv6DE7tzqu6Pl6l
        SnCtdrJXOJPjoU7PMEsra2j92g==
X-Google-Smtp-Source: ANB0VdYxtmpWbEdv3t1xlAfJvedWHMUZq0ysAYSqlZj7j3sMBjFhH8r9C1YSeia4uZsAmIfJeCpZmg==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr61344985edo.280.1537394697798;
        Wed, 19 Sep 2018 15:04:57 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 06/22] linux/printk.h: use unique identifier for each struct _ddebug
Date:   Thu, 20 Sep 2018 00:04:28 +0200
Message-Id: <20180919220444.23190-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for pr_debug_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Cc: Petr Mladek <pmladek@suse.com>
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
2.16.4

