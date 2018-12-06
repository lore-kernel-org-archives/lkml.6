Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8443EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A18221479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107679;
	bh=nLNTGs0u1yjXrSpnDEKfdMLhqPbEcTYKzgcL1P8ZKbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gs/nnj8ASMTfmr2j5UBDlmQEDVRod7XKIZSKSWMUSlyDCZyKqjhclJPP5PGy31Bpy
	 XbV+MrPPsX1FldTgwLC/kvLMibzeuCIll3dddSiNffpA0hbn4D5W2QU+N6JkOGVvin
	 EJSciw1TnXjOmMudnR7oeWr62LYML846Hm2v0Tzw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A18221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeLFOr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbeLFOru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B9621479;
        Thu,  6 Dec 2018 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107670;
        bh=nLNTGs0u1yjXrSpnDEKfdMLhqPbEcTYKzgcL1P8ZKbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PB0JYf23W+6egPKpnzZUHkWJgMZbIzhY0+ZWpQyfN/2YGPigxCLkLo0oD92SZ16l+
         k2VZB2fbvCfTMuy+GmAcJMzI0vS3c+2MTyfxjlL3n/s7/rIMbe0qki/Q6mGIPQ44jD
         PR5uEk8yct55zWdM3G/RpJSZBkkNymWZf2tZkuug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 094/101] f2fs: Add sanity_check_inode() function
Date:   Thu,  6 Dec 2018 15:39:33 +0100
Message-Id: <20181206143018.404273274@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This was done as part of commits 5d64600d4f33 "f2fs: avoid bug_on on
corrupted inode" and 76d56d4ab4f2 "f2fs: fix to do sanity check with
extra_attr feature" upstream, but the specific checks they added are
not applicable to 4.9.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/inode.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -104,6 +104,13 @@ static void __recover_inline_status(stru
 	return;
 }
 
+static bool sanity_check_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	return true;
+}
+
 static int do_read_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -153,6 +160,11 @@ static int do_read_inode(struct inode *i
 
 	get_inline_info(inode, ri);
 
+	if (!sanity_check_inode(inode)) {
+		f2fs_put_page(node_page, 1);
+		return -EINVAL;
+	}
+
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);


