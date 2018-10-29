Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EACE2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7AJ6Xix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EACE2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeJ3Inj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:43:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34585 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Ini (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:43:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id k1-v6so3260267pgq.1;
        Mon, 29 Oct 2018 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AtQivvj6hJ1qy9E/5uGhpUB8LlJCIsHqyEiYftwE/sA=;
        b=p7AJ6XixL296KovyKMAD+UzeA+mwLeJ3m1QA5oj6PcFN5uBSkIug+6L9XN8E27b191
         B37oztlbjdZXaancADeb/EH0MDVF41xkeXaqLdysJJYJXtglzeGPpl8SFXP/Oa2R9u3e
         ZrmV4prxSDk0zXDgZegDvpRWMNUREV/ACi1oQQD7c5J+rDRZxNJth/pyFDyEkuT7uLBi
         UZzP0+DqoU92CYEz4n4wZmDbG57FGeVAs9fgfipfRz6qQamrFSZMwwZHCP+u4KQakJSk
         1H/YUqj2tphWaaYQNHkEoVJqZL6pczSzt0uaF1oH6VOjQBngKwYF5DeNS/IERJ0K06fw
         9Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AtQivvj6hJ1qy9E/5uGhpUB8LlJCIsHqyEiYftwE/sA=;
        b=FXzlKfetexa5rlDIHxqyUOFAH/ulrcQO72dGFq3POd4Oc4Owd7W5uzkGFTiswbo/j9
         2yWUrzwye2M5IQRa2HjNw6TyZ+2+CH/c5wbN60V5nL84hPz9OTHzZFF95mVyeQibcp7V
         iIy/+cBGWPtM1q60PtOKN2YsFr5FO8UfW64xn6PvQGnonjUU250dGQuaCYCcGablmJqR
         rg8e4FHz25Pc5QAuewv/WaRVq/wX4T36Z3/XOUYiFPBnwrxdAGoN5GSUt53/It5H/SH/
         EF6RFtjdv7/hNRCHKQYzHj3HeD6XbyFmTroK9dhPHeilXQ8yUn0KPEL6AhMCFSeRRZ+R
         xmuw==
X-Gm-Message-State: AGRZ1gIsw5vD8wMTHveYjFL3PsJknvBUBwMm6P1Ny6KChmq4aYydh+PW
        Q7kkY6yOopQPh2axPrenmKkTFklC
X-Google-Smtp-Source: AJdET5cJBzb7p6c/l41cmqC5bBs2xtjr6B0hdL70p3RdSxmQYPKkuPyP1v1uKJ4lb4gShWumd4fCJQ==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr15872242pgm.376.1540857154346;
        Mon, 29 Oct 2018 16:52:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm22537981pff.30.2018.10.29.16.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:52:33 -0700 (PDT)
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
        ard.biesheuvel@linaro.org
Subject: [PATCH 1/6] nds32: Remove phys_initrd_start and phys_initrd_size
Date:   Mon, 29 Oct 2018 16:52:01 -0700
Message-Id: <20181029235206.30060-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029235206.30060-1-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
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
index c713d2ad55dc..32f55a24ccbb 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -22,8 +22,6 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern unsigned long phys_initrd_start;
-extern unsigned long phys_initrd_size;
 
 /*
  * empty_zero_page is a special page that is used for
-- 
2.17.1

