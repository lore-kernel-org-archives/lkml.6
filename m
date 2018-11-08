Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A990CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672792089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuODYlNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672792089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeKIHdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbeKIHdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:39 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 015C72089F;
        Thu,  8 Nov 2018 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714172;
        bh=hpD44BghX5qk7nOh1wQvPqgLthst28TmI6j5YydykJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuODYlNJtKVULKbcPhb1DepTPM4otff/AK5c4IKbzzVSEpEaZwtbggtoHnH4+bOB3
         Ky1EvXEVLZHQzrqWiUpSWXrQ1BYqhM95OT23f3Fam4YSMCRpOBic68fDHfHoZyF9m7
         irBDNgOC4kISCbB3mp2f5zzpiyNcwlfub1Y8Tt2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 095/144] ext4: fix an ext3 collapse range regression in xfstests
Date:   Thu,  8 Nov 2018 13:51:06 -0800
Message-Id: <20181108215104.487718721@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



