Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E120EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8852086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJkv5NHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8852086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH1TgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:36:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40044 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1TgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:36:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so1816218ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gbD1om2mYQoJhBmlemn6HuiD+4IymnviyedOr+tDlKQ=;
        b=HJkv5NHvYPut8QXc42yJC8XrGNbyRgnec0tlgBidpTte3hzDbmEwfhYmj9otJlPPTK
         4rfCNy1Gx6MPIfV9AUNSuDTVH1sbRWBtIdbyd2Cb4o3bBtvaKd2q04TveQcG4luZC6D0
         KwRw4e8ktv7JzgppjhGi7lIIgcx+y+2yT7DGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gbD1om2mYQoJhBmlemn6HuiD+4IymnviyedOr+tDlKQ=;
        b=eVU1656df/sbm0Zesn+hKqSQ+ByrBV+QyaXhrG8evriwWNsb7Ew+B07DjX/8nS4OpY
         cEhKodq/amJ9cCsC7qmAsD8IRdO9Cg/ODOkbH1K4e4iq/9dDgNLT+OEElownIrWkcO18
         dWWmSs/VEljaBBw6GsK47YAgbm/ZczkSc8PBVBtWcWpiR4+01RWYyleN9PWfzjCsZ5a5
         ufrYx9pH8tZqNCWUZcpF1AshAgkyDxqE+fZAy+aLHpvtKTkRHeWM0c3qE16UdiRNU2K1
         F0sC0vijgXxDyLnmytWnhWRFh/REK49V75OdVNd1JKR5SuQPQ7IfOo5BsviXKeS1Fovo
         q/uA==
X-Gm-Message-State: APzg51BvYAJSZ61dggO/0peOAlVWec3+CrKDGMuEXAHlm8/DOvhjm2A6
        BoummGgq7RSUTtIALj6U8XNySrbkloI=
X-Google-Smtp-Source: ANB0VdZS5vUm6NRrR5xeiS+OdqTmmdS8ktWcm9BEH9aclrCAdrsQHoIKVTGsTZQQBSYlF9v+iHd31A==
X-Received: by 2002:a2e:658a:: with SMTP id e10-v6mr1500350ljf.99.1535471045518;
        Tue, 28 Aug 2018 08:44:05 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id u84-v6sm266200lff.35.2018.08.28.08.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 08:44:04 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] kernel/SRCU: Fix ctags
Date:   Tue, 28 Aug 2018 18:44:03 +0300
Message-Id: <20180828154403.9207-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.18.0
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
index f35c7bf76143..2c6ff4cde938 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -122,8 +122,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 
 #ifdef CONFIG_TREE_SRCU
 #define _SRCU_NOTIFIER_HEAD(name, mod)				\
-	static DEFINE_PER_CPU(struct srcu_data,			\
-			name##_head_srcu_data);			\
+	static DEFINE_PER_CPU(struct srcu_data, name##_head_srcu_data);	\
 	mod struct srcu_notifier_head name =			\
 			SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
 
-- 
2.18.0

