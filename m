Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3178AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065EE20656
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfAIRpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:45:01 -0500
Received: from gateway20.websitewelcome.com ([192.185.65.13]:29661 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbfAIRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:45:00 -0500
X-Greylist: delayed 1212 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 12:45:00 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3F1A840126EE2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 11:24:47 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hHaxg8yikdnCehHaxgEmrB; Wed, 09 Jan 2019 11:24:47 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=44100 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghHaw-003lK6-Kn; Wed, 09 Jan 2019 11:24:46 -0600
Date:   Wed, 9 Jan 2019 11:24:45 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] gcov: use struct_size() in kzalloc()
Message-ID: <20190109172445.GA15908@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghHaw-003lK6-Kn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:44100
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with memory
for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/gcov/gcc_3_4.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
index 1e32e66c9563..2dddecbdbe6e 100644
--- a/kernel/gcov/gcc_3_4.c
+++ b/kernel/gcov/gcc_3_4.c
@@ -245,8 +245,7 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
 
 	/* Duplicate gcov_info. */
 	active = num_counter_active(info);
-	dup = kzalloc(sizeof(struct gcov_info) +
-		      sizeof(struct gcov_ctr_info) * active, GFP_KERNEL);
+	dup = kzalloc(struct_size(dup, counts, active), GFP_KERNEL);
 	if (!dup)
 		return NULL;
 	dup->version		= info->version;
@@ -364,8 +363,7 @@ struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
 {
 	struct gcov_iterator *iter;
 
-	iter = kzalloc(sizeof(struct gcov_iterator) +
-		       num_counter_active(info) * sizeof(struct type_info),
+	iter = kzalloc(struct_size(iter, type_info, num_counter_active(info)),
 		       GFP_KERNEL);
 	if (iter)
 		iter->info = info;
-- 
2.20.1

