Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FFB213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9tTtF2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FFB213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbeJKXHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B663B2087A;
        Thu, 11 Oct 2018 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272359;
        bh=jocewMz2E3mjRsIqV9ezGZvUIUVxTGSTwJXP+zYUzV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9tTtF2YE/w96id9ehuRonaqtJkMj4YM7nMmpwAD7KqcC8aVO7mz+mb5S6v+eomnv
         cfLx8up6M716cXr5itPuajw7scGrvYLGxNUEdwDEkZ9gM8wQs0lh1ee2+Pyd0zfhMU
         AYhRe+ql28Jbc3Go8aPAo9A2SvuVSdAohu4Q0DoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 064/120] ext4: verify the depth of extent tree in ext4_find_extent()
Date:   Thu, 11 Oct 2018 17:34:05 +0200
Message-Id: <20181011152552.436933782@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit bc890a60247171294acc0bd67d211fa4b88d40ba upstream.

If there is a corupted file system where the claimed depth of the
extent tree is -1, this can cause a massive buffer overrun leading to
sadness.

This addresses CVE-2018-10877.

https://bugzilla.kernel.org/show_bug.cgi?id=199417

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: return -EIO instead of -EFSCORRUPTED]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4_extents.h |    1 +
 fs/ext4/extents.c      |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -103,6 +103,7 @@ struct ext4_extent_header {
 };
 
 #define EXT4_EXT_MAGIC		cpu_to_le16(0xf30a)
+#define EXT4_MAX_EXTENT_DEPTH 5
 
 #define EXT4_EXTENT_TAIL_OFFSET(hdr) \
 	(sizeof(struct ext4_extent_header) + \
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -870,6 +870,12 @@ ext4_find_extent(struct inode *inode, ex
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
+	if (depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH) {
+		EXT4_ERROR_INODE(inode, "inode has invalid extent depth: %d",
+				 depth);
+		ret = -EIO;
+		goto err;
+	}
 
 	if (path) {
 		ext4_ext_drop_refs(path);


