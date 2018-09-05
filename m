Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F5DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2052073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2052073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIFC1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:27:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbeIFC1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F035E40216E3;
        Wed,  5 Sep 2018 21:54:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371612027EA0;
        Wed,  5 Sep 2018 21:54:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/22] KEYS: Allow the public_key struct to hold a private
 key
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:54:57 +0100
Message-ID: <153618449772.7946.7781296222641718446.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put a flag in the public_key struct to indicate if the structure is holding
a private key.  The private key must be held ASN.1 encoded in the format
specified in RFC 3447 A.1.2.  This is the form required by crypto/rsa.c.

The software encryption subtype's verification and query functions then
need to select the appropriate crypto function to set the key.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/public_key.c |   14 ++++++++++++--
 include/crypto/public_key.h         |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 761bfab352dc..f2dc27897319 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -115,7 +115,12 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
-	ret = crypto_akcipher_set_pub_key(tfm, pkey->key, pkey->keylen);
+	if (pkey->key_is_private)
+		ret = crypto_akcipher_set_priv_key(tfm,
+						   pkey->key, pkey->keylen);
+	else
+		ret = crypto_akcipher_set_pub_key(tfm,
+						  pkey->key, pkey->keylen);
 	if (ret < 0)
 		goto error_free_tfm;
 
@@ -170,7 +175,12 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (!req)
 		goto error_free_tfm;
 
-	ret = crypto_akcipher_set_pub_key(tfm, pkey->key, pkey->keylen);
+	if (pkey->key_is_private)
+		ret = crypto_akcipher_set_priv_key(tfm,
+						   pkey->key, pkey->keylen);
+	else
+		ret = crypto_akcipher_set_pub_key(tfm,
+						  pkey->key, pkey->keylen);
 	if (ret)
 		goto error_free_req;
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 3a1047a0195c..be626eac9113 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -25,6 +25,7 @@
 struct public_key {
 	void *key;
 	u32 keylen;
+	bool key_is_private;
 	const char *id_type;
 	const char *pkey_algo;
 };

