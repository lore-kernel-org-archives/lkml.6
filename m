Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C0ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428722148E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed4nyT9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428722148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeJSCG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbeJSCG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25EE52148D;
        Thu, 18 Oct 2018 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885889;
        bh=DSJc3g1xNMsHZFFiGfhoU4iZoYv4AfrdROhZ9gVh6zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ed4nyT9v4K9/VZ+m/HfTWHnbWxJaQE1cAuXysFrKCEX/0WKgWcxWVUWvpwt2yevdD
         /V2Pi5bMeyMGieRCidTSL/HluvHDAJH6VzQRgO/eYErCzUJMalmTsxrMzJvCKOyLZI
         b/RAkWobNr9V65MwuO0Js5kE0bfPBIBL3i2CjJKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 4.4 10/48] ext4: add corruption check in ext4_xattr_set_entry()
Date:   Thu, 18 Oct 2018 19:54:45 +0200
Message-Id: <20181018175428.537398160@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 5369a762c882c0b6e9599e4ebbb3a9ba9eee7e2d upstream.

In theory this should have been caught earlier when the xattr list was
verified, but in case it got missed, it's simple enough to add check
to make sure we don't overrun the xattr buffer.

This addresses CVE-2018-10879.

https://bugzilla.kernel.org/show_bug.cgi?id=200001

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
[bwh: Backported to 3.16:
 - Add inode parameter to ext4_xattr_set_entry() and update callers
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
[adjusted for 4.4 context]
Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -638,14 +638,20 @@ static size_t ext4_xattr_free_space(stru
 }
 
 static int
-ext4_xattr_set_entry(struct ext4_xattr_info *i, struct ext4_xattr_search *s)
+ext4_xattr_set_entry(struct ext4_xattr_info *i, struct ext4_xattr_search *s,
+		     struct inode *inode)
 {
-	struct ext4_xattr_entry *last;
+	struct ext4_xattr_entry *last, *next;
 	size_t free, min_offs = s->end - s->base, name_len = strlen(i->name);
 
 	/* Compute min_offs and last. */
 	last = s->first;
-	for (; !IS_LAST_ENTRY(last); last = EXT4_XATTR_NEXT(last)) {
+	for (; !IS_LAST_ENTRY(last); last = next) {
+		next = EXT4_XATTR_NEXT(last);
+		if ((void *)next >= s->end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			return -EFSCORRUPTED;
+		}
 		if (!last->e_value_block && last->e_value_size) {
 			size_t offs = le16_to_cpu(last->e_value_offs);
 			if (offs < min_offs)
@@ -825,7 +831,7 @@ ext4_xattr_block_set(handle_t *handle, s
 				ce = NULL;
 			}
 			ea_bdebug(bs->bh, "modifying in-place");
-			error = ext4_xattr_set_entry(i, s);
+			error = ext4_xattr_set_entry(i, s, inode);
 			if (!error) {
 				if (!IS_LAST_ENTRY(s->first))
 					ext4_xattr_rehash(header(s->base),
@@ -875,7 +881,7 @@ ext4_xattr_block_set(handle_t *handle, s
 		s->end = s->base + sb->s_blocksize;
 	}
 
-	error = ext4_xattr_set_entry(i, s);
+	error = ext4_xattr_set_entry(i, s, inode);
 	if (error == -EFSCORRUPTED)
 		goto bad_block;
 	if (error)
@@ -1037,7 +1043,7 @@ int ext4_xattr_ibody_inline_set(handle_t
 
 	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
-	error = ext4_xattr_set_entry(i, s);
+	error = ext4_xattr_set_entry(i, s, inode);
 	if (error) {
 		if (error == -ENOSPC &&
 		    ext4_has_inline_data(inode)) {
@@ -1049,7 +1055,7 @@ int ext4_xattr_ibody_inline_set(handle_t
 			error = ext4_xattr_ibody_find(inode, i, is);
 			if (error)
 				return error;
-			error = ext4_xattr_set_entry(i, s);
+			error = ext4_xattr_set_entry(i, s, inode);
 		}
 		if (error)
 			return error;
@@ -1075,7 +1081,7 @@ static int ext4_xattr_ibody_set(handle_t
 
 	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
-	error = ext4_xattr_set_entry(i, s);
+	error = ext4_xattr_set_entry(i, s, inode);
 	if (error)
 		return error;
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));


