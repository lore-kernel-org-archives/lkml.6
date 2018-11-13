Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D37206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG18++r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D37206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeKMP7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:59:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbeKMPrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:22 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913732251D;
        Tue, 13 Nov 2018 05:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088254;
        bh=qaZO47W0igsDSqRJBIAHYu4atpIPeKrqOsaUyOCM4Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BG18++r5ORxudZuh+kYGJtUG8XPOsgq5M3SXcAlD1ezd/RHpFNwyZDCiY6iGjGlta
         Ue+zeAZgEfnQz8W+KKMiOnymau+TkWsvOv4USbx1q8YOPakp4jxAsBF2YEp3Qe/2JI
         Dm23PRcxixfjV7vyuzGpzXAbRROuyJ4gNDH2ll6s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 02/39] cifs: don't dereference smb_file_target before null check
Date:   Tue, 13 Nov 2018 00:50:16 -0500
Message-Id: <20181113055053.78352-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 8c6c9bed8773375b1d54ccca2911ec892c59db5d ]

There is a null check on dst_file->private data which suggests
it can be potentially null. However, before this check, pointer
smb_file_target is derived from dst_file->private and dereferenced
in the call to tlink_tcon, hence there is a potential null pointer
deference.

Fix this by assigning smb_file_target and target_tcon after the
null pointer sanity checks.

Detected by CoverityScan, CID#1475302 ("Dereference before null check")

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 69ec5427769c..9c194593270b 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -984,8 +984,8 @@ static int cifs_clone_file_range(struct file *src_file, loff_t off,
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *target_inode = file_inode(dst_file);
 	struct cifsFileInfo *smb_file_src = src_file->private_data;
-	struct cifsFileInfo *smb_file_target = dst_file->private_data;
-	struct cifs_tcon *target_tcon = tlink_tcon(smb_file_target->tlink);
+	struct cifsFileInfo *smb_file_target;
+	struct cifs_tcon *target_tcon;
 	unsigned int xid;
 	int rc;
 
@@ -999,6 +999,9 @@ static int cifs_clone_file_range(struct file *src_file, loff_t off,
 		goto out;
 	}
 
+	smb_file_target = dst_file->private_data;
+	target_tcon = tlink_tcon(smb_file_target->tlink);
+
 	/*
 	 * Note: cifs case is easier than btrfs since server responsible for
 	 * checks for proper open modes and file type and if it wants
-- 
2.17.1

