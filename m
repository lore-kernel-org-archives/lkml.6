Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F42BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B3A21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuA859qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B3A21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388637AbeIUDUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeIUDUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:20:34 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EACC21523;
        Thu, 20 Sep 2018 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537479303;
        bh=XpDykNoe4eJWGq9sgQK5gsxVhM5xBCZwMeELGR1436Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VuA859qhwebGcF7+hY4UfFAKzya682WZCAiTvciKS/x91iK31pyngjB7FHraWAzKE
         sEQsHCuDMxD9kdEAeftMUzeNQDTrVkSz9ytVTCZDl5Q9wOJQKruldsvGuNBn6ymc7X
         7MTel+MVM08Wf5upcA2J/tNjNDc5EnD+CAPKmfdQ=
Date:   Thu, 20 Sep 2018 14:35:01 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2 v3] f2fs: report ENOENT correct in
 f2fs_rename
Message-ID: <20180920213501.GA35918@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes wrong error report in f2fs_rename.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Change log from v2:
  - remove needless err assignment
  - relocate err precisely

 fs/f2fs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 98d3ab7c3ce6..abbad9610fad 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
 	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
-	int err = -ENOENT;
+	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -860,6 +860,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out;
 	}
 
+	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
@@ -1025,7 +1026,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_dir_entry = NULL, *new_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry, *new_entry;
 	int old_nlink = 0, new_nlink = 0;
-	int err = -ENOENT;
+	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -1049,6 +1050,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		goto out;
 
+	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
-- 
2.17.0.441.gb46fe60e1d-goog

