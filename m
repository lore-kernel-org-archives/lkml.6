Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1775C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97642510E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97642510E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934446AbeFXPxZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:53:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933919AbeFXPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:53:22 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4DC42C;
        Sun, 24 Jun 2018 15:53:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaco Kroon <jaco@uls.co.za>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 4.9 22/39] ext4: fix fencepost error in check for inode count overflow during resize
Date:   Sun, 24 Jun 2018 23:24:09 +0800
Message-Id: <20180624152354.480673614@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
References: <20180624152352.038950449@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 4f2f76f751433908364ccff82f437a57d0e6e9b7 upstream.

ext4_resize_fs() has an off-by-one bug when checking whether growing of
a filesystem will not overflow inode count. As a result it allows a
filesystem with 8192 inodes per group to grow to 64TB which overflows
inode count to 0 and makes filesystem unusable. Fix it.

Cc: stable@vger.kernel.org
Fixes: 3f8a6411fbada1fa482276591e037f3b1adcf55b
Reported-by: Jaco Kroon <jaco@uls.co.za>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1903,7 +1903,7 @@ retry:
 		return 0;
 
 	n_group = ext4_get_group_number(sb, n_blocks_count - 1);
-	if (n_group > (0xFFFFFFFFUL / EXT4_INODES_PER_GROUP(sb))) {
+	if (n_group >= (0xFFFFFFFFUL / EXT4_INODES_PER_GROUP(sb))) {
 		ext4_warning(sb, "resize would cause inodes_count overflow");
 		return -EINVAL;
 	}


