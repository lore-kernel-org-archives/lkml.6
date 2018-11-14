Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E607622419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYBB3qu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E607622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeKOJOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:14:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39428 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeKOJOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:14:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so8059356pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5OyESa8c6SBNyWdNb3gM8rcHT89xSJW92/maCjWyiyU=;
        b=tYBB3qu9K9lLTGc5NTC2d6UZ2AcYMYgzMYo0HrcFzlbGoApDGCnvMUo928lhH9U9P4
         SfB9abR4ckQl9YZFbXN3Wa6KubUM44jtjLusjND5um9ny9DpBkiSStDCNm3QsB4OcqU5
         dZnVuEFsbuCM20+0L31d3b65e6apKi3jrkLEv4jJh6qVcjWRGAfeRmjTRuXI/zlDQFJx
         ko6Vk4dx8AcPWbXnfGAVhFaxQMqNO21p8ONQzZrghIagZI0UBdYUihALT7PrnceQ5Iw6
         CaYZVFMNjqx9UYj1ZOc5mINpElQ8QQaMgGiaI472X5yv8JR2/pz+au8VsURCxXfdWMj+
         bmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5OyESa8c6SBNyWdNb3gM8rcHT89xSJW92/maCjWyiyU=;
        b=YDYjhVkmjy+ntxlc6URG0/Nr+dKXKBVqxlDKp1NHQ2WnmQdgZNzd21sZuiK4asPVdV
         PxDAOSwWfE3zrz0nPkEA0M8gcn+MYSRA5+YMH85x801suyOVhnZJ+bsvKySLxDd5sxKi
         xmAPbVPfKfkm6VKBO9PIVxvcy3XGhvrdK3p4Wm43n8oDejhHaj6/hlH0HzeUctEvROet
         ZD9u3IJhjDaD9M5a1oO9J0lx+MLRqfm8bZH6IHjyWrG4W9Hus/4pGrfCKaaOei809oxQ
         +gpwUp2QDVvV0LLfLeNo0FuNXGa1wxI6FCZfx63s6p/74z52YeqBV26uimk6V/qcbgjO
         1/Sw==
X-Gm-Message-State: AGRZ1gKPN4PuEJGj1UKF0e/SK8R6szFrJ6N18yflRTz+Lcc5nRi5cy33
        cYEtcZ3koX77riWORLRSrdE=
X-Google-Smtp-Source: AJdET5cXwdBW0WUkH1r/PjdQAyiEMD3WBlc10tBJkVR+JscyqRI4K2e+uVJe0TNPIqokYfN2Fv/lqg==
X-Received: by 2002:a65:6684:: with SMTP id b4mr3567897pgw.55.1542236958149;
        Wed, 14 Nov 2018 15:09:18 -0800 (PST)
Received: from localhost.localdomain ([207.246.110.149])
        by smtp.gmail.com with ESMTPSA id d9-v6sm10640725pfo.162.2018.11.14.15.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 15:09:17 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] openrisc: make function cache_loop() inline
Date:   Thu, 15 Nov 2018 07:08:56 +0800
Message-Id: <20181114230856.30143-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The third operand of mtspr instruction must be a constant. To guarantee
this condition, function cache_loop() which uses macro mtspr() must be
inlined. So let's force it as 'inline'. This is to fix compiling error with
new option CONFIG_NO_AUTO_INLINE.

In file included from arch/openrisc/mm/cache.c:17:0:
arch/openrisc/mm/cache.c: In function 'cache_loop':
arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
                              ^
arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
      mtspr(reg, line);
      ^~~~~
arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index b747bf1fc1b6..4a4b2b6e006b 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -20,7 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static void cache_loop(struct page *page, const unsigned int reg)
+static inline void cache_loop(struct page *page, const unsigned int reg)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
 	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
-- 
2.17.1

