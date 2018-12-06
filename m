Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A1C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D3C21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107654;
	bh=ahM0vENcfmYccr7KmWt3oK8rj3AjRk/YqYLt1KZjAcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDFy19PCkdxnVcRj/HFsJj70AmEbh6L3pAMG9zBzKTEhseKVzaIKM2X93oA9iTy/Z
	 WRcPfDpRRBuwTee4xlEHL/zLJcpNHq5u/ywLM8x0h8VhwML7BEVlQKRlJLcjDoLylA
	 TKVHYmrzMkzu4v9i6XZFF1QRkvekcEVDsKtWcnxw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D3C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeLFOrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbeLFOrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87042146D;
        Thu,  6 Dec 2018 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107639;
        bh=ahM0vENcfmYccr7KmWt3oK8rj3AjRk/YqYLt1KZjAcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFpeLk2XZLO6I3jagnFQnkPomleV+Np9hMcjSz8P0s1xOaS6nnNEofAPhO+ORVia1
         TeqXmIUm4aG2t4d70qOOOMs9xbgGwaOGXN40nxfIYEXSr3596miku0Ww9ZbjsJ5pdc
         p2wN8zG54wrYp509Dg9dKDEOk1CdlvjLk6bup78c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 083/101] f2fs: fix a panic caused by NULL flush_cmd_control
Date:   Thu,  6 Dec 2018 15:39:22 +0100
Message-Id: <20181206143017.450236496@linuxfoundation.org>
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

From: Yunlei He <heyunlei@huawei.com>

commit d4fdf8ba0e5808ba9ad6b44337783bd9935e0982 upstream.

Mount fs with option noflush_merge, boot failed for illegal address
fcc in function f2fs_issue_flush:

        if (!test_opt(sbi, FLUSH_MERGE)) {
                ret = submit_flush_wait(sbi);
                atomic_inc(&fcc->issued_flush);   ->  Here, fcc illegal
                return ret;
        }

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -493,6 +493,9 @@ int create_flush_cmd_control(struct f2fs
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->cmd_control_info = fcc;
+	if (!test_opt(sbi, FLUSH_MERGE))
+		return err;
+
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
@@ -2539,7 +2542,7 @@ int build_segment_manager(struct f2fs_sb
 
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
-	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
+	if (!f2fs_readonly(sbi->sb)) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
 			return err;


