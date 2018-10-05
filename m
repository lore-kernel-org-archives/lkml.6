Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83101C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C1020834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="abFohKWR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZvSjrlXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C1020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJEMPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:15:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeJEMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:15:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0907960BE3; Fri,  5 Oct 2018 05:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538716732;
        bh=/2d7KpOhkCyYlV2JfTm28f9ElUB3XZkkJtMlR2xH2Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abFohKWRHCWi9DSau2AUNYSVpfvYubX3eepGzCIfKjUq5O6t8ohMiaGVgqSIDlt0M
         40dHBRPJwLuXISv33Um6aD+y86b6C5Cgpxsa3k6/mGye3uJR9FTbqF8P61ywrztt+Y
         uu94OQ7kpkTPY1/K5wd/jiXy+WCAbFoeDoXxOFoU=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B7F76081B;
        Fri,  5 Oct 2018 05:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538716731;
        bh=/2d7KpOhkCyYlV2JfTm28f9ElUB3XZkkJtMlR2xH2Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvSjrlXctB89rrJOaCOr+T8n9oDIk7ecLHWhucI16NXU2gC4qS51I64Y9dekbcOBJ
         1tIS5PYgYsMqa0T822uNG7EyUqpc3vZCGcHoCyq+x6o12JGEdwALLQJkTBS7wOZsZa
         4OMg8nhZrtsZil3SprH+Cw54Vbj/+u3RCQVUn5+w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B7F76081B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 2/2] f2fs: update REQ_TIME in f2fs_cross_rename()
Date:   Fri,  5 Oct 2018 10:47:40 +0530
Message-Id: <1538716660-31572-2-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
References: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update REQ_TIME in the missing path - f2fs_cross_rename().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a146327..e37af23 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1154,6 +1154,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
+
+	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 out_new_dir:
 	if (new_dir_entry) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

