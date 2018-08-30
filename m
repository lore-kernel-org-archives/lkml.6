Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D671C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3573620839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXodEwnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3573620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeHaCjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43313 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeHaCjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so8448240lfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qc6f3RCeMvcYS414KQk2UoalnwZYaTIGU5CNR2lJgd4=;
        b=EXodEwnGIpMW5E+2RkKDsdSaK+s/JKPNGZVII2/JtEGMhRxHusH3kRgiTC5Rc0HXLF
         QImdw81xc3yzZjXuREBzNN9AEd4+BCKyhyHZfPWxvWLZt8u+4OCkeLeNdjQOf4do4Lwg
         SSEGZfBFSAY1FvNBhACE52UwsIA2exx+Npu7g5aNJoSL7JF8mD8BseuOtfT039oHmBke
         K6hjU88ZNhKS+p6N6ihn+Yjjw2nAnXl8zn5aeyz6Gm/NkfFrRgGQSOXC7mcoXsDbrBaZ
         5xID2ziWTbZiaMhhoegoPU5UE9FlcOkenKQ7RXlqTJCMbXUHuSnEFKzFeW0doe7g49r8
         m7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qc6f3RCeMvcYS414KQk2UoalnwZYaTIGU5CNR2lJgd4=;
        b=nA+2CS3B6RN3iszI7eqJIoxavMcinbTbUD32hhQJDNa0AM/2i1kElQwM8Ns7G1928P
         z4nA/ElEAwFeovLRW+zKTh9xUD3KahwcHoVceYU0gV6TIi5W49kiKo0NJJL/chlsgvqR
         cCLBbu71FyCJH5UuWhDV7Eapp0W/NegEg2QWnTXMJ9sW0uEokAquHwnh+jIncOar9hEn
         4ht0rhS65bKUA5flc07Q8ZofWjfL4ZEw3itYxlPjIgojfeNcd7dBv1tqW7hpJfzu7sUs
         uxDxmvHjl3pqiSG90ZPE/mCmdYZotrcyDN/4bRkeHd1i6tSWBZFzlo6PmMmoQFhH+UcI
         dD9A==
X-Gm-Message-State: APzg51DZiI/m/S/gPV6xivjqTPuSHuEAr8JN9cJtASDB7H7XES9fBQne
        AChdxZKaFYgb8dZSHy4k1G+VJGR1AbI=
X-Google-Smtp-Source: ANB0VdYgcHn1dHctYnICcymBDn8AdvI3rjBPZJkJaeZEkYW9PROIKZGTonLjBFduDzKsfyf3lfweCg==
X-Received: by 2002:a19:f83:: with SMTP id 3-v6mr8510414lfp.131.1535668521108;
        Thu, 30 Aug 2018 15:35:21 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:20 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/23] asm-generic: bug: add unlikely() to BUG_ON()
Date:   Fri, 31 Aug 2018 01:34:09 +0300
Message-Id: <20180830223429.30051-4-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hint to the compiler.
If BUG_ON() is used instead of BUG(), it means that probably the
preferred outcome is to not BUG().

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..34c48444c942 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -183,7 +183,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
2.17.1

