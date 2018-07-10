Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF42AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29332083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29332083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbeGJScT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:32:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732845AbeGJScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68447D0B;
        Tue, 10 Jul 2018 18:32:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, stable@kernel.org
Subject: [PATCH 4.14 16/53] ext4: add corruption check in ext4_xattr_set_entry()
Date:   Tue, 10 Jul 2018 20:24:52 +0200
Message-Id: <20180710182459.826091949@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1559,7 +1559,7 @@ static int ext4_xattr_set_entry(struct e
 				handle_t *handle, struct inode *inode,
 				bool is_block)
 {
-	struct ext4_xattr_entry *last;
+	struct ext4_xattr_entry *last, *next;
 	struct ext4_xattr_entry *here = s->here;
 	size_t min_offs = s->end - s->base, name_len = strlen(i->name);
 	int in_inode = i->in_inode;
@@ -1594,7 +1594,13 @@ static int ext4_xattr_set_entry(struct e
 
 	/* Compute min_offs and last. */
 	last = s->first;
-	for (; !IS_LAST_ENTRY(last); last = EXT4_XATTR_NEXT(last)) {
+	for (; !IS_LAST_ENTRY(last); last = next) {
+		next = EXT4_XATTR_NEXT(last);
+		if ((void *)next >= s->end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
 		if (!last->e_value_inum && last->e_value_size) {
 			size_t offs = le16_to_cpu(last->e_value_offs);
 			if (offs < min_offs)


