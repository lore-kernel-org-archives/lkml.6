Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34962C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1382083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1382083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbeGJScq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:32:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGJScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 556F0CED;
        Tue, 10 Jul 2018 18:32:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 24/53] ext4: never move the system.data xattr out of the inode body
Date:   Tue, 10 Jul 2018 20:25:00 +0200
Message-Id: <20180710182500.299241493@linuxfoundation.org>
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

commit 8cdb5240ec5928b20490a2bb34cb87e9a5f40226 upstream.

When expanding the extra isize space, we must never move the
system.data xattr out of the inode body.  For performance reasons, it
doesn't make any sense, and the inline data implementation assumes
that system.data xattr is never in the external xattr block.

This addresses CVE-2018-10880

https://bugzilla.kernel.org/show_bug.cgi?id=200005

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2656,6 +2656,11 @@ static int ext4_xattr_make_inode_space(h
 		last = IFIRST(header);
 		/* Find the entry best suited to be pushed into EA block */
 		for (; !IS_LAST_ENTRY(last); last = EXT4_XATTR_NEXT(last)) {
+			/* never move system.data out of the inode */
+			if ((last->e_name_len == 4) &&
+			    (last->e_name_index == EXT4_XATTR_INDEX_SYSTEM) &&
+			    !memcmp(last->e_name, "data", 4))
+				continue;
 			total_size = EXT4_XATTR_LEN(last->e_name_len);
 			if (!last->e_value_inum)
 				total_size += EXT4_XATTR_SIZE(


