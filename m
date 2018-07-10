Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956E620936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956E620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbeGJS1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732909AbeGJS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:26:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B2AADB4;
        Tue, 10 Jul 2018 18:26:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 3.18 12/23] ext4: clear i_data in ext4_inode_info when removing inline data
Date:   Tue, 10 Jul 2018 20:24:45 +0200
Message-Id: <20180710182309.410649178@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
References: <20180710182308.877332304@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 6e8ab72a812396996035a37e5ca4b3b99b5d214b upstream.

When converting from an inode from storing the data in-line to a data
block, ext4_destroy_inline_data_nolock() was only clearing the on-disk
copy of the i_blocks[] array.  It was not clearing copy of the
i_blocks[] in ext4_inode_info, in i_data[], which is the copy actually
used by ext4_map_blocks().

This didn't matter much if we are using extents, since the extents
header would be invalid and thus the extents could would re-initialize
the extents tree.  But if we are using indirect blocks, the previous
contents of the i_blocks array will be treated as block numbers, with
potentially catastrophic results to the file system integrity and/or
user data.

This gets worse if the file system is using a 1k block size and
s_first_data is zero, but even without this, the file system can get
quite badly corrupted.

This addresses CVE-2018-10881.

https://bugzilla.kernel.org/show_bug.cgi?id=200015

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inline.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -432,6 +432,7 @@ static int ext4_destroy_inline_data_nolo
 
 	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
 		0, EXT4_MIN_INLINE_DATA_SIZE);
+	memset(ei->i_data, 0, EXT4_MIN_INLINE_DATA_SIZE);
 
 	if (EXT4_HAS_INCOMPAT_FEATURE(inode->i_sb,
 				      EXT4_FEATURE_INCOMPAT_EXTENTS)) {


