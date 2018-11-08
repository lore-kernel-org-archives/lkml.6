Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E1CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49892089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTJXbnRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49892089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbeKIHrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbeKIHrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:40 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D4E214DB;
        Thu,  8 Nov 2018 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715007;
        bh=W513KvSHLy0RkfdR6FkAYep0ADwCiL36O+NVb39EkFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTJXbnRczk3a8xhEeNBNVn/Mh+H0lwNg1PtQK+/9hWvld2zGUKaRbTLRNNAeSBaca
         748NajbtAooe8T/G/OvAEzvCCCxsVZovhX83cerSswRJZf71fLjdjf8Q0shDe9MyEE
         aRCDt+ig3pCqT2GoEsBwrRgiuGzmFuZOPVFKDVCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com,
        Eric Sandeen <sandeen@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 4.18 08/34] fscache: Fix out of bound read in long cookie keys
Date:   Thu,  8 Nov 2018 13:52:37 -0800
Message-Id: <20181108215139.425688236@linuxfoundation.org>
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

From: Eric Sandeen <sandeen@redhat.com>

commit fa520c47eaa15b9baa8ad66ac18da4a31679693b upstream.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fscache/cookie.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -70,7 +70,7 @@ void fscache_free_cookie(struct fscache_
 }
 
 /*
- * Set the index key in a cookie.  The cookie struct has space for a 12-byte
+ * Set the index key in a cookie.  The cookie struct has space for a 16-byte
  * key plus length and hash, but if that's not big enough, it's instead a
  * pointer to a buffer containing 3 bytes of hash, 1 byte of length and then
  * the key data.
@@ -80,10 +80,13 @@ static int fscache_set_key(struct fscach
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
@@ -98,7 +101,8 @@ static int fscache_set_key(struct fscach
 	 */
 	h = (unsigned long)cookie->parent;
 	h += index_key_len + cookie->type;
-	for (i = 0; i < (index_key_len + sizeof(u32) - 1) / sizeof(u32); i++)
+
+	for (i = 0; i < bufs; i++)
 		h += buf[i];
 
 	cookie->key_hash = h ^ (h >> 32);


