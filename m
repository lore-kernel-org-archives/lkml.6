Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B140C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C453F20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C453F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeICVzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeICVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:11 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D49BED18;
        Mon,  3 Sep 2018 17:34:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Arnd Bergmann <arnd@arndb.de>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.18 043/123] ext4: sysfs: print ext4_super_block fields as little-endian
Date:   Mon,  3 Sep 2018 18:56:27 +0200
Message-Id: <20180903165721.289965138@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit a4d2aadca184ece182418950d45ba4ffc7b652d2 upstream.

While working on extended rand for last_error/first_error timestamps,
I noticed that the endianess is wrong; we access the little-endian
fields in struct ext4_super_block as native-endian when we print them.

This adds a special case in ext4_attr_show() and ext4_attr_store()
to byteswap the superblock fields if needed.

In older kernels, this code was part of super.c, it got moved to
sysfs.c in linux-4.4.

Cc: stable@vger.kernel.org
Fixes: 52c198c6820f ("ext4: add sysfs entry showing whether the fs contains errors")
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/sysfs.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -274,8 +274,12 @@ static ssize_t ext4_attr_show(struct kob
 	case attr_pointer_ui:
 		if (!ptr)
 			return 0;
-		return snprintf(buf, PAGE_SIZE, "%u\n",
-				*((unsigned int *) ptr));
+		if (a->attr_ptr == ptr_ext4_super_block_offset)
+			return snprintf(buf, PAGE_SIZE, "%u\n",
+					le32_to_cpup(ptr));
+		else
+			return snprintf(buf, PAGE_SIZE, "%u\n",
+					*((unsigned int *) ptr));
 	case attr_pointer_atomic:
 		if (!ptr)
 			return 0;
@@ -308,7 +312,10 @@ static ssize_t ext4_attr_store(struct ko
 		ret = kstrtoul(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
-		*((unsigned int *) ptr) = t;
+		if (a->attr_ptr == ptr_ext4_super_block_offset)
+			*((__le32 *) ptr) = cpu_to_le32(t);
+		else
+			*((unsigned int *) ptr) = t;
 		return len;
 	case attr_inode_readahead:
 		return inode_readahead_blks_store(sbi, buf, len);


