Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42198C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BED217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359179;
	bh=SfLom5BcJPvMaMGp686lMUwM0VL+ik+u+n/e6XirH0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K2GB/X/Lt2iAGx3IrsBN3UVBtyXp7Zs6SgrbN7YBtmb4NV09QbDVAZ+r1mh5jseyg
	 Ue6yrbUoNqxM3syr+1wKFs83Ut2bqNs7HkRSrOX0NNrtDY8UNLdSS/XYF6bGAYosLy
	 F6uXcRVD2PTqzNtga/T50onWXuvsq10Eq4Za4zoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfAXTqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388026AbfAXToE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8AA620663;
        Thu, 24 Jan 2019 19:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359044;
        bh=SfLom5BcJPvMaMGp686lMUwM0VL+ik+u+n/e6XirH0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylL/mn760bqv1HcVIjBfu2Do+fYoF8XQTyh5bp1ZdspDr4T5yGCnUF1i71LZCMgj2
         jzBn7bmux/hQwa3ekYohLL5RUQsEyR/wYcTfhXdoZNePWEDHH6BXt8bA72xsJ2shsG
         hU8d2KntYBgTgiAgsnWZ1LXHWiL4iaXv6RQJZFMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 080/127] btrfs: improve error handling of btrfs_add_link
Date:   Thu, 24 Jan 2019 20:20:26 +0100
Message-Id: <20190124190215.521067939@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 02772f8823cf..561bffcb56a0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6419,14 +6419,19 @@ fail_dir_item:
 		err = btrfs_del_root_ref(trans, key.objectid,
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



