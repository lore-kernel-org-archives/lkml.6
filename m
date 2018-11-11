Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC05AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6943A21707
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkO/lRW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6943A21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeKLIUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbeKLIUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:13 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC0D22419;
        Sun, 11 Nov 2018 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975416;
        bh=LKoW/IriWs7o7A9WZj7Ad2UxL5c9UL7Q1uRcYoRrPW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkO/lRW0Uz1Y5BD4X7wUK2MTPKKvNULNg7UQo+tap8oYJe1FsjosPnya0F6K5fD3c
         2vR8uAkrPsePCqlqG7R89lZZ2oHcJ6ohjhyMuCilCSgYgt1qJBbvvz+yVl5SLFshND
         p5GYMdldCUFaJf8wWpqC7x5Hf+DCEfwC6pePcj00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 137/350] f2fs: fix to account IO correctly for cgroup writeback
Date:   Sun, 11 Nov 2018 14:20:01 -0800
Message-Id: <20181111221713.770057413@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -453,6 +453,10 @@ int f2fs_submit_page_bio(struct f2fs_io_
 		bio_put(bio);
 		return -EFAULT;
 	}
+
+	if (fio->io_wbc && !is_read_io(fio->op))
+		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
+
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 	__submit_bio(fio->sbi, bio, fio->type);


