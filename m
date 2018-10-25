Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA49D2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ8jIUkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA49D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeJYWxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731078AbeJYWxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:32 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760AA20870;
        Thu, 25 Oct 2018 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477234;
        bh=UoqF7p2JFFg5bigMVRulHFkIBKZyumDDZme1ro0lK7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZ8jIUkAUdBdX5mFbuiFmUbdKyzGVnuRyzuQBwJZRt1E8LiZwaCHBfJIhwId4Crn3
         wQ/Jh4k0lxhY28h+HBDg+PtbqMfbAHTD27GC++ykf55mpR4/phM2kmEy5snb3i7aig
         kAbQCKsVJ2CnsspwJRwJShdlXWh9ODvhepv3WxCU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 66/98] ext4: fix an ext3 collapse range regression in xfstests
Date:   Thu, 25 Oct 2018 10:18:21 -0400
Message-Id: <20181025141853.214051-66-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit b9576fc3624eb9fc88bec0d0ae883fd78be86239 ]

The xfstests test suite assumes that an attempt to collapse range on
the range (0, 1) will return EOPNOTSUPP if the file system does not
support collapse range.  Commit 280227a75b56: "ext4: move check under
lock scope to close a race" broke this, and this caused xfstests to
fail when run when testing file systems that did not have the extents
feature enabled.

Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 6dbfa92bf78a..1e51008e237f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5400,6 +5400,14 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size, ioffset;
 	int ret;
 
+	/*
+	 * We need to test this early because xfstests assumes that a
+	 * collapse range of (0, 1) will return EOPNOTSUPP if the file
+	 * system does not support collapse range.
+	 */
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -EOPNOTSUPP;
+
 	/* Collapse range works only on fs block size aligned offsets. */
 	if (offset & (EXT4_CLUSTER_SIZE(sb) - 1) ||
 	    len & (EXT4_CLUSTER_SIZE(sb) - 1))
-- 
2.17.1

