Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF8FA3745
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C487B21530
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C487B21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeIMVTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:19:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbeIMVTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:19:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26AD7308403C;
        Thu, 13 Sep 2018 16:09:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F17A65D9C9;
        Thu, 13 Sep 2018 16:09:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/6] afs: afs_end_vnode_operation() needs to translate abort
 codes to errors
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 17:09:16 +0100
Message-ID: <153685495622.16086.10265386563835390377.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Sep 2018 16:09:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_end_vnode_operation() calls the function to translate an abort code
into an error return, but never actually assigns the error.

Fix this by storing the looked up error back into the cursor.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rotate.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 1faef56b12bd..add0dbb18763 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -512,7 +512,6 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 {
 	struct afs_net *net = afs_v2net(fc->vnode);
-	int ret;
 
 	mutex_unlock(&fc->vnode->io_lock);
 
@@ -520,9 +519,8 @@ int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 	afs_put_cb_interest(net, fc->cbi);
 	afs_put_serverlist(net, fc->server_list);
 
-	ret = fc->ac.error;
-	if (ret == -ECONNABORTED)
-		afs_abort_to_error(fc->ac.abort_code);
+	if (fc->ac.error == -ECONNABORTED)
+		fc->ac.error = afs_abort_to_error(fc->ac.abort_code);
 
 	return fc->ac.error;
 }

