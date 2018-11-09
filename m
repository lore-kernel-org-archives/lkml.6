Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E26C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F1E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="A8wzIs5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F1E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeKJIzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:55:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37798 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbeKJIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id p17so2505870lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXZ474A5qatt+7Auyj7430sAVnYt/gcAddDmQbWpJtw=;
        b=A8wzIs5WmkiW9d2evMfg9DM5rXANVGFJNlEQva8hfqMrWTg7ye80vm2QBiM4VjpAoT
         QQeJ9LAe3bmxpOHdSxKWuLc0tJGPaGvKu4ii76OZAtkIORdx0K2UHG5FeegFQXt3HYu0
         u6VZOKOohBSTUTOa56YPCieJ0Xn0SNzncTkKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXZ474A5qatt+7Auyj7430sAVnYt/gcAddDmQbWpJtw=;
        b=J3SYXCRJQyoPI544N/hp4joSC/5lGt8NxJ0dWYQrlh5WVij7ZHA1xr/KsMOb1Uy3LI
         2Fm1hrAgGncNaZAfIgxGUwriteGhXluuLf8Gg2yv5ElReR13RDk32WHvTl8QoVWYO1Jb
         1AEkve4HD/sTMjom14cowDfVcqxg1RpomRKKDaH+eMSidqRQEMeeEleJrrPnQg0xF5n0
         fOsi3VOZDnD7rHsHNYlvGSA1k9SFyf+SJygu58cC+XxSHHbJfP3S4YobzrkZf04nEpwO
         Ibf8/hG4/CiKXWy/UXLo6PcKpusunDVHbRbbuwhh3DHa5PvaVolZ+YsWyfI9ergY2stO
         xEAA==
X-Gm-Message-State: AGRZ1gILO6RRCZAbyzsDpnILBJY8ECzbBLS9QhL7PBBKtIAaIgNOhyBI
        oM1/PsPds3imEOc5nfUxrrzSlQ==
X-Google-Smtp-Source: AJdET5dKL0OqzgnRyqEeSg8inKRAA5do6EA7lslSRziqjZ8Ho9mFZfAoll4PzzQUztsy88XNO+yCYw==
X-Received: by 2002:a19:6514:: with SMTP id z20mr6146264lfb.31.1541805064785;
        Fri, 09 Nov 2018 15:11:04 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:04 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v3 04/23] linux/net.h: use unique identifier for each struct _ddebug
Date:   Sat, 10 Nov 2018 00:10:02 +0100
Message-Id: <20181109231021.11658-5-linux@rasmusvillemoes.dk>
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
that for net_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Cc: netdev@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
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
2.19.1.6.gbde171bbf5

