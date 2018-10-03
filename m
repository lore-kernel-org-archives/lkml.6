Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35A221470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="a1vIf0fU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35A221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJDANL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:13:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33403 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:13:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id o21-v6so4755069lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=utv6fEpwR6QLfcyWWwvXTi4UbTJ6FH6NK3F/Ekoe3DA=;
        b=a1vIf0fUhFtjdwwIYhCB69iB7lpdS3+PBAxjs/aot/VZHk+FTbxEmxJSXS6LIsdf4A
         K71mHBU0uEwUJjUHq8nBJiVZVFHFJMtw4cjTWoCTeAVx3zzhxfcdZ8wXUUr3AT0xltsy
         kaT8Or1TtUeWpit2kdY8m3qv+0+TlmnKonS6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=utv6fEpwR6QLfcyWWwvXTi4UbTJ6FH6NK3F/Ekoe3DA=;
        b=qxSSb5GnXQQ4vKqWH5tL2MEpH30H434tDqOYMRde3d7Gvh/SWtOJ624FOXn2Wzb4In
         k//y1zW9RB0IQFyPtxBMfqspG/lTg4MJGm85I7YxR/WGkor7Wb9sBCgixcrKUTCAQGWn
         ScH0pn5aRw7HJdDUmYum48KLvx2RWPJLfMiy4i9JtrFaHzZeQ2w78HtwhYlgszKREnHR
         5/YO6sV2M2nC4+ckHUFn21/ebh/lapaCI766NAZjjB1TMYKXs9OdI/23nSVcgwq+bHhi
         LENQcmiAcDPRFuF1M6diIfj5E/ULYpw0LLAwsQAyTUR0/An6R9Ma9JPc/08yGLjTEs67
         3pQg==
X-Gm-Message-State: ABuFfohDBmYYXh1w2994/X4qp4IgiOjiI+SjLNGHhuhkvN7jn00wje/3
        XX4nUKxOHgFxpu2EDPolO2WK6g==
X-Google-Smtp-Source: ACcGV60k6rD8Md05wKIDwUDR9PdQcJw0KRMU5diuz8UDS9mAIQzWapjgYqVUg+AkYKwe3a/A2fS8ew==
X-Received: by 2002:a19:a3d1:: with SMTP id m200-v6mr1537650lfe.38.1538587429578;
        Wed, 03 Oct 2018 10:23:49 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id d126-v6sm471174lfe.75.2018.10.03.10.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 10:23:48 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: delete duplication of BUILTIN_DTB selection
Date:   Wed,  3 Oct 2018 20:23:35 +0300
Message-Id: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BUILTIN_DTB selection is duplicated in menu
"Machine selection" under MIPS_MALTA.

Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3551199..71d6549 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -539,7 +539,6 @@ config MIPS_MALTA
 	select USE_OF
 	select LIBFDT
 	select ZONE_DMA32 if 64BIT
-	select BUILTIN_DTB
 	select LIBFDT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
-- 
2.7.4

