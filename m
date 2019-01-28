Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EBF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692843;
	bh=Z7BXl2HHNT0lK4qhoI52gHTo+5maWGJNhJI2wA205kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsk7jp/v/DPSBNDMlAZIjE2P7+NuN954akl+VuPwE+ah+ToWo4JsOBTk1dh1G9mYu
	 Xay1TVA/Yt/UKsjdpjdg3kVNYdSPFS1yHkrBkLGAElV8VZ9B22JJvBvdYsrKd9HwGy
	 0VFQDyRyfkjTvXWzCXJB7V+YonvYA6D45npVRKYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389589AbfA1Q1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390364AbfA1Q1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:27:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3D2A21848;
        Mon, 28 Jan 2019 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692830;
        bh=Z7BXl2HHNT0lK4qhoI52gHTo+5maWGJNhJI2wA205kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXLGBujti1C15JUkaBw30VokOgyNoyc0oJlS/zFSCRR3SPE/1VoRapmEMuppyHw8l
         hIBYs1a6PvzuUNBvytt2MZ7/My5AKdSAxOGP5lLpeHm34qQ9bjjUIRDHOjC7Cjvuh9
         MnjxC471cQvvKNDiWs8o1SKcw2+vqUtjYFlEUbOI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 29/61] udf: Fix BUG on corrupted inode
Date:   Mon, 28 Jan 2019 11:25:51 -0500
Message-Id: <20190128162623.59854-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit d288d95842f1503414b7eebce3773bac3390457e ]

When inode is corrupted so that extent type is invalid, some functions
(such as udf_truncate_extents()) will just BUG. Check that extent type
is valid when loading the inode to memory.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 0c1ca254d616..00c2caff1743 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1366,6 +1366,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 
 	iinfo->i_alloc_type = le16_to_cpu(fe->icbTag.flags) &
 							ICBTAG_FLAG_AD_MASK;
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_SHORT &&
+	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_LONG &&
+	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		ret = -EIO;
+		goto out;
+	}
 	iinfo->i_unique = 0;
 	iinfo->i_lenEAttr = 0;
 	iinfo->i_lenExtents = 0;
-- 
2.19.1

