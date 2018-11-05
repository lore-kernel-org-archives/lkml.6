Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D734C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51AB20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51AB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeKEUgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:36:18 -0500
Received: from relay.sw.ru ([185.231.240.75]:47944 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbeKEUgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:36:18 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gJcsQ-0007QG-0v; Mon, 05 Nov 2018 14:17:02 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] mm: use kvzalloc for swap_info_struct allocation
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>
References: <20181105061016.GA4502@intel.com>
Message-ID: <fc23172d-3c75-21e2-d551-8b1808cbe593@virtuozzo.com>
Date:   Mon, 5 Nov 2018 14:17:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105061016.GA4502@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a2468cc9bfdf ("swap: choose swap device according to numa node")
changed 'avail_lists' field of 'struct swap_info_struct' to an array.
In popular linux distros it increased size of swap_info_struct up to
40 Kbytes and now swap_info_struct allocation requires order-4 page.
Switch to kvzmalloc allows to avoid unexpected allocation failures.

Acked-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/swapfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 644f746e167a..8688ae65ef58 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2813,7 +2813,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 	unsigned int type;
 	int i;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kvzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -2824,7 +2824,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	if (type >= MAX_SWAPFILES) {
 		spin_unlock(&swap_lock);
-		kfree(p);
+		kvfree(p);
 		return ERR_PTR(-EPERM);
 	}
 	if (type >= nr_swapfiles) {
@@ -2838,7 +2838,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 		smp_wmb();
 		nr_swapfiles++;
 	} else {
-		kfree(p);
+		kvfree(p);
 		p = swap_info[type];
 		/*
 		 * Do not memset this entry: a racing procfs swap_next()
-- 
2.17.1

