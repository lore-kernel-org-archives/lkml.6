Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D20C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0852320645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571700;
	bh=u1pIxHDP0qJ+KkJoDyg8+zRW+M0CkPuHMLWd70yeq98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QBCRl5nzGGKaLUORpcv1RlRWJ/qcLja4CRbmbACSWsjGx2OZ6aqDBCLyixlo5HETI
	 jxtWU95Ao0aocb01Ri9QCwJWNatg5T1KMn2nAZqNHr7xKMiRs/buYu20aGoV0NdbIS
	 n+TFaNgVge5se/xdeYhLijASEHABC8hH5a5EbjR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfAORBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbfAOQhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331AC20868;
        Tue, 15 Jan 2019 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570251;
        bh=u1pIxHDP0qJ+KkJoDyg8+zRW+M0CkPuHMLWd70yeq98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpadtP2mb3kq78cyHTSf86KX/3iiojB4i2V2HRN7Shv6GLKZCAekujKGuyfuSQkkW
         CT1SUB2wgFp/2g4F+r3QeYFrtYlPxEFkE8AYK68ESFNygvsww/mqujAWOmpPIHsotN
         ynLUw+KGWR5w9oDksVr1vQGHymJirc6KNPoRBHUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 25/51] btrfs: tree-check: reduce stack consumption in check_dir_item
Date:   Tue, 15 Jan 2019 17:35:21 +0100
Message-Id: <20190115154850.212605253@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

commit e2683fc9d219430f5b78889b50cde7f40efeba7b upstream.

I've noticed that the updated item checker stack consumption increased
dramatically in 542f5385e20cf97447 ("btrfs: tree-checker: Add checker
for dir item")

tree-checker.c:check_leaf                    +552 (176 -> 728)

The array is 255 bytes long, dynamic allocation would slow down the
sanity checks so it's more reasonable to keep it on-stack. Moving the
variable to the scope of use reduces the stack usage again

tree-checker.c:check_leaf                    -264 (728 -> 464)

Reviewed-by: Josef Bacik <jbacik@fb.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -212,7 +212,6 @@ static int check_dir_item(struct btrfs_r
 
 	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 	while (cur < item_size) {
-		char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
 		u32 name_len;
 		u32 data_len;
 		u32 max_name_len;
@@ -295,6 +294,8 @@ static int check_dir_item(struct btrfs_r
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
+			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
 			name_hash = btrfs_name_hash(namebuf, name_len);


