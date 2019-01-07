Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1AEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E9220449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864946;
	bh=74eV48mgHKQsLGjT9N6ZWdujaOkjmMCBydoGHvlG4a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J5bTZw3YqQniYPKlPX25ZsTNNTrXsdx04edrboLOt1wTPD4jm6k53r33Cs9Gu85KH
	 wlqqzgUju2R72gTzZC1S70juUwJbGqb0dJxcU5N358XsVMYWgUtYyqo6IsBEoCk7LO
	 Wys4/qA6ovpCUt1gsdWw9LYrVgv13nuAekwzZKNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfAGMmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfAGMmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B6820449;
        Mon,  7 Jan 2019 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864941;
        bh=74eV48mgHKQsLGjT9N6ZWdujaOkjmMCBydoGHvlG4a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfwoVgZ/Zr5bpmKuGe5mQpziX9wcxQ/NLUXKQt6uVPIqn99CWsWGwYBftGhKgN6F6
         24UWEdzx6f5Zh7OVPfxqPj2jymv3wLg6xg0hzEGizJoAGZ0kLEYr8gGfLvCI3rNyNF
         RvolCbWXH5nxzxe+90j5tyQyaamRHG2x3EszZJug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia Zhu <zhujia13@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.20 105/145] f2fs: fix to update new block address correctly for OPU
Date:   Mon,  7 Jan 2019 13:32:22 +0100
Message-Id: <20190107104450.998605845@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Jia Zhu <zhujia13@huawei.com>

commit 73c0a9272a7d2942bcae29d4829bf63277cc57c8 upstream.

Previously, we allocated a new block address for OPU mode in direct_IO.

But the new address couldn't be assigned to @map->m_pblk correctly.

This patch fix it.

Cc: <stable@vger.kernel.org>
Fixes: 511f52d02f05 ("f2fs: allow out-place-update for direct IO in LFS mode")
Signed-off-by: Jia Zhu <zhujia13@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/data.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1102,8 +1102,10 @@ next_block:
 		if (test_opt(sbi, LFS) && create &&
 				flag == F2FS_GET_BLOCK_DIO) {
 			err = __allocate_data_block(&dn, map->m_seg_type);
-			if (!err)
+			if (!err) {
+				blkaddr = dn.data_blkaddr;
 				set_inode_flag(inode, FI_APPEND_WRITE);
+			}
 		}
 	} else {
 		if (create) {


