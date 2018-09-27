Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B60120836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B60120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeI0Pbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:31:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeI0Pbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:31:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 857CB1117;
        Thu, 27 Sep 2018 09:14:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Wen Xu <wen.xu@gatech.edu>
Subject: [PATCH 4.18 76/88] ext4: check to make sure the rename(2)s destination is not freed
Date:   Thu, 27 Sep 2018 11:03:57 +0200
Message-Id: <20180927090309.838008301@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit b50282f3241acee880514212d88b6049fb5039c8 upstream.

If the destination of the rename(2) system call exists, the inode's
link count (i_nlinks) must be non-zero.  If it is, the inode can end
up on the orphan list prematurely, leading to all sorts of hilarity,
including a use-after-free.

https://bugzilla.kernel.org/show_bug.cgi?id=200931

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Wen Xu <wen.xu@gatech.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/namei.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3478,6 +3478,12 @@ static int ext4_rename(struct inode *old
 	int credits;
 	u8 old_file_type;
 
+	if (new.inode && new.inode->i_nlink == 0) {
+		EXT4_ERROR_INODE(new.inode,
+				 "target of rename is already freed");
+		return -EFSCORRUPTED;
+	}
+
 	if ((ext4_test_inode_flag(new_dir, EXT4_INODE_PROJINHERIT)) &&
 	    (!projid_eq(EXT4_I(new_dir)->i_projid,
 			EXT4_I(old_dentry->d_inode)->i_projid)))


