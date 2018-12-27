Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DAEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2162148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFNTkx4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbeL0Xr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:47:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeL0Xr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:47:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so9319965plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q2nJ9rfyypggwGRZ0F93ZauVq8Vari0uStE/oU9pY6s=;
        b=QFNTkx4TFLmeIKJblC3YN67IvstJInDThS2hmGCMZO1ketk5nOP8rCdoZq3NgCHIdb
         24/CDpxmU6MTkStMDpgcmP8XPoVnmkElu4KMmU3BDOd6Nxn0BXhvG0QPdoPcbcXzFQ21
         t+nfaksHzRwg5JhiLgvh7G6FX1qj1v1R2VaeqM/rVIS4uKfGaycVpjVQ/06BTHSWU3eB
         r07EU+Lf5w9EAx53nW4nRqv35UVh6vAVamDwoCVsvsf7TFnBlUXiBZh0BfEpCpZZ1spE
         7EoUhMk7PJE05WKDVHj+oUQDpRcwpyFvmPD/HiHOGVlrO6VW99sl41iXZO8y+CSbzmAX
         4uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q2nJ9rfyypggwGRZ0F93ZauVq8Vari0uStE/oU9pY6s=;
        b=k2yFrsuze6AR84dNZBZqt0GDOXy8jR6Kh5g33YXz4MMyzvBfmdiw4jviKPz2WVUT3g
         esLl1uIZ25PqxfeDA7xs63mi64n/yV51LeAtYs6JqSDV+4L/6pMVYyN2ndaATfOtq/5G
         OJXfOYDUs9CsgeE7VAq6Pu2s/KpCZ44u66onJLSa3j8gDKVUd1bJiChGyWAqdypjJupt
         j/lUkeEsIhgpw0Sk7Z7Q6RXAQYZUkZt8b9nhYEMnDATNTM1vl4UgKsrcKGZYcvvS5Qhz
         5iqYijjEU1nGtCQAUfv6u/GsQVUP+HYFI12bK74hjY+c9DrAPdAH8S3ianVZbdOgJbl3
         tSQQ==
X-Gm-Message-State: AJcUukehn/bLrWsHXLinDuGDnw5Vuc5kQmhE/ZjJSimhiNSczb2OickJ
        VMfP9u2Eiai2KDJU4zwfZjo=
X-Google-Smtp-Source: ALg8bN47/jxZO17cgPLQQSuAQ9rjaDbOV9Lq9vKY8gFaVkf2/1PNJy/xoWCJuIl0kSBeQH4kVaSpbg==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4mr25578969plb.191.1545954476894;
        Thu, 27 Dec 2018 15:47:56 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id l64sm48462219pge.73.2018.12.27.15.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Dec 2018 15:47:56 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH] ARM: mm: initialize pfn limits with find_limits()
Date:   Thu, 27 Dec 2018 15:47:27 -0800
Message-Id: <1545954447-22513-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_low_pfn value must be set before sparse_init() is called to
keep the early memblock allocations and frees balanced for kmemleak
initialization when sparsemem is enabled.

This commit accomplishes that by replacing the local variables min,
max_low, and max_high with the global limit variables min_low_pfn,
max_low_pfn, and max_pfn respectively in bootmem_init(). The global
variables are initialized directly by find_limits() and used in the
remainder of the function.

Fixes: 9099daed9c69 ("mm: kmemleak: avoid using __va() on addresses that don't have a lowmem mapping")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 arch/arm/mm/init.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 32e4845af2b6..98a733f3a5b9 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -302,15 +302,12 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 
 void __init bootmem_init(void)
 {
-	unsigned long min, max_low, max_high;
-
 	memblock_allow_resize();
-	max_low = max_high = 0;
 
-	find_limits(&min, &max_low, &max_high);
+	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 
-	early_memtest((phys_addr_t)min << PAGE_SHIFT,
-		      (phys_addr_t)max_low << PAGE_SHIFT);
+	early_memtest((phys_addr_t)min_low_pfn << PAGE_SHIFT,
+		      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
 
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(),
@@ -328,16 +325,7 @@ void __init bootmem_init(void)
 	 * the sparse mem_map arrays initialized by sparse_init()
 	 * for memmap_init_zone(), otherwise all PFNs are invalid.
 	 */
-	zone_sizes_init(min, max_low, max_high);
-
-	/*
-	 * This doesn't seem to be used by the Linux memory manager any
-	 * more, but is used by ll_rw_block.  If we can get rid of it, we
-	 * also get rid of some of the stuff above as well.
-	 */
-	min_low_pfn = min;
-	max_low_pfn = max_low;
-	max_pfn = max_high;
+	zone_sizes_init(min_low_pfn, max_low_pfn, max_pfn);
 }
 
 /*
-- 
2.7.4

