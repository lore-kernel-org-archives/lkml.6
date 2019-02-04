Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEA6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BBE217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277603;
	bh=TIIJG1vNevh3PoS01w5HxwM6JL2vBhp8WyKHhHisvYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KX0+/3HIl3Q9COrWXKzE6k/jRY0v+UrbsY7I0OfBY4LQ1OhyhDVhXu4CvEp8BWFqw
	 3YJLuO5/t0r9s/Bka7BbkVoP33ZaXRrwIuSYIKwiJ2zm5WuOqrAYuRDflJGCTp62j4
	 5EW24g4BiVXPnzq4ydzRXg0PJOFmw4q/zQUtvEyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfBDKvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732373AbfBDKvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63492070C;
        Mon,  4 Feb 2019 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277480;
        bh=TIIJG1vNevh3PoS01w5HxwM6JL2vBhp8WyKHhHisvYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQHCzYEyvjHz4SUDN4tynL1lPocu6YeBlxWYeNwHqdsCu8igZlxSUTi7Reg9tzmOy
         p7Z5ZxpjfiCfKoZvkzCRQYlQ0Vd63RXWCe3PNv6D4K/6x15i5F6GwAoEINq69bcFhL
         tCESdi7/XrV1UsTi48Myn2Xdh2RDmdT9Ht3SKGD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 26/80] net: tls: Save iv in tls_rec for async crypto requests
Date:   Mon,  4 Feb 2019 11:36:46 +0100
Message-Id: <20190204103623.555093147@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Dave Watson <davejwatson@fb.com>

[ Upstream commit 32eb67b93c9e3cd62cb423e30b090cdd4aa8d275 ]

aead_request_set_crypt takes an iv pointer, and we change the iv
soon after setting it.  Some async crypto algorithms don't save the iv,
so we need to save it in the tls_rec for async requests.

Found by hardcoding x64 aesni to use async crypto manager (to test the async
codepath), however I don't think this combination can happen in the wild.
Presumably other hardware offloads will need this fix, but there have been
no user reports.

Fixes: a42055e8d2c30 ("Add support for async encryption of records...")
Signed-off-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tls.h |    2 ++
 net/tls/tls_sw.c  |    4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -120,6 +120,8 @@ struct tls_rec {
 	struct scatterlist sg_aead_out[2];
 
 	char aad_space[TLS_AAD_SPACE_SIZE];
+	u8 iv_data[TLS_CIPHER_AES_GCM_128_IV_SIZE +
+		   TLS_CIPHER_AES_GCM_128_SALT_SIZE];
 	struct aead_request aead_req;
 	u8 aead_req_ctx[];
 };
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -439,6 +439,8 @@ static int tls_do_encryption(struct sock
 	struct scatterlist *sge = sk_msg_elem(msg_en, start);
 	int rc;
 
+	memcpy(rec->iv_data, tls_ctx->tx.iv, sizeof(rec->iv_data));
+
 	sge->offset += tls_ctx->tx.prepend_size;
 	sge->length -= tls_ctx->tx.prepend_size;
 
@@ -448,7 +450,7 @@ static int tls_do_encryption(struct sock
 	aead_request_set_ad(aead_req, TLS_AAD_SPACE_SIZE);
 	aead_request_set_crypt(aead_req, rec->sg_aead_in,
 			       rec->sg_aead_out,
-			       data_len, tls_ctx->tx.iv);
+			       data_len, rec->iv_data);
 
 	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				  tls_encrypt_done, sk);


