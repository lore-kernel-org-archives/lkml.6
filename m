Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB29C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C4521900
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357869;
	bh=nmzaavWoOw0E7e/RKYQZG1XaN/NaEiTWHMs6cyRdupM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSwnAd+ZRQ7lbaz1IJl3B5/IEUQ1HFO/RwKRgNehnzXvlqouIPc2W9p7DfY7h8G/G
	 Fr8ImsGvZV1Hq9mdfMVUl6hAN5dWBA1MtERttiYhrEL2cQ7MYnUtJWrT8ChSFiYUqc
	 cab7aran2vqfMDC4IREkieIQ6bW/ETmff/T9YBtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfAXTY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbfAXTYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB6821903;
        Thu, 24 Jan 2019 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357865;
        bh=nmzaavWoOw0E7e/RKYQZG1XaN/NaEiTWHMs6cyRdupM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoG1beY2GGxuTgXe0rgtZGRaWL8K0Y/AiXx9x4/ghkm1Ip2VxnqD8rnlWbcwZzXIS
         w4gf9rhZ2qPQ2DZyC1TrJmcmmKuw9tQmoU11uJYAH/2qy8DeH3cI4npywpJ5jbfWAu
         drOoUEwVxZctwY4z4rHjEm/fp0R24G/b9kBTVR7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 016/104] f2fs: put directory inodes before checkpoint in roll-forward recovery
Date:   Thu, 24 Jan 2019 20:19:05 +0100
Message-Id: <20190124190156.627559199@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 9e1e6df412a28cdbbd2909de5c6189eda4a3383d upstream.

Before checkpoint, we'd be better drop any inodes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/recovery.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -597,6 +597,9 @@ out:
 		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
 	mutex_unlock(&sbi->cp_mutex);
 
+	/* let's drop all the directory inodes for clean checkpoint */
+	destroy_fsync_dnodes(&dir_list);
+
 	if (!err && need_writecp) {
 		struct cp_control cpc = {
 			.reason = CP_RECOVERY,
@@ -604,7 +607,6 @@ out:
 		write_checkpoint(sbi, &cpc);
 	}
 
-	destroy_fsync_dnodes(&dir_list);
 	kmem_cache_destroy(fsync_entry_slab);
 	return ret ? ret: err;
 }


