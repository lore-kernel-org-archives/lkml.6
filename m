Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0044C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED5B218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBGFil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:38:41 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:39334 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfBGFij (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 7 Feb 2019 00:38:39 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 07 Feb 2019 06:38:37 +0100
Received: from localhost.localdomain (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 07 Feb 2019 05:38:05 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] MIPS/c-r4k: do no use mmap_sem for gup_fast()
Date:   Wed,  6 Feb 2019 21:37:40 -0800
Message-Id: <20190207053740.26915-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190207053740.26915-1-dave@stgolabs.net>
References: <20190207053740.26915-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is well known that because the mm can internally
call the regular gup_unlocked if the lockless approach
fails and take the sem there, the caller must not hold
the mmap_sem already.

Fixes: e523f289fe4d (MIPS: c-r4k: Fix sigtramp SMP call to use kmap)
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/mips/mm/c-r4k.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index cc4e17caeb26..38fe86928837 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1034,11 +1034,9 @@ static void r4k_flush_cache_sigtramp(unsigned long addr)
 	struct flush_cache_sigtramp_args args;
 	int npages;
 
-	down_read(&current->mm->mmap_sem);
-
 	npages = get_user_pages_fast(addr, 1, 0, &args.page);
 	if (npages < 1)
-		goto out;
+		return;
 
 	args.mm = current->mm;
 	args.addr = addr;
@@ -1046,8 +1044,6 @@ static void r4k_flush_cache_sigtramp(unsigned long addr)
 	r4k_on_each_cpu(R4K_HIT, local_r4k_flush_cache_sigtramp, &args);
 
 	put_page(args.page);
-out:
-	up_read(&current->mm->mmap_sem);
 }
 
 static void r4k_flush_icache_all(void)
-- 
2.16.4

