Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBBB20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfAQP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:27:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:27:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D479C059B7A;
        Thu, 17 Jan 2019 15:27:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D02560851;
        Thu, 17 Jan 2019 15:27:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] afs: Use struct_size() in kzalloc()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 15:27:36 +0000
Message-ID: <154773885685.24105.3699803861773624915.stgit@warthog.procyon.org.uk>
In-Reply-To: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
References: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 17 Jan 2019 15:27:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with
memory for some number of elements for that array. For example:

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
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/server_list.c |    4 +---
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
 

