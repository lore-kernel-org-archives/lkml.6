Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C897C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EE7222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfBPODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:03:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPODg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:03:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF01BB216;
        Sat, 16 Feb 2019 14:03:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0657F608E2;
        Sat, 16 Feb 2019 14:02:57 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, travis@sgi.com, thgarnie@google.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 4/6] x86/mm/KASLR: Fix the wrong calculation of memory region initial size
Date:   Sat, 16 Feb 2019 22:00:06 +0800
Message-Id: <20190216140008.28671-5-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-1-bhe@redhat.com>
References: <20190216140008.28671-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 16 Feb 2019 14:03:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
the initial size of the direct mapping region. This is correct in
the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
46 bits, and only 4-level mode was supported.

Later, in commit b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT
always 52"), __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no
matter it's 5-level or 4-level. This is wrong for 4-level paging. Then
when we adapt physical memory region size based on available memory, it
will overflow if the amount of system RAM and the padding is bigger
than 64 TB.

In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.

Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index bf680929fe26..97768df923e3 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -137,7 +137,7 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
-	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
 	/*
-- 
2.17.2

