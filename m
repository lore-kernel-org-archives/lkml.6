Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DACC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2935F2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3jqbZOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2935F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeKBA3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:29:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41673 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKBA3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:29:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so2960242plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hdoLI5ATJtiQRnlONOiUGs2fz3ZAA1J4pBQbUBFgaz4=;
        b=K3jqbZOLZaoawHY6NdADOE+Bb458eVjsA8j5IRldw6Ls80a3Qb6LFpCUxqrkslmCGO
         ivgdiUMiOy7gtophfrl/B/99gXv64YPHO9bRMFGcpCFNh/Vq5AFoei5klnCOKP5Vjrs7
         6g/BzUUT31TOim2yE3Iygud6TOkhY+0T9of8KAwgufqcvgtXBb0cM/hsVesy3QYCimA6
         sds59Eeo0oRbzYRty7grqSSGM6KlmMPHl/4/CsdKClp/DEJxz5z8bMnWO+4O1K6nXcyh
         5eJ7jEb+pR2yX7zC1eAUW2rdd65kYdLNnBNv8qitWJInPtyObcw11VC2E3PfFjdckI3y
         Z67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hdoLI5ATJtiQRnlONOiUGs2fz3ZAA1J4pBQbUBFgaz4=;
        b=pXfaatn1OGVYo9cnir/PsCTo/h0b8piB8wWdvhjorEjQ0gHJ3b1b0CwvetFpr1MiZR
         5FfgtRMVaXG3Kxg1lRxrjEPI4Xr1+tGi8cFU1EMcdobkNMWKMtZ5URYxdWSVK8mosN8R
         k4mCobqDmNbyQoKQQ0V3MbltMEnjaKdrRDEX/96uXWeYwwqGrEv06n63gxqiZD6fa+69
         qgmE6nmRnBg8IxEg1znP9hY8qzqPwUZ/lTlAS3Wsoo2+nWMk1NUOp7V6Wg+rD09vKum6
         dup7NQHmVwmyRMct6sL2vgFxD0fRem5ik3HhfInVFj8Z8xAE6e56Q5N1axUwl9zlhebr
         SHDg==
X-Gm-Message-State: AGRZ1gLA1NdwsK10PlX4IqupHglA1ar1bIYd6ZSmcN1G2McczTS+LFX3
        It/l/635LgwawgkLhBmK/NQihefAeX4=
X-Google-Smtp-Source: AJdET5fAP4imr8M+FVMpuyeh8SpLqC1d9x5BUpZnMT0K9NwrLTD8CZ6ADosU19rmmGInAV4CfS/smw==
X-Received: by 2002:a17:902:54d:: with SMTP id 71-v6mr8166889plf.80.1541085943077;
        Thu, 01 Nov 2018 08:25:43 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id s80-v6sm35644565pfa.114.2018.11.01.08.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:25:42 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] arm64: kdump: fix small typo
Date:   Thu,  1 Nov 2018 11:25:31 -0400
Message-Id: <20181101152531.22489-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index f46d57c31443..6b5037ed15b2 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -58,7 +58,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 /**
  * elfcorehdr_read - read from ELF core header
  * @buf: buffer where the data is placed
- * @csize: number of bytes to read
+ * @count: number of bytes to read
  * @ppos: address in the memory
  *
  * This function reads @count bytes from elf core header which exists
-- 
2.17.0

