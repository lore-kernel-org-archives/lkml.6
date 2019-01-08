Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EDAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C896420883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfAHVbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:31:01 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.39]:37166 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728913AbfAHVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:31:01 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D01836DEF53
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 15:31:00 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gyxggbvZk2qH7gyxggGqkI; Tue, 08 Jan 2019 15:31:00 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=60024 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ggyxg-000LTL-8d; Tue, 08 Jan 2019 15:31:00 -0600
Date:   Tue, 8 Jan 2019 15:30:59 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] afs: Use struct_size() in kzalloc()
Message-ID: <20190108213059.GA10112@embeddedor>
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
X-Exim-ID: 1ggyxg-000LTL-8d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:60024
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
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
 fs/afs/server_list.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 95d0761cdb34..155dc14caef9 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -42,9 +42,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 		if (vldb->fs_mask[i] & type_mask)
 			nr_servers++;
 
-	slist = kzalloc(sizeof(struct afs_server_list) +
-			sizeof(struct afs_server_entry) * nr_servers,
-			GFP_KERNEL);
+	slist = kzalloc(struct_size(slist, servers, nr_servers), GFP_KERNEL);
 	if (!slist)
 		goto error;
 
-- 
2.20.1

