Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F18C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0B2218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497739;
	bh=bSrHssxr3Xyw30DTpTlZL++GHAIn64VArkiX5+qHKfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j94qvkBdLbJzWVeFw0ye67e/4CITDCA2UH9vKymjf/8b/LgZxTggVblkB8UUU0oNj
	 aHpnplR+2BEBpYezL/Uyb5g3qDlCBcj3qcTArrnWzhGdNOkTvnMdmYoO3OQTySd66n
	 sddUaW9TCqQc8D7rdQEFMk6RO0IL/GEF80nYSWZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfBRNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbfBRNsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 528EE217F5;
        Mon, 18 Feb 2019 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497732;
        bh=bSrHssxr3Xyw30DTpTlZL++GHAIn64VArkiX5+qHKfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIWSywpLNWsynqEKpToKTv/KrspC4kd2lU3IPFmGuWFZkS/qigzyvU37ladXv12bI
         kB5bxRn/oXu8WwVUFlA9ChK0VLl84ThJvbThoCSdBHefSJB01S09SSeoxSbyF8t54z
         IhozoF3MfQKzM6gPuWgfpEZFiZYK3ufcCZ2lKKOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.20 85/92] sunrpc: fix 4 more call sites that were using stack memory with a scatterlist
Date:   Mon, 18 Feb 2019 14:43:28 +0100
Message-Id: <20190218133503.232151421@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

commit e7afe6c1d486b516ed586dcc10b3e7e3e85a9c2b upstream.

While trying to reproduce a reported kernel panic on arm64, I discovered
that AUTH_GSS basically doesn't work at all with older enctypes on arm64
systems with CONFIG_VMAP_STACK enabled.  It turns out there still a few
places using stack memory with scatterlists, causing krb5_encrypt() and
krb5_decrypt() to produce incorrect results (or a BUG if CONFIG_DEBUG_SG
is enabled).

Tested with cthon on v4.0/v4.1/v4.2 with krb5/krb5i/krb5p using
des3-cbc-sha1 and arcfour-hmac-md5.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/auth_gss/gss_krb5_seqnum.c |   49 ++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 11 deletions(-)

--- a/net/sunrpc/auth_gss/gss_krb5_seqnum.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seqnum.c
@@ -44,7 +44,7 @@ krb5_make_rc4_seq_num(struct krb5_ctx *k
 		      unsigned char *cksum, unsigned char *buf)
 {
 	struct crypto_sync_skcipher *cipher;
-	unsigned char plain[8];
+	unsigned char *plain;
 	s32 code;
 
 	dprintk("RPC:       %s:\n", __func__);
@@ -52,6 +52,10 @@ krb5_make_rc4_seq_num(struct krb5_ctx *k
 	if (IS_ERR(cipher))
 		return PTR_ERR(cipher);
 
+	plain = kmalloc(8, GFP_NOFS);
+	if (!plain)
+		return -ENOMEM;
+
 	plain[0] = (unsigned char) ((seqnum >> 24) & 0xff);
 	plain[1] = (unsigned char) ((seqnum >> 16) & 0xff);
 	plain[2] = (unsigned char) ((seqnum >> 8) & 0xff);
@@ -67,6 +71,7 @@ krb5_make_rc4_seq_num(struct krb5_ctx *k
 
 	code = krb5_encrypt(cipher, cksum, plain, buf, 8);
 out:
+	kfree(plain);
 	crypto_free_sync_skcipher(cipher);
 	return code;
 }
@@ -77,12 +82,17 @@ krb5_make_seq_num(struct krb5_ctx *kctx,
 		u32 seqnum,
 		unsigned char *cksum, unsigned char *buf)
 {
-	unsigned char plain[8];
+	unsigned char *plain;
+	s32 code;
 
 	if (kctx->enctype == ENCTYPE_ARCFOUR_HMAC)
 		return krb5_make_rc4_seq_num(kctx, direction, seqnum,
 					     cksum, buf);
 
+	plain = kmalloc(8, GFP_NOFS);
+	if (!plain)
+		return -ENOMEM;
+
 	plain[0] = (unsigned char) (seqnum & 0xff);
 	plain[1] = (unsigned char) ((seqnum >> 8) & 0xff);
 	plain[2] = (unsigned char) ((seqnum >> 16) & 0xff);
@@ -93,7 +103,9 @@ krb5_make_seq_num(struct krb5_ctx *kctx,
 	plain[6] = direction;
 	plain[7] = direction;
 
-	return krb5_encrypt(key, cksum, plain, buf, 8);
+	code = krb5_encrypt(key, cksum, plain, buf, 8);
+	kfree(plain);
+	return code;
 }
 
 static s32
@@ -101,7 +113,7 @@ krb5_get_rc4_seq_num(struct krb5_ctx *kc
 		     unsigned char *buf, int *direction, s32 *seqnum)
 {
 	struct crypto_sync_skcipher *cipher;
-	unsigned char plain[8];
+	unsigned char *plain;
 	s32 code;
 
 	dprintk("RPC:       %s:\n", __func__);
@@ -113,20 +125,28 @@ krb5_get_rc4_seq_num(struct krb5_ctx *kc
 	if (code)
 		goto out;
 
+	plain = kmalloc(8, GFP_NOFS);
+	if (!plain) {
+		code = -ENOMEM;
+		goto out;
+	}
+
 	code = krb5_decrypt(cipher, cksum, buf, plain, 8);
 	if (code)
-		goto out;
+		goto out_plain;
 
 	if ((plain[4] != plain[5]) || (plain[4] != plain[6])
 				   || (plain[4] != plain[7])) {
 		code = (s32)KG_BAD_SEQ;
-		goto out;
+		goto out_plain;
 	}
 
 	*direction = plain[4];
 
 	*seqnum = ((plain[0] << 24) | (plain[1] << 16) |
 					(plain[2] << 8) | (plain[3]));
+out_plain:
+	kfree(plain);
 out:
 	crypto_free_sync_skcipher(cipher);
 	return code;
@@ -139,7 +159,7 @@ krb5_get_seq_num(struct krb5_ctx *kctx,
 	       int *direction, u32 *seqnum)
 {
 	s32 code;
-	unsigned char plain[8];
+	unsigned char *plain;
 	struct crypto_sync_skcipher *key = kctx->seq;
 
 	dprintk("RPC:       krb5_get_seq_num:\n");
@@ -147,18 +167,25 @@ krb5_get_seq_num(struct krb5_ctx *kctx,
 	if (kctx->enctype == ENCTYPE_ARCFOUR_HMAC)
 		return krb5_get_rc4_seq_num(kctx, cksum, buf,
 					    direction, seqnum);
+	plain = kmalloc(8, GFP_NOFS);
+	if (!plain)
+		return -ENOMEM;
 
 	if ((code = krb5_decrypt(key, cksum, buf, plain, 8)))
-		return code;
+		goto out;
 
 	if ((plain[4] != plain[5]) || (plain[4] != plain[6]) ||
-	    (plain[4] != plain[7]))
-		return (s32)KG_BAD_SEQ;
+	    (plain[4] != plain[7])) {
+		code = (s32)KG_BAD_SEQ;
+		goto out;
+	}
 
 	*direction = plain[4];
 
 	*seqnum = ((plain[0]) |
 		   (plain[1] << 8) | (plain[2] << 16) | (plain[3] << 24));
 
-	return 0;
+out:
+	kfree(plain);
+	return code;
 }


