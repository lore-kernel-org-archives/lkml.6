Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1589DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68BC208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfeh3guB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68BC208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeKIHft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbeKIHfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:48 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431F0208E3;
        Thu,  8 Nov 2018 21:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714300;
        bh=s+AShUkBd/qwo94Rq0iejbV0auoreRcHzBFuLirBO1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hfeh3guBFVPkY7l0rZk+jFAIyfWebWmxjOuQv7qXiruoQDG3NYmu/G3xt9FEcmCf4
         Xh7y7UpVY+ax2vNUyHDnHfSA3bZ6zYbu6COHFKcndF7phdFqFwEav1czla0ezONiQc
         mRJclnZaDlWfp05qElqtFl7biIHjxq4YW2tG8mPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Crequy <alban.crequy@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 120/144] ovl: fix open in stacked overlay
Date:   Thu,  8 Nov 2018 13:51:31 -0800
Message-Id: <20181108215106.712592404@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



