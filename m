Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDA5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0533320658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0533320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbeICVyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:54:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeICVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:54:54 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B8BFD16;
        Mon,  3 Sep 2018 17:33:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.18 009/123] cifs: use a refcount to protect open/closing the cached file handle
Date:   Mon,  3 Sep 2018 18:55:53 +0200
Message-Id: <20180903165719.880570760@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 9da6ec7775d2cd76df53fbf4f1f35f6d490204f5 upstream.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsglob.h  |    1 +
 fs/cifs/smb2inode.c |    4 +++-
 fs/cifs/smb2ops.c   |   31 ++++++++++++++++++++++++++-----
 fs/cifs/smb2proto.h |    1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -913,6 +913,7 @@ cap_unix(struct cifs_ses *ses)
 
 struct cached_fid {
 	bool is_valid:1;	/* Do we have a useable root fid */
+	struct kref refcount;
 	struct cifs_fid *fid;
 	struct mutex fid_mutex;
 	struct cifs_tcon *tcon;
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -120,7 +120,9 @@ smb2_open_op_close(const unsigned int xi
 		break;
 	}
 
-	if (use_cached_root_handle == false)
+	if (use_cached_root_handle)
+		close_shroot(&tcon->crfid);
+	else
 		rc = SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	if (tmprc)
 		rc = tmprc;
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -466,21 +466,36 @@ out:
 	return rc;
 }
 
-void
-smb2_cached_lease_break(struct work_struct *work)
+static void
+smb2_close_cached_fid(struct kref *ref)
 {
-	struct cached_fid *cfid = container_of(work,
-				struct cached_fid, lease_break);
-	mutex_lock(&cfid->fid_mutex);
+	struct cached_fid *cfid = container_of(ref, struct cached_fid,
+					       refcount);
+
 	if (cfid->is_valid) {
 		cifs_dbg(FYI, "clear cached root file handle\n");
 		SMB2_close(0, cfid->tcon, cfid->fid->persistent_fid,
 			   cfid->fid->volatile_fid);
 		cfid->is_valid = false;
 	}
+}
+
+void close_shroot(struct cached_fid *cfid)
+{
+	mutex_lock(&cfid->fid_mutex);
+	kref_put(&cfid->refcount, smb2_close_cached_fid);
 	mutex_unlock(&cfid->fid_mutex);
 }
 
+void
+smb2_cached_lease_break(struct work_struct *work)
+{
+	struct cached_fid *cfid = container_of(work,
+				struct cached_fid, lease_break);
+
+	close_shroot(cfid);
+}
+
 /*
  * Open the directory at the root of a share
  */
@@ -495,6 +510,7 @@ int open_shroot(unsigned int xid, struct
 	if (tcon->crfid.is_valid) {
 		cifs_dbg(FYI, "found a cached root file handle\n");
 		memcpy(pfid, tcon->crfid.fid, sizeof(struct cifs_fid));
+		kref_get(&tcon->crfid.refcount);
 		mutex_unlock(&tcon->crfid.fid_mutex);
 		return 0;
 	}
@@ -511,6 +527,8 @@ int open_shroot(unsigned int xid, struct
 		memcpy(tcon->crfid.fid, pfid, sizeof(struct cifs_fid));
 		tcon->crfid.tcon = tcon;
 		tcon->crfid.is_valid = true;
+		kref_init(&tcon->crfid.refcount);
+		kref_get(&tcon->crfid.refcount);
 	}
 	mutex_unlock(&tcon->crfid.fid_mutex);
 	return rc;
@@ -552,6 +570,9 @@ smb3_qfs_tcon(const unsigned int xid, st
 			FS_SECTOR_SIZE_INFORMATION); /* SMB3 specific */
 	if (no_cached_open)
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
+	else
+		close_shroot(&tcon->crfid);
+
 	return;
 }
 
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -68,6 +68,7 @@ extern int smb3_handle_read_data(struct
 
 extern int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
 			struct cifs_fid *pfid);
+extern void close_shroot(struct cached_fid *cfid);
 extern void move_smb2_info_to_cifs(FILE_ALL_INFO *dst,
 				   struct smb2_file_all_info *src);
 extern int smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,


