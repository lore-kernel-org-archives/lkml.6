Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-553228-1519316481-2-9181514006260474746
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519316481; b=ZGVCeUK3OdJ7JFBnfSh2YBWxJZu3asrdNpIMe5ji64hEOEL
    poCrDm4rSsXhAsDj5n6XJi4fVX9W3l6lWUV0UU0kyxygH9WPfh6iQxnlrtnY0vOZ
    jwlrRiYwUYoY+0vgMXqnWVdzEwESKSI4TSeJb8yU2uNgl+M+o+0+Tc0Tl+ykH851
    aF4S6MB2H9eh5iOnKehNkO04Ckz7i77OfOdMiiVyl6QuqQ/O+D2Xi56BjSqxWelz
    hLx7xUKHRanIermVw091bHcZnUPIIFpWUg7TXPVXO0tLfMQe9rLOGQMA9sSrOhWI
    dRPPzFC1Y/BlvcZHVllZeN8VZ1xV0vvf9Hclpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519316481; bh=7r8vEXxFUTNoKhQiVq2Rj56XYJW8KGKRoVbrh+Fe0bo=; b=b
    rSrI1B9r1lABBFOmTOqzmEsDcp44c2UXIvJ98J4VPjaTtrRI+6hDHEEClai+52zd
    qfzZ7MVWJfc/TCNhCE7nTmAy+9Ayp09xM8tvKOt2tXeSTLCV6U7gtztXOd869+Ct
    dVvkVCMjSdGyXE5ppOzDAZUTW0xNrhLrvjcrl25vIKqdCz9gw9ib/SA8nWjLY/Hc
    Rv5a9mnmPdh+zbPMe2SnUS2zOCAXLeUGwQiq9V/td3HrBMnDO5wCIivrAutn7k4Q
    PoSoQn7m5oyT+Ya7Ev65YI5kVSGuV9imFYVj3ZYkWfMOmpHyr+IucyHIWVH+j2ju
    UzjgyoApzu5R4xkD7SSBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbeBVQVR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:21:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeBVQVL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:21:11 -0500
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH 6/6] KEYS: Use individual pages in big_key for crypto buffers
Date: Thu, 22 Feb 2018 16:21:09 +0000
Message-Id: <151931646922.27713.5363631712174136041.stgit@warthog.procyon.org.uk>
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United Kingdom. Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
References: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

