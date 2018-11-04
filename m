Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D8ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00E32081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00E32081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbeKEH3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:29:43 -0500
Received: from relay.sw.ru ([185.231.240.75]:54608 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbeKEH3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:29:42 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gJQds-00063T-EZ; Mon, 05 Nov 2018 01:13:12 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 2/2] mm: avoid unnecessary swap_info_struct allocation
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>
Message-ID: <a24bf353-8715-2bee-d0fa-96ca06c5b69f@virtuozzo.com>
Date:   Mon, 5 Nov 2018 01:13:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently newly allocated swap_info_struct can be quickly freed.
This patch avoid uneccessary high-order page allocation and helps
to decrease the memory pressure.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/swapfile.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8688ae65ef58..53ec2f0cdf26 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2809,14 +2809,17 @@ late_initcall(max_swapfiles_check);
 
 static struct swap_info_struct *alloc_swap_info(void)
 {
-	struct swap_info_struct *p;
+	struct swap_info_struct *p = NULL;
 	unsigned int type;
 	int i;
+	bool force_alloc = false;
 
-	p = kvzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
+retry:
+	if (force_alloc) {
+		p = kvzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return ERR_PTR(-ENOMEM);
+	}
 	spin_lock(&swap_lock);
 	for (type = 0; type < nr_swapfiles; type++) {
 		if (!(swap_info[type]->flags & SWP_USED))
@@ -2828,6 +2831,11 @@ static struct swap_info_struct *alloc_swap_info(void)
 		return ERR_PTR(-EPERM);
 	}
 	if (type >= nr_swapfiles) {
+		if (!force_alloc) {
+			force_alloc = true;
+			spin_unlock(&swap_lock);
+			goto retry;
+		}
 		p->type = type;
 		swap_info[type] = p;
 		/*
-- 
2.17.1


