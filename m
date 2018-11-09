Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BAAC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7F020855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ROfAT1QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7F020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeKJIxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42968 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeKJIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id q6-v6so2485872lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5H/2BQHGZLrKM6jSLCP6CQFWR47Yx/RzZKSAa86TREo=;
        b=ROfAT1QDitdlouUzw9O+xCIpRb8UnESgKrD4Jmpq8YtwSo0o7Tnc3CCjw4VbFKI0Ot
         yMiK5zyqU3DR5RPrI1q0aEVPTzU/rCJKDS4+/7dbYDZdPOL9A4+OI+58SBqp3pqJ6rgJ
         s4VmWmN9R8pLOOj/UMaPV9XTPhr+GB3ITBqUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5H/2BQHGZLrKM6jSLCP6CQFWR47Yx/RzZKSAa86TREo=;
        b=pV/puIqMe8eaGu4KAhArOByF1dJ6dAnenvdDeH/w0PQGkLMMhBlBZ0V3jOKmrK+6Ve
         6zrfs3HXsNkKVbh5kG+hOIWCB53MAidoH1wuQBD1/UX/oSwYzui+bE1MkL9nFweq31s/
         I+lnsN99TMNwH41bRZdbs7DF30/4pSnSwedvxJTXWl9DAKbHpaupjaIGz8D91McKVRsq
         NKW+g57RvhWjsi3WjDD/HLVLAT60wc5wpVU1EqK5+vUxmxNIUKor5oFbbwBKA/LZeXO6
         KiDl8KpTY5fScWhUGcVN4dC7wgxYZhkA48dqxSuaPMGVZNejkJNhHy+bUjMeLbPR21fr
         D9Tw==
X-Gm-Message-State: AGRZ1gIkr4wACGLrUZohs9jUQRSo2f0guiTGMNvmIrFFguuojkijteCa
        mgDfqfDseZ8odkbg18gDwfJalg==
X-Google-Smtp-Source: AJdET5f3Bn9Fv4uatOCunOWQx1Ji8eQq6PNf7NUpZLY0TgHri7ESjGrBugn1K6xyb6yZiCqZx8ppDw==
X-Received: by 2002:a19:cec8:: with SMTP id e191mr6344662lfg.13.1541805063367;
        Fri, 09 Nov 2018 15:11:03 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:02 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v3 03/23] linux/net.h: use DYNAMIC_DEBUG_BRANCH in net_dbg_ratelimited
Date:   Sat, 10 Nov 2018 00:10:01 +0100
Message-Id: <20181109231021.11658-4-linux@rasmusvillemoes.dk>
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

net_dbg_ratelimited tests the dynamic debug descriptor the old-fashioned
way, and doesn't utilize the static key/jump label implementation on
architectures that HAVE_JUMP_LABEL. Use the DYNAMIC_DEBUG_BRANCH which
is defined appropriately.

Cc: netdev@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index e0930678c8bf..651fca72286c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -263,7 +263,7 @@ do {								\
 #define net_dbg_ratelimited(fmt, ...)					\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    net_ratelimit())						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
 		                   ##__VA_ARGS__);			\
-- 
2.19.1.6.gbde171bbf5

