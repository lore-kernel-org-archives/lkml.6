Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB4721473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkm6qhyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB4721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbeK3Bdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbeK3Bde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BF0A213A2;
        Thu, 29 Nov 2018 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501681;
        bh=tS0ISHNod2Ix81Y3wVApC5b2chR0tzJyaxSoMFzwNEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkm6qhyIke21ggs0dGQ+IPfXRuhy8iMN3fXHRPuVVzy3B/r3ra8EXA1R7AhwJxW+q
         YEBKaJ/VtEr/g/EE+BKZvFpTV88BN5wZG5hGOd2yfIlpbgsBhGukSWXdNynHH6Fruk
         niVewFpX9Cj08HyQ2Mk2oXDowYk4DUDDuOsErHh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Aditya Kali <adityakali@google.com>
Subject: [PATCH 4.14 098/100] EVM: Add support for portable signature format
Date:   Thu, 29 Nov 2018 15:13:08 +0100
Message-Id: <20181129140107.212855023@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Garrett <mjg59@google.com>

commit 50b977481fce90aa5fbda55e330b9d722733e358 upstream.

The EVM signature includes the inode number and (optionally) the
filesystem UUID, making it impractical to ship EVM signatures in
packages. This patch adds a new portable format intended to allow
distributions to include EVM signatures. It is identical to the existing
format but hardcodes the inode and generation numbers to 0 and does not
include the filesystem UUID even if the kernel is configured to do so.

Removing the inode means that the metadata and signature from one file
could be copied to another file without invalidating it. This is avoided
by ensuring that an IMA xattr is present during EVM validation.

Portable signatures are intended to be immutable - ie, they will never
be transformed into HMACs.

Based on earlier work by Dmitry Kasatkin and Mikhail Kurinnoi.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Aditya Kali <adityakali@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/integrity.h             |    1 
 security/integrity/evm/evm.h          |    2 
 security/integrity/evm/evm_crypto.c   |   75 +++++++++++++++++++++++++++++-----
 security/integrity/evm/evm_main.c     |   29 ++++++++-----
 security/integrity/ima/ima_appraise.c |    4 +
 security/integrity/integrity.h        |    2 
 6 files changed, 92 insertions(+), 21 deletions(-)

--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -14,6 +14,7 @@
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
+	INTEGRITY_PASS_IMMUTABLE,
 	INTEGRITY_FAIL,
 	INTEGRITY_NOLABEL,
 	INTEGRITY_NOXATTRS,
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -48,7 +48,7 @@ int evm_calc_hmac(struct dentry *dentry,
 		  size_t req_xattr_value_len, char *digest);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, char type, char *digest);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -139,7 +139,7 @@ out:
  * protection.)
  */
 static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
-			  char *digest)
+			  char type, char *digest)
 {
 	struct h_misc {
 		unsigned long ino;
@@ -150,8 +150,13 @@ static void hmac_add_misc(struct shash_d
 	} hmac_misc;
 
 	memset(&hmac_misc, 0, sizeof(hmac_misc));
-	hmac_misc.ino = inode->i_ino;
-	hmac_misc.generation = inode->i_generation;
+	/* Don't include the inode or generation number in portable
+	 * signatures
+	 */
+	if (type != EVM_XATTR_PORTABLE_DIGSIG) {
+		hmac_misc.ino = inode->i_ino;
+		hmac_misc.generation = inode->i_generation;
+	}
 	/* The hmac uid and gid must be encoded in the initial user
 	 * namespace (not the filesystems user namespace) as encoding
 	 * them in the filesystems user namespace allows an attack
@@ -164,7 +169,8 @@ static void hmac_add_misc(struct shash_d
 	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
 	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
-	if (evm_hmac_attrs & EVM_ATTR_FSUUID)
+	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
+	    type != EVM_XATTR_PORTABLE_DIGSIG)
 		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
 				    sizeof(inode->i_sb->s_uuid));
 	crypto_shash_final(desc, digest);
@@ -190,6 +196,7 @@ static int evm_calc_hmac_or_hash(struct
 	char *xattr_value = NULL;
 	int error;
 	int size;
+	bool ima_present = false;
 
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
@@ -200,11 +207,18 @@ static int evm_calc_hmac_or_hash(struct
 
 	error = -ENODATA;
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
+		bool is_ima = false;
+
+		if (strcmp(*xattrname, XATTR_NAME_IMA) == 0)
+			is_ima = true;
+
 		if ((req_xattr_name && req_xattr_value)
 		    && !strcmp(*xattrname, req_xattr_name)) {
 			error = 0;
 			crypto_shash_update(desc, (const u8 *)req_xattr_value,
 					     req_xattr_value_len);
+			if (is_ima)
+				ima_present = true;
 			continue;
 		}
 		size = vfs_getxattr_alloc(dentry, *xattrname,
@@ -219,9 +233,14 @@ static int evm_calc_hmac_or_hash(struct
 		error = 0;
 		xattr_size = size;
 		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
+		if (is_ima)
+			ima_present = true;
 	}
-	hmac_add_misc(desc, inode, digest);
+	hmac_add_misc(desc, inode, type, digest);
 
+	/* Portable EVM signatures must include an IMA hash */
+	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
+		return -EPERM;
 out:
 	kfree(xattr_value);
 	kfree(desc);
@@ -233,17 +252,45 @@ int evm_calc_hmac(struct dentry *dentry,
 		  char *digest)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				req_xattr_value_len, EVM_XATTR_HMAC, digest);
+			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char *digest)
+		  char type, char *digest)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				req_xattr_value_len, IMA_XATTR_DIGEST, digest);
+				     req_xattr_value_len, type, digest);
+}
+
+static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
+{
+	const struct evm_ima_xattr_data *xattr_data = NULL;
+	struct integrity_iint_cache *iint;
+	int rc = 0;
+
+	iint = integrity_iint_find(inode);
+	if (iint && (iint->flags & EVM_IMMUTABLE_DIGSIG))
+		return 1;
+
+	/* Do this the hard way */
+	rc = vfs_getxattr_alloc(dentry, XATTR_NAME_EVM, (char **)&xattr_data, 0,
+				GFP_NOFS);
+	if (rc <= 0) {
+		if (rc == -ENODATA)
+			return 0;
+		return rc;
+	}
+	if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG)
+		rc = 1;
+	else
+		rc = 0;
+
+	kfree(xattr_data);
+	return rc;
 }
 
