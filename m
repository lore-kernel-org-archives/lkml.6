Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E45C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB062054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570284;
	bh=CETXa2M8JxvnuIpZUwIhCpIEAyRQITBxd6nxpGwIcDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Kbb8tZvpmYxdL8v4eT1tPxN3Z2CieChH597bh5s/efJihCBCKBnyG3uiDlvYqcc9
	 hi/PH9JzQ/U/Sj16lM80VCuwVhMUQpB7o10kcFdJS1TU8C8jQ7jhAmp/0JH34PY4Sv
	 bA5TSyjs8HcxQjhlZXDVxzvgycImyiB3ua3o8HGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfAOQiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfAOQiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BD720675;
        Tue, 15 Jan 2019 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570280;
        bh=CETXa2M8JxvnuIpZUwIhCpIEAyRQITBxd6nxpGwIcDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcu17OV8Dpog0Jf7Df0UKDB4vTvSsNWwkE3R1GNH/aXw8QXigKhVLOo7+miB72VBd
         H5zPOz0CS2I02ePaT17D5AyntS84o+5yQ9HeCFs7oMGcQ+HefzkrxAeufPgHh/3n+3
         FwOkq8+BlqfVLWISp5sFLnBrlCfoy4j1DzXf/p5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 17/51] btrfs: Check if item pointer overlaps with the item itself
Date:   Tue, 15 Jan 2019 17:35:13 +0100
Message-Id: <20190115154849.233055664@linuxfoundation.org>
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

From: Qu Wenruo <quwenruo.btrfs@gmx.com>

commit 7f43d4affb2a254d421ab20b0cf65ac2569909fb upstream.

Function check_leaf() checks if any item pointer points outside of the
leaf, but it doesn't check if the pointer overlaps with the item itself.

Normally only the last item may be the victim, but adding such check is
never a bad idea anyway.

Signed-off-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -621,6 +621,13 @@ static noinline int check_leaf(struct bt
 			return -EUCLEAN;
 		}
 
+		/* Also check if the item pointer overlaps with btrfs item. */
+		if (btrfs_item_nr_offset(slot) + sizeof(struct btrfs_item) >
+		    btrfs_item_ptr_offset(leaf, slot)) {
+			CORRUPT("slot overlap with its data", leaf, root, slot);
+			return -EUCLEAN;
+		}
+
 		prev_key.objectid = key.objectid;
 		prev_key.type = key.type;
 		prev_key.offset = key.offset;


