Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F091ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A79206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="W0Bg8h21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A79206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbeITDox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44984 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeITDox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so6146066edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Av/QbXrtGl2sZ3B3dVs/I7MgqzR6B1VGUfMvV4GEX70=;
        b=W0Bg8h212pEdlh+Awvd3xXpyKeJe0zXT9e2wx/wq/sWYsb/Hw/PSOYyvcvkOevc15k
         EzyrtBfHR3eY4B6phUcDk6AXvYLHHjLGf4aW4KGF/vlEJ+jU0oG2lcI+lFD1pGIdbcaO
         WH0ed7+tJFL5RcX/zh3fi4tpWo+EdkQHYE8Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Av/QbXrtGl2sZ3B3dVs/I7MgqzR6B1VGUfMvV4GEX70=;
        b=fulAxvaYpU5Wm1ul/R+BNm1GYKED3oH0TJn68Bzf8drkCu8EoGeMAHuxJZHZK6uosK
         LVNSiybRSpV8n33F7pdzWBnJ7MAzWDWWSdLEqu0z4L3VU3BxXfkZQEJAFCuGsId+9Lc7
         nUDXghRANx8+sMW3BCK667h5yhNRKa5HRhetez9uMlDjzTvoTQ/rxY8k0050B+10YYrM
         6au19OeXuzVoQmdBZ+rp/uA6QaKRRSV4CTbL3DpRefz/egVm0v2SlNYqQsN38xeNDRPo
         YmTR5hOCf/G3eInt6ryz6Af8DqqcElx0TbhKRuluhfCiKGrx1UCCadrDI+K2ozU3lcRg
         B1MQ==
X-Gm-Message-State: APzg51Dj9TxdDikx0eukAOQiPKCJSpSVb3jj2aZQtNmToORM730MjcFU
        TP9x27e9rGyToTa5LzZLFMxBhg==
X-Google-Smtp-Source: ANB0VdaLg4iQlEpV/LrKrfc88JUtvctwrF0ItWQL4EeGW3cDtMBsysuwGqScy4eA85XBXbURb/gGNQ==
X-Received: by 2002:a50:b12e:: with SMTP id k43-v6mr61656865edd.269.1537394695579;
        Wed, 19 Sep 2018 15:04:55 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:55 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH 04/22] linux/net.h: use unique identifier for each struct _ddebug
Date:   Thu, 20 Sep 2018 00:04:26 +0200
Message-Id: <20180919220444.23190-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for net_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Cc: netdev@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 651fca72286c..397243a25f56 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -260,7 +260,7 @@ do {								\
 #define net_info_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_info, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
-#define net_dbg_ratelimited(fmt, ...)					\
+#define _net_dbg_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
 	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
@@ -268,6 +268,8 @@ do {									\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
 		                   ##__VA_ARGS__);			\
 } while (0)
+#define net_dbg_ratelimited(fmt, ...)					\
+	_net_dbg_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define net_dbg_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
-- 
2.16.4

