Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C15E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570592;
	bh=V+F6vjlImWUE+oxpFQaEK880Gb92fPsOY2fKHCdGv38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sIjJwTuchmV1cQC2bNvyLlaRZSee0K1U1MfYX6gRRK2NZhc8UhFMTVTT9kYVLy24s
	 8S9qaFI/KP6ZHqsgJxACqT2EG623b9TgN4JBe46B9MtJCNjkpS///zjN9WiSF6lVvL
	 JihH5DDBduk8woYsG2pIEXGe/b8Wp5rqTbe7bCh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbfAOQnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733163AbfAOQnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232CD20645;
        Tue, 15 Jan 2019 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570588;
        bh=V+F6vjlImWUE+oxpFQaEK880Gb92fPsOY2fKHCdGv38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljGMeB2YYLHFm1aHxRBLN2tuuzQTFKYDUeoyNmQfWjujYy/WdS/l4rRO3osGQz5+U
         4iyjtLRbpUlCPtymeIRiSdu6nJMdPuS8YtS2W/RmNW0WACc/W6ZZZHNx5xAAtvLzh/
         7e9Qvw6S0pXe/Fn7Pbts7faTGBEBBE8xecn5PDrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 50/50] Btrfs: use nofs context when initializing security xattrs to avoid deadlock
Date:   Tue, 15 Jan 2019 17:36:26 +0100
Message-Id: <20190115154912.890567679@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 827aa18e7b903c5ff3b3cd8fec328a99b1dbd411 upstream.

When initializing the security xattrs, we are holding a transaction handle
therefore we need to use a GFP_NOFS context in order to avoid a deadlock
with reclaim in case it's triggered.

Fixes: 39a27ec1004e8 ("btrfs: use GFP_KERNEL for xattr and acl allocations")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/xattr.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -11,6 +11,7 @@
 #include <linux/security.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/iversion.h>
+#include <linux/sched/mm.h>
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
@@ -422,9 +423,15 @@ static int btrfs_initxattrs(struct inode
 {
 	const struct xattr *xattr;
 	struct btrfs_trans_handle *trans = fs_info;
+	unsigned int nofs_flag;
 	char *name;
 	int err = 0;
 
+	/*
+	 * We're holding a transaction handle, so use a NOFS memory allocation
+	 * context to avoid deadlock if reclaim happens.
+	 */
+	nofs_flag = memalloc_nofs_save();
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		name = kmalloc(XATTR_SECURITY_PREFIX_LEN +
 			       strlen(xattr->name) + 1, GFP_KERNEL);
@@ -440,6 +447,7 @@ static int btrfs_initxattrs(struct inode
 		if (err < 0)
 			break;
 	}
+	memalloc_nofs_restore(nofs_flag);
 	return err;
 }
 


