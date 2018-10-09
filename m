Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952020835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Q91B24Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5952020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJIShG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46110 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeJIShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id g32-v6so1301584edg.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YnEe4RJi9cJsTZRq5G9IiFZ3ouBP3ndXXuRWxyHLTBA=;
        b=Q91B24AhIgPoFCJs2MwZ/Uo5Xg9F8cKgdwq1EOJLna5ELZcnp57Z25Ex2nByf+gglL
         rz7130IR22TomcVMs3SZKeSZIKngjYkch7Lt3WAvFPuStpLNyiDWpdEUEiQDd7YYa5kX
         8IGjClBlko4OXO1Y5yn9/DQFM6cEX44/Y7LoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YnEe4RJi9cJsTZRq5G9IiFZ3ouBP3ndXXuRWxyHLTBA=;
        b=bZHt62VpOFz25C6Dl89bT5rbLXTmqta+pxQsNjpGBo/cuJ86I+vvY5vx7FuJZwovnn
         PdX6IpjpbFv3rf4jFLoP3WjINK/83ClTvohqPQ/6l2EtChRWalyahpmSePaLdkZpJQV2
         PyD5R2k9vPVunXbGgEwH48g5CoUx6KNDb/nfRU+uG/Hz09LGWS92FeJU8DSOo6ig0vab
         iawXg0cFG5m+gJaYpCHBLEB06ohmG90ZQwyTu0Ch6nU2emHqOmswWc3daoghfLwly5CC
         LBQEOwZHFrla+jpMR8tSDnkraEf352Y972l6PQE47pr5g/ZFKmnHxKnS2TSLFPWwkhNV
         1gHA==
X-Gm-Message-State: ABuFfoioWvL9T2sjm7QoM41dHmOO+savQV5+O7bTuItJSo3TeRNwzl7u
        JkKVOJngNufZdGVqJe9D9PHQAQ==
X-Google-Smtp-Source: ACcGV63euAfRyUgSzPFYjSpTGwNUUMp9dmA1ZWiaPfZrTzS03WeeJePR+lf5oeP8lmgR8XXQsTnBlw==
X-Received: by 2002:a17:906:90f:: with SMTP id i15-v6mr27111939ejd.225.1539084035573;
        Tue, 09 Oct 2018 04:20:35 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:35 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 15/23] ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
Date:   Tue,  9 Oct 2018 13:20:05 +0200
Message-Id: <20181009112013.14238-16-linux@rasmusvillemoes.dk>
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

dynamic debug may be implemented via static keys, but ACPI is missing
out on that runtime benefit since it open-codes one possible definition
of DYNAMIC_DEBUG_BRANCH.

Cc: linux-acpi@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index de8d3d3fa651..21e03aa32aae 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -982,7 +982,7 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #define acpi_handle_debug(handle, fmt, ...)				\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
 		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
 				##__VA_ARGS__);				\
 } while (0)
-- 
2.19.1.3.g1d92a00e68

