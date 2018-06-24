Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8314924FD3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8314924FD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754899AbeFXPc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:32:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeFXPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:32:24 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25E492C;
        Sun, 24 Jun 2018 15:32:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.16 15/64] ext4: do not allow external inodes for inline data
Date:   Sun, 24 Jun 2018 23:21:56 +0800
Message-Id: <20180624142744.618264425@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 117166efb1ee8f13c38f9e96b258f16d4923f888 upstream.

The inline data feature was implemented before we added support for
external inodes for xattrs.  It makes no sense to support that
combination, but the problem is that there are a number of extended
attribute checks that are skipped if e_value_inum is non-zero.

Unfortunately, the inline data code is completely e_value_inum
unaware, and attempts to interpret the xattr fields as if it were an
inline xattr --- at which point, Hilarty Ensues.

This addresses CVE-2018-11412.

https://bugzilla.kernel.org/show_bug.cgi?id=199803

Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inline.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -144,6 +144,12 @@ int ext4_find_inline_data_nolock(struct
 		goto out;
 
 	if (!is.s.not_found) {
+		if (is.s.here->e_value_inum) {
+			EXT4_ERROR_INODE(inode, "inline data xattr refers "
+					 "to an external xattr inode");
+			error = -EFSCORRUPTED;
+			goto out;
+		}
 		EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
 					(void *)ext4_raw_inode(&is.iloc));
 		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +


