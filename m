Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5ADC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC7820645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC7820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeIHCD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:03:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeIHCD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:03:27 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60696DC4;
        Fri,  7 Sep 2018 21:20:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.18 096/145] xtensa: increase ranges in ___invalidate_{i,d}cache_all
Date:   Fri,  7 Sep 2018 23:09:22 +0200
Message-Id: <20180907210911.874022299@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/include/asm/cacheasm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/xtensa/include/asm/cacheasm.h
+++ b/arch/xtensa/include/asm/cacheasm.h
@@ -123,7 +123,7 @@
 	.macro	___invalidate_dcache_all ar at
 
 #if XCHAL_DCACHE_SIZE
-	__loop_cache_all \ar \at dii __stringify(DCACHE_WAY_SIZE) \
+	__loop_cache_all \ar \at dii XCHAL_DCACHE_SIZE \
 			 XCHAL_DCACHE_LINEWIDTH 1020
 #endif
 
@@ -133,7 +133,7 @@
 	.macro	___invalidate_icache_all ar at
 
 #if XCHAL_ICACHE_SIZE
-	__loop_cache_all \ar \at iii __stringify(ICACHE_WAY_SIZE) \
+	__loop_cache_all \ar \at iii XCHAL_ICACHE_SIZE \
 			 XCHAL_ICACHE_LINEWIDTH 1020
 #endif
 


