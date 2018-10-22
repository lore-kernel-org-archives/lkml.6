Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F7BECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A202083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A202083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeJVJ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:29:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeJVJ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:29:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0C819BB397488;
        Mon, 22 Oct 2018 09:13:16 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Mon, 22 Oct 2018 09:13:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] f2fs: fix to account IO correctly
Date:   Mon, 22 Oct 2018 09:12:51 +0800
Message-ID: <20181022011251.70020-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below race can cause reversed reference on dirty count, fix it by
relocating __submit_bio() and inc_page_count().

Thread A				Thread B
- f2fs_inplace_write_data
 - f2fs_submit_page_bio
  - __submit_bio
					- f2fs_write_end_io
					 - dec_page_count
  - inc_page_count

Cc: <stable@vger.kernel.org>
Fixes: d1b3e72d5490 ("f2fs: submit bio of in-place-update pages")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- split into two parts, fix previous bug in this part, merge another
part into other related patch.
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ef6f1f01eda..83b1983094bd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -462,10 +462,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	}
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
-	__submit_bio(fio->sbi, bio, fio->type);
-
 	if (!is_read_io(fio->op))
 		inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
+
+	__submit_bio(fio->sbi, bio, fio->type);
 	return 0;
 }
 
-- 
2.18.0.rc1

