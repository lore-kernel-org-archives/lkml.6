Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68DEC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9463B20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9463B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeLIWPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:15:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38198 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbeLIWPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:15:30 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002pp-8T; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003OH-FW; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Max Filippov" <jcmvbkbc@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.129179912@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 137/328] xtensa: increase ranges in ___invalidate_{i,d}cache_all
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit fec3259c9f747c039f90e99570540114c8d81a14 upstream.

Cache invalidation macros use cache line size to iterate over
invalidated cache lines, assuming that all cache ways are invalidated by
single instruction, but xtensa ISA recommends to not assume that for
future compatibility:
  In some implementations all ways at index Addry-1..z are invalidated
  regardless of the specified way, but for future compatibility this
  behavior should not be assumed.

Iterate over all cache ways in ___invalidate_icache_all and
___invalidate_dcache_all.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/include/asm/cacheasm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/xtensa/include/asm/cacheasm.h
+++ b/arch/xtensa/include/asm/cacheasm.h
@@ -119,7 +119,7 @@
 
 	.macro	___invalidate_dcache_all ar at
 
-	__loop_cache_all \ar \at dii __stringify(DCACHE_WAY_SIZE) \
+	__loop_cache_all \ar \at dii XCHAL_DCACHE_SIZE \
 			 XCHAL_DCACHE_LINEWIDTH 1020
 
 	.endm
@@ -127,7 +127,7 @@
 
 	.macro	___invalidate_icache_all ar at
 
-	__loop_cache_all \ar \at iii __stringify(ICACHE_WAY_SIZE) \
+	__loop_cache_all \ar \at iii XCHAL_ICACHE_SIZE \
 			 XCHAL_ICACHE_LINEWIDTH 1020
 
 	.endm

