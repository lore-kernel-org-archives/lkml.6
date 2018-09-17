Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52492ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132352146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132352146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbeIREgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbeIREgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:49 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83F10707;
        Mon, 17 Sep 2018 23:07:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.18 016/158] SMB3: Backup intent flag missing for directory opens with backupuid mounts
Date:   Tue, 18 Sep 2018 00:40:46 +0200
Message-Id: <20180917211711.515155319@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

commit 5e19697b56a64004e2d0ff1bb952ea05493c088f upstream.

When "backup intent" is requested on the mount (e.g. backupuid or
backupgid mount options), the corresponding flag needs to be set
on opens of directories (and files) but was missing in some
places causing access denied trying to enumerate and backup
servers.

Fixes kernel bugzilla #200953
https://bugzilla.kernel.org/show_bug.cgi?id=200953

Reported-and-tested-by: <whh@rubrik.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/inode.c   |    2 ++
 fs/cifs/smb2ops.c |   25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -469,6 +469,8 @@ cifs_sfu_type(struct cifs_fattr *fattr,
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_READ;
 	oparms.create_options = CREATE_NOT_DIR;
+	if (backup_cred(cifs_sb))
+		oparms.create_options |= CREATE_OPEN_BACKUP_INTENT;
 	oparms.disposition = FILE_OPEN;
 	oparms.path = path;
 	oparms.fid = &fid;
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -626,7 +626,10 @@ smb2_is_path_accessible(const unsigned i
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options = 0;
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -775,7 +778,10 @@ smb2_query_eas(const unsigned int xid, s
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_EA;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options = 0;
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -854,7 +860,10 @@ smb2_set_ea(const unsigned int xid, stru
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_WRITE_EA;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options = 0;
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -1460,7 +1469,10 @@ smb2_query_dir_first(const unsigned int
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES | FILE_READ_DATA;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options = 0;
 	oparms.fid = fid;
 	oparms.reconnect = false;
 
@@ -1735,7 +1747,10 @@ smb2_query_symlink(const unsigned int xi
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options = 0;
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 


