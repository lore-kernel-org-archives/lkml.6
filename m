Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D046214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D046214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeHUNOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:14:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeHUNOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:14:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAB47401EF05;
        Tue, 21 Aug 2018 09:55:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-147.rdu2.redhat.com [10.10.123.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52A8C112D163;
        Tue, 21 Aug 2018 09:55:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] vfs: Fix vfs_dup_fs_context()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 10:55:05 +0100
Message-ID: <153484530575.1183.124318951692100857.stgit@warthog.procyon.org.uk>
In-Reply-To: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
References: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 21 Aug 2018 09:55:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 21 Aug 2018 09:55:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfs_dup_fs_context() allocates the wrong type of structure and as a result
ends up with one that's too small.

This isn't a problem at this time as nothing uses vfs_dup_fs_context() yet
(until nfs and btrfs conversions come along).

Fixes: ad3e21240b41 ("vfs: Implement a filesystem superblock creation/configuration context")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs_context.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a6597a2fbf2b..14921b2c1e42 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -348,7 +348,7 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 	if (!src_fc->ops->dup)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	fc = kmemdup(src_fc, sizeof(struct legacy_fs_context), GFP_KERNEL);
+	fc = kmemdup(src_fc, sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
 		return ERR_PTR(-ENOMEM);
 

