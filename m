Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE95C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1F2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE1F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIFC0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:26:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727593AbeIFC0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:26:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D39A140216F3;
        Wed,  5 Sep 2018 21:54:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1AC5112D16C;
        Wed,  5 Sep 2018 21:54:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/22] KEYS: Provide key type operations for asymmetric key
 ops
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:54:24 +0100
Message-ID: <153618446448.7946.17891209527565509218.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide five new operations in the key_type struct that can be used to
provide access to asymmetric key operations.  These will be implemented for
the asymmetric key type in a later patch and may refer to a key retained in
RAM by the kernel or a key retained in crypto hardware.

     int (*asym_query)(const struct kernel_pkey_params *params,
		       struct kernel_pkey_query *info);
     int (*asym_eds_op)(struct kernel_pkey_params *params,
			const void *in, void *out);
     int (*asym_verify_signature)(struct kernel_pkey_params *params,
			          const void *in, const void *in2);

Since encrypt, decrypt and sign are identical in their interfaces, they're
rolled together in the asym_eds_op() operation and there's an operation ID
in the params argument to distinguish them.

Verify is different in that we supply the data and the signature instead
and get an error value (or 0) as the only result on the expectation that
this may well be how a hardware crypto device may work.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/core.rst |  106 ++++++++++++++++++++++++++++++++++
 include/linux/key-type.h             |   11 ++++
 include/linux/keyctl.h               |   46 +++++++++++++++
 include/uapi/linux/keyctl.h          |    5 ++
 4 files changed, 168 insertions(+)
 create mode 100644 include/linux/keyctl.h

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 9ce7256c6edb..2cdccde6c585 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1483,6 +1483,112 @@ The structure has a number of fields, some of which are mandatory:
      attempted key link operation. If there is no match, -EINVAL is returned.
 
 
+  *  ``int (*asym_eds_op)(struct kernel_pkey_params *params,
+			  const void *in, void *out);``
+     ``int (*asym_verify_signature)(struct kernel_pkey_params *params,
+				    const void *in, const void *in2);``
+
+     These methods are optional.  If provided the first allows a key to be
+     used to encrypt, decrypt or sign a blob of data, and the second allows a
+     key to verify a signature.
+
+     In all cases, the following information is provided in the params block::
+
+	struct kernel_pkey_params {
+		struct key	*key;
+		const char	*encoding;
+		const char	*hash_algo;
+		char		*info;
+		__u32		in_len;
+		union {
+			__u32	out_len;
+			__u32	in2_len;
+		};
+		enum kernel_pkey_operation op : 8;
+	};
+
+     This includes the key to be used; an optional string indicating the
+     encoding to use (for instance, "pkcs1" may be used with an RSA key to
+     indicate RSASSA-PKCS1-v1.5 or RSAES-PKCS1-v1.5 encoding); the name of the
+     hash algorithm used to generate the data for a signature (if appropriate);
+     the sizes of the input and output (or second input) buffers; and the ID of
+     the operation to be performed.
+
+     For a given operation ID, the input and output buffers are used as
+     follows::
+
+	Operation ID		in,in_len	out,out_len	in2,in2_len
+	=======================	===============	===============	===============
+	kernel_pkey_encrypt	Raw data	Encrypted data	-
+	kernel_pkey_decrypt	Encrypted data	Raw data	-
+	kernel_pkey_sign	Raw data	Signature	-
+	kernel_pkey_verify	Raw data	-		Signature
+
+     asym_eds_op() deals with encryption, decryption and signature creation as
+     specified by params->op.  Note that params->op is also set for
+     asym_verify_signature().
+
+     Encrypting and signature creation both take raw data in the input buffer
+     and return the encrypted result in the output buffer.  Padding may have
+     been added if an encoding was set.  In the case of signature creation,
+     depending on the encoding, the padding created may need to indicate the
+     digest algorithm - the name of which should be supplied in hash_algo.
+
+     Decryption takes encrypted data in the input buffer and returns the raw
+     data in the output buffer.  Padding will get checked and stripped off if
+     an encoding was set.
+
+     Verification takes raw data in the input buffer and the signature in the
+     second input buffer and checks that the one matches the other.  Padding
+     will be validated.  Depending on the encoding, the digest algorithm used
+     to generate the raw data may need to be indicated in hash_algo.
+
+     If successful, asym_eds_op() should return the number of bytes written
+     into the output buffer.  asym_verify_signature() should return 0.
+
+     A variety of errors may be returned, including EOPNOTSUPP if the operation
+     is not supported; EKEYREJECTED if verification fails; ENOPKG if the
+     required crypto isn't available.
+
+
+  *  ``int (*asym_query)(const struct kernel_pkey_params *params,
+			 struct kernel_pkey_query *info);``
+
+     This method is optional.  If provided it allows information about the
+     public or asymmetric key held in the key to be determined.
+
+     The parameter block is as for asym_eds_op() and co. but in_len and out_len
+     are unused.  The encoding and hash_algo fields should be used to reduce
+     the returned buffer/data sizes as appropriate.
+
+     If successful, the following information is filled in::
+
+	struct kernel_pkey_query {
+		__u32		supported_ops;
+		__u32		key_size;
+		__u16		max_data_size;
+		__u16		max_sig_size;
+		__u16		max_enc_size;
+		__u16		max_dec_size;
+	};
+
+     The supported_ops field will contain a bitmask indicating what operations
+     are supported by the key, including encryption of a blob, decryption of a
+     blob, signing a blob and verifying the signature on a blob.  The following
+     constants are defined for this::
+
+	KEYCTL_SUPPORTS_{ENCRYPT,DECRYPT,SIGN,VERIFY}
+
+     The key_size field is the size of the key in bits.  max_data_size and
+     max_sig_size are the maximum raw data and signature sizes for creation and
+     verification of a signature; max_enc_size and max_dec_size are the maximum
+     raw data and signature sizes for encryption and decryption.  The
+     max_*_size fields are measured in bytes.
+
+     If successful, 0 will be returned.  If the key doesn't support this,
+     EOPNOTSUPP will be returned.
+
+
 Request-Key Callback Service
 ============================
 
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 05d8fb5a06c4..bc9af551fc83 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -17,6 +17,9 @@
 
 #ifdef CONFIG_KEYS
 
