Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6CBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFB420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CgacSZn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFB420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeKJIzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:55:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35707 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbeKJIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so713146lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zA3jXv5BwmvrTp+thE10lUJ1l9/RcLdDyVc1hor/QEw=;
        b=CgacSZn2X4rLN7XgLyqzMjAvclCpVIdnt6qKmwoKY5pacJmrW/nSI47wv5uHhynAWV
         6JhlO7MPOLVLzK2CmyCeFGgf4IO5jByfSzUx8tHp6rVv/6zCXJU66c62wZ+08BbYU18o
         jVH7oZ0q2voBigVxZJj/8yZ/jKyLkoqbPjEkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zA3jXv5BwmvrTp+thE10lUJ1l9/RcLdDyVc1hor/QEw=;
        b=qoNBLIq3N3bIIjR7EKRGsQor/vdA4LVtk5GirWT0FDgEOVELvWBg9o40xUMU0yD68L
         ltkxW4dcTXaKFQNzZKCMgw1PsqKCL9FzQHwSlaG9lCgMftsOSeLVkieHVaRHWHgu1wDe
         7mTJil8/q57JelzIp28AqWrrfZwzyjzzJOOK/4j5pQ0y5gg1QF3pbx52U6yTelcymsDs
         mV45wZVUlynZrQf5f/VLh/ySt4j0WGdNcXGmjNFhP6guH6FcY/DeHruXddu9EEpjmmz0
         yLEbMg3qUt7Uikx2noheJv4mVbQ2Kz028wqCxKsJMfyLMVSIvVdOxFd8CiZf0ypWZ1VB
         OcfA==
X-Gm-Message-State: AGRZ1gIaLXntTAWxHuY+HUhFr5HGUzh0IhnVtBZTmBmYAQ3Ou4gXMecl
        CkPmUU4KrWK+7s7NePikyxZdYA==
X-Google-Smtp-Source: AJdET5e5sgLWNLk5En+aW9pc8+bCOaWSsXGjsmvrbCof6zNTLjYY9uR8xoptmrYeJXI5rLdZpuM+aA==
X-Received: by 2002:a19:750a:: with SMTP id y10mr6488689lfe.43.1541805065962;
        Fri, 09 Nov 2018 15:11:05 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:05 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 05/23] linux/printk.h: use DYNAMIC_DEBUG_BRANCH in pr_debug_ratelimited
Date:   Sat, 10 Nov 2018 00:10:03 +0100
Message-Id: <20181109231021.11658-6-linux@rasmusvillemoes.dk>
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
2.19.1.6.gbde171bbf5

