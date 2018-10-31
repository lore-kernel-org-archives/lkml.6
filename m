Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AADFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F69B20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="11VP/W7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F69B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeKAIrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbeKAIHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3391020838;
        Wed, 31 Oct 2018 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027222;
        bh=2hl5u622X1c+uqokhqZBotD8d8ug4sepP9SC4XCeiY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11VP/W7/RCubYZIfgjBo6VunJAHGzhSvTqm97a1L2d9p87uSNBMotCZxKYECT4MJ5
         e0B0veTk//F4pU+PzqqFX/MUsm9sCQHKWBB3SWrxvvZTdqxZDX3NZGomlQ3LRNeYs6
         PqzyB8Y6CKIuNK1c++/244O2qmmqBbu3i1mzDVGA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 088/146] f2fs: fix to account IO correctly for cgroup writeback
Date:   Wed, 31 Oct 2018 19:04:43 -0400
Message-Id: <20181031230541.28822-88-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 78efac537de33faab9a4302cc05a70bb4a8b3b63 ]

Now, we have supported cgroup writeback, it depends on correctly IO
account of specified filesystem.

But in commit d1b3e72d5490 ("f2fs: submit bio of in-place-update pages"),
we split write paths from f2fs_submit_page_mbio() to two:
- f2fs_submit_page_bio() for IPU path
- f2fs_submit_page_bio() for OPU path

But still we account write IO only in f2fs_submit_page_mbio(), result in
incorrect IO account, fix it by adding missing IO account in IPU path.

Fixes: d1b3e72d5490 ("f2fs: submit bio of in-place-update pages")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 382c1ef9a9e4..cd5d53353a61 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -456,6 +456,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 		bio_put(bio);
 		return -EFAULT;
 	}
+
+	if (fio->io_wbc && !is_read_io(fio->op))
+		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
+
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 	__submit_bio(fio->sbi, bio, fio->type);
-- 
2.17.1

