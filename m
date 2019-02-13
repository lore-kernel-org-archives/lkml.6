Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F1AC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1251D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083691;
	bh=Hbf0xLssCghT4W7m2Q/2dJlZfJLco96g6vP0aKu74Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1XmdT0/EDqu6XloPEm5dxeML1Z6uMqf79v7CcUHqc5UH1ZaoLxrFZ6vsAX3i8GUX
	 5qNLwF1vaCAjXNuzsz6SZW1sGAereS/ME9651mClcBSq8hHXIOHXA2+Ji244IytoVj
	 hGSBcmyljmMbnFnPzjZ/FEKnkf+e3ZcT2zMEmPnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406524AbfBMSqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406497AbfBMSqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A687920811;
        Wed, 13 Feb 2019 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083603;
        bh=Hbf0xLssCghT4W7m2Q/2dJlZfJLco96g6vP0aKu74Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeKmBl0I3AvlpxlGaS9XScH9WlwHjlIqffBathaiPRnIgGTObYiQgdNJef5cnameu
         T/oyoQzjf/RPJmvO/qKhW+L+c/qEKMPXn0jWrWQBvq8rMvcpTFnSQNExaoInIb5GRw
         jJBhwVdQEYLIDrRqL/jErvs7G0N6/WGM5IQADMDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.20 46/50] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
Date:   Wed, 13 Feb 2019 19:38:51 +0100
Message-Id: <20190213183659.307182878@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

commit 8fdd60f2ae3682caf2a7258626abc21eb4711892 upstream.

This reverts commit ad211f3e94b314a910d4af03178a0b52a7d1ee0a.

As Jan Kara pointed out, this change was unsafe since it means we lose
the call to sync_mapping_buffers() in the nojournal case.  The
original point of the commit was avoid taking the inode mutex (since
it causes a lockdep warning in generic/113); but we need the mutex in
order to call sync_mapping_buffers().

The real fix to this problem was discussed here:

https://lore.kernel.org/lkml/20181025150540.259281-4-bvanassche@acm.org

The proposed patch was to fix a syzbot complaint, but the problem can
also demonstrated via "kvm-xfstests -c nojournal generic/113".
Multiple solutions were discused in the e-mail thread, but none have
landed in the kernel as of this writing.  Anyway, commit
ad211f3e94b314 is absolutely the wrong way to suppress the lockdep, so
revert it.

Fixes: ad211f3e94b314a910d4af03178a0b52a7d1ee0a ("ext4: use ext4_write_inode() when fsyncing w/o a journal")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/fsync.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -116,16 +116,8 @@ int ext4_sync_file(struct file *file, lo
 		goto out;
 	}
 
-	ret = file_write_and_wait_range(file, start, end);
-	if (ret)
-		return ret;
-
 	if (!journal) {
-		struct writeback_control wbc = {
-			.sync_mode = WB_SYNC_ALL
-		};
-
-		ret = ext4_write_inode(inode, &wbc);
+		ret = __generic_file_fsync(file, start, end, datasync);
 		if (!ret)
 			ret = ext4_sync_parent(inode);
 		if (test_opt(inode->i_sb, BARRIER))
@@ -133,6 +125,9 @@ int ext4_sync_file(struct file *file, lo
 		goto out;
 	}
 
+	ret = file_write_and_wait_range(file, start, end);
+	if (ret)
+		return ret;
 	/*
 	 * data=writeback,ordered:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.