+struct kernel_pkey_query;
+struct kernel_pkey_params;
+
 /*
  * key under-construction record
  * - passed to the request_key actor if supplied
@@ -155,6 +158,14 @@ struct key_type {
 	 */
 	struct key_restriction *(*lookup_restriction)(const char *params);
 
+	/* Asymmetric key accessor functions. */
+	int (*asym_query)(const struct kernel_pkey_params *params,
+			  struct kernel_pkey_query *info);
+	int (*asym_eds_op)(struct kernel_pkey_params *params,
+			   const void *in, void *out);
+	int (*asym_verify_signature)(struct kernel_pkey_params *params,
+				     const void *in, const void *in2);
+
 	/* internal fields */
 	struct list_head	link;		/* link in types list */
 	struct lock_class_key	lock_class;	/* key->sem lock class */
diff --git a/include/linux/keyctl.h b/include/linux/keyctl.h
new file mode 100644
index 000000000000..e89b4a4e43d0
--- /dev/null
+++ b/include/linux/keyctl.h
@@ -0,0 +1,46 @@
+/* keyctl kernel bits
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef __LINUX_KEYCTL_H
+#define __LINUX_KEYCTL_H
+
+#include <uapi/linux/keyctl.h>
+
+struct kernel_pkey_query {
+	__u32		supported_ops;	/* Which ops are supported */
+	__u32		key_size;	/* Size of the key in bits */
+	__u16		max_data_size;	/* Maximum size of raw data to sign in bytes */
+	__u16		max_sig_size;	/* Maximum size of signature in bytes */
+	__u16		max_enc_size;	/* Maximum size of encrypted blob in bytes */
+	__u16		max_dec_size;	/* Maximum size of decrypted blob in bytes */
+};
+
+enum kernel_pkey_operation {
+	kernel_pkey_encrypt,
+	kernel_pkey_decrypt,
+	kernel_pkey_sign,
+	kernel_pkey_verify,
+};
+
+struct kernel_pkey_params {
+	struct key	*key;
+	const char	*encoding;	/* Encoding (eg. "oaep" or NULL for raw) */
+	const char	*hash_algo;	/* Digest algorithm used (eg. "sha1") or NULL if N/A */
+	char		*info;		/* Modified info string to be released later */
+	__u32		in_len;		/* Input data size */
+	union {
+		__u32	out_len;	/* Output buffer size (enc/dec/sign) */
+		__u32	in2_len;	/* 2nd input data size (verify) */
+	};
+	enum kernel_pkey_operation op : 8;
+};
+
+#endif /* __LINUX_KEYCTL_H */
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 7b8c9e19bad1..d5eac15bc00c 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -77,4 +77,9 @@ struct keyctl_kdf_params {
 	__u32 __spare[8];
 };
 
+#define KEYCTL_SUPPORTS_ENCRYPT		0x01
+#define KEYCTL_SUPPORTS_DECRYPT		0x02
+#define KEYCTL_SUPPORTS_SIGN		0x04
+#define KEYCTL_SUPPORTS_VERIFY		0x08
+
 #endif /*  _LINUX_KEYCTL_H */

