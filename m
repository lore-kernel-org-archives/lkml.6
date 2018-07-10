Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C16C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014C9208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014C9208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbeGJSft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:35:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbeGJSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCAA6EB8;
        Tue, 10 Jul 2018 18:35:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.17 33/56] ext4: verify the depth of extent tree in ext4_find_extent()
Date:   Tue, 10 Jul 2018 20:25:15 +0200
Message-Id: <20180710182505.202363458@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit bc890a60247171294acc0bd67d211fa4b88d40ba upstream.

If there is a corupted file system where the claimed depth of the
extent tree is -1, this can cause a massive buffer overrun leading to
sadness.

This addresses CVE-2018-10877.

https://bugzilla.kernel.org/show_bug.cgi?id=199417

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4_extents.h |    1 +
 fs/ext4/extents.c      |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -91,6 +91,7 @@ struct ext4_extent_header {
 };
 
 #define EXT4_EXT_MAGIC		cpu_to_le16(0xf30a)
+#define EXT4_MAX_EXTENT_DEPTH 5
 
 #define EXT4_EXTENT_TAIL_OFFSET(hdr) \
 	(sizeof(struct ext4_extent_header) + \
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -869,6 +869,12 @@ ext4_find_extent(struct inode *inode, ex
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
+	if (depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH) {
+		EXT4_ERROR_INODE(inode, "inode has invalid extent depth: %d",
+				 depth);
+		ret = -EFSCORRUPTED;
+		goto err;
+	}
 
 	if (path) {
 		ext4_ext_drop_refs(path);


