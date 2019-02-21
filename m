Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8CEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8690E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="q0w+laaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfBUBI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:08:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42902 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUBI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:08:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so29621348qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LgKFH1mGi8c00OC5CaAghfF2/QymbWXD9Kas2gMOlVs=;
        b=q0w+laaMsCEL6A/1PgH9jnG3QJWlLo2ITG/6YD8f0I8tidgiTjb55RhFpOgRi5d4Q/
         eT9p0ByZyVxZfv+gJfoIPxKRY1D3YUzfPd9P0i1XuFuHzN6qL78Y8YB8pTqoJk8sSCFB
         aNJ1VrSsuADQOKM6i0dWqp9tzeIjPUnu4UhZphutYwoL2kCZ5D5Go01kask6o1Qlbm6S
         92c0Np3OLeAvbBn04jFr9TyDxZK0IJ/LoKwIm8IC9Xatgs22GmUb/ZE1Hg2zFESqfxQx
         YjccqC3vaWYYeRe3XaKN2Ix+KtN7e1QU5/sAPaJnh1iUBm1GI/brMx1IMJg9fO1bD+Ry
         ovsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LgKFH1mGi8c00OC5CaAghfF2/QymbWXD9Kas2gMOlVs=;
        b=t7V74mQqodDKw1qYBDuHNXmF70DmckR8S8uVn9TOXUipUFGa+tv93CAFd5i8AuX7ww
         uOZJ+7rvownyOZMY/IbsJLj5aqxNA5Od3PT1puvJuD+WnDkYTUlINliiWSontpmYe+rH
         QBiSICGuu+B1uBRIxrWy5xCTUWg8HZA+XCV/AVcC2BzWvhkl8UQjFnmZBYx5nRmDJKHb
         qHt/9ZRuHgt0p6Wqc+KZCK6g4jK7NXNGJAIA1LXZ0INXoObWksuWwBgSChumYKdEj1CM
         3Tf1USovWtT1pYNd23zhGMk3ei4IphW+/xa9GA7PPg7dxql0i5+KJk5kaKaxXupsj8o8
         uoPw==
X-Gm-Message-State: AHQUAub8B/aUtQxCjIyAAr7ro5S0UiduuwfS0HUFz+KQ/HrJNRZo6iK7
        Eo323Gq0xS7UwSk/5DuBK9IgqZUz/4o=
X-Google-Smtp-Source: AHgI3IYy3raoHx+Iskr/hYqAnmynUTEF231M3/+3RbDjlKaPoI058zx9Wua90jyIaG1/0a69PKV0dQ==
X-Received: by 2002:ac8:35f8:: with SMTP id l53mr30259475qtb.15.1550711335043;
        Wed, 20 Feb 2019 17:08:55 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q184sm10504681qkb.23.2019.02.20.17.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 17:08:54 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/debug: use lx% for atomic64_read() on ppc64le
Date:   Wed, 20 Feb 2019 20:08:19 -0500
Message-Id: <20190221010819.92039-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic64_read() on ppc64le returns "long int" while "long long" seems on
all other arches, so deal the special case for ppc64le.

In file included from ./include/linux/printk.h:7,
                 from ./include/linux/kernel.h:15,
                 from mm/debug.c:9:
mm/debug.c: In function 'dump_mm':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects
argument of type 'long long unsigned int', but argument 19 has type
'long int' [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^~~~~~
./include/linux/kern_levels.h:8:20: note: in expansion of macro
'KERN_SOH'
 #define KERN_EMERG KERN_SOH "0" /* system is unusable */
                    ^~~~~~~~
./include/linux/printk.h:297:9: note: in expansion of macro 'KERN_EMERG'
  printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~~~
mm/debug.c:133:2: note: in expansion of macro 'pr_emerg'
  pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
  ^~~~~~~~
mm/debug.c:140:17: note: format string is defined here
   "pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
              ~~~^
              %lx

Fixes: 70f8a3ca68d3 ("mm: make mm->pinned_vm an atomic64 counter")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/debug.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index c0b31b6c3877..e4ec3d68833e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -137,7 +137,12 @@ void dump_mm(const struct mm_struct *mm)
 		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
-		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
+#ifdef __powerpc64__
+		"pinned_vm %lx "
+#else
+		"pinned_vm %llx "
+#endif
+		"data_vm %lx exec_vm %lx stack_vm %lx\n"
 		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
 		"start_brk %lx brk %lx start_stack %lx\n"
 		"arg_start %lx arg_end %lx env_start %lx env_end %lx\n"
-- 
2.17.2 (Apple Git-113)

