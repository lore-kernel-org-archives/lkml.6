Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F401FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13D0205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13D0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJQWUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:20:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65397 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQWUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:20:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDF6F30001EF;
        Wed, 17 Oct 2018 14:24:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7193E60150;
        Wed, 17 Oct 2018 14:23:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/4] fscache: Fix out of bound read in long cookie keys
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com,
        Eric Sandeen <sandeen@redhat.com>, viro@zeniv.linux.org.uk,
        sandeen@redhat.com, dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Oct 2018 15:23:59 +0100
Message-ID: <153978623918.8478.5800765927320866010.stgit@warthog.procyon.org.uk>
In-Reply-To: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
References: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 17 Oct 2018 14:24:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

fscache_set_key() can incur an out-of-bounds read, reported by KASAN:

 BUG: KASAN: slab-out-of-bounds in fscache_alloc_cookie+0x5b3/0x680 [fscache]
 Read of size 4 at addr ffff88084ff056d4 by task mount.nfs/32615

and also reported by syzbot at https://lkml.org/lkml/2018/7/8/236

  BUG: KASAN: slab-out-of-bounds in fscache_set_key fs/fscache/cookie.c:120 [inline]
  BUG: KASAN: slab-out-of-bounds in fscache_alloc_cookie+0x7a9/0x880 fs/fscache/cookie.c:171
  Read of size 4 at addr ffff8801d3cc8bb4 by task syz-executor907/4466

This happens for any index_key_len which is not divisible by 4 and is
larger than the size of the inline key, because the code allocates exactly
index_key_len for the key buffer, but the hashing loop is stepping through
it 4 bytes (u32) at a time in the buf[] array.

Fix this by calculating how many u32 buffers we'll need by using
DIV_ROUND_UP, and then using kcalloc() to allocate a precleared allocation
buffer to hold the index_key, then using that same count as the hashing
index limit.

Fixes: ec0328e46d6e ("fscache: Maintain a catalogue of allocated cookies")
Reported-by: syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index b52f1dcd5dea..c550512ce335 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -70,7 +70,7 @@ void fscache_free_cookie(struct fscache_cookie *cookie)
 }
 
 /*
- * Set the index key in a cookie.  The cookie struct has space for a 12-byte
+ * Set the index key in a cookie.  The cookie struct has space for a 16-byte
  * key plus length and hash, but if that's not big enough, it's instead a
  * pointer to a buffer containing 3 bytes of hash, 1 byte of length and then
  * the key data.
@@ -80,10 +80,13 @@ static int fscache_set_key(struct fscache_cookie *cookie,
 {
 	unsigned long long h;
 	u32 *buf;
+	int bufs;
 	int i;
 
+	bufs = DIV_ROUND_UP(index_key_len, sizeof(*buf));
+
 	if (index_key_len > sizeof(cookie->inline_key)) {
-		buf = kzalloc(index_key_len, GFP_KERNEL);
+		buf = kcalloc(bufs, sizeof(*buf), GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 		cookie->key = buf;
@@ -98,7 +101,8 @@ static int fscache_set_key(struct fscache_cookie *cookie,
 	 */
 	h = (unsigned long)cookie->parent;
 	h += index_key_len + cookie->type;
-	for (i = 0; i < (index_key_len + sizeof(u32) - 1) / sizeof(u32); i++)
+
+	for (i = 0; i < bufs; i++)
 		h += buf[i];
 
 	cookie->key_hash = h ^ (h >> 32);

