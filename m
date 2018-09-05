Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDC5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFF02073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFF02073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeIFC04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:26:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727707AbeIFC0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:26:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DEEC8575F;
        Wed,  5 Sep 2018 21:54:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4262E2166BA1;
        Wed,  5 Sep 2018 21:54:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/22] KEYS: Make the X.509 and PKCS7 parsers supply the sig
 encoding type
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:54:44 +0100
Message-ID: <153618448451.7946.79126788153992612.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 05 Sep 2018 21:54:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 05 Sep 2018 21:54:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the X.509 and PKCS7 parsers fill in the signature encoding type field
recently added to the public_key_signature struct.

Signed-off-by: David Howells <dhowells@redhat.com>
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

