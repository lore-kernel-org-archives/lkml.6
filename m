Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2522183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864877;
	bh=7VQXGA9yZ057BGDnovALWoyw2QFA5skZUmM1lX+DZ4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D+muryJhoODfZDwhOxaNfuwgmGqyP0p7uCypHGvmQFNnh06gihNS1a1HgecP9wfZ4
	 plAD3UrXBXQRPFyA0YKOhi9z4kETOGksb5bDL3ExzeAKf/S7OWySxD/0kykhJ+y8Jz
	 UTSzF+vfOYYYJlbmKbFNDp6xqjoXK+g5mM6fxzuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfAGMlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfAGMlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD9321855;
        Mon,  7 Jan 2019 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864872;
        bh=7VQXGA9yZ057BGDnovALWoyw2QFA5skZUmM1lX+DZ4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg5jV7leJR45V/xC9nveFWSy8Zb4SsixyT5I5SaB1h+/3iZGqFyGH1QvsbZF8QNWX
         SuePDXoA8Tj3zc+7dzGx+9KH17AWwDynmV2CS1ka9PJSLwKud0gAnlUO7uEnbrp3BS
         WEwhTeHoBr+o/m8LJBQ2AUhDq3fq9AXqx4dxErEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.20 088/145] crypto: cfb - fix decryption
Date:   Mon,  7 Jan 2019 13:32:05 +0100
Message-Id: <20190107104448.739785916@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

commit fa4600734b74f74d9169c3015946d4722f8bcf79 upstream.

crypto_cfb_decrypt_segment() incorrectly XOR'ed generated keystream with
IV, rather than with data stream, resulting in incorrect decryption.
Test vectors will be added in the next patch.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/cfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/cfb.c
+++ b/crypto/cfb.c
@@ -144,7 +144,7 @@ static int crypto_cfb_decrypt_segment(st
 
 	do {
 		crypto_cfb_encrypt_one(tfm, iv, dst);
-		crypto_xor(dst, iv, bsize);
+		crypto_xor(dst, src, bsize);
 		iv = src;
 
 		src += bsize;


