Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDFCC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AFB20664
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMzaZYb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AFB20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeJVXni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJVXnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:43:37 -0400
Received: from localhost.localdomain (unknown [49.77.232.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7699E20663;
        Mon, 22 Oct 2018 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540221878;
        bh=RNY8H+eE6k9lovsv0Zty6B8Bwwrj+y9ugJLNcQnDm9g=;
        h=From:To:Cc:Subject:Date:From;
        b=vMzaZYb2FjWfa+AI8xibLZPxdcpNTgjW5/YfQmC8LAWsZdc3VjvIaj1refoO1YePN
         adBQ4WtEF051TfT3QRO1podMScGKG6/TRkRweg61/dPeCsnSTqovFmEbomlRpKqISa
         vuiQQ308TdBbbQhnvvQ2R+Y3pL8i93OgoXOHfwp4=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to account IO correctly for cgroup writeback
Date:   Mon, 22 Oct 2018 23:24:28 +0800
Message-Id: <20181022152428.9292-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

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
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c6618eee4650..2dea5777597f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -478,6 +478,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 		bio_put(bio);
 		return -EFAULT;
 	}
+
+	if (fio->io_wbc && !is_read_io(fio->op))
+		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
+
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
-- 
2.18.0

