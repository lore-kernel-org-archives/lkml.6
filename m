Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0805DECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF306206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Acw7Zrbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF306206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeITDpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43212 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbeITDpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so6147800edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnAb6cCBC8ah3DmJhREWNHBuYwNcmaAAPZ+lXSIi240=;
        b=Acw7Zrbj35k1L7Zk+2zd/dNVQQfI/RS/7MKg/XUdrlV/l2GQvNKgaX8yCWNS8t7Xma
         Cy914RSZw/cuOGeyBCxck6Or/niZdAHplzI5X9gT1ablsmdMBGPOusecCJRpVexQc+CH
         d6HCEYl7846MsWD+/8IEiKokSGh5vjVoUe1G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZnAb6cCBC8ah3DmJhREWNHBuYwNcmaAAPZ+lXSIi240=;
        b=e/wA22Ko+DiAh1p+DwzgbykZCHsPGTrzsKnMS9KH2zjloznqIfMWjYSX9mwYW7mcyZ
         BzRYaU3Sl2OplZegvqF+i26yNMP5B7ZksC2CAuhiEpwMb1ebrbqYrrqEV+ggKsajKKjQ
         aZPgk1SPmf+iBM4MDAXC8GZwlviYKOcc9wxBgBc2Ep6X3LcLzvuh3oKdsfLj58S3SYxT
         yW9U5sRfx5LCtx1DFNaBEnyvMEnE1bs5qHAffbhxT8qS4b9+DG17jsucpE/f48G7CJHQ
         N/N2JzttgfNbYSIIImTqEJmpcFy0NvQcOYmKqBebctwZ6ewWWSLHjq1SZMON2grSaYHr
         b8Vg==
X-Gm-Message-State: APzg51BqKgoINGsJTULS6wiYEfBxKEk+uCS1soohj+N5vDBOJImM6Bk9
        U7FVWATlj8WQUi5zrCkqaO7Nfg==
X-Google-Smtp-Source: ANB0VdYOp5gDvqteWKMJMBBVhe6Q+1puUZEkLxTZjtiOxge5iqQ6XqKYrBcaxJH29ERfENH+Nu+GIw==
X-Received: by 2002:a50:bb69:: with SMTP id y96-v6mr62368010ede.10.1537394714619;
        Wed, 19 Sep 2018 15:05:14 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:14 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 17/22] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date:   Thu, 20 Sep 2018 00:04:39 +0200
Message-Id: <20180919220444.23190-18-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With coming changes on x86-64, all dynamic debug descriptors in a
translation unit must have distinct names. The macro _dynamic_func_call
takes care of that. No functional change.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e12d5ef1a054..83bacf9039e9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -977,12 +977,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #else
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define acpi_handle_debug(handle, fmt, ...)				\
-do {									\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
-		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
-				##__VA_ARGS__);				\
-} while (0)
+	_dynamic_func_call(fmt, __acpi_handle_debug,			\
+			   handle, pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define acpi_handle_debug(handle, fmt, ...)				\
 ({									\
-- 
2.16.4

