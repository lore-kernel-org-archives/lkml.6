Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0766ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AE42081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx8grZ1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AE42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeKAIfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbeKAIJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFC32064C;
        Wed, 31 Oct 2018 23:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027344;
        bh=yVjPZIbPakPdFKOeRxM4CmMydYyzIlJKgYJZVqUk0GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cx8grZ1hm6F/L1j2+i/h/4ax9wnJhPxqJhrxghkSoR02JNRhgroZbS/sWCAG0Cw5p
         uPcU1N+VdW+t3KYJi7DnfzQteO6LNBNFOioXvYBALsoYU+1Z+Gnm9YtsDt6BFhKdQ1
         F+aGaYh0YdQdqfxkpZ7vAnSOLNB194RwvKZr9stk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 076/126] f2fs: fix to account IO correctly for cgroup writeback
Date:   Wed, 31 Oct 2018 19:07:04 -0400
Message-Id: <20181031230754.29029-76-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
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
index b61954d40c25..fa439f5c4d88 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -453,6 +453,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
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

