Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D4BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DAA20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjFo4+as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DAA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeJ3E7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:59:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43827 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJ3E7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:59:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id u18so7062764lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QS6dZ87sS3U+xHgd+KUKlmFdyksLdCO58lGethbtJOA=;
        b=AjFo4+asqBnPn57OXLgcAUHeRkwLFyckPVV8/QACUpx2hb1BWqoEMs8m1spz9KGyzt
         QrDBusfofKPqiqWs50uAT5f5qwubP6X9upPYyzqkFS/r7hZWbcoN/J4kusl/vVf6ZZJU
         adb+p8RWqPXNJvflgRP1S3pUeccH2jHv7Clnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QS6dZ87sS3U+xHgd+KUKlmFdyksLdCO58lGethbtJOA=;
        b=CphmuYj2DgztKqNWKeGrXwf3hc+Cz6YtOPl3r8Z4tJCHjYRUvKsiR0r8ODHsIV3s8V
         AZF9uBueag0OrOX23pg0uwjNH5ibgFBLqzr9qxl+F3X6qqwbNOrQTbBDwJHwa0fi0bk8
         e1ACWY3U208iK9ZtAqPppO7bKm43HASK8LYVXvINI0HJ3FisOE23ATNFK2E4r77Q1rwW
         ok2SZW7ZuR2OWP5zMGs0XbBsQfg2UF3mAFYqlj7k+FVdJm+uzrkQDcR/I9vF5vqVg+Vf
         UaudhjdfzFvWhzq16dDev2jbztbCoTL+Hp5jD4sPBTSZRdXWi8m5TfKh6SlXapM1CJG+
         v4Fg==
X-Gm-Message-State: AGRZ1gJkf7gADCb4FHaDGg+GhDBT9SmwawHk0x712bMtdanT3fCSoCjn
        qUjCaXJKIi+mlOipO6IxiCIufg==
X-Google-Smtp-Source: AJdET5cj+hUF9n4b3kBkGH7Yb4e2gZ94cKdtJ0vZPx1ce3zT/0KCXGnk5sYhh9dDQZJY2y2ftM+nEg==
X-Received: by 2002:a19:d145:: with SMTP id i66mr85731lfg.97.1540843762571;
        Mon, 29 Oct 2018 13:09:22 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id t73-v6sm2894333lje.23.2018.10.29.13.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 13:09:21 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] kernel/SRCU: Fix ctags
Date:   Mon, 29 Oct 2018 22:09:20 +0200
Message-Id: <20181029200920.28901-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctags indexing ("make tags" command) throws this warning:

    ctags: Warning: include/linux/notifier.h:125:
    null expansion of name pattern "\1"

This is the result of DEFINE_PER_CPU() macro exapansion. Fix that by
getting rid of line break.

Similar fix was already done in commit 25528213fe9f ("tags: Fix
DEFINE_PER_CPU expansions"), but this one probably wasn't noticed.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/linux/notifier.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index f35c7bf76143..0096a05395e3 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -122,8 +122,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 
 #ifdef CONFIG_TREE_SRCU
 #define _SRCU_NOTIFIER_HEAD(name, mod)				\
-	static DEFINE_PER_CPU(struct srcu_data,			\
-			name##_head_srcu_data);			\
+	static DEFINE_PER_CPU(struct srcu_data, name##_head_srcu_data); \
 	mod struct srcu_notifier_head name =			\
 			SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
 
-- 
2.19.1

