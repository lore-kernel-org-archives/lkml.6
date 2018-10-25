Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C54C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2120873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEHDvM2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE2120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbeJYWyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731391AbeJYWyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:14 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44BD208A3;
        Thu, 25 Oct 2018 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477276;
        bh=oUgCrfxuFoKusEFzDu8KhR5xjFkIXaKyFd7BWgyoW0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEHDvM2sD2yg8T/hj3KmPlGwMorcWTzptH/Mcq38DhkDwBtq8Va0cdd+B30TT/uYT
         TKDvPt5nnqZ9atLtYE/cvIRTD/S18p30zwBGt58WNnV6JxQAqGaqwazml51rrsqVoI
         C3ciDsss9oX9GO8PQa9RhETjeb3FTe+NvG9ZWo00=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 92/98] ovl: fix open in stacked overlay
Date:   Thu, 25 Oct 2018 10:18:47 -0400
Message-Id: <20181025141853.214051-92-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <miklos@szeredi.hu>

[ Upstream commit 1c8a47df36d72ace8cf78eb6c228aa0f8027d3c2 ]

If two overlayfs filesystems are stacked on top of each other, then we need
recursion in ovl_d_select_inode().

I guess d_backing_inode() is supposed to do that.  But currently it doesn't
and that functionality is open coded in vfs_open().  This is now copied
into ovl_d_select_inode() to fix this regression.

Reported-by: Alban Crequy <alban.crequy@gmail.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Fixes: 4bacc9c9234c ("overlayfs: Make f_path always point to the overlay...")
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org> # v4.2+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index df5c2853c4e5..a01ec1836a72 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -377,6 +377,9 @@ struct inode *ovl_d_select_inode(struct dentry *dentry, unsigned file_flags)
 		ovl_path_upper(dentry, &realpath);
 	}
 
+	if (realpath.dentry->d_flags & DCACHE_OP_SELECT_INODE)
+		return realpath.dentry->d_op->d_select_inode(realpath.dentry, file_flags);
+
 	return d_backing_inode(realpath.dentry);
 }
 
-- 
2.17.1

