Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52DCC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD59204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD59204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbeIMTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:08:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbeIMTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:08:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91EBED0E;
        Thu, 13 Sep 2018 13:59:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Paulo Alcantara <palcantara@suse.de>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 121/197] CIFS: fix memory leak and remove dead code
Date:   Thu, 13 Sep 2018 15:31:10 +0200
Message-Id: <20180913131846.385355159@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Aurelien Aptel <aaptel@suse.com>

[ Upstream commit 256b4c3f03d77d8c0dc69e3a6ceb3afd0d1810bd ]

also fixes error code in smb311_posix_mkdir() (where
the error assignment needs to go before the goto)
a typo that Dan Carpenter and Paulo and Gustavo
pointed out.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Paulo Alcantara <palcantara@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2pdu.c |  101 ++++++++++++++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1928,7 +1928,7 @@ int smb311_posix_mkdir(const unsigned in
 {
 	struct smb_rqst rqst;
 	struct smb2_create_req *req;
-	struct smb2_create_rsp *rsp;
+	struct smb2_create_rsp *rsp = NULL;
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses = tcon->ses;
 	struct kvec iov[3]; /* make sure at least one for each open context */
@@ -1943,27 +1943,31 @@ int smb311_posix_mkdir(const unsigned in
 	char *pc_buf = NULL;
 	int flags = 0;
 	unsigned int total_len;
-	__le16 *path = cifs_convert_path_to_utf16(full_path, cifs_sb);
-
-	if (!path)
-		return -ENOMEM;
+	__le16 *utf16_path = NULL;
 
 	cifs_dbg(FYI, "mkdir\n");
 
+	/* resource #1: path allocation */
+	utf16_path = cifs_convert_path_to_utf16(full_path, cifs_sb);
+	if (!utf16_path)
+		return -ENOMEM;
+
 	if (ses && (ses->server))
 		server = ses->server;
-	else
-		return -EIO;
+	else {
+		rc = -EIO;
+		goto err_free_path;
+	}
 
+	/* resource #2: request */
 	rc = smb2_plain_req_init(SMB2_CREATE, tcon, (void **) &req, &total_len);
-
 	if (rc)
-		return rc;
+		goto err_free_path;
+
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-
 	req->ImpersonationLevel = IL_IMPERSONATION;
 	req->DesiredAccess = cpu_to_le32(FILE_WRITE_ATTRIBUTES);
 	/* File attributes ignored on open (used in create though) */
@@ -1992,50 +1996,44 @@ int smb311_posix_mkdir(const unsigned in
 		req->sync_hdr.Flags |= SMB2_FLAGS_DFS_OPERATIONS;
 		rc = alloc_path_with_tree_prefix(&copy_path, &copy_size,
 						 &name_len,
-						 tcon->treeName, path);
-		if (rc) {
-			cifs_small_buf_release(req);
-			return rc;
-		}
+						 tcon->treeName, utf16_path);
+		if (rc)
+			goto err_free_req;
+
 		req->NameLength = cpu_to_le16(name_len * 2);
 		uni_path_len = copy_size;
-		path = copy_path;
+		/* free before overwriting resource */
+		kfree(utf16_path);
+		utf16_path = copy_path;
 	} else {
-		uni_path_len = (2 * UniStrnlen((wchar_t *)path, PATH_MAX)) + 2;
+		uni_path_len = (2 * UniStrnlen((wchar_t *)utf16_path, PATH_MAX)) + 2;
 		/* MUST set path len (NameLength) to 0 opening root of share */
 		req->NameLength = cpu_to_le16(uni_path_len - 2);
 		if (uni_path_len % 8 != 0) {
 			copy_size = roundup(uni_path_len, 8);
 			copy_path = kzalloc(copy_size, GFP_KERNEL);
 			if (!copy_path) {
-				cifs_small_buf_release(req);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto err_free_req;
 			}
-			memcpy((char *)copy_path, (const char *)path,
+			memcpy((char *)copy_path, (const char *)utf16_path,
 			       uni_path_len);
 			uni_path_len = copy_size;
-			path = copy_path;
+			/* free before overwriting resource */
+			kfree(utf16_path);
+			utf16_path = copy_path;
 		}
 	}
 
 	iov[1].iov_len = uni_path_len;
-	iov[1].iov_base = path;
+	iov[1].iov_base = utf16_path;
 	req->RequestedOplockLevel = SMB2_OPLOCK_LEVEL_NONE;
 
 	if (tcon->posix_extensions) {
-		if (n_iov > 2) {
-			struct create_context *ccontext =
-			    (struct create_context *)iov[n_iov-1].iov_base;
-			ccontext->Next =
-				cpu_to_le32(iov[n_iov-1].iov_len);
-		}
-
+		/* resource #3: posix buf */
 		rc = add_posix_context(iov, &n_iov, mode);
-		if (rc) {
-			cifs_small_buf_release(req);
-			kfree(copy_path);
-			return rc;
-		}
+		if (rc)
+			goto err_free_req;
 		pc_buf = iov[n_iov-1].iov_base;
 	}
 
@@ -2044,32 +2042,33 @@ int smb311_posix_mkdir(const unsigned in
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = n_iov;
 
-	rc = cifs_send_recv(xid, ses, &rqst, &resp_buftype, flags,
-			    &rsp_iov);
-
-	cifs_small_buf_release(req);
-	rsp = (struct smb2_create_rsp *)rsp_iov.iov_base;
-
-	if (rc != 0) {
+	/* resource #4: response buffer */
+	rc = cifs_send_recv(xid, ses, &rqst, &resp_buftype, flags, &rsp_iov);
+	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_CREATE_HE);
 		trace_smb3_posix_mkdir_err(xid, tcon->tid, ses->Suid,
-				    CREATE_NOT_FILE, FILE_WRITE_ATTRIBUTES, rc);
-		goto smb311_mkdir_exit;
-	} else
-		trace_smb3_posix_mkdir_done(xid, rsp->PersistentFileId, tcon->tid,
-				     ses->Suid, CREATE_NOT_FILE,
-				     FILE_WRITE_ATTRIBUTES);
+					   CREATE_NOT_FILE,
+					   FILE_WRITE_ATTRIBUTES, rc);
+		goto err_free_rsp_buf;
+	}
+
+	rsp = (struct smb2_create_rsp *)rsp_iov.iov_base;
+	trace_smb3_posix_mkdir_done(xid, rsp->PersistentFileId, tcon->tid,
+				    ses->Suid, CREATE_NOT_FILE,
+				    FILE_WRITE_ATTRIBUTES);
 
 	SMB2_close(xid, tcon, rsp->PersistentFileId, rsp->VolatileFileId);
 
 	/* Eventually save off posix specific response info and timestaps */
 
-smb311_mkdir_exit:
-	kfree(copy_path);
-	kfree(pc_buf);
+err_free_rsp_buf:
 	free_rsp_buf(resp_buftype, rsp);
+	kfree(pc_buf);
+err_free_req:
+	cifs_small_buf_release(req);
+err_free_path:
+	kfree(utf16_path);
 	return rc;
-
 }
 #endif /* SMB311 */
 


