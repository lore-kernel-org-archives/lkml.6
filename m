Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65BFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D32F21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548239227;
	bh=8elRsiUUmltK773A4kHdJiqDIPdWPYYKIr1UqJkt4D0=;
	h=Date:From:To:Subject:List-ID:From;
	b=rTmJQwlA604UeUqqut55s47IySwuuhqKGSdBqGwmpuwSRBf7WFqaEitiUzXNJUHZS
	 GFI1/NSxvZzMW0s7MFnkO01MwZtVcqUG+TGPdcQfXwAVRMkiIkZnqJ36BtOB7x98fu
	 39VSINYfd0jS+7SMfogZD3rwK7KBRjQ4nDD/LUlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfAWK1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAWK1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:27:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3357421019;
        Wed, 23 Jan 2019 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548239224;
        bh=8elRsiUUmltK773A4kHdJiqDIPdWPYYKIr1UqJkt4D0=;
        h=Date:From:To:Subject:From;
        b=QFSHm0lBwMjEPhH/GpieOwZwPcH6LA6HpV/95UOowJaQowMwIWKcqFrTxKRrYQryR
         JtwuSZIB2yPdHUR3ubTS47nzmuk/Zsiii59+71a554Sr/JKZZCqaQfIBDLH8LrJix6
         tpP+n4go6GuMLda48xSC69CwEoLlwQtgsFcDGgfg=
Date:   Wed, 23 Jan 2019 11:27:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] debugfs: fix debugfs_rename parameter checking
Message-ID: <20190123102702.GA17123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_rename() needs to check that the dentries passed into it really
are valid, as sometimes they are not (i.e. if the return value of
another debugfs call is passed into this one.)  So fix this up by
properly checking if the two parent directories are errors (they are
allowed to be NULL), and if the dentry to rename is not NULL or an
error.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b01351dd1c..41ef452c1fcf 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -787,6 +787,13 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 	struct dentry *dentry = NULL, *trap;
 	struct name_snapshot old_name;
 
+	if (IS_ERR(old_dir))
+		return old_dir;
+	if (IS_ERR(new_dir))
+		return new_dir;
+	if (IS_ERR_OR_NULL(old_dentry))
+		return old_dentry;
+
 	trap = lock_rename(new_dir, old_dir);
 	/* Source or destination directories don't exist? */
 	if (d_really_is_negative(old_dir) || d_really_is_negative(new_dir))
-- 
2.20.1

