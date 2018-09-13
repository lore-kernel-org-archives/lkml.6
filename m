Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A0C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A9620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A9620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbeIMS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:56:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeIMS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:56:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D93F1D19;
        Thu, 13 Sep 2018 13:46:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 080/115] btrfs: Exit gracefully when chunk map cannot be inserted to the tree
Date:   Thu, 13 Sep 2018 15:31:40 +0200
Message-Id: <20180913131828.505905143@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 64f64f43c89aca1782aa672e0586f6903c5d8979 ]

It's entirely possible that a crafted btrfs image contains overlapping
chunks.

Although we can't detect such problem by tree-checker, it's not a
catastrophic problem, current extent map can already detect such problem
and return -EEXIST.

We just only need to exit gracefully and fail the mount.

Reported-by: Xu Wen <wen.xu@gatech.edu>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200409
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6492,10 +6492,14 @@ static int read_one_chunk(struct btrfs_f
 	write_lock(&map_tree->map_tree.lock);
 	ret = add_extent_mapping(&map_tree->map_tree, em, 0);
 	write_unlock(&map_tree->map_tree.lock);
-	BUG_ON(ret); /* Tree corruption */
+	if (ret < 0) {
+		btrfs_err(fs_info,
+			  "failed to add chunk map, start=%llu len=%llu: %d",
+			  em->start, em->len, ret);
+	}
 	free_extent_map(em);
 
-	return 0;
+	return ret;
 }
 
 static void fill_device_from_item(struct extent_buffer *leaf,


