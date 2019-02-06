Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B6EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D85D20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VaGpYHLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfBFE5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 23:57:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35345 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 23:57:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so3588335qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 20:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hyT7vucaind/xR3A8bXmjCQBx023N6EByMsSM7Ep6+g=;
        b=VaGpYHLI3k9vl9sAbEUb5GiBtHS+xC8Hhs9+lPDOsVRsD2sA78qtFH41Hzcc1FMbfQ
         BcjMlpRd3/phcWeo02dzpZ5+4v+bkSBrRzGnAU1ph3/12ykH6/e0DPxz9tEbqRjNVcv+
         3DhY8Mv+++L9qeqQxVIgIhCZXnA96MkRI7yZZuVWJOfzVMyWUkk/8yVoAZa88rQB4EQK
         hcRqw2EA5gCCfwgjcUnHM5VxB7adKNHlCdRiPCmIlQhPoIy8nKm75Kls7qT9oOPBAAnu
         ylQI9Zc4XcOFqKVBaNhUZGirCdL/7eu8rHFdujt/7em4VghA8Xj+OA7KSqm652Q6A9aO
         Wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hyT7vucaind/xR3A8bXmjCQBx023N6EByMsSM7Ep6+g=;
        b=pKPQ0+8xWW96YmURThpHzM+2C2WDO7nVjRQMJkAaQ/SXSw6ArgKZawZRL4BoKT4mt2
         +fs7RznQxDdhgCPvg5s5YvXQNUJc5UeigSI0x6f6ouESKuWmPmVZjJxDTYRTKgtkzEDP
         uRE/JhLfPG8WQHYZUWXe+f2iQrI5OD5CJMBmN6VY9kna8xkUei/kphuI5iwjOejqr86T
         IDeyu/c95RCKzD+SqrPIL3r/x6gk55y9wQ8q56//QsJLqrHrUvtecnoHK57tp21M9SS2
         eCLMofsCR40OoFL6OHUScG+5RoC/oMfXI6dl16qbXJnqmg5Qaw7hHlY7N7AuzzHbwzyR
         U5Fw==
X-Gm-Message-State: AHQUAua4YIMgAaXqQ0tH+Aw9BmalEjAGIQO1NwEvj065IrsjUOtN+G5k
        cWyc5IdfhFdTuDSIaK5w7Ez5uA==
X-Google-Smtp-Source: AHgI3IYz+D5+XeBjKYvVYHBgzusMer2xFn0CufjqTWSO380jKjS/vHa74SuA6SBJqAuEF+YP6K/jRQ==
X-Received: by 2002:a37:9543:: with SMTP id x64mr6250203qkd.158.1549429031618;
        Tue, 05 Feb 2019 20:57:11 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u23sm10392959qtj.74.2019.02.05.20.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 20:57:11 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] x86_64: tidy up KASAN_EXTRA
Date:   Tue,  5 Feb 2019 23:56:57 -0500
Message-Id: <20190206045657.76020-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 585a4c1f9978 ("kasan: remove use after scope bugs
detection.") removed KASAN_EXTRA, so tidy up leftovers.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/include/asm/page_64_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 0ce558a8150d..8f657286d599 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,11 +7,7 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_KASAN_EXTRA
-#define KASAN_STACK_ORDER 2
-#else
 #define KASAN_STACK_ORDER 1
-#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
-- 
2.17.2 (Apple Git-113)

