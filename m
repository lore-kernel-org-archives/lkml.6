Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83855214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY95/Gn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83855214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJQK12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbeJQK12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:27:28 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020F5214C3;
        Wed, 17 Oct 2018 02:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539743645;
        bh=ylB1CfOTRjXtiDjQJHzt6mfOLd+Wg+0+SAOkM2JZPxA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=UY95/Gn0pLrWyo1hZu5muoIL5NK7VTbU6ZhGMG6LVRCdT6bULppjCjEUwEAYRH7lK
         OmBfwOdrVz5/TZeAwj7aK/mJDf0GBCIK7jbtSPQp6DVXAwwfs42IOlsqoEo18aRyH3
         SJQi38I0j5t2Wn6BRUfrN792zgdRsS1A55EqH4pM=
Date:   Tue, 16 Oct 2018 19:34:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: clear cold data flag if IO is not counted
Message-ID: <20181017023404.GB77619@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010212217.52289-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.

If we clear the cold data flag out of the writeback flow, we can miscount
-1 by end_io.

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3f272c18fb61..0d0b4dd55b04 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2650,10 +2650,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
-	/* don't remain PG_checked flag which was set during GC */
-	if (is_cold_data(page))
-		clear_cold_data(page);
-
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			f2fs_register_inmem_page(inode, page);
-- 
2.19.0.605.g01d371f741-goog

