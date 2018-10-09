Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9417BC677F0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A10E20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HSZ/nAGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A10E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJISg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:36:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34068 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJISgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id w19-v6so1330388eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7Zavo18W+dgKjFasc7fnyMrIhwvyXuFM0QJyhWeM74=;
        b=HSZ/nAGGmm58bJq0dtq+D/Fc22JmtOqzWK8YfEFuvpilMxDEhj50bmpehoLcyYyE2v
         TT4gLhFf7i58AVgPNUwiVI2W63n7fw3eS9npz7+80KJkNYZ2KTKhW6lAWsYK3TP7+4SX
         tUFtLDWRM5G5UIcHmm6vZe2guBXUrLst2DnoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7Zavo18W+dgKjFasc7fnyMrIhwvyXuFM0QJyhWeM74=;
        b=UNgqz/9ijrqT/Fk1KhJE9Lom9RzpU2z9yWTnTkJvpBDmlykYV+Uslz5MPcpYAwicVs
         ghDNO4SJD4MnGOUygpUBmkwpyeOwloNMdXaR5BNoX4BO4iGqkdtVlGzqpxNHBuGqoYlt
         ZWBC7KpwEkMRuJZrXWwrjPbjm3oiVm1dp6ZYB8Ld9R8WyStgHRVV5IautX4DfAHxoASR
         p0JZ/N/Dr1NfUADdv/4rUXKVwGR20TYDKwg76VidbKgmZ+yF4+QO91iRifakWIu/pGU5
         7E2DZBi+Q9e97mPYVUOSMfgXcscBMDXrW6iMCOQWtYMQK8Tg9Hr4546Bn74GR8aitUol
         OGTw==
X-Gm-Message-State: ABuFfohMRImFKIpLlJjwYOnGTVspaDy47phnga+YqVYrOV7Q7YnHpvua
        Wn/EDjhYqhDCJyPC57OFEsx7eg==
X-Google-Smtp-Source: ACcGV610YWO4iwpzdNd/tFMcfIZzTmGDsQZP8H4NPFxhIUmmXM4M3edthcVJPuJH7F5x9pejQGSLAg==
X-Received: by 2002:a50:ab81:: with SMTP id u1-v6mr34298768edc.259.1539084025327;
        Tue, 09 Oct 2018 04:20:25 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:24 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 05/23] linux/printk.h: use DYNAMIC_DEBUG_BRANCH in pr_debug_ratelimited
Date:   Tue,  9 Oct 2018 13:19:55 +0200
Message-Id: <20181009112013.14238-6-linux@rasmusvillemoes.dk>
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

pr_debug_ratelimited tests the dynamic debug descriptor the old-fashioned
way, and doesn't utilize the static key/jump label implementation on
architectures that HAVE_JUMP_LABEL. Use the DYNAMIC_DEBUG_BRANCH which
is defined appropriately.

Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/printk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccfe1543..d3ba3245531d 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -466,7 +466,7 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
-- 
2.19.1.3.g1d92a00e68

