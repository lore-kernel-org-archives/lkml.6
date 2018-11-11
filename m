Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1528FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBAC21527
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mljtCqk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBAC21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbeKLITC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbeKLITB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:01 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD7A2154B;
        Sun, 11 Nov 2018 22:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975345;
        bh=3D1IRyOCPxtZGsc0nApRg02T/VdBPi4Kl/GTiB+gcv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mljtCqk1dBJbh5iYzNnSzAobABpt0OOKtOwN/G75HulUSNcgliMLjsHqL/KV1TRFt
         uCEDxoxxoEgCVoq6BfRnhrwhhhW8fM5qC+dGTE3P0GjvCjvmtxjVh20htW77MkAQ5t
         nwvRntI/kvejT7PcAfy5xpop/RvxtG7p+LGFM8Z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 326/361] btrfs: qgroup: Avoid calling qgroup functions if qgroup is not enabled
Date:   Sun, 11 Nov 2018 14:21:13 -0800
Message-Id: <20181111221659.471431123@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 3628b4ca64f24a4ec55055597d0cb1c814729f8b upstream.

Some qgroup trace events like btrfs_qgroup_release_data() and
btrfs_qgroup_free_delayed_ref() can still be triggered even if qgroup is
not enabled.

This is caused by the lack of qgroup status check before calling some
qgroup functions.  Thankfully the functions can handle quota disabled
case well and just do nothing for qgroup disabled case.

This patch will do earlier check before triggering related trace events.

And for enabled <-> disabled race case:

1) For enabled->disabled case
   Disable will wipe out all qgroups data including reservation and
   excl/rfer. Even if we leak some reservation or numbers, it will
   still be cleared, so nothing will go wrong.

2) For disabled -> enabled case
   Current btrfs_qgroup_release_data() will use extent_io tree to ensure
   we won't underflow reservation. And for delayed_ref we use
   head->qgroup_reserved to record the reserved space, so in that case
   head->qgroup_reserved should be 0 and we won't underflow.

CC: stable@vger.kernel.org # 4.14+
Reported-by: Chris Murphy <lists@colorremedies.com>
Link: https://lore.kernel.org/linux-btrfs/CAJCQCtQau7DtuUUeycCkZ36qjbKuxNzsgqJ7+sJ6W0dK_NLE3w@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    4 ++++
 fs/btrfs/qgroup.h |    2 ++
 2 files changed, 6 insertions(+)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3106,6 +3106,10 @@ static int __btrfs_qgroup_release_data(s
 	int trace_op = QGROUP_RELEASE;
 	int ret;
 
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED,
+		      &BTRFS_I(inode)->root->fs_info->flags))
+		return 0;
+
 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
 	if (free && reserved)
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -249,6 +249,8 @@ void btrfs_qgroup_free_refroot(struct bt
 static inline void btrfs_qgroup_free_delayed_ref(struct btrfs_fs_info *fs_info,
 						 u64 ref_root, u64 num_bytes)
 {
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		return;
 	trace_btrfs_qgroup_free_delayed_ref(fs_info, ref_root, num_bytes);
 	btrfs_qgroup_free_refroot(fs_info, ref_root, num_bytes,
 				  BTRFS_QGROUP_RSV_DATA);


