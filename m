Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83946C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A61020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqz0zJ3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A61020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbeKLJh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733176AbeKLISt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:49 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE0D21582;
        Sun, 11 Nov 2018 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975333;
        bh=l+4G7udtpBLJaaPhSe2a2226TUYcXdtPjyVzy44caCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dqz0zJ3OiYHPID+hIKM6KliPUWM5voOQ1/yhXS2dSBIpPaCMMP07ksXdoM+i4wj2J
         zr31DZErhoLDpOIOpBrHZJEcmkgwRoSa5tdMhXHc/TQznTNMbuWXhtdZkWmIt6hn51
         toWWnqEFaasFLJNW3wNqnUxJzN8cgLSE1CM7yp6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 350/361] btrfs: dont use ctl->free_space for max_extent_size
Date:   Sun, 11 Nov 2018 14:21:37 -0800
Message-Id: <20181111221701.463651122@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>

commit fb5c39d7a887108087de6ff93d3f326b01b4ef41 upstream.

max_extent_size is supposed to be the largest contiguous range for the
space info, and ctl->free_space is the total free space in the block
group.  We need to keep track of these separately and _only_ use the
max_free_space if we don't have a max_extent_size, as that means our
original request was too large to search any of the block groups for and
therefore wouldn't have a max_extent_size set.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7230,6 +7230,7 @@ static noinline int find_free_extent(str
 	struct btrfs_block_group_cache *block_group = NULL;
 	u64 search_start = 0;
 	u64 max_extent_size = 0;
+	u64 max_free_space = 0;
 	u64 empty_cluster = 0;
 	struct btrfs_space_info *space_info;
 	int loop = 0;
@@ -7525,8 +7526,8 @@ unclustered_alloc:
 			spin_lock(&ctl->tree_lock);
 			if (ctl->free_space <
 			    num_bytes + empty_cluster + empty_size) {
-				if (ctl->free_space > max_extent_size)
-					max_extent_size = ctl->free_space;
+				max_free_space = max(max_free_space,
+						     ctl->free_space);
 				spin_unlock(&ctl->tree_lock);
 				goto loop;
 			}
@@ -7693,6 +7694,8 @@ loop:
 	}
 out:
 	if (ret == -ENOSPC) {
+		if (!max_extent_size)
+			max_extent_size = max_free_space;
 		spin_lock(&space_info->lock);
 		space_info->max_extent_size = max_extent_size;
 		spin_unlock(&space_info->lock);