+
 /*
  * Calculate the hmac and update security.evm xattr
  *
@@ -256,6 +303,16 @@ int evm_update_evmxattr(struct dentry *d
 	struct evm_ima_xattr_data xattr_data;
 	int rc = 0;
 
+	/*
+	 * Don't permit any transformation of the EVM xattr if the signature
+	 * is of an immutable type
+	 */
+	rc = evm_is_immutable(dentry, inode);
+	if (rc < 0)
+		return rc;
+	if (rc)
+		return -EPERM;
+
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
 			   xattr_value_len, xattr_data.digest);
 	if (rc == 0) {
@@ -281,7 +338,7 @@ int evm_init_hmac(struct inode *inode, c
 	}
 
 	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
-	hmac_add_misc(desc, inode, hmac_val);
+	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
 	kfree(desc);
 	return 0;
 }
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -31,7 +31,7 @@
 int evm_initialized;
 
 static char *integrity_status_msg[] = {
-	"pass", "fail", "no_label", "no_xattrs", "unknown"
+	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
 };
 char *evm_hmac = "hmac(sha1)";
 char *evm_hash = "sha1";
@@ -120,7 +120,8 @@ static enum integrity_status evm_verify_
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	int rc, xattr_len;
 
-	if (iint && iint->evm_status == INTEGRITY_PASS)
+	if (iint && (iint->evm_status == INTEGRITY_PASS ||
+		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
 		return iint->evm_status;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -161,22 +162,26 @@ static enum integrity_status evm_verify_
 			rc = -EINVAL;
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
+	case EVM_XATTR_PORTABLE_DIGSIG:
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
-				xattr_value_len, calc.digest);
+				   xattr_value_len, xattr_data->type,
+				   calc.digest);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
 					(const char *)xattr_data, xattr_len,
 					calc.digest, sizeof(calc.digest));
 		if (!rc) {
-			/* Replace RSA with HMAC if not mounted readonly and
-			 * not immutable
-			 */
-			if (!IS_RDONLY(d_backing_inode(dentry)) &&
-			    !IS_IMMUTABLE(d_backing_inode(dentry)))
+			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
+				if (iint)
+					iint->flags |= EVM_IMMUTABLE_DIGSIG;
+				evm_status = INTEGRITY_PASS_IMMUTABLE;
+			} else if (!IS_RDONLY(d_backing_inode(dentry)) &&
+				   !IS_IMMUTABLE(d_backing_inode(dentry))) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
 						    xattr_value_len);
+			}
 		}
 		break;
 	default:
@@ -277,7 +282,7 @@ static enum integrity_status evm_verify_
  * affect security.evm.  An interesting side affect of writing posix xattr
  * acls is their modifying of the i_mode, which is included in security.evm.
  * For posix xattr acls only, permit security.evm, even if it currently
- * doesn't exist, to be updated.
+ * doesn't exist, to be updated unless the EVM signature is immutable.
  */
 static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
@@ -345,7 +350,8 @@ int evm_inode_setxattr(struct dentry *de
 	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
 		if (!xattr_value_len)
 			return -EINVAL;
-		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
+		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
+		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
 			return -EPERM;
 	}
 	return evm_protect_xattr(dentry, xattr_name, xattr_value,
@@ -422,6 +428,9 @@ void evm_inode_post_removexattr(struct d
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
  * @dentry: pointer to the affected dentry
+ *
+ * Permit update of file attributes when files have a valid EVM signature,
+ * except in the case of them having an immutable portable signature.
  */
 int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 {
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -230,7 +230,9 @@ int ima_appraise_measurement(enum ima_ho
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
+	if ((status != INTEGRITY_PASS) &&
+	    (status != INTEGRITY_PASS_IMMUTABLE) &&
+	    (status != INTEGRITY_UNKNOWN)) {
 		if ((status == INTEGRITY_NOLABEL)
 		    || (status == INTEGRITY_NOXATTRS))
 			cause = "missing-HMAC";
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -33,6 +33,7 @@
 #define IMA_DIGSIG_REQUIRED	0x02000000
 #define IMA_PERMIT_DIRECTIO	0x04000000
 #define IMA_NEW_FILE		0x08000000
+#define EVM_IMMUTABLE_DIGSIG	0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_APPRAISE_SUBMASK)
@@ -58,6 +59,7 @@ enum evm_ima_xattr_type {
 	EVM_XATTR_HMAC,
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
+	EVM_XATTR_PORTABLE_DIGSIG,
 	IMA_XATTR_LAST
 };
 


