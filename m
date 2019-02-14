Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A0AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482C20823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502641AbfBNQUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:20:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbfBNQUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:20:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A52457E45F;
        Thu, 14 Feb 2019 16:20:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90C131024901;
        Thu, 14 Feb 2019 16:20:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/4] keys: Fix dependency loop between construction record
 and auth key
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, ebiggers@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 16:20:25 +0000
Message-ID: <155016122303.8115.13283862185293467040.stgit@warthog.procyon.org.uk>
In-Reply-To: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
References: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 14 Feb 2019 16:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the request_key() upcall mechanism there's a dependency loop by which if
a key type driver overrides the ->request_key hook and the userspace side
manages to lose the authorisation key, the auth key and the internal
construction record (struct key_construction) can keep each other pinned.

Fix this by the following changes:

 (1) Killing off the construction record and using the auth key instead.

 (2) Including the operation name in the auth key payload and making the
     payload available outside of security/keys/.

 (3) The ->request_key hook is given the authkey instead of the cons
     record and operation name.

Changes (2) and (3) allow the auth key to naturally be cleaned up if the
keyring it is in is destroyed or cleared or the auth key is unlinked.

Fixes: 7ee02a316600 ("keys: Fix dependency loop between construction record and auth key")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/nfs4idmap.c                   |   31 ++++++++-------
 include/keys/request_key_auth-type.h |   36 +++++++++++++++++
 include/linux/key-type.h             |   22 +++-------
 security/keys/internal.h             |   13 ------
 security/keys/keyctl.c               |    1 
 security/keys/process_keys.c         |    1 
 security/keys/request_key.c          |   72 ++++++++++++++--------------------
 security/keys/request_key_auth.c     |   16 ++++----
 8 files changed, 100 insertions(+), 92 deletions(-)
 create mode 100644 include/keys/request_key_auth-type.h

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 3f23b6840547..bf34ddaa2ad7 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -44,6 +44,7 @@
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
+#include <keys/request_key_auth-type.h>
 #include <linux/module.h>
 
 #include "internal.h"
@@ -59,7 +60,7 @@ static struct key_type key_type_id_resolver_legacy;
 struct idmap_legacy_upcalldata {
 	struct rpc_pipe_msg pipe_msg;
 	struct idmap_msg idmap_msg;
-	struct key_construction	*key_cons;
+	struct key	*authkey;
 	struct idmap *idmap;
 };
 
@@ -384,7 +385,7 @@ static const match_table_t nfs_idmap_tokens = {
 	{ Opt_find_err, NULL }
 };
 
-static int nfs_idmap_legacy_upcall(struct key_construction *, const char *, void *);
+static int nfs_idmap_legacy_upcall(struct key *, void *);
 static ssize_t idmap_pipe_downcall(struct file *, const char __user *,
 				   size_t);
 static void idmap_release_pipe(struct inode *);
@@ -549,11 +550,12 @@ nfs_idmap_prepare_pipe_upcall(struct idmap *idmap,
 static void
 nfs_idmap_complete_pipe_upcall_locked(struct idmap *idmap, int ret)
 {
-	struct key_construction *cons = idmap->idmap_upcall_data->key_cons;
+	struct key *authkey = idmap->idmap_upcall_data->authkey;
 
 	kfree(idmap->idmap_upcall_data);
 	idmap->idmap_upcall_data = NULL;
-	complete_request_key(cons, ret);
+	complete_request_key(authkey, ret);
+	key_put(authkey);
 }
 
 static void
@@ -563,15 +565,14 @@ nfs_idmap_abort_pipe_upcall(struct idmap *idmap, int ret)
 		nfs_idmap_complete_pipe_upcall_locked(idmap, ret);
 }
 
