Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B783C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09D025529
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMGhzll0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09D025529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965012AbeGBLRs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:17:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45537 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeGBLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:17:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id bi1-v6so7802305plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5irZlLoFnL5qlm35hW3XOZGz2KCUXPTwo+VHvtx0y/A=;
        b=nMGhzll0ctqURgOIb3kXB2p5tL0pjoRaDIg67sWvMJ1XhbVrLqRUWLbWKjTzIMv0hJ
         KX61vYwuYvwNxw3KXPVDMAUdIvlasheR7IvaEYgbxe8cTsgapcCWgKIP2cINk3iZo2no
         xvdnrpUwxJuQjwT+drCnVOu/azRZ4SvxTiB+p/XEFyHWI2C2EXQWYNtLEzW1ouRSy1J5
         MvM4kmLLips/wmPz5TvQpqRfh2Y8qJmJq0c8P/ighp5bBpoRPPwX1DooBV9rCHS5R2HP
         JbYOyzb31x7+A0Dsnjv6BHVIrWb7YA4ADzhk4lrMsBzj19vXBhQY1TPps85+Zqye2vdU
         Et+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5irZlLoFnL5qlm35hW3XOZGz2KCUXPTwo+VHvtx0y/A=;
        b=k2F0a1Tx0TgiDltIJWL6XLNg3MdoXWIEYUHu1k0XCqgPhJFSoxpUsSwt86QlcoVIRf
         C+c6esHYFpIBjf043vWQzG+7oqAJrvp+W3IkmKKldkLGRHy8p2Z93nVXIassijjZBsIF
         WuvrYEQJPN9otFJeEl6J5AHQsu/n8KkMIoXx1IKPNRMgPL+1l8ML6IDssST4JiEcY4p8
         S1kO+10MIKlk/sacN0gE5+BSfXEm1wZpZ3O40z6CZ7O2wf89+QdZSppUHMzwIyiv/bh7
         iNUwsqkyzo1XIZrDp7vmkF+chF14CDkGUY4vNvFAg7a8+ooECGr0CiaWSmazbhej8iAZ
         4Www==
X-Gm-Message-State: APt69E2TjE0Vf6vWlx4KTt+bT68jLdC0Mnsr25slECmRGoFvfzukvG3J
        L+baiHbh4TvcKt8qnhB3vps=
X-Google-Smtp-Source: ADUXVKJOeIJsWwdHXwMtl8z5vwqyxuBZcZbq2d39QHW2sk1zVycuCwuizcsjvreTC8phxqvM150KJg==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1-v6mr25876884plp.20.1530530263601;
        Mon, 02 Jul 2018 04:17:43 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id s2-v6sm11262150pfh.186.2018.07.02.04.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:17:43 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] arm64/mm: Make swapper_pg_dir smaller
Date:   Mon,  2 Jul 2018 19:16:58 +0800
Message-Id: <20180702111659.25570-5-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702111659.25570-1-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make swapper_pg_dir smaller so we don't need to memblock_free() it.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 arch/arm64/mm/mmu.c             | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index d4fc68286a49..d69e11ad92e3 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -236,7 +236,7 @@ SECTIONS
 	. += RESERVED_TTBR0_SIZE;
 #endif
 	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
+	. += PAGE_SIZE;
 	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a7ab0010ff80..a1e8fc624324 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -632,14 +632,6 @@ void __init paging_init(void)
 	map_mem(swapper_pg_dir);
 	cpu_replace_ttbr1(swapper_pg_dir);
 	init_mm.pgd = swapper_pg_dir;
-
-	/*
-	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
-	 * allocated with it.
-	 */
-	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
-		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
-		      - PAGE_SIZE);
 }
 
 /*
-- 
2.17.1

