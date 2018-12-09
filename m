Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32441C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E9820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E9820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeLIWIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37332 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbeLIWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002il-Di; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Su-7p; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Pavel Shilovsky" <pshilov@microsoft.com>,
        "Steve French" <stfrench@microsoft.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.534988148@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 182/328] SMB3: Backup intent flag missing for
 directory opens with backupuid mounts
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
[bwh: Backported to 3.16: drop changes in smb2_query_eas(), smb2_set_ea()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -446,6 +446,8 @@ cifs_sfu_type(struct cifs_fattr *fattr,
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
@@ -315,7 +315,10 @@ smb2_is_path_accessible(const unsigned i
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
 
@@ -725,7 +728,10 @@ smb2_query_dir_first(const unsigned int
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
 
@@ -891,7 +897,10 @@ smb2_query_symlink(const unsigned int xi
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
 

