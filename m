Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F76ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF12214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF12214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeJTJUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:20:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:20:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C97530820C4;
        Sat, 20 Oct 2018 01:11:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCD76C51B;
        Sat, 20 Oct 2018 01:11:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/24] afs: Don't invoke the server to read data beyond EOF
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:11:57 +0100
Message-ID: <153999791749.866.7965988630811562818.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 20 Oct 2018 01:11:59 +0000 (UTC)
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
index fdb9d6024126..11066a3248ba 100644
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
 	req = kzalloc(sizeof(struct afs_read) + sizeof(struct page *),
 		      GFP_KERNEL);
 	if (!req)

