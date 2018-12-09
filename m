Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC794C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B883E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbeLIV7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:59:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36178 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbeLIVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:38 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW730-0002if-QN; Sun, 09 Dec 2018 21:55:35 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003XR-3p; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.663922937@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 221/328] dm: disable CRYPTO_TFM_REQ_MAY_SLEEP to fix
 a GFP_KERNEL recursion deadlock
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 432061b3da64e488be3403124a72a9250bbe96d4 upstream.

There's a XFS on dm-crypt deadlock, recursing back to itself due to the
crypto subsystems use of GFP_KERNEL, reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=200835

* dm-crypt calls crypt_convert in xts mode
* init_crypt from xts.c calls kmalloc(GFP_KERNEL)
* kmalloc(GFP_KERNEL) recurses into the XFS filesystem, the filesystem
	tries to submit some bios and wait for them, causing a deadlock

Fix this by updating both the DM crypt and integrity targets to no
longer use the CRYPTO_TFM_REQ_MAY_SLEEP flag, which will change the
crypto allocations from GFP_KERNEL to GFP_ATOMIC, therefore they can't
recurse into a filesystem.  A GFP_ATOMIC allocation can fail, but
init_crypt() in xts.c handles the allocation failure gracefully - it
will fall back to preallocated buffer if the allocation fails.

The crypto API maintainer says that the crypto API only needs to
allocate memory when dealing with unaligned buffers and therefore
turning CRYPTO_TFM_REQ_MAY_SLEEP off is safe (see this discussion:
https://www.redhat.com/archives/dm-devel/2018-August/msg00195.html )

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[bwh: Backported to 3.16:
 - Drop change to crypt_alloc_req_aead() in dm-crypt
 - Drop changes to dm-integrity
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -262,7 +262,7 @@ static int crypt_iv_essiv_init(struct cr
 
 	sg_init_one(&sg, cc->key, cc->key_size);
 	desc.tfm = essiv->hash_tfm;
-	desc.flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	desc.flags = 0;
 
 	err = crypto_hash_digest(&desc, &sg, cc->key_size, essiv->salt);
 	if (err)
@@ -533,7 +533,7 @@ static int crypt_iv_lmk_one(struct crypt
 	int i, r;
 
 	sdesc.desc.tfm = lmk->hash_tfm;
-	sdesc.desc.flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	sdesc.desc.flags = 0;
 
 	r = crypto_shash_init(&sdesc.desc);
 	if (r)
@@ -690,7 +690,7 @@ static int crypt_iv_tcw_whitening(struct
 
 	/* calculate crc32 for every 32bit part and xor it */
 	sdesc.desc.tfm = tcw->crc32_tfm;
-	sdesc.desc.flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	sdesc.desc.flags = 0;
 	for (i = 0; i < 4; i++) {
 		r = crypto_shash_init(&sdesc.desc);
 		if (r)
@@ -891,7 +891,7 @@ static void crypt_alloc_req(struct crypt
 
 	ablkcipher_request_set_tfm(ctx->req, cc->tfms[key_index]);
 	ablkcipher_request_set_callback(ctx->req,
-	    CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+	    CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->req));
 }
 

