Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C9521B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896754;
	bh=6+Hpdgltq/ElXAc6KxMPPVJpYbrh3muUvhmZza4KnU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XIsbQU0wIVRWTRKQjpgfavTHgFYkDPkoc/vpQL5WXUFDS0HWVsRzlXjC8EPOqQkMF
	 7wX3ynLmFPVtxAt8iGy/be4XqhN4vraZCrlheno2jt6b7dUmV16KK9vNJ8lyQbPMrr
	 Rx7LyQ8u62w+tfAa2pvaoz/F/J7G3d6qrTsMzV9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBKOwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388444AbfBKOwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990DC20855;
        Mon, 11 Feb 2019 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896750;
        bh=6+Hpdgltq/ElXAc6KxMPPVJpYbrh3muUvhmZza4KnU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIWmrkRsCO2p7FRZAxcVzFsyc55nJQHHYYXcFRF0tpqRtOGmXalLO2HxUCCrN/KbH
         vxK26Kc6npWXPoAbb92C5bW/VObtBlwA99GgmLM07vt2A3lUDBUtHDonock4QDBruh
         soWqWB+9Ya9YB6/KTM42Ugh0Qtbz4v6Zp9m5AT6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 257/313] xfs: fix inverted return from xfs_btree_sblock_verify_crc
Date:   Mon, 11 Feb 2019 15:18:57 +0100
Message-Id: <20190211141910.485093855@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 7d048df4e9b05ba89b74d062df59498aa81f3785 upstream.

xfs_btree_sblock_verify_crc is a bool so should not be returning
a failaddr_t; worse, if xfs_log_check_lsn fails it returns
__this_address which looks like a boolean true (i.e. success)
to the caller.

(interestingly xfs_btree_lblock_verify_crc doesn't have the issue)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 34c6d7bd4d18..bbdae2b4559f 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -330,7 +330,7 @@ xfs_btree_sblock_verify_crc(
 
 	if (xfs_sb_version_hascrc(&mp->m_sb)) {
 		if (!xfs_log_check_lsn(mp, be64_to_cpu(block->bb_u.s.bb_lsn)))
-			return __this_address;
+			return false;
 		return xfs_buf_verify_cksum(bp, XFS_BTREE_SBLOCK_CRC_OFF);
 	}
 
-- 
2.19.1



