Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAB420844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAB420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeIGVdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:33:00 -0400
Received: from nautica.notk.org ([91.121.71.147]:38082 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbeIGVc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:32:59 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 3478AC01A; Fri,  7 Sep 2018 18:51:12 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 1/4] 9p: acl: fix uninitialized iattr access
Date:   Fri,  7 Sep 2018 18:50:54 +0200
Message-Id: <1536339057-21974-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1536339057-21974-1-git-send-email-asmadeus@codewreck.org>
References: <1536339057-21974-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

iattr is passed to v9fs_vfs_setattr_dotl which does send various
values from iattr over the wire, even if it tells the server to
only look at iattr.ia_valid fields this could leak some stack data.

Addresses-Coverity-ID: 1195601 ("Uninitalized scalar variable")
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---
 fs/9p/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 082d227fa56b..6261719f6f2a 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -276,7 +276,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 	switch (handler->flags) {
 	case ACL_TYPE_ACCESS:
 		if (acl) {
-			struct iattr iattr;
+			struct iattr iattr = { 0 };
 			struct posix_acl *old_acl = acl;
 
 			retval = posix_acl_update_mode(inode, &iattr.ia_mode, &acl);
-- 
2.17.1

