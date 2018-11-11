Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B47C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0BE20839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT3EHcW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0BE20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbeKLJnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732732AbeKLISZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5E12175B;
        Sun, 11 Nov 2018 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975309;
        bh=LlWkG9DejTpnQRhD7uPOrAOcGoPFwQEGrP2nZtk3CNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JT3EHcW7i2NNiw9iheleOUax8WSks7VyGo2xRdDmL0DUAsfFRV/imlgj+IUrSGXDq
         MlLkM/1BOeAhbkkTSz/HPxkKILvIRWOtQkr6ZS48ZHYlArgWvZ7pvqzjGmNEu9nv3Q
         TAOQi4NYDAQ+HxAZVbUpaiR4mUW4RUlIs0H3Jtxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 4.19 251/361] ima: open a new file instance if no read permissions
Date:   Sun, 11 Nov 2018 14:19:58 -0800
Message-Id: <20181111221653.190707609@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Goldwyn Rodrigues <rgoldwyn@suse.de>

commit a408e4a86b36bf98ad15b9ada531cf0e5118ac67 upstream.

Open a new file instance as opposed to changing file->f_mode when
the file is not readable.  This is done to accomodate overlayfs
stacked file operations change.  The real struct file is hidden
behind the overlays struct file.  So, any file->f_mode manipulations are
not reflected on the real struct file.  Open the file again in read mode
if original file cannot be read, read and calculate the hash.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc: stable@vger.kernel.org (linux-4.19)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/ima/ima_crypto.c |   54 ++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 20 deletions(-)

--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -210,7 +210,7 @@ static int ima_calc_file_hash_atfm(struc
 {
 	loff_t i_size, offset;
 	char *rbuf[2] = { NULL, };
-	int rc, read = 0, rbuf_len, active = 0, ahash_rc = 0;
+	int rc, rbuf_len, active = 0, ahash_rc = 0;
 	struct ahash_request *req;
 	struct scatterlist sg[1];
 	struct crypto_wait wait;
@@ -257,11 +257,6 @@ static int ima_calc_file_hash_atfm(struc
 					  &rbuf_size[1], 0);
 	}
 
-	if (!(file->f_mode & FMODE_READ)) {
-		file->f_mode |= FMODE_READ;
-		read = 1;
-	}
-
 	for (offset = 0; offset < i_size; offset += rbuf_len) {
 		if (!rbuf[1] && offset) {
 			/* Not using two buffers, and it is not the first
@@ -300,8 +295,6 @@ static int ima_calc_file_hash_atfm(struc
 	/* wait for the last update request to complete */
 	rc = ahash_wait(ahash_rc, &wait);
 out3:
-	if (read)
-		file->f_mode &= ~FMODE_READ;
 	ima_free_pages(rbuf[0], rbuf_size[0]);
 	ima_free_pages(rbuf[1], rbuf_size[1]);
 out2:
@@ -336,7 +329,7 @@ static int ima_calc_file_hash_tfm(struct
 {
 	loff_t i_size, offset = 0;
 	char *rbuf;
-	int rc, read = 0;
+	int rc;
 	SHASH_DESC_ON_STACK(shash, tfm);
 
 	shash->tfm = tfm;
@@ -357,11 +350,6 @@ static int ima_calc_file_hash_tfm(struct
 	if (!rbuf)
 		return -ENOMEM;
 
-	if (!(file->f_mode & FMODE_READ)) {
-		file->f_mode |= FMODE_READ;
-		read = 1;
-	}
-
 	while (offset < i_size) {
 		int rbuf_len;
 
@@ -378,8 +366,6 @@ static int ima_calc_file_hash_tfm(struct
 		if (rc)
 			break;
 	}
-	if (read)
-		file->f_mode &= ~FMODE_READ;
 	kfree(rbuf);
 out:
 	if (!rc)
@@ -420,6 +406,8 @@ int ima_calc_file_hash(struct file *file
 {
 	loff_t i_size;
 	int rc;
+	struct file *f = file;
+	bool new_file_instance = false, modified_flags = false;
 
 	/*
 	 * For consistency, fail file's opened with the O_DIRECT flag on
@@ -431,15 +419,41 @@ int ima_calc_file_hash(struct file *file
 		return -EINVAL;
 	}
 
-	i_size = i_size_read(file_inode(file));
+	/* Open a new file instance in O_RDONLY if we cannot read */
+	if (!(file->f_mode & FMODE_READ)) {
+		int flags = file->f_flags & ~(O_WRONLY | O_APPEND |
+				O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
+		flags |= O_RDONLY;
+		f = dentry_open(&file->f_path, flags, file->f_cred);
+		if (IS_ERR(f)) {
+			/*
+			 * Cannot open the file again, lets modify f_flags
+			 * of original and continue
+			 */
+			pr_info_ratelimited("Unable to reopen file for reading.\n");
+			f = file;
+			f->f_flags |= FMODE_READ;
+			modified_flags = true;
+		} else {
+			new_file_instance = true;
+		}
+	}
+
+	i_size = i_size_read(file_inode(f));
 
 	if (ima_ahash_minsize && i_size >= ima_ahash_minsize) {
-		rc = ima_calc_file_ahash(file, hash);
+		rc = ima_calc_file_ahash(f, hash);
 		if (!rc)
-			return 0;
+			goto out;
 	}
 
-	return ima_calc_file_shash(file, hash);
+	rc = ima_calc_file_shash(f, hash);
+out:
+	if (new_file_instance)
+		fput(f);
+	else if (modified_flags)
+		f->f_flags &= ~FMODE_READ;
+	return rc;
 }
 
 /*


