Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43602081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43602081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeK2EoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:44:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:39399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbeK2EoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:44:03 -0500
Received: from qcai.nay.com ([66.187.233.206]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MIzGn-1gQ8xq1Y2D-002aBw; Wed, 28
 Nov 2018 18:41:27 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, mhocko@suse.com, rppt@linux.vnet.ibm.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] mm/memblock: skip kmemleak for kasan_init()
Date:   Wed, 28 Nov 2018 12:40:33 -0500
Message-Id: <1543426833-24378-1-git-send-email-cai@gmx.us>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:qjMDYAnS9M16W4sElBJaSqT3EFyT3+AdB9qEyEt3yDLNPxiFnSI
 8eL/sLnADeJgHy+kDJ4y6wCMvau7xSN6ZKSdNQWHVpIOcJDk9Vi7bG0txAC+Pzjvv+VVeso
 48uP5hxkjSCrfGvj+n2bPJsHKlnVqJ0/mueHD10q6cHQZQwDD46YBFqqqN0p7NUs+LpEDtS
 5E9c/U1hEhah/OBFkW4Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zuh3AKbbfzA=:FGGwhkdEGq8mSIMD1wP//Z
 /LRPjbUuk6EZrXJjzKUIwXkGBbudQSUVrtkiX7KD4krJRoiHzH3HzOuEC+qgSuVEze6x91IgU
 JIB5FRMcDNLBkEfr3eZ8C7Vhu1JuAnf2Ff4vb36JgnZg2Eh6TIql2av9VcWke37SXY8pE/DoV
 ffAKGlBhVvAFdzGmJDzlzRRcevIyewE0OWSx+M+IRpC4cmc+LWc2XDJPKRfbcCOhMtpqsSW2Z
 X/r/+Rzod3nTo9BOKdZ2NeMoBK+1c+F/MYpIpiMBeOXDaofnXQE7huSoiYb2cZgvRfbrsZpzE
 RkK4VuA1rb8PzxnNNz8n7ocyrknMu5z7IgI+pfSbA5KYE/8xb7et17BAKci7Xz6hBCDeXyGGG
 9v0Dz3cbNboNNoxY4S4kn2jkKFwwXq7zO7laBysahktCD0xIRY5YvwmFp++k8aO4FvThp0x1L
 u8TSMuMxcagG91rcyPUaI1hrngz9sazzYI3W1WwsX7lDkWkEwnFyhpzhBw8TEknbdu/tuQNtt
 AiXG5fNAcwuvJ3RSKStKL8an9P+gX3swRLGqf00crvdyv84aeIaYsRvCmdCH62lTYlPFBK68H
 I9cKVHAL5HTfbbF5mw/vp3jO7qobFzE1YbkmtNTkndXlwsrlCUKtW/Bnc/NjK2dlBsxBZc7CN
 5169O9cF+nctPhfpQlziSyLDty7Rm9vIuvD7hhfDJ7vPA7d0TYlma6tDIBddTxRyXZPd5VUpa
 I3euMyrk7PfFcZ5Nk6JZr5sf7IIbxm69ofcp+ufVou8EWiDp/psAoLjFvHvFnBPEm/EzBKfo/
 TEkoEydYfa4HT0PwmMg3VK378kKvZWVDCFvHcTRJlseDG91fYE8dFRPypvbz4QsIf2Dzu2LZj
 ttbd+BlPUdLZgU4R+wPqNRbkqqEf8q5kvQJCtM+ls=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak does not play well with KASAN (tested on both HPE Apollo 70 and
Huawei TaiShan 2280 aarch64 servers).

After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early
log buffer went from something like 280 to 260000 which caused kmemleak
disabled and crash dump memory reservation failed. The multitude of
kmemleak_alloc() calls is from,

for_each_memblock(memory, reg) x \
while (pgdp++, addr = next, addr != end) x \
while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp))) \
while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp))) \
while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)))

Signed-off-by: Qian Cai <cai@gmx.us>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 9a2d5ae..fd78e39 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1412,6 +1412,8 @@ static void * __init memblock_alloc_internal(
 done:
 	ptr = phys_to_virt(alloc);
 
+/* Skip kmemleak for kasan_init() due to high volume. */
+#ifndef CONFIG_KASAN
 	/*
 	 * The min_count is set to 0 so that bootmem allocated blocks
 	 * are never reported as leaks. This is because many of these blocks
@@ -1419,6 +1421,7 @@ static void * __init memblock_alloc_internal(
 	 * looked up by kmemleak.
 	 */
 	kmemleak_alloc(ptr, size, 0, 0);
+#endif
 
 	return ptr;
 }
-- 
1.8.3.1

