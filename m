Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C918C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2410B206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfBXNWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfBXNWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:22:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00A8A30821A0;
        Sun, 24 Feb 2019 13:22:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C64536017E;
        Sun, 24 Feb 2019 13:22:43 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] x86/mm/KASLR: Change the granularity of randomization to PUD size in 5-level
Date:   Sun, 24 Feb 2019 21:22:31 +0800
Message-Id: <20190224132231.4878-3-bhe@redhat.com>
In-Reply-To: <20190224132231.4878-1-bhe@redhat.com>
References: <20190224132231.4878-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 24 Feb 2019 13:22:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current randomization granularity of 5-level is 512 GB. Improve
it to 1 GB. This can add more randomness to memory region KASLR in
5-level paging mode

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 6b2a06c36b6f..248509986f1f 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -204,10 +204,7 @@ void __init kernel_randomize_memory(void)
 		 */
 		entropy = remain_entropy / (ARRAY_SIZE(kaslr_regions) - i);
 		prandom_bytes_state(&rand_state, &rand, sizeof(rand));
-		if (pgtable_l5_enabled())
-			entropy = (rand % (entropy + 1)) & P4D_MASK;
-		else
-			entropy = (rand % (entropy + 1)) & PUD_MASK;
+		entropy = (rand % (entropy + 1)) & PUD_MASK;
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
 
@@ -216,10 +213,7 @@ void __init kernel_randomize_memory(void)
 		 * randomization alignment.
 		 */
 		vaddr += kaslr_regions[i].size_tb << TB_SHIFT;
-		if (pgtable_l5_enabled())
-			vaddr = round_up(vaddr + 1, P4D_SIZE);
-		else
-			vaddr = round_up(vaddr + 1, PUD_SIZE);
+		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
 }
-- 
2.17.2

