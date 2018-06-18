Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8349CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B0820852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B0820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936846AbeFRJHT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:07:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966854AbeFRIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3288AC8A;
        Mon, 18 Jun 2018 08:31:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <tyhicks@canonical.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 020/189] eCryptfs: dont pass up plaintext names when using filename encryption
Date:   Mon, 18 Jun 2018 10:11:56 +0200
Message-Id: <20180618081210.022856336@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyler Hicks <tyhicks@canonical.com>

[ Upstream commit e86281e700cca8a773f9a572fa406adf2784ba5c ]

Both ecryptfs_filldir() and ecryptfs_readlink_lower() use
ecryptfs_decode_and_decrypt_filename() to translate lower filenames to
upper filenames. The function correctly passes up lower filenames,
unchanged, when filename encryption isn't in use. However, it was also
passing up lower filenames when the filename wasn't encrypted or
when decryption failed. Since 88ae4ab9802e, eCryptfs refuses to lookup
lower plaintext names when filename encryption is enabled so this
resulted in a situation where userspace would see lower plaintext
filenames in calls to getdents(2) but then not be able to lookup those
filenames.

An example of this can be seen when enabling filename encryption on an
eCryptfs mount at the root directory of an Ext4 filesystem:

$ ls -1i /lower
12 ECRYPTFS_FNEK_ENCRYPTED.FWYZD8TcW.5FV-TKTEYOHsheiHX9a-w.NURCCYIMjI8pn5BDB9-h3fXwrE--
11 lost+found
$ ls -1i /upper
ls: cannot access '/upper/lost+found': No such file or directory
 ? lost+found
12 test

With this change, the lower lost+found dentry is ignored:

$ ls -1i /lower
12 ECRYPTFS_FNEK_ENCRYPTED.FWYZD8TcW.5FV-TKTEYOHsheiHX9a-w.NURCCYIMjI8pn5BDB9-h3fXwrE--
11 lost+found
$ ls -1i /upper
12 test

Additionally, some potentially noisy error/info messages in the related
code paths are turned into debug messages so that the logs can't be
easily filled.

Fixes: 88ae4ab9802e ("ecryptfs_lookup(): try either only encrypted or plaintext name")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ecryptfs/crypto.c |   41 ++++++++++++++++++++++++++++-------------
 fs/ecryptfs/file.c   |   21 ++++++++++++++++-----
 2 files changed, 44 insertions(+), 18 deletions(-)

--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -2026,6 +2026,16 @@ out:
 	return rc;
 }
 
+static bool is_dot_dotdot(const char *name, size_t name_size)
+{
+	if (name_size == 1 && name[0] == '.')
+		return true;
+	else if (name_size == 2 && name[0] == '.' && name[1] == '.')
+		return true;
+
+	return false;
+}
+
 /**
  * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher text name to decoded plaintext
  * @plaintext_name: The plaintext name
@@ -2050,13 +2060,21 @@ int ecryptfs_decode_and_decrypt_filename
 	size_t packet_size;
 	int rc = 0;
 
-	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)
-	    && !(mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
-	    && (name_size > ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE)
-	    && (strncmp(name, ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX,
-			ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE) == 0)) {
-		const char *orig_name = name;
-		size_t orig_name_size = name_size;
+	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) &&
+	    !(mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)) {
+		if (is_dot_dotdot(name, name_size)) {
+			rc = ecryptfs_copy_filename(plaintext_name,
+						    plaintext_name_size,
+						    name, name_size);
+			goto out;
+		}
+
+		if (name_size <= ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE ||
+		    strncmp(name, ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX,
+			    ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE)) {
+			rc = -EINVAL;
+			goto out;
+		}
 
 		name += ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE;
 		name_size -= ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE;
@@ -2079,12 +2097,9 @@ int ecryptfs_decode_and_decrypt_filename
 						  decoded_name,
 						  decoded_name_size);
 		if (rc) {
-			printk(KERN_INFO "%s: Could not parse tag 70 packet "
-			       "from filename; copying through filename "
-			       "as-is\n", __func__);
-			rc = ecryptfs_copy_filename(plaintext_name,
-						    plaintext_name_size,
-						    orig_name, orig_name_size);
+			ecryptfs_printk(KERN_DEBUG,
+					"%s: Could not parse tag 70 packet from filename\n",
+					__func__);
 			goto out_free;
 		}
 	} else {
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -82,17 +82,28 @@ ecryptfs_filldir(struct dir_context *ctx
 						  buf->sb, lower_name,
 						  lower_namelen);
 	if (rc) {
-		printk(KERN_ERR "%s: Error attempting to decode and decrypt "
-		       "filename [%s]; rc = [%d]\n", __func__, lower_name,
-		       rc);
-		goto out;
+		if (rc != -EINVAL) {
+			ecryptfs_printk(KERN_DEBUG,
+					"%s: Error attempting to decode and decrypt filename [%s]; rc = [%d]\n",
+					__func__, lower_name, rc);
+			return rc;
+		}
+
+		/* Mask -EINVAL errors as these are most likely due a plaintext
+		 * filename present in the lower filesystem despite filename
+		 * encryption being enabled. One unavoidable example would be
+		 * the "lost+found" dentry in the root directory of an Ext4
+		 * filesystem.
+		 */
+		return 0;
 	}
+
 	buf->caller->pos = buf->ctx.pos;
 	rc = !dir_emit(buf->caller, name, name_size, ino, d_type);
 	kfree(name);
 	if (!rc)
 		buf->entries_written++;
-out:
+
 	return rc;
 }
 


