Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E17AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA520834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FQx6qouS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FQx6qouS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DA520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJEMPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:15:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59462 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeJEMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:15:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AEB6760BF7; Fri,  5 Oct 2018 05:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538716719;
        bh=yNIKmyMKlbygn8NWomTU28OHTQDH20xraepsEtgSdh0=;
        h=From:To:Cc:Subject:Date:From;
        b=FQx6qouS795W6hQ/2T4egdJz0jAhELm8T2CxIHVQylTWIUzXdXGt16FfuTsk8rYqu
         vRNg9RaY28DTZtv7HzR2bga+PijgDiS3+6wmwabwpjcz7XEfCuQTduqCNuzlxxsNrQ
         wtvzmQis/d9j4DAL23FnEE4CTL8NDUMKkTKQC99M=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D3086081B;
        Fri,  5 Oct 2018 05:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538716719;
        bh=yNIKmyMKlbygn8NWomTU28OHTQDH20xraepsEtgSdh0=;
        h=From:To:Cc:Subject:Date:From;
        b=FQx6qouS795W6hQ/2T4egdJz0jAhELm8T2CxIHVQylTWIUzXdXGt16FfuTsk8rYqu
         vRNg9RaY28DTZtv7HzR2bga+PijgDiS3+6wmwabwpjcz7XEfCuQTduqCNuzlxxsNrQ
         wtvzmQis/d9j4DAL23FnEE4CTL8NDUMKkTKQC99M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D3086081B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 1/2] f2fs: do not update REQ_TIME in case of error conditions
Date:   Fri,  5 Oct 2018 10:47:39 +0530
Message-Id: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The REQ_TIME should be updated only in case of success cases
as followed at all other places in the file system.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/dir.c  | 2 +-
 fs/f2fs/file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c77a580..e02db5d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -655,9 +655,9 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	f2fs_put_page(page, 1);
 
 	clear_inode_flag(inode, FI_NEW_INODE);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 fail:
 	up_write(&F2FS_I(inode)->i_sem);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return err;
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b1aaa73..543c742 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -106,6 +106,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		SetPageUptodate(page);
 
 	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
+	f2fs_update_time(sbi, REQ_TIME);
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 out_sem:
@@ -114,7 +115,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_balance_fs(sbi, dn.node_changed);
 
 	sb_end_pagefault(inode->i_sb);
-	f2fs_update_time(sbi, REQ_TIME);
 err:
 	return block_page_mkwrite_return(err);
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

