Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4EC2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rX3Kwr1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfBUBzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:55:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43857 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfBUBzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:55:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so29726081qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YM0Wn0jbNjB6y9zmP7dH8GmfHqq62eVgozcbKGDoac8=;
        b=rX3Kwr1XpKa35TGbIbHweo+w6hrnkhnOFGhfI5p39p72tXevCMi9+XmIjeHA5GTUDk
         IlrqVmrC2yjHRh0uRCohxLlIqqROxJTrgoTiFA0MqIQgFG9HlfCtSFmDdFJPbiPOPBUD
         3/AjVqXTHZb2aMWyeGyBf+9Eo82YZGJGeZAAlE33V0QyAOeegzmGIsxw4cXIWZU2+5uY
         6TfxxYS0uNtGQ13azntRmgLRayZbTfsVkF4DA0nRb0I4r9ZA/W2LuCdCH0XJLO7ILAIr
         t8lNdQm9UQWHPZVNl4behZYdRMNC5RU98PRRIppuIEpN4ujQHMSdsdURVGlVJBJRALxb
         qFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YM0Wn0jbNjB6y9zmP7dH8GmfHqq62eVgozcbKGDoac8=;
        b=B9dKL2PCJ+fS6VW2cTEraoeIe8ZXEYKUYmWzkFH1d0YTot8JfoP4iado3U3TqULVL2
         XVd0l8p0ON2avVVFDwS8MyAOonv1xesGdb/z9dkVLUi8LBkEGpma0qqX5viCcB61+NWY
         2tLZ1tv0lQll1ojNjU7yfR+UKSpfyhjnCa8Q/w36pI7/iwQujZYuE/f+wqG0iAAKw7R3
         4KVg/q8Y09mbdXZpEJRM7dnUd18G26+HSGZdIFsoBaHLg0AudYZrMhDnS3G4k8Fp+Ki5
         jYKKRST9BArdDJHM+WaHzxdQou47+WwZlM9v0pTd4Vrcc3V2AYp8zYTBxndmV+0S21ge
         P31g==
X-Gm-Message-State: AHQUAuYDsp98WOUoGu9VAqHK0jvJvr2oS0CaV4Z5fxnLhUaR6fgfy7qe
        2VPI4olcG+5dxEkI5azocU2VXw==
X-Google-Smtp-Source: AHgI3IYucRujwkaTloIv/EFjGFEC/zNXpiIkUATN/kinrnMMB1vkS/LJTzdNHqtwt+yrsxX+aVIZUA==
X-Received: by 2002:a0c:987a:: with SMTP id e55mr8103237qvd.21.1550714116320;
        Wed, 20 Feb 2019 17:55:16 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s8sm6657974qtb.70.2019.02.20.17.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 17:55:15 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/debug: add a cast to u64 for atomic64_read()
Date:   Wed, 20 Feb 2019 20:55:07 -0500
Message-Id: <20190221015507.92299-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic64_read() on ppc64le returns "long int", so fix the same way as
the commit d549f545e690 ("drm/virtio: use %llu format string form
atomic64_t") by adding a cast to u64, which makes it work on all arches.

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
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index c0b31b6c3877..45d9eb77b84e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -168,7 +168,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm_pgtables_bytes(mm),
 		mm->map_count,
 		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm, mm->locked_vm,
-		atomic64_read(&mm->pinned_vm),
+		(u64)atomic64_read(&mm->pinned_vm),
 		mm->data_vm, mm->exec_vm, mm->stack_vm,
 		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
 		mm->start_brk, mm->brk, mm->start_stack,
-- 
2.17.2 (Apple Git-113)

