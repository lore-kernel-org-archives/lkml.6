Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A70620823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfBUPqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:46:24 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.253]:22005 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfBUPqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:46:24 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id EA57415677E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:46:23 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wqYJgWfWg2PzOwqYJgyukU; Thu, 21 Feb 2019 09:46:23 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=37372 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gwqYJ-000atD-5u; Thu, 21 Feb 2019 09:46:23 -0600
Date:   Thu, 21 Feb 2019 09:46:22 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mm/swapfile.c: use struct_size() in kvzalloc()
Message-ID: <20190221154622.GA19599@embeddedor>
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
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gwqYJ-000atD-5u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:37372
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kvzalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kvzalloc(struct_size(instance, entry, count), GFP_KERNEL);

Notice that, in this case, variable size is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 mm/swapfile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index cca8420b12db..fd9b0025ad00 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2713,9 +2713,8 @@ static struct swap_info_struct *alloc_swap_info(void)
 	struct swap_info_struct *p;
 	unsigned int type;
 	int i;
-	unsigned int size = sizeof(*p) + nr_node_ids * sizeof(struct plist_node);
 
-	p = kvzalloc(size, GFP_KERNEL);
+	p = kvzalloc(struct_size(p, avail_lists, nr_node_ids), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.20.1

