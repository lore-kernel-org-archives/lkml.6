Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D99C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA18C20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SntNiq5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA18C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeLDLWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeLDLCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A193D214E0;
        Tue,  4 Dec 2018 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921351;
        bh=KsOyvkKrYRl7HQwnlYfX3WOZWxnS1lAd76q/yJX8W9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SntNiq5mjNY7oHr3dqBhJc422DSGY4o+Me3177JRc0S12KOErBqYoTh+xW5P4AU4a
         evZ/oSfv5m5X4QVpozORXkxwA0i4sAe5YKP54yzXVueC0J8O4b2OUuu31QX1hyBdjd
         ruz+UbntX6HEF+WSnC2bWWW44O89r/iy7h6EPHV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 038/146] btrfs: tree-check: reduce stack consumption in check_dir_item
Date:   Tue,  4 Dec 2018 11:48:44 +0100
Message-Id: <20181204103728.388713799@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9376739a4cc8..f7e7a455b710 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -212,7 +212,6 @@ static int check_dir_item(struct btrfs_root *root,
 
 	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 	while (cur < item_size) {
-		char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
 		u32 name_len;
 		u32 data_len;
 		u32 max_name_len;
@@ -295,6 +294,8 @@ static int check_dir_item(struct btrfs_root *root,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
+			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
 			name_hash = btrfs_name_hash(namebuf, name_len);
-- 
2.17.1



