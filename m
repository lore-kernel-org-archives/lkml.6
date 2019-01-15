Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4982BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E36D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570741;
	bh=peZIb1sBmdwMzTxAUJ3NjYM+cdjao2OUVMQINyzeRvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RLHYc6cxene2XMK/sY5X2v8U0T/CHr1FqtPrxVQda0pec+0A3QQRJ+4EZt5Ex9OMG
	 7rNl2B7qLzRTGS1xglA586KgAAvIJLsAdBQdNITdbo0J2PvonH2IesJAAFo++HWFwv
	 2KrxJzXh7KK05CZ2X8E4rElqCIzAMpNS8wGxAjnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfAOQpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387808AbfAOQpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC34A2054F;
        Tue, 15 Jan 2019 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570732;
        bh=peZIb1sBmdwMzTxAUJ3NjYM+cdjao2OUVMQINyzeRvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pt88z3xk9xYSg4Esp+PUSF2GqwSTotblbVFWdN/pjSwuAszrsjRZ7lws4S6LviJ17
         pLkUmOicClqgtsAiJox+mAFKCdCsAyxKAePi1Rjck6ZyaqBTYMZXhKfWbCQMpqfxUH
         6hqg+7U1mElhARf8EDAzG2r9nKVa2QOzHRS32a20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.20 50/57] ext4: use ext4_write_inode() when fsyncing w/o a journal
Date:   Tue, 15 Jan 2019 17:36:31 +0100
Message-Id: <20190115154913.813038440@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit ad211f3e94b314a910d4af03178a0b52a7d1ee0a upstream.

In no-journal mode, we previously used __generic_file_fsync() in
no-journal mode.  This triggers a lockdep warning, and in addition,
it's not safe to depend on the inode writeback mechanism in the case
ext4.  We can solve both problems by calling ext4_write_inode()
directly.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/fsync.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -116,8 +116,16 @@ int ext4_sync_file(struct file *file, lo
 		goto out;
 	}
 
+	ret = file_write_and_wait_range(file, start, end);
+	if (ret)
+		return ret;
+
 	if (!journal) {
-		ret = __generic_file_fsync(file, start, end, datasync);
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_ALL
+		};
+
+		ret = ext4_write_inode(inode, &wbc);
 		if (!ret)
 			ret = ext4_sync_parent(inode);
 		if (test_opt(inode->i_sb, BARRIER))
@@ -125,9 +133,6 @@ int ext4_sync_file(struct file *file, lo
 		goto out;
 	}
 
-	ret = file_write_and_wait_range(file, start, end);
-	if (ret)
-		return ret;
 	/*
 	 * data=writeback,ordered:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.


