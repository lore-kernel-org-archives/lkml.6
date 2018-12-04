Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4D5C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51642214F1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJumK2vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51642214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbeLDLDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbeLDLDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6D8214DE;
        Tue,  4 Dec 2018 11:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921428;
        bh=Z8+JQz/WAcAk5NbUECB1z7/j9JOusXeGQ7VuVKWNH1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJumK2vgbQbetDaZhUi5x3Uei7L9lZMKYzZluPN7bhe7qBCoZRLROYJaRfZaWu/SP
         FDIz1LFkqcvWhmY9HyfyJbqOVtZxDetoA4Kwsapb3IZSSwG3UyDvhwvNZc2drBfib6
         OSb7JvSkI8eElYqTH47f0djTGSlwuYpINjcf0KQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 032/146] btrfs: Add checker for EXTENT_CSUM
Date:   Tue,  4 Dec 2018 11:48:38 +0100
Message-Id: <20181204103728.151080174@linuxfoundation.org>
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

commit 4b865cab96fe2a30ed512cf667b354bd291b3b0a upstream.

EXTENT_CSUM checker is a relatively easy one, only needs to check:

1) Objectid
   Fixed to BTRFS_EXTENT_CSUM_OBJECTID

2) Key offset alignment
   Must be aligned to sectorsize

3) Item size alignedment
   Must be aligned to csum size

Signed-off-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ab8925b2efd1..53841d773a40 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -627,6 +627,27 @@ static int check_extent_data_item(struct btrfs_root *root,
 	return 0;
 }
 
+static int check_csum_item(struct btrfs_root *root, struct extent_buffer *leaf,
+			   struct btrfs_key *key, int slot)
+{
+	u32 sectorsize = root->fs_info->sectorsize;
+	u32 csumsize = btrfs_super_csum_size(root->fs_info->super_copy);
+
+	if (key->objectid != BTRFS_EXTENT_CSUM_OBJECTID) {
+		CORRUPT("invalid objectid for csum item", leaf, root, slot);
+		return -EUCLEAN;
+	}
+	if (!IS_ALIGNED(key->offset, sectorsize)) {
+		CORRUPT("unaligned key offset for csum item", leaf, root, slot);
+		return -EUCLEAN;
+	}
+	if (!IS_ALIGNED(btrfs_item_size_nr(leaf, slot), csumsize)) {
+		CORRUPT("unaligned csum item size", leaf, root, slot);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -640,6 +661,9 @@ static int check_leaf_item(struct btrfs_root *root,
 	case BTRFS_EXTENT_DATA_KEY:
 		ret = check_extent_data_item(root, leaf, key, slot);
 		break;
+	case BTRFS_EXTENT_CSUM_KEY:
+		ret = check_csum_item(root, leaf, key, slot);
+		break;
 	}
 	return ret;
 }
-- 
2.17.1



