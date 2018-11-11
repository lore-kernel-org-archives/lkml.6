Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0FCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E19920869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8CQuCqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E19920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389069AbeKLJSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388859AbeKLIUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53034223C8;
        Sun, 11 Nov 2018 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975438;
        bh=W0ghDE8K82EeFaWSIm6Ra6/QSkAFZ2q5PdadjItSqYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8CQuCqrlqdfbed2fUYb9lDNU1pFsX2KHv7sZL6GDna3+Bt9n/Kj1EmYRmtmZk5kh
         t2BhF1q/oDWEuZ6GQH7CHcQvv1hbdd9CoxDLjGqOEtQ005rfP/y+I/AbadiaPpAL4i
         gdv6v/itaZvTu8Jyrmjdi8w7GZ4CXQjMI3aQl9hA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.18 190/350] f2fs: fix to account IO correctly
Date:   Sun, 11 Nov 2018 14:20:54 -0800
Message-Id: <20181111221715.972812406@linuxfoundation.org>
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

commit 4c58ed076875f36dae0f240da1e25e99e5d4afb8 upstream.

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/data.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -460,10 +460,10 @@ int f2fs_submit_page_bio(struct f2fs_io_
 
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
-	__submit_bio(fio->sbi, bio, fio->type);
-
 	if (!is_read_io(fio->op))
 		inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
+
+	__submit_bio(fio->sbi, bio, fio->type);
 	return 0;
 }
 


