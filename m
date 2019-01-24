Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C9C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2EB21903
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358442;
	bh=q8gvVrYg/+Iq88f/k0SIPMx8MYtOKWuAnhJJbWk8s5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a3/UEXqiEhV64p2b4AdnMwgwppCO5BYcWeUquDOvYwWW2VMKXK6QWB5Laby2EaSj6
	 9CeoT8vGYlRy8iFDFT5wlX4wPwefV2l0bdtL/1z6IJvYaiKUwW+rUYvMpgDosoMKXw
	 PkB4GFgTj+XlvL1m78PE5MXOCPKTmtgXosTP4yMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfAXTeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:34:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731678AbfAXTd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:33:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CF221905;
        Thu, 24 Jan 2019 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358435;
        bh=q8gvVrYg/+Iq88f/k0SIPMx8MYtOKWuAnhJJbWk8s5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMZDCR9A55/lCDs4ASw6zxS/Snou/4LELaxMmIUMW7tDzRpnFO5y7LT+BxG3rxSMu
         AJxXi00INMjxzPVveyqPCMDxNutR9wDFSa7zHVJXf2zNVJl2hixYnp1qVz0jbewwbf
         COJaTrj2FeexMMCjCw5CSD5xqbLOV5OgKQoDCvIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 36/63] btrfs: improve error handling of btrfs_add_link
Date:   Thu, 24 Jan 2019 20:20:25 +0100
Message-Id: <20190124190159.306977550@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1690dd41e0cb1dade80850ed8a3eb0121b96d22f ]

In the error handling block, err holds the return value of either
btrfs_del_root_ref() or btrfs_del_inode_ref() but it hasn't been checked
since it's introduction with commit fe66a05a0679 (Btrfs: improve error
handling for btrfs_insert_dir_item callers) in 2012.

If the error handling in the error handling fails, there's not much left
to do and the abort either happened earlier in the callees or is
necessary here.

So if one of btrfs_del_root_ref() or btrfs_del_inode_ref() failed, abort
the transaction, but still return the original code of the failure
stored in 'ret' as this will be reported to the user.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 909f7ea92e0b..7e288510fd2c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6594,14 +6594,19 @@ fail_dir_item:
 		err = btrfs_del_root_ref(trans, fs_info, key.objectid,
 					 root->root_key.objectid, parent_ino,
 					 &local_index, name, name_len);
-
+		if (err)
+			btrfs_abort_transaction(trans, err);
 	} else if (add_backref) {
 		u64 local_index;
 		int err;
 
 		err = btrfs_del_inode_ref(trans, root, name, name_len,
 					  ino, parent_ino, &local_index);
+		if (err)
+			btrfs_abort_transaction(trans, err);
 	}
+
+	/* Return the original error code */
 	return ret;
 }
 
-- 
2.19.1



