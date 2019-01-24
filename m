Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA0BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1918D218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357705;
	bh=LRT47hZfTE/v+3u078Lf9q81Ia1vMc4QeCkwmMR7MTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QFoWI+cuRgMaSVjwkMQHZoSGkCHWT4vcWkiC632qLgFf8sf7AH080uPAt5bsYbnMN
	 dI/PyPAjPButcgkMrAyxAJjjhvv1hd52EuVom6sJKIqD2PYWqgFxAAwgbmkkuFQQgz
	 VkBREU+kSYGfSTixJB3YCEpnyRQh9xb1qOoxp5pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfAXTVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfAXTVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:21:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD8AF218D0;
        Thu, 24 Jan 2019 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357700;
        bh=LRT47hZfTE/v+3u078Lf9q81Ia1vMc4QeCkwmMR7MTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGiljGiXa8UAO4fjrqZBF/mTA01uQil8SFPC1q4/qx2ZDLDl+qPTugranSEH4H/ra
         aAcYmtm5dLwz4q30Tad1kCQiXWj8NqNRsDyXmLV3ZYNqTjEbFXDyylfgObB5nC2hTL
         9hu5iC5gYR1k2V2k9v8HCBLYe8MjWi9uawdnvk/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 3.18 10/52] crypto: cts - fix crash on short inputs
Date:   Thu, 24 Jan 2019 20:19:34 +0100
Message-Id: <20190124190142.661275592@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Eric Biggers <ebiggers@google.com>

[It's a minimal fix for a bug that was fixed incidentally by a large
refactoring in v4.8.]

In the CTS template, when the input length is <= one block cipher block
(e.g. <= 16 bytes for AES) pass the correct length to the underlying CBC
transform rather than one block.  This matches the upstream behavior and
makes the encryption/decryption operation correctly return -EINVAL when
1 <= nbytes < bsize or succeed when nbytes == 0, rather than crashing.

This was fixed upstream incidentally by a large refactoring,
commit 0605c41cc53c ("crypto: cts - Convert to skcipher").  But
syzkaller easily trips over this when running on older kernels, as it's
easily reachable via AF_ALG.  Therefore, this patch makes the minimal
fix for older kernels.

Cc: linux-crypto@vger.kernel.org
Fixes: 76cb9521795a ("[CRYPTO] cts: Add CTS mode required for Kerberos AES support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/cts.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/crypto/cts.c
+++ b/crypto/cts.c
@@ -137,8 +137,8 @@ static int crypto_cts_encrypt(struct blk
 	lcldesc.info = desc->info;
 	lcldesc.flags = desc->flags;
 
-	if (tot_blocks == 1) {
-		err = crypto_blkcipher_encrypt_iv(&lcldesc, dst, src, bsize);
+	if (tot_blocks <= 1) {
+		err = crypto_blkcipher_encrypt_iv(&lcldesc, dst, src, nbytes);
 	} else if (nbytes <= bsize * 2) {
 		err = cts_cbc_encrypt(ctx, desc, dst, src, 0, nbytes);
 	} else {
@@ -232,8 +232,8 @@ static int crypto_cts_decrypt(struct blk
 	lcldesc.info = desc->info;
 	lcldesc.flags = desc->flags;
 
-	if (tot_blocks == 1) {
-		err = crypto_blkcipher_decrypt_iv(&lcldesc, dst, src, bsize);
+	if (tot_blocks <= 1) {
+		err = crypto_blkcipher_decrypt_iv(&lcldesc, dst, src, nbytes);
 	} else if (nbytes <= bsize * 2) {
 		err = cts_cbc_decrypt(ctx, desc, dst, src, 0, nbytes);
 	} else {


