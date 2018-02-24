Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBXQDV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:03:21 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:41518 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeBXQDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:03:20 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 1/3] X.509: unpack RSA signatureValue field from BIT STRING
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <44885af5-b1f5-30cb-5f51-226949cb11a6@maciej.szmigiero.name>
Date: Sat, 24 Feb 2018 17:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signatureValue field of a X.509 certificate is encoded as a BIT STRING.
For RSA signatures this BIT STRING is of so-called primitive subtype, which
contains a u8 prefix indicating a count of unused bits in the encoding.

We have to strip this prefix from signature data, just as we already do for
key data in x509_extract_key_data() function.

This wasn't noticed earlier because this prefix byte is zero for RSA key
sizes divisible by 8. Since BIT STRING is a big-endian encoding adding zero
prefixes has no bearing on its value.

The signature length, however was incorrect, which is a problem for RSA
implementations that need it to be exactly correct (like AMD CCP).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: c26fd69fa009 ("X.509: Add a crypto key parser for binary (DER) X.509 certificates")
Cc: stable@vger.kernel.org
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index ce2df8c9c583..88c26a4538ae 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -249,6 +249,15 @@ int x509_note_signature(void *context, size_t hdrlen,
 		return -EINVAL;
 	}
 
+	if (!strcmp(ctx->cert->sig->pkey_algo, "rsa")) {
+		/* Discard the BIT STRING metadata */
+		if (vlen < 1 || *(const u8 *)value != 0)
+			return -EBADMSG;
+
+		value++;
+		vlen--;
+	}
+
 	ctx->cert->raw_sig = value;
 	ctx->cert->raw_sig_size = vlen;
 	return 0;
