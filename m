Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90061C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543A6218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357911;
	bh=hwH7LT3VlbcFyMQQAS2qJK6osh39n6Lx6rXHse8xLKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oid8fKxHupCr+0pgFgMBPfJn92eJjzwu853AtvC097qpGu+mBdGthp+EMpXvdrarC
	 aeWOdMQYJkuMUSrI7m8AuaK0g3zZLRFmv/sg/5cDfMBrbKvFE64UpPY+4iS7QkLC3s
	 iD3nvgsKNbuw5U20Fy83c9kcSUeurV6jg7mOGPz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfAXTZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730272AbfAXTZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4A1218FC;
        Thu, 24 Jan 2019 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357904;
        bh=hwH7LT3VlbcFyMQQAS2qJK6osh39n6Lx6rXHse8xLKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPVDtL1dJzIRn57zcbeDMJW4I3QfoulgWKnD7Dq/X282Ei9YoTEDyTMJ3QzUkwGf1
         TfhoMNs27FErBI/N5F2hAOge3w7R9IKPFZeFk1tQzaH3MPpPWQd3tkyddDW2qXxgFp
         E+boDBoZsuKF8+CG1xXPxBtKrVv7P2BWdiLZG05Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 029/104] f2fs: Add sanity_check_inode() function
Date:   Thu, 24 Jan 2019 20:19:18 +0100
Message-Id: <20190124190158.280017406@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This was done as part of commits 5d64600d4f33 "f2fs: avoid bug_on on
corrupted inode" and 76d56d4ab4f2 "f2fs: fix to do sanity check with
extra_attr feature" upstream, but the specific checks they added are
not applicable to 4.4.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/inode.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -95,6 +95,13 @@ static void __recover_inline_status(stru
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
@@ -143,6 +150,11 @@ static int do_read_inode(struct inode *i
 
 	get_inline_info(fi, ri);
 
+	if (!sanity_check_inode(inode)) {
+		f2fs_put_page(node_page, 1);
+		return -EINVAL;
+	}
+
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);


