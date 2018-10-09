Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9DEC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E300F2150F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BZKFZX3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E300F2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJISgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:36:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34066 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeJISgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so1330280eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbKzguH8Zx9359J1RlWTzJqi3SVOndEcPSlJxthaAXI=;
        b=BZKFZX3kE5/4CGxbfhZXCy4luEK+JAMy5hu60rUfh7+b2sLIAN/4gKsmO0QsXv9gQi
         vwPjJIwjQk2pcyh/2vrdvoVKBS2okDoBhtgxZzBGEmpTGSQtxnM+okgGpJrXJwqQU0kH
         QkYiDPi8ZlLCXCFA/FtXGgIiTyJgvPqoH4nIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbKzguH8Zx9359J1RlWTzJqi3SVOndEcPSlJxthaAXI=;
        b=uPX20qWPS2nYxr/O7D4+hT8r3HkLmxSOuVfR18XzM52Fc/MQdQocgK+fEvYetNyoL0
         KvQ6PRhOYtF+mk53hwmaY841jkJNBiaUxrPHnQ9JP6dfvzAMmQbaqinbIeuF2oBCim3k
         ZlZBNZrwotNErjYwypmY6T1MI2P17oQNVjuD41fmyMHZ1PTxjMIa8JKRxPW3uC/YyS4e
         /NcQmKV4NvOwWmW8+XJsbK8pdevg0yS9uKzeQGDwgn5gsFnihdYnc47n29lRcIUkwsKj
         ApszCzSNJC8HE+04uwiDdku2GIYREmRqk+6W2QdHLpq00MzPm7YPoaeNUfx7rFuaRYPP
         1acQ==
X-Gm-Message-State: ABuFfogoiIiPEvfEpYu6ODG9RTIgJ0zzc4tlZL8M6cRd4p+dvvLaNeVf
        GQ3HPkKicAPp5ZWZMVoUyrSpXA==
X-Google-Smtp-Source: ACcGV63nh+tkQJsPZhUid0UDS0NJ1b2veQavTmmA/qT9cMjUQV/veSwTk9llGE31VtByM0z3mpG1EA==
X-Received: by 2002:a50:86fd:: with SMTP id 58-v6mr2495214edu.15.1539084023344;
        Tue, 09 Oct 2018 04:20:23 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:22 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v2 03/23] linux/net.h: use DYNAMIC_DEBUG_BRANCH in net_dbg_ratelimited
Date:   Tue,  9 Oct 2018 13:19:53 +0200
Message-Id: <20181009112013.14238-4-linux@rasmusvillemoes.dk>
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
2.19.1.3.g1d92a00e68

