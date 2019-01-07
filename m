Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5503C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850C420651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865783;
	bh=lwf9VWzUDbuk8BMYcis/I7xhqRmiD9Eu5u0jxVRgWZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qzNWudvA8BixdtDl3TUkPyhNI4BuY7aHrZ3dYQkdyfqehUee8SrQG0htVodMeNxzP
	 USieOvJya2oh8J2ZxeM1lFT1zAmTEnwfGgEFIHlRQdkFi24AAlgRHuWfnaeotYU5Qo
	 08H2eaFlwiyWPDz7OX6NrC/u6gA6S3DCID6joJZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfAGM4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729874AbfAGM4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:56:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A524B20651;
        Mon,  7 Jan 2019 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865779;
        bh=lwf9VWzUDbuk8BMYcis/I7xhqRmiD9Eu5u0jxVRgWZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQHl6hKGmd+uHKPHfdA2b2Pps1phd1Axs7K2PAveYu0HKy/c4Z9Bwlce8hj2CshWV
         LlMPah/4I7z8N8Jch3YvB7ol7NDE8mw6bvvPQKf6eYNb0lvDSYFm8nMBSg6bVhNwdZ
         bw++Si25drYDaNXQfMidwj+5sBT0/lBr1H59+A1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 123/170] crypto: cfb - fix decryption
Date:   Mon,  7 Jan 2019 13:32:30 +0100
Message-Id: <20190107104507.459422967@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


