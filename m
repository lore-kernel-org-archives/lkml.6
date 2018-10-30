Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2FEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD29620664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOeaD2YD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD29620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJaFXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:23:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34144 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeJaFXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:23:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id n26-v6so9970015lfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIW1UYQw4eKeTZv5sBJ9BCIRK6s/SbrfrZFiIpToa6s=;
        b=bOeaD2YDMx+BPaoXbX6DUOsR8Wd71ECXKNBYUH90AzQCBYioqxQhSPexpnHGOGrfr3
         Un17H3pQ7Bqb/3IlQMPYWzwOap8U+PCF8O+2igRyvDeXqkVTDmKriYpNXvQIKzC13NHO
         vNkwqW54ZFpKrs/F+VD1AAx2bCXV+u4f62fnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIW1UYQw4eKeTZv5sBJ9BCIRK6s/SbrfrZFiIpToa6s=;
        b=jND5XaJYlfKiNDDJLhmTYNDQwxR+0ophqh+cbc8skWhhgXR4H/BkxG9iX0RfnDNC/H
         De1zARI3im8kAmS4y3kC+T02wknIys1fgtvE4nGBskoAaocVwtiYt2Tv8WkBKnqgHP/m
         fbAcftJZw0VYumw5ig8TEHYzqQkZG8uDcrJhmpBCKKUjRZEaL2S48rLphUX9e7TA25SQ
         EPWIx/kXH3hwylpzGp8/px4laTlrYD8l9TwTH3TYoGRJ9Z7OXwqiG63MN+cw/CLtlQja
         86ypSrW6ClGmXxvU8V6YmyRw4OYzYuu5vyVB5r6/wNgHBtnx01ULGg/gJFSyOVwb08N3
         HQJA==
X-Gm-Message-State: AGRZ1gJeq10jDmn4zkKQWpMDbGhkc8FfEa3Be4a9Yy3ImEZUHWI1q6oh
        XI+xgPiPc8vefGkzY68tTg+Iaw==
X-Google-Smtp-Source: AJdET5d2MdZT2SmiwXwZNEO4ZZp+OyQk+OHrABe0C7J2pLIqYmETGQ2u1TfWtQe0rx62ZAko8zZnQA==
X-Received: by 2002:a19:9844:: with SMTP id a65-v6mr118404lfe.63.1540931290586;
        Tue, 30 Oct 2018 13:28:10 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id a9sm1312322lfi.57.2018.10.30.13.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:28:09 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] kernel/SRCU: Fix ctags
Date:   Tue, 30 Oct 2018 22:28:08 +0200
Message-Id: <20181030202808.28027-1-semen.protsenko@linaro.org>
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

This is the result of DEFINE_PER_CPU() macro expansion. Fix that by
getting rid of line break.

Similar fix was already done in commit 25528213fe9f ("tags: Fix
DEFINE_PER_CPU expansions"), but this one probably wasn't noticed.

Fixes: 9c80172b902d ("kernel/SRCU: provide a static initializer")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
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

