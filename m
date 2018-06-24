Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D76C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A667925021
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A667925021
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755578AbeFXPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:37:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeFXPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:37:30 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2FB02C;
        Sun, 24 Jun 2018 15:37:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.16 31/64] smb3: fix various xid leaks
Date:   Sun, 24 Jun 2018 23:22:12 +0800
Message-Id: <20180624142745.723983453@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit cfe89091644c441a1ade6dae6d2e47b715648615 upstream.

Fix a few cases where we were not freeing the xid which led to
active requests being non-zero at unmount time.

Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   63 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 19 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1589,8 +1589,11 @@ get_smb2_acl_by_path(struct cifs_sb_info
 		oparms.create_options = 0;
 
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
-	if (!utf16_path)
-		return ERR_PTR(-ENOMEM);
+	if (!utf16_path) {
+		rc = -ENOMEM;
+		free_xid(xid);
+		return ERR_PTR(rc);
+	}
 
 	oparms.tcon = tcon;
 	oparms.desired_access = READ_CONTROL;
@@ -1648,8 +1651,11 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, _
 		access_flags = WRITE_DAC;
 
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
-	if (!utf16_path)
-		return -ENOMEM;
+	if (!utf16_path) {
+		rc = -ENOMEM;
+		free_xid(xid);
+		return rc;
+	}
 
 	oparms.tcon = tcon;
 	oparms.desired_access = access_flags;
@@ -1709,15 +1715,21 @@ static long smb3_zero_range(struct file
 
 	/* if file not oplocked can't be sure whether asking to extend size */
 	if (!CIFS_CACHE_READ(cifsi))
-		if (keep_size == false)
-			return -EOPNOTSUPP;
+		if (keep_size == false) {
+			rc = -EOPNOTSUPP;
+			free_xid(xid);
+			return rc;
+		}
 
 	/*
 	 * Must check if file sparse since fallocate -z (zero range) assumes
 	 * non-sparse allocation
 	 */
-	if (!(cifsi->cifsAttrs & FILE_ATTRIBUTE_SPARSE_FILE))
-		return -EOPNOTSUPP;
+	if (!(cifsi->cifsAttrs & FILE_ATTRIBUTE_SPARSE_FILE)) {
+		rc = -EOPNOTSUPP;
+		free_xid(xid);
+		return rc;
+	}
 
 	/*
 	 * need to make sure we are not asked to extend the file since the SMB3
@@ -1726,8 +1738,11 @@ static long smb3_zero_range(struct file
 	 * which for a non sparse file would zero the newly extended range
 	 */
 	if (keep_size == false)
-		if (i_size_read(inode) < offset + len)
-			return -EOPNOTSUPP;
+		if (i_size_read(inode) < offset + len) {
+			rc = -EOPNOTSUPP;
+			free_xid(xid);
+			return rc;
+		}
 
 	cifs_dbg(FYI, "offset %lld len %lld", offset, len);
 
@@ -1760,8 +1775,11 @@ static long smb3_punch_hole(struct file
 
 	/* Need to make file sparse, if not already, before freeing range. */
 	/* Consider adding equivalent for compressed since it could also work */
-	if (!smb2_set_sparse(xid, tcon, cfile, inode, set_sparse))
-		return -EOPNOTSUPP;
+	if (!smb2_set_sparse(xid, tcon, cfile, inode, set_sparse)) {
+		rc = -EOPNOTSUPP;
+		free_xid(xid);
+		return rc;
+	}
 
 	cifs_dbg(FYI, "offset %lld len %lld", offset, len);
 
@@ -1792,8 +1810,10 @@ static long smb3_simple_falloc(struct fi
 
 	/* if file not oplocked can't be sure whether asking to extend size */
 	if (!CIFS_CACHE_READ(cifsi))
-		if (keep_size == false)
-			return -EOPNOTSUPP;
+		if (keep_size == false) {
+			free_xid(xid);
+			return rc;
+		}
 
 	/*
 	 * Files are non-sparse by default so falloc may be a no-op
@@ -1802,14 +1822,16 @@ static long smb3_simple_falloc(struct fi
 	 */
 	if ((cifsi->cifsAttrs & FILE_ATTRIBUTE_SPARSE_FILE) == 0) {
 		if (keep_size == true)
-			return 0;
+			rc = 0;
 		/* check if extending file */
 		else if (i_size_read(inode) >= off + len)
 			/* not extending file and already not sparse */
-			return 0;
+			rc = 0;
 		/* BB: in future add else clause to extend file */
 		else
-			return -EOPNOTSUPP;
+			rc = -EOPNOTSUPP;
+		free_xid(xid);
+		return rc;
 	}
 
 	if ((keep_size == true) || (i_size_read(inode) >= off + len)) {
@@ -1821,8 +1843,11 @@ static long smb3_simple_falloc(struct fi
 		 * ie potentially making a few extra pages at the beginning
 		 * or end of the file non-sparse via set_sparse is harmless.
 		 */
-		if ((off > 8192) || (off + len + 8192 < i_size_read(inode)))
-			return -EOPNOTSUPP;
+		if ((off > 8192) || (off + len + 8192 < i_size_read(inode))) {
+			rc = -EOPNOTSUPP;
+			free_xid(xid);
+			return rc;
+		}
 
 		rc = smb2_set_sparse(xid, tcon, cfile, inode, false);
 	}


