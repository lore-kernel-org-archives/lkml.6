Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F08C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3667120869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdHYiuR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3667120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeIDMTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:19:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40619 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:19:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so1253382pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=rpuNrMeZj+C1saLa9Rc3chGpIRtRdC3Dqo4K5f6mVEo=;
        b=BdHYiuR71OBf5MZDZwP82pSQb0UFdgRN3nKrEvsGYQeKWLQfNEZzvhds5jkrwOpi4B
         A4zhcRKbw5TtBJnCi3oyivQdiz/gzunjiju7Mbkc8gkcBhmpRreH2yKZg/j0GeA04Dtb
         9ZBDp3CnbD15J/95azytkamohXzMcGSBn0muRqBwLQajPFpetLUvdL8NuEVz/m9gmZ2/
         cBNQ4oO+fpIxrUmt+0BUlDkoYo5qJI6Wzs4E71GbUXnPnJ4DCGf5qxWN8KtzhkQRouu9
         UYOSx8JYIz43L6nfjr9E2rOK38fVQqasJIdViIaRDvxr3aAoxxd9PafS2kjXBB/M7476
         bYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=rpuNrMeZj+C1saLa9Rc3chGpIRtRdC3Dqo4K5f6mVEo=;
        b=fw5VdfOl5wNkQgv1eigMv1K46ZFgg+RbnwYTfykHMOOb4fzdZ8C6C3TcTbtkp9K45v
         uXy4g+ey44/m4NqQjR8XseGtfM4K0S+jxRR1PYa4MdDqvwF41IiJtSmPWYsUjLJgO/EO
         tA4hh/WwmzWuWZYbjq92ayBfnv+vlpSNXqHx/3KHVPwmDnYHp2ahHGYO2y6UPqLjsa7c
         ig+XmVkEGKfL1REvUXr9ioCPxHlDuiyZGEAi3im3uDeh+ku+T+7doayGhGnBjeuMw1pS
         0ppjjxpp9u9FvcfLY4RO4tUvQWKmJCaCRkfosYqnRmYNl5y4U3HVT8jhD4g1vIwoEi+L
         nBcw==
X-Gm-Message-State: APzg51Ax0tjItUMRZt5tfZqon8XuBlEl+rydJmWwPJW6ROgTplXQ97at
        vbe+Deu6LJKv8fBjTj84F7EtmnA8
X-Google-Smtp-Source: ANB0VdbHWPQB7R2NDbbHoZjXHpGWNPCxKDgRKBWjoUxtr0Rlz2ZqNnYpJ54JVSf97XxpzDrKIRiMZQ==
X-Received: by 2002:a63:a40a:: with SMTP id c10-v6mr15344042pgf.346.1536047738602;
        Tue, 04 Sep 2018 00:55:38 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id q25-v6sm28170693pfh.113.2018.09.04.00.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 00:55:38 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, mhiramat@kernel.org
Subject: [PATCH] nds32: linker script: GCOV kernel may refers data in __exit
Date:   Tue,  4 Sep 2018 15:54:19 +0800
Message-Id: <20180904075419.2994-1-greentime@andestech.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to fix nds32 allmodconfig/allyesconfig build error
because GCOV kernel embeds counters in the kernel for each line
and a part of that embed in __exit text. So we need to keep the
EXIT_TEXT and EXIT_DATA  if CONFIG_GCOV_KERNEL=y.

Link: https://lkml.org/lkml/2018/9/1/125
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/vmlinux.lds.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
index 288313b886ef..9e90f30a181d 100644
--- a/arch/nds32/kernel/vmlinux.lds.S
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -13,14 +13,26 @@ OUTPUT_ARCH(nds32)
 ENTRY(_stext_lma)
 jiffies = jiffies_64;
 
+#if defined(CONFIG_GCOV_KERNEL)
+#define NDS32_EXIT_KEEP(x)	x
+#else
+#define NDS32_EXIT_KEEP(x)
+#endif
+
 SECTIONS
 {
 	_stext_lma = TEXTADDR - LOAD_OFFSET;
 	. = TEXTADDR;
 	__init_begin = .;
 	HEAD_TEXT_SECTION
+	.exit.text : {
+		NDS32_EXIT_KEEP(EXIT_TEXT)
+	}
 	INIT_TEXT_SECTION(PAGE_SIZE)
 	INIT_DATA_SECTION(16)
+	.exit.data : {
+		NDS32_EXIT_KEEP(EXIT_DATA)
+	}
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	__init_end = .;
 
-- 
2.18.0

