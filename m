Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0E8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5239C2241B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXf9r2g7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5239C2241B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390742AbeKLIWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390708AbeKLIWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:33 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A9621582;
        Sun, 11 Nov 2018 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975556;
        bh=nMyRhnBXjiM8ECHLM0FxmeP0AiJuGw2SrKqUlDJZukw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXf9r2g7WZFZdEchbnDuyATLf3wfFRFypEmooZG3lZhpzcPyCVt7mNV4nD35upnuD
         mf1u5iEAIneQIAaKQ3wJtiqDN/sZYV7FcCXH4j0xv3vqL1jg65nDUIKnLHNxw1fbJa
         VyAv0d9tOWcCbnCaUnC7YJlFXnnhq2kBr1KJ+hKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.14 110/222] Revert "f2fs: fix to clear PG_checked flag in set_page_dirty()"
Date:   Sun, 11 Nov 2018 14:23:27 -0800
Message-Id: <20181111221657.650884964@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 164a63fa6b384e30ceb96ed80bc7dc3379bc0960 upstream.

This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.

If we clear the cold data flag out of the writeback flow, we can miscount
-1 by end_io, which incurs a deadlock caused by all I/Os being blocked during
heavy GC.

Balancing F2FS Async:
 - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   ...

GC thread:                              IRQ
- move_data_page()
 - set_page_dirty()
  - clear_cold_data()
                                        - f2fs_write_end_io()
                                         - type = WB_DATA_TYPE(page);
                                           here, we get wrong type
                                         - dec_page_count(sbi, type);
 - f2fs_wait_on_page_writeback()

Cc: <stable@vger.kernel.org>
Reported-and-Tested-by: Park Ju Hyung <qkrwngud825@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/data.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2190,10 +2190,6 @@ static int f2fs_set_data_page_dirty(stru
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
-	/* don't remain PG_checked flag which was set during GC */
-	if (is_cold_data(page))
-		clear_cold_data(page);
-
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			register_inmem_page(inode, page);