-static int nfs_idmap_legacy_upcall(struct key_construction *cons,
-				   const char *op,
-				   void *aux)
+static int nfs_idmap_legacy_upcall(struct key *authkey, void *aux)
 {
 	struct idmap_legacy_upcalldata *data;
+	struct request_key_auth *rka = get_request_key_auth(authkey);
 	struct rpc_pipe_msg *msg;
 	struct idmap_msg *im;
 	struct idmap *idmap = (struct idmap *)aux;
-	struct key *key = cons->key;
+	struct key *key = rka->target_key;
 	int ret = -ENOKEY;
 
 	if (!aux)
@@ -586,7 +587,7 @@ static int nfs_idmap_legacy_upcall(struct key_construction *cons,
 	msg = &data->pipe_msg;
 	im = &data->idmap_msg;
 	data->idmap = idmap;
-	data->key_cons = cons;
+	data->authkey = key_get(authkey);
 
 	ret = nfs_idmap_prepare_message(key->description, idmap, im, msg);
 	if (ret < 0)
@@ -604,7 +605,7 @@ static int nfs_idmap_legacy_upcall(struct key_construction *cons,
 out2:
 	kfree(data);
 out1:
-	complete_request_key(cons, ret);
+	complete_request_key(authkey, ret);
 	return ret;
 }
 
@@ -651,9 +652,10 @@ static int nfs_idmap_read_and_verify_message(struct idmap_msg *im,
 static ssize_t
 idmap_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 {
+	struct request_key_auth *rka;
 	struct rpc_inode *rpci = RPC_I(file_inode(filp));
 	struct idmap *idmap = (struct idmap *)rpci->private;
-	struct key_construction *cons;
+	struct key *authkey;
 	struct idmap_msg im;
 	size_t namelen_in;
 	int ret = -ENOKEY;
@@ -665,7 +667,8 @@ idmap_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (idmap->idmap_upcall_data == NULL)
 		goto out_noupcall;
 
-	cons = idmap->idmap_upcall_data->key_cons;
+	authkey = idmap->idmap_upcall_data->authkey;
+	rka = get_request_key_auth(authkey);
 
 	if (mlen != sizeof(im)) {
 		ret = -ENOSPC;
@@ -690,9 +693,9 @@ idmap_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 
 	ret = nfs_idmap_read_and_verify_message(&im,
 			&idmap->idmap_upcall_data->idmap_msg,
-			cons->key, cons->authkey);
+			rka->target_key, authkey);
 	if (ret >= 0) {
-		key_set_timeout(cons->key, nfs_idmap_cache_timeout);
+		key_set_timeout(rka->target_key, nfs_idmap_cache_timeout);
 		ret = mlen;
 	}
 
diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
new file mode 100644
index 000000000000..a726dd3f1dc6
--- /dev/null
+++ b/include/keys/request_key_auth-type.h
@@ -0,0 +1,36 @@
+/* request_key authorisation token key type
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _KEYS_REQUEST_KEY_AUTH_TYPE_H
+#define _KEYS_REQUEST_KEY_AUTH_TYPE_H
+
+#include <linux/key.h>
+
+/*
+ * Authorisation record for request_key().
+ */
+struct request_key_auth {
+	struct key		*target_key;
+	struct key		*dest_keyring;
+	const struct cred	*cred;
+	void			*callout_info;
+	size_t			callout_len;
+	pid_t			pid;
+	char			op[8];
+} __randomize_layout;
+
+static inline struct request_key_auth *get_request_key_auth(const struct key *key)
+{
+	return key->payload.data[0];
+}
+
+
+#endif /* _KEYS_REQUEST_KEY_AUTH_TYPE_H */
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index bc9af551fc83..e49d1de0614e 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -20,15 +20,6 @@
 struct kernel_pkey_query;
 struct kernel_pkey_params;
 
-/*
- * key under-construction record
- * - passed to the request_key actor if supplied
- */
-struct key_construction {
-	struct key	*key;	/* key being constructed */
-	struct key	*authkey;/* authorisation for key being constructed */
-};
-
 /*
  * Pre-parsed payload, used by key add, update and instantiate.
  *
@@ -50,8 +41,7 @@ struct key_preparsed_payload {
 	time64_t	expiry;		/* Expiry time of key */
 } __randomize_layout;
 
-typedef int (*request_key_actor_t)(struct key_construction *key,
-				   const char *op, void *aux);
+typedef int (*request_key_actor_t)(struct key *auth_key, void *aux);
 
 /*
  * Preparsed matching criterion.
@@ -181,20 +171,20 @@ extern int key_instantiate_and_link(struct key *key,
 				    const void *data,
 				    size_t datalen,
 				    struct key *keyring,
-				    struct key *instkey);
+				    struct key *authkey);
 extern int key_reject_and_link(struct key *key,
 			       unsigned timeout,
 			       unsigned error,
 			       struct key *keyring,
-			       struct key *instkey);
-extern void complete_request_key(struct key_construction *cons, int error);
+			       struct key *authkey);
+extern void complete_request_key(struct key *authkey, int error);
 
 static inline int key_negate_and_link(struct key *key,
 				      unsigned timeout,
 				      struct key *keyring,
-				      struct key *instkey)
+				      struct key *authkey)
 {
-	return key_reject_and_link(key, timeout, ENOKEY, keyring, instkey);
+	return key_reject_and_link(key, timeout, ENOKEY, keyring, authkey);
 }
 
 extern int generic_key_instantiate(struct key *key, struct key_preparsed_payload *prep);
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 479909b858c7..8f533c81aa8d 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -186,20 +186,9 @@ static inline int key_permission(const key_ref_t key_ref, unsigned perm)
 	return key_task_permission(key_ref, current_cred(), perm);
 }
 
-/*
- * Authorisation record for request_key().
- */
-struct request_key_auth {
-	struct key		*target_key;
-	struct key		*dest_keyring;
-	const struct cred	*cred;
-	void			*callout_info;
-	size_t			callout_len;
-	pid_t			pid;
-} __randomize_layout;
-
 extern struct key_type key_type_request_key_auth;
 extern struct key *request_key_auth_new(struct key *target,
+					const char *op,
 					const void *callout_info,
 					size_t callout_len,
 					struct key *dest_keyring);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index e8093d025966..7bbe03593e58 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -25,6 +25,7 @@
 #include <linux/security.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
+#include <keys/request_key_auth-type.h>
 #include "internal.h"
 
 #define KEY_MAX_DESC_SIZE 4096
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 02c77e928f68..0e0b9ccad2f8 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -19,6 +19,7 @@
 #include <linux/security.h>
 #include <linux/user_namespace.h>
 #include <linux/uaccess.h>
+#include <keys/request_key_auth-type.h>
 #include "internal.h"
 
 /* Session keyring create vs join semaphore */
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 301f0e300dbd..3f56a312dd35 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -18,31 +18,30 @@
 #include <linux/keyctl.h>
 #include <linux/slab.h>
 #include "internal.h"
+#include <keys/request_key_auth-type.h>
 
 #define key_negative_timeout	60	/* default timeout on a negative key's existence */
 
 /**
  * complete_request_key - Complete the construction of a key.
- * @cons: The key construction record.
+ * @auth_key: The authorisation key.
  * @error: The success or failute of the construction.
  *
  * Complete the attempt to construct a key.  The key will be negated
  * if an error is indicated.  The authorisation key will be revoked
  * unconditionally.
  */
-void complete_request_key(struct key_construction *cons, int error)
+void complete_request_key(struct key *authkey, int error)
 {
-	kenter("{%d,%d},%d", cons->key->serial, cons->authkey->serial, error);
+	struct request_key_auth *rka = get_request_key_auth(authkey);
+	struct key *key = rka->target_key;
+
+	kenter("%d{%d},%d", authkey->serial, key->serial, error);
 
 	if (error < 0)
-		key_negate_and_link(cons->key, key_negative_timeout, NULL,
-				    cons->authkey);
+		key_negate_and_link(key, key_negative_timeout, NULL, authkey);
 	else
-		key_revoke(cons->authkey);
-
-	key_put(cons->key);
-	key_put(cons->authkey);
-	kfree(cons);
+		key_revoke(authkey);
 }
 EXPORT_SYMBOL(complete_request_key);
 
@@ -91,21 +90,19 @@ static int call_usermodehelper_keys(const char *path, char **argv, char **envp,
  * Request userspace finish the construction of a key
  * - execute "/sbin/request-key <op> <key> <uid> <gid> <keyring> <keyring> <keyring>"
  */
-static int call_sbin_request_key(struct key_construction *cons,
-				 const char *op,
-				 void *aux)
+static int call_sbin_request_key(struct key *authkey, void *aux)
 {
 	static char const request_key[] = "/sbin/request-key";
+	struct request_key_auth *rka = get_request_key_auth(authkey);
 	const struct cred *cred = current_cred();
 	key_serial_t prkey, sskey;
-	struct key *key = cons->key, *authkey = cons->authkey, *keyring,
-		*session;
+	struct key *key = rka->target_key, *keyring, *session;
 	char *argv[9], *envp[3], uid_str[12], gid_str[12];
 	char key_str[12], keyring_str[3][12];
 	char desc[20];
 	int ret, i;
 
-	kenter("{%d},{%d},%s", key->serial, authkey->serial, op);
+	kenter("{%d},{%d},%s", key->serial, authkey->serial, rka->op);
 
 	ret = install_user_keyrings();
 	if (ret < 0)
@@ -163,7 +160,7 @@ static int call_sbin_request_key(struct key_construction *cons,
 	/* set up the argument list */
 	i = 0;
 	argv[i++] = (char *)request_key;
-	argv[i++] = (char *) op;
+	argv[i++] = (char *)rka->op;
 	argv[i++] = key_str;
 	argv[i++] = uid_str;
 	argv[i++] = gid_str;
@@ -191,7 +188,7 @@ static int call_sbin_request_key(struct key_construction *cons,
 	key_put(keyring);
 
 error_alloc:
-	complete_request_key(cons, ret);
+	complete_request_key(authkey, ret);
 	kleave(" = %d", ret);
 	return ret;
 }
@@ -205,42 +202,31 @@ static int construct_key(struct key *key, const void *callout_info,
 			 size_t callout_len, void *aux,
 			 struct key *dest_keyring)
 {
-	struct key_construction *cons;
 	request_key_actor_t actor;
 	struct key *authkey;
 	int ret;
 
 	kenter("%d,%p,%zu,%p", key->serial, callout_info, callout_len, aux);
 
-	cons = kmalloc(sizeof(*cons), GFP_KERNEL);
-	if (!cons)
-		return -ENOMEM;
-
 	/* allocate an authorisation key */
-	authkey = request_key_auth_new(key, callout_info, callout_len,
+	authkey = request_key_auth_new(key, "create", callout_info, callout_len,
 				       dest_keyring);
-	if (IS_ERR(authkey)) {
-		kfree(cons);
-		ret = PTR_ERR(authkey);
-		authkey = NULL;
-	} else {
-		cons->authkey = key_get(authkey);
-		cons->key = key_get(key);
+	if (IS_ERR(authkey))
+		return PTR_ERR(authkey);
 
-		/* make the call */
-		actor = call_sbin_request_key;
-		if (key->type->request_key)
-			actor = key->type->request_key;
+	/* Make the call */
+	actor = call_sbin_request_key;
+	if (key->type->request_key)
+		actor = key->type->request_key;
 
-		ret = actor(cons, "create", aux);
+	ret = actor(authkey, aux);
 
-		/* check that the actor called complete_request_key() prior to
-		 * returning an error */
-		WARN_ON(ret < 0 &&
-			!test_bit(KEY_FLAG_REVOKED, &authkey->flags));
-		key_put(authkey);
-	}
+	/* check that the actor called complete_request_key() prior to
+	 * returning an error */
+	WARN_ON(ret < 0 &&
+		!test_bit(KEY_FLAG_REVOKED, &authkey->flags));
 
+	key_put(authkey);
 	kleave(" = %d", ret);
 	return ret;
 }
@@ -275,7 +261,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 			if (cred->request_key_auth) {
 				authkey = cred->request_key_auth;
 				down_read(&authkey->sem);
-				rka = authkey->payload.data[0];
+				rka = get_request_key_auth(authkey);
 				if (!test_bit(KEY_FLAG_REVOKED,
 					      &authkey->flags))
 					dest_keyring =
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 87ea2f54dedc..afc304e8b61e 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include "internal.h"
-#include <keys/user-type.h>
+#include <keys/request_key_auth-type.h>
 
 static int request_key_auth_preparse(struct key_preparsed_payload *);
 static void request_key_auth_free_preparse(struct key_preparsed_payload *);
@@ -68,7 +68,7 @@ static int request_key_auth_instantiate(struct key *key,
 static void request_key_auth_describe(const struct key *key,
 				      struct seq_file *m)
 {
-	struct request_key_auth *rka = key->payload.data[0];
+	struct request_key_auth *rka = get_request_key_auth(key);
 
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
@@ -83,7 +83,7 @@ static void request_key_auth_describe(const struct key *key,
 static long request_key_auth_read(const struct key *key,
 				  char __user *buffer, size_t buflen)
 {
-	struct request_key_auth *rka = key->payload.data[0];
+	struct request_key_auth *rka = get_request_key_auth(key);
 	size_t datalen;
 	long ret;
 
@@ -109,7 +109,7 @@ static long request_key_auth_read(const struct key *key,
  */
 static void request_key_auth_revoke(struct key *key)
 {
-	struct request_key_auth *rka = key->payload.data[0];
+	struct request_key_auth *rka = get_request_key_auth(key);
 
 	kenter("{%d}", key->serial);
 
@@ -136,7 +136,7 @@ static void free_request_key_auth(struct request_key_auth *rka)
  */
 static void request_key_auth_destroy(struct key *key)
 {
-	struct request_key_auth *rka = key->payload.data[0];
+	struct request_key_auth *rka = get_request_key_auth(key);
 
 	kenter("{%d}", key->serial);
 
@@ -147,8 +147,9 @@ static void request_key_auth_destroy(struct key *key)
  * Create an authorisation token for /sbin/request-key or whoever to gain
  * access to the caller's security data.
  */
-struct key *request_key_auth_new(struct key *target, const void *callout_info,
-				 size_t callout_len, struct key *dest_keyring)
+struct key *request_key_auth_new(struct key *target, const char *op,
+				 const void *callout_info, size_t callout_len,
+				 struct key *dest_keyring)
 {
 	struct request_key_auth *rka, *irka;
 	const struct cred *cred = current->cred;
@@ -166,6 +167,7 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 	if (!rka->callout_info)
 		goto error_free_rka;
 	rka->callout_len = callout_len;
+	strlcpy(rka->op, op, sizeof(rka->op));
 
 	/* see if the calling process is already servicing the key request of
 	 * another process */

