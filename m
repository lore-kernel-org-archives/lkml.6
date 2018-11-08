Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E163ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B82208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="meYI/vbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B82208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbeKIHrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732891AbeKIHri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FFE2147D;
        Thu,  8 Nov 2018 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715006;
        bh=lLWi+jf2OiDQfIvO3DXaPe2YaTHsFeamlsFdB4bKVVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meYI/vbk/qia1w6QFUXxWW4vakbmoAm2P1U8pspFbKIYB/9n4HwZlZ3FiqYMVO1MU
         A3APmtWLR2H2HdocmLh1AjiSyuPSnWfvG2g3PW1dGfomHDbsBoCoV+rkbrkrT1HvzJ
         Jku65gUQ9CVuFL5GSOcboDDINJI3VZeHv56pt664=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com,
        Eric Sandeen <sandeen@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 4.18 06/34] fscache: Fix incomplete initialisation of inline key space
Date:   Thu,  8 Nov 2018 13:52:35 -0800
Message-Id: <20181108215139.300568580@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

commit 1ff22883b0b2f7a73eb2609ffe879c9fd96f6328 upstream.

The inline key in struct rxrpc_cookie is insufficiently initialized,
zeroing only 3 of the 4 slots, therefore an index_key_len between 13 and 15
bytes will end up hashing uninitialized memory because the memcpy only
partially fills the last buf[] element.

Fix this by clearing fscache_cookie objects on allocation rather than using
the slab constructor to initialise them.  We're going to pretty much fill
in the entire struct anyway, so bringing it into our dcache writably
shouldn't incur much overhead.

This removes the need to do clearance in fscache_set_key() (where we aren't
doing it correctly anyway).

Also, we don't need to set cookie->key_len in fscache_set_key() as we
already did it in the only caller, so remove that.

Fixes: ec0328e46d6e ("fscache: Maintain a catalogue of allocated cookies")
Reported-by: syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com
Reported-by: Eric Sandeen <sandeen@redhat.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fscache/cookie.c   |   23 ++++-------------------
 fs/fscache/internal.h |    1 -
 fs/fscache/main.c     |    4 +---
 3 files changed, 5 insertions(+), 23 deletions(-)

--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -70,19 +70,6 @@ void fscache_free_cookie(struct fscache_
 }
 
 /*
- * initialise an cookie jar slab element prior to any use
- */
-void fscache_cookie_init_once(void *_cookie)
-{
-	struct fscache_cookie *cookie = _cookie;
-
-	memset(cookie, 0, sizeof(*cookie));
-	spin_lock_init(&cookie->lock);
-	spin_lock_init(&cookie->stores_lock);
-	INIT_HLIST_HEAD(&cookie->backing_objects);
-}
-
-/*
  * Set the index key in a cookie.  The cookie struct has space for a 12-byte
  * key plus length and hash, but if that's not big enough, it's instead a
  * pointer to a buffer containing 3 bytes of hash, 1 byte of length and then
@@ -95,8 +82,6 @@ static int fscache_set_key(struct fscach
 	u32 *buf;
 	int i;
 
-	cookie->key_len = index_key_len;
-
 	if (index_key_len > sizeof(cookie->inline_key)) {
 		buf = kzalloc(index_key_len, GFP_KERNEL);
 		if (!buf)
@@ -104,9 +89,6 @@ static int fscache_set_key(struct fscach
 		cookie->key = buf;
 	} else {
 		buf = (u32 *)cookie->inline_key;
-		buf[0] = 0;
-		buf[1] = 0;
-		buf[2] = 0;
 	}
 
 	memcpy(buf, index_key, index_key_len);
@@ -161,7 +143,7 @@ struct fscache_cookie *fscache_alloc_coo
 	struct fscache_cookie *cookie;
 
 	/* allocate and initialise a cookie */
-	cookie = kmem_cache_alloc(fscache_cookie_jar, GFP_KERNEL);
+	cookie = kmem_cache_zalloc(fscache_cookie_jar, GFP_KERNEL);
 	if (!cookie)
 		return NULL;
 
@@ -192,6 +174,9 @@ struct fscache_cookie *fscache_alloc_coo
 	cookie->netfs_data	= netfs_data;
 	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
 	cookie->type		= def->type;
+	spin_lock_init(&cookie->lock);
+	spin_lock_init(&cookie->stores_lock);
+	INIT_HLIST_HEAD(&cookie->backing_objects);
 
 	/* radix tree insertion won't use the preallocation pool unless it's
 	 * told it may not wait */
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -51,7 +51,6 @@ extern struct fscache_cache *fscache_sel
 extern struct kmem_cache *fscache_cookie_jar;
 
 extern void fscache_free_cookie(struct fscache_cookie *);
-extern void fscache_cookie_init_once(void *);
 extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
 						   const struct fscache_cookie_def *,
 						   const void *, size_t,
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -143,9 +143,7 @@ static int __init fscache_init(void)
 
 	fscache_cookie_jar = kmem_cache_create("fscache_cookie_jar",
 					       sizeof(struct fscache_cookie),
-					       0,
-					       0,
-					       fscache_cookie_init_once);
+					       0, 0, NULL);
 	if (!fscache_cookie_jar) {
 		pr_notice("Failed to allocate a cookie jar\n");
 		ret = -ENOMEM;


