Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF0C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C4321916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQbVWXFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfBISe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:34:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52918 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBISe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:34:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so9492755wml.2;
        Sat, 09 Feb 2019 10:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=SYxH1yx8PgayeikM4YgapG+FoS6nT4L4Mzor/Idpn2g=;
        b=uQbVWXFeij5Y5/wN+V5RzqQE5hPfuateLFSf1seTvd4L9cKgzxXZ0YjW8VlFsh9w5G
         ApYjmCuLtrUogmbge27IP93g0rgjPVO313Dk8WI2ekC8NUJdzpVrxyYJrAs5zKHeNmyH
         c/2ViAUSkvW5NWUDHWbVIAUQB+uQFA7rtuaysZiO4ltidS1ABAmlwMpzAULTny2eLBof
         6aayIQyQkiPMiDEoS4yUSjdaLiU7SamB4pc44dE13izM5dmpHoKINOknh2bK66qv5pj0
         ASqRwxca22tDGjKaG0ki5ze49uqoSWhF+Cwxi4LJpQ7QfWSLdjfOAniCzxzCK6yBJg5Q
         YWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=SYxH1yx8PgayeikM4YgapG+FoS6nT4L4Mzor/Idpn2g=;
        b=NGNLWeRj13sw3vIpDSggX7O6k6IiVd+Mpt/8mdE7ldvIm1sfcIWArqVhOEj0xI+h29
         7M4+vsW3kket7xNlHO9fuY6OxEivqFW8p91vi9pYHhaUNVvUK0hMpUeHuAkwvsQ7z/wO
         3QWmjFZ84wyFFz/T4HQlC6ip3/1lIqv4u2mEO72Opq8fvBCk86if9iSyIKJjYGzYwcVA
         NwhSm9W8AAXyQa5Cbn0IxEi/uGX4vaYOvofKgZucHg5avZqh3BCXhDDAT6aJ/debSZvj
         jzNcIx6zQzR7PDVMu3XvBhJIWKs0cIrzCfuY/Zn90CClrfymvRlClzoEJ6T1Py7g1wl1
         pmgQ==
X-Gm-Message-State: AHQUAuaou2p/nDGXkMHeUU+TlTj1ruyIOUb3RIfnAVQn7/9OeNQXfeL5
        Z3KPUdjuogRoYSBAxvc91ws=
X-Google-Smtp-Source: AHgI3IaWBOsRg6JmG8tOQzmAPqqQR8GvhejxcmrsGr121gaQd0LtmpQLBdlBIX+wJVJW12C+eXIwfQ==
X-Received: by 2002:adf:c5cc:: with SMTP id v12mr20698627wrg.176.1549737294680;
        Sat, 09 Feb 2019 10:34:54 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
        by smtp.gmail.com with ESMTPSA id s187sm3064346wms.8.2019.02.09.10.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:34:54 -0800 (PST)
Message-ID: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
Subject: [PATCH] arm64/io: Don't use WZR in writel
From:   AngeloGioacchino Del Regno <kholk11@gmail.com>
To:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Date:   Sat, 09 Feb 2019 19:34:53 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 33fb6d036de273bb71ac1c67d7a91b7a5148e659 Mon Sep 17 00:00:00 2001
From: "Angelo G. Del Regno" <kholk11@gmail.com>
Date: Sat, 9 Feb 2019 18:56:46 +0100
Subject: [PATCH] arm64/io: Don't use WZR in writel

This is a partial revert of commit ee5e41b5f21a
("arm64/io: Allow I/O writes to use {W,X}ZR")

When we try to use the zero register directly on some SoCs,
their security will make them freeze due to a firmware bug.
This behavior is seen with the arm-smmu driver freezing on
TLBI and TLBSYNC on MSM8996, MSM8998, SDM630, SDM660.

Allocating a temporary register to store the zero for the
write actually solves the issue on these SoCs.

Signed-off-by: Angelo G. Del Regno <kholk11@gmail.com>
---
 arch/arm64/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ee723835c1f4..a0a6d1aeb670 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -49,7 +49,7 @@ static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 #define __raw_writel __raw_writel
 static inline void __raw_writel(u32 val, volatile void __iomem *addr)
 {
-	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
+	asm volatile("str %w0, [%1]" : : "r" (val), "r" (addr));
 }
 
 #define __raw_writeq __raw_writeq
-- 
2.19.1


