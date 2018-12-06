Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8036C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB1F20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107744;
	bh=oVGQIz4XXiEGOftiRYiY1jIhPDOYSnxinYpNM4ouqKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyCNuXVOJByHl+my0nkKErmzPHgWXjutfWW1oXc+mLp08o2hzvLXkHC+OLB2X0rvb
	 ILa+5Jgv8dAS8OlGcMAoHWE0WgZIIOnvJYyM8JZtNCUUsAJTSq1Kj1Ggb5lO/WiP/F
	 KU8GtE9HIiG4B7OnV+5+beTDnQApjPmqWJUx5UX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB1F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbeLFOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbeLFOsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:48:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04CC020892;
        Thu,  6 Dec 2018 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107695;
        bh=oVGQIz4XXiEGOftiRYiY1jIhPDOYSnxinYpNM4ouqKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpNAeRbqGZdX8nK/H1mnHqNH0JOBmYP1qoUhQBWzXz6hZaVhdf01LFlKKLVZWv+Hr
         BR+q/sX1vKYWnwcH6JdBCA5MTxFhKc1Bx00/PpJyuh7kKvO2lmcoI3bYLv37aOs0Rg
         p/YTXj+qf0ybF6YJpPASi+il/yotuR2CYCKYOkiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 077/101] btrfs: tree-check: reduce stack consumption in check_dir_item
Date:   Thu,  6 Dec 2018 15:39:16 +0100
Message-Id: <20181206143016.555628642@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


