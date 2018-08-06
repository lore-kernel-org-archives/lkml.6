Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC11C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407E821A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407E821A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeHFP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:26:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729660AbeHFP0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4919406F8A7;
        Mon,  6 Aug 2018 13:17:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E48C51010427;
        Mon,  6 Aug 2018 13:17:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/10] afs: Don't invoke the server to read data beyond EOF
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:17:46 +0100
Message-ID: <153356146640.1195.13118526596319391965.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 13:17:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 13:17:47 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing a new page, clear space in the page rather than attempting to
load it from the server if the space is beyond the EOF.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/write.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 6ff0f25836de..7c7a03310f16 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -33,10 +33,21 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 			 loff_t pos, unsigned int len, struct page *page)
 {
 	struct afs_read *req;
+	size_t p;
+	void *data;
 	int ret;
 
 	_enter(",,%llu", (unsigned long long)pos);
 
+	if (pos >= vnode->vfs_inode.i_size) {
+		p = pos & ~PAGE_MASK;
+		ASSERTCMP(p + len, <=, PAGE_SIZE);
+		data = kmap(page);
+		memset(data + p, 0, len);
+		kunmap(page);
+		return 0;
+	}
+
 	req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;

