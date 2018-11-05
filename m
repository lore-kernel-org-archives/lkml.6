Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C120866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXeH/wDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5C120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbeKFIUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:20:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42630 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbeKFIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:19:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so4892326pgq.9;
        Mon, 05 Nov 2018 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3usUwYojcwaU66hyFniYwIfMZmcaRKijdMd9ub5bn8=;
        b=pXeH/wDqkJgLGhHgT9KUWZ6VKBwAE+INwAnsSDMoGB+slAZB6aW/y/9/mmaW9ZJ2u1
         3Oa2rQiDMv/poDzQ5cu1C7P0QUxezQfAcxew6pzjTQJCi7829LB+KW/3KR3dNY2aAUYt
         VETVviZeG/PHAeSSWL9rLP5gpEK9jsFVHK075O4TiX7knRniVbnSwDa/5eChQiCD8v1g
         +9W3ln64To6TWBQaAgvIMWH0/O+K5VR3drTdSRPtoUdPmfOt7KLFJdr942h3G0W4p6Xc
         k3Qa/TbFVPGOHLIsLhJCzrSY2627sQiWRtvhik3dd4a5IHDpDE81wXZ8fkn9/eVUH8wE
         R6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3usUwYojcwaU66hyFniYwIfMZmcaRKijdMd9ub5bn8=;
        b=AjUzQndoMNizf4kUjrUXM4lDyRcoZShZ43wkRAXqyegkbqjYafJ2tHI5Rt1hY7RsuS
         /xLfouF8+nBsxvqyxgdRCY81ZqfATaZmilYNCCND6D2Y7X5OmCIKo9i/P7OAma4DoSUp
         xvXcqrhSx4T6eSxZCDxggC+MhC26Sdx0EhpU6Rdj4bRXzTJ6znsIdzvxqRHxBIsUfrMM
         Fyg+I8m6KtdRo8Xng/6OPv3uDXahU/+mNtO8OL+l+K2948G83C8ArkeS1Li8lXAhZSSl
         v9/OMzAmNk51563SjwT1KWJdlYjOPgsTtmeAo45bJ8LuackJJS31taaltN8ROVj6iT7A
         ieCg==
X-Gm-Message-State: AGRZ1gJM5bW/Gl2dGL7gbePWqaQja7oDVtubeUbnRHJRLXo57kfrVHcy
        /xRQHUgaJPo8DzaTmDnwtuymRYza
X-Google-Smtp-Source: AJdET5e1oLnAiMdQFa1Xjn43gKt+HOkE63wECR6J1MukkfBbLN+UMM6FQ1Ve48Kz/D7/KMVW6pZ89A==
X-Received: by 2002:a63:f65:: with SMTP id 37mr15671257pgp.238.1541458676654;
        Mon, 05 Nov 2018 14:57:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm12898479pgq.7.2018.11.05.14.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:57:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: [PATCH v4 1/6] nds32: Remove phys_initrd_start and phys_initrd_size
Date:   Mon,  5 Nov 2018 14:54:26 -0800
Message-Id: <20181105225431.24485-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will conflict with a subsequent change making phys_initrd_start and
phys_initrd_size global variables. nds32 does not make use of those nor
provides a suitable declarations so just get rid of them.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/nds32/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 131104bd2538..253f79fc7196 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -21,8 +21,6 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern unsigned long phys_initrd_start;
-extern unsigned long phys_initrd_size;
 
 /*
  * empty_zero_page is a special page that is used for
-- 
2.17.1