kmalloc() can't always allocate large enough buffers for big_key to use for
crypto (1MB + some metadata) so we cannot use that to allocate the buffer.
Further, vmalloc'd pages can't be passed to sg_init_one() and the aead
crypto accessors cannot be called progressively and must be passed all the
data in one go (which means we can't pass the data in one block at a time).

Fix this by allocating the buffer pages individually and passing them
through a multientry scatterlist to the crypto layer.  This has the bonus
advantage that we don't have to allocate a contiguous series of pages.

We then vmap() the page list and pass that through to the VFS read/write
routines.

This can trigger a warning:

	WARNING: CPU: 0 PID: 60912 at mm/page_alloc.c:3883 __alloc_pages_nodemask+0xb7c/0x15f8
	([<00000000002acbb6>] __alloc_pages_nodemask+0x1ee/0x15f8)
	 [<00000000002dd356>] kmalloc_order+0x46/0x90
	 [<00000000002dd3e0>] kmalloc_order_trace+0x40/0x1f8
	 [<0000000000326a10>] __kmalloc+0x430/0x4c0
	 [<00000000004343e4>] big_key_preparse+0x7c/0x210
	 [<000000000042c040>] key_create_or_update+0x128/0x420
	 [<000000000042e52c>] SyS_add_key+0x124/0x220
	 [<00000000007bba2c>] system_call+0xc4/0x2b0

from the keyctl/padd/useradd test of the keyutils testsuite on s390x.

Note that it might be better to shovel data through in page-sized lumps
instead as there's no particular need to use a monolithic buffer unless the
kernel itself wants to access the data.

Fixes: 13100a72f40f ("Security: Keys: Big keys stored encrypted")
Reported-by: Paul Bunyan <pbunyan@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Kirill Marinushkin <k.marinushkin@gmail.com>
---

 security/keys/big_key.c |  110 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 23 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 929e14978c42..4e99e8ba8612 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -22,6 +22,13 @@
 #include <keys/big_key-type.h>
 #include <crypto/aead.h>
 
+struct big_key_buf {
+	unsigned int		nr_pages;
+	void			*virt;
+	struct scatterlist	*sg;
+	struct page		*pages[];
+};
+
 /*
  * Layout of key payload words.
  */
@@ -91,10 +98,9 @@ static DEFINE_MUTEX(big_key_aead_lock);
 /*
  * Encrypt/decrypt big_key data
  */
-static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
+static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t datalen, u8 *key)
 {
 	int ret;
-	struct scatterlist sgio;
 	struct aead_request *aead_req;
 	/* We always use a zero nonce. The reason we can get away with this is
 	 * because we're using a different randomly generated key for every
@@ -109,8 +115,7 @@ static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
 		return -ENOMEM;
 
 	memset(zero_nonce, 0, sizeof(zero_nonce));
-	sg_init_one(&sgio, data, datalen + (op == BIG_KEY_ENC ? ENC_AUTHTAG_SIZE : 0));
-	aead_request_set_crypt(aead_req, &sgio, &sgio, datalen, zero_nonce);
+	aead_request_set_crypt(aead_req, buf->sg, buf->sg, datalen, zero_nonce);
 	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
 	aead_request_set_ad(aead_req, 0);
 
@@ -130,21 +135,81 @@ static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
 }
 
 /*
+ * Free up the buffer.
+ */
+static void big_key_free_buffer(struct big_key_buf *buf)
+{
+	unsigned int i;
+
+	if (buf->virt) {
+		memset(buf->virt, 0, buf->nr_pages * PAGE_SIZE);
+		vunmap(buf->virt);
+	}
+
+	for (i = 0; i < buf->nr_pages; i++)
+		if (buf->pages[i])
+			__free_page(buf->pages[i]);
+
+	kfree(buf);
+}
+
+/*
+ * Allocate a buffer consisting of a set of pages with a virtual mapping
+ * applied over them.
+ */
+static void *big_key_alloc_buffer(size_t len)
+{
+	struct big_key_buf *buf;
+	unsigned int npg = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned int i, l;
+
+	buf = kzalloc(sizeof(struct big_key_buf) +
+		      sizeof(struct page) * npg +
+		      sizeof(struct scatterlist) * npg,
+		      GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->nr_pages = npg;
+	buf->sg = (void *)(buf->pages + npg);
+	sg_init_table(buf->sg, npg);
+
+	for (i = 0; i < buf->nr_pages; i++) {
+		buf->pages[i] = alloc_page(GFP_KERNEL);
+		if (!buf->pages[i])
+			goto nomem;
+
+		l = min(len, PAGE_SIZE);
+		sg_set_page(&buf->sg[i], buf->pages[i], l, 0);
+		len -= l;
+	}
+
+	buf->virt = vmap(buf->pages, buf->nr_pages, VM_MAP, PAGE_KERNEL);
+	if (!buf->virt)
+		goto nomem;
+
+	return buf;
+
+nomem:
+	big_key_free_buffer(buf);
+	return NULL;
+}
+
+/*
  * Preparse a big key
  */
 int big_key_preparse(struct key_preparsed_payload *prep)
 {
+	struct big_key_buf *buf;
 	struct path *path = (struct path *)&prep->payload.data[big_key_path];
 	struct file *file;
 	u8 *enckey;
-	u8 *data = NULL;
 	ssize_t written;
-	size_t datalen = prep->datalen;
+	size_t datalen = prep->datalen, enclen = datalen + ENC_AUTHTAG_SIZE;
 	int ret;
 
-	ret = -EINVAL;
 	if (datalen <= 0 || datalen > 1024 * 1024 || !prep->data)
-		goto error;
+		return -EINVAL;
 
 	/* Set an arbitrary quota */
 	prep->quotalen = 16;
@@ -157,13 +222,12 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		 *
 		 * File content is stored encrypted with randomly generated key.
 		 */
-		size_t enclen = datalen + ENC_AUTHTAG_SIZE;
 		loff_t pos = 0;
 
-		data = kmalloc(enclen, GFP_KERNEL);
-		if (!data)
+		buf = big_key_alloc_buffer(enclen);
+		if (!buf)
 			return -ENOMEM;
-		memcpy(data, prep->data, datalen);
+		memcpy(buf->virt, prep->data, datalen);
 
 		/* generate random key */
 		enckey = kmalloc(ENC_KEY_SIZE, GFP_KERNEL);
@@ -176,7 +240,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 			goto err_enckey;
 
 		/* encrypt aligned data */
-		ret = big_key_crypt(BIG_KEY_ENC, data, datalen, enckey);
+		ret = big_key_crypt(BIG_KEY_ENC, buf, datalen, enckey);
 		if (ret)
 			goto err_enckey;
 
@@ -187,7 +251,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 			goto err_enckey;
 		}
 
-		written = kernel_write(file, data, enclen, &pos);
+		written = kernel_write(file, buf->virt, enclen, &pos);
 		if (written != enclen) {
 			ret = written;
 			if (written >= 0)
@@ -202,7 +266,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		*path = file->f_path;
 		path_get(path);
 		fput(file);
-		kzfree(data);
+		big_key_free_buffer(buf);
 	} else {
 		/* Just store the data in a buffer */
 		void *data = kmalloc(datalen, GFP_KERNEL);
@@ -220,7 +284,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 err_enckey:
 	kzfree(enckey);
 error:
-	kzfree(data);
+	big_key_free_buffer(buf);
 	return ret;
 }
 
@@ -298,15 +362,15 @@ long big_key_read(const struct key *key, char __user *buffer, size_t buflen)
 		return datalen;
 
 	if (datalen > BIG_KEY_FILE_THRESHOLD) {
+		struct big_key_buf *buf;
 		struct path *path = (struct path *)&key->payload.data[big_key_path];
 		struct file *file;
-		u8 *data;
 		u8 *enckey = (u8 *)key->payload.data[big_key_data];
 		size_t enclen = datalen + ENC_AUTHTAG_SIZE;
 		loff_t pos = 0;
 
-		data = kmalloc(enclen, GFP_KERNEL);
-		if (!data)
+		buf = big_key_alloc_buffer(enclen);
+		if (!buf)
 			return -ENOMEM;
 
 		file = dentry_open(path, O_RDONLY, current_cred());
@@ -316,26 +380,26 @@ long big_key_read(const struct key *key, char __user *buffer, size_t buflen)
 		}
 
 		/* read file to kernel and decrypt */
-		ret = kernel_read(file, data, enclen, &pos);
+		ret = kernel_read(file, buf->virt, enclen, &pos);
 		if (ret >= 0 && ret != enclen) {
 			ret = -EIO;
 			goto err_fput;
 		}
 
-		ret = big_key_crypt(BIG_KEY_DEC, data, enclen, enckey);
+		ret = big_key_crypt(BIG_KEY_DEC, buf, enclen, enckey);
 		if (ret)
 			goto err_fput;
 
 		ret = datalen;
 
 		/* copy decrypted data to user */
-		if (copy_to_user(buffer, data, datalen) != 0)
+		if (copy_to_user(buffer, buf->virt, datalen) != 0)
 			ret = -EFAULT;
 
 err_fput:
 		fput(file);
 error:
-		kzfree(data);
+		big_key_free_buffer(buf);
 	} else {
 		ret = datalen;
 		if (copy_to_user(buffer, key->payload.data[big_key_data],
