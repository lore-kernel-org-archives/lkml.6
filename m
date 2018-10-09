Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E773C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E4C2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E4C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJJAFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25265 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJJAFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:05:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 369653083390;
        Tue,  9 Oct 2018 16:47:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3812B7A5F7;
        Tue,  9 Oct 2018 16:47:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/22] KEYS: Make the X.509 and PKCS7 parsers supply the sig
 encoding type [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Denis Kenzior <denkenz@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>, dhowells@redhat.com,
        denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 17:47:15 +0100
Message-ID: <153910363539.12141.4210082234235945107.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 09 Oct 2018 16:47:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the X.509 and PKCS7 parsers fill in the signature encoding type field
recently added to the public_key_signature struct.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Denis Kenzior <denkenz@gmail.com>
Tested-by: Denis Kenzior <denkenz@gmail.com>
---

 crypto/asymmetric_keys/pkcs7_parser.c     |    1 +
 crypto/asymmetric_keys/x509_cert_parser.c |   21 +++++++++------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 0f134162cef4..f0d56e1a8b7e 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -271,6 +271,7 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
 	switch (ctx->last_oid) {
 	case OID_rsaEncryption:
 		ctx->sinfo->sig->pkey_algo = "rsa";
+		ctx->sinfo->sig->encoding = "pkcs1";
 		break;
 	default:
 		printk("Unsupported pkey algo: %u\n", ctx->last_oid);
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index b6cabac4b62b..991f4d735a4e 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -199,35 +199,32 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 
 	case OID_md4WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "md4";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha1WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha1";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha256WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha256";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha384WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha384";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha512WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha512";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 
 	case OID_sha224WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha224";
-		ctx->cert->sig->pkey_algo = "rsa";
-		break;
+		goto rsa_pkcs1;
 	}
 
+rsa_pkcs1:
+	ctx->cert->sig->pkey_algo = "rsa";
+	ctx->cert->sig->encoding = "pkcs1";
 	ctx->algo_oid = ctx->last_oid;
 	return 0;
 }

