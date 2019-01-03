Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4454020883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YAmxB7Ef";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YAmxB7Ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfACILV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:11:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfACILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:11:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E95376072E; Thu,  3 Jan 2019 08:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546503079;
        bh=j/SAagVlDke4Jyf/+xZYDhG7d4KCNjlblFKRQwehW2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=YAmxB7EfDoHfxINwjEOusLfiLQpxYGAalrAVdPZJxvLFf6i/t2fO9jyhpZS5fh8ZR
         CNmpAaTzZdp2hSGHPOvXquS6FonUuG/kyHHrij3OX3N6Ych0ouLzXgHhBquCoprbgQ
         /bwU/PsZc5zzq/dClYQ5fS+1Sj6fd4XpHffaAcEM=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C5C460709;
        Thu,  3 Jan 2019 08:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546503079;
        bh=j/SAagVlDke4Jyf/+xZYDhG7d4KCNjlblFKRQwehW2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=YAmxB7EfDoHfxINwjEOusLfiLQpxYGAalrAVdPZJxvLFf6i/t2fO9jyhpZS5fh8ZR
         CNmpAaTzZdp2hSGHPOvXquS6FonUuG/kyHHrij3OX3N6Ych0ouLzXgHhBquCoprbgQ
         /bwU/PsZc5zzq/dClYQ5fS+1Sj6fd4XpHffaAcEM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C5C460709
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] configfs: Fix use-after-free when accessing sd->s_dentry
Date:   Thu,  3 Jan 2019 13:41:04 +0530
Message-Id: <1546503064-12695-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the vfs_statx() context, during path lookup, the dentry gets
added to sd->s_dentry via configfs_attach_attr(). In the end,
vfs_statx() kills the dentry by calling path_put(), which invokes
configfs_d_iput(). Ideally, this dentry must be removed from
sd->s_dentry but it doesn't if the sd->s_count >= 3. As a result,
sd->s_dentry is holding reference to a stale dentry pointer whose
memory is already freed up. This results in use-after-free issue,
when this stale sd->s_dentry is accessed later in
configfs_readdir() path.

This issue can be easily reproduced, by running the LTP test case -
sh fs_racer_file_list.sh /config
(https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/racer/fs_racer_file_list.sh)

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/configfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 39843fa..a5906c5 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -66,7 +66,7 @@ static void configfs_d_iput(struct dentry * dentry,
 		 * configfs_attach_attr and set sd->s_dentry to null
 		 * even it's still in use.
 		 */
-		if (atomic_read(&sd->s_count) <= 2)
+		if (sd->s_dentry == dentry)
 			sd->s_dentry = NULL;
 
 		spin_unlock(&configfs_dirent_lock);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

