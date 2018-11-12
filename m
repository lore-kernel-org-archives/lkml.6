Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD66C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8D223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8D223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeKLUYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:24:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbeKLUYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:24:04 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A3F6B8745C475;
        Mon, 12 Nov 2018 10:31:23 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.42) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 12 Nov 2018 10:31:19 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
Subject: [RFC][PATCH 07/12] KEYS: Provide PGP key description autogeneration
Date:   Mon, 12 Nov 2018 11:24:18 +0100
Message-ID: <20181112102423.30415-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112102423.30415-1-roberto.sassu@huawei.com>
References: <20181112102423.30415-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Provide a facility to autogenerate the name of PGP keys from the contents
of the payload.  If add_key() is given a blank description, a description
is constructed from the last user ID packet in the payload data plus the
last 8 hex digits of the key ID.  For instance:

	keyctl padd asymmetric "" @s </tmp/key.pub

might create a key with a constructed description that can be seen in
/proc/keys:

2f674b96 I--Q---     1 perm 39390000     0     0 crypto    \
			Sample kernel key 31f0ae93: PGP.RSA 31f0ae93 []

Changelog

v0:
- fix style issues (Roberto Sassu)

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp_public_key.c | 46 ++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pgp_public_key.c b/crypto/asymmetric_keys/pgp_public_key.c
index a5ce146a1250..371a3e721f69 100644
--- a/crypto/asymmetric_keys/pgp_public_key.c
+++ b/crypto/asymmetric_keys/pgp_public_key.c
@@ -35,6 +35,9 @@ struct pgp_key_data_parse_context {
 	struct public_key *pub;
 	unsigned char *raw_fingerprint;
 	char *fingerprint;
+	const char *user_id;
+	size_t user_id_len;
+	size_t fingerprint_len;
 };
 
 /*
@@ -155,6 +158,7 @@ static int pgp_generate_fingerprint(struct pgp_key_data_parse_context *ctx,
 	if (ret < 0)
 		goto cleanup_raw_fingerprint;
 
+	ctx->fingerprint_len = digest_size * 2;
 	fingerprint = kmalloc(digest_size * 2 + 1, GFP_KERNEL);
 	if (!fingerprint)
 		goto cleanup_raw_fingerprint;
@@ -199,6 +203,13 @@ static int pgp_process_public_key(struct pgp_parse_context *context,
 
 	kenter(",%u,%u,,%zu", type, headerlen, datalen);
 
+	if (type == PGP_PKT_USER_ID) {
+		ctx->user_id = data;
+		ctx->user_id_len = datalen;
+		kleave(" = 0 [user ID]");
+		return 0;
+	}
+
 	if (ctx->fingerprint) {
 		kleave(" = -ENOKEY [already]");
 		return -EBADMSG;
@@ -291,13 +302,46 @@ static int pgp_key_parse(struct key_preparsed_payload *prep)
 	kenter("");
 
 	memset(&ctx, 0, sizeof(ctx));
-	ctx.pgp.types_of_interest = (1 << PGP_PKT_PUBLIC_KEY);
+	ctx.pgp.types_of_interest = (1 << PGP_PKT_PUBLIC_KEY) |
+				    (1 << PGP_PKT_USER_ID);
 	ctx.pgp.process_packet = pgp_process_public_key;
 
 	ret = pgp_parse_packets(prep->data, prep->datalen, &ctx.pgp);
 	if (ret < 0)
 		goto error;
 
+	if (ctx.user_id && ctx.user_id_len > 0) {
+		/* Propose a description for the key
+		 * (user ID without the comment)
+		 */
+		size_t ulen = ctx.user_id_len, flen = ctx.fingerprint_len;
+		const char *p;
+
+		p = memchr(ctx.user_id, '(', ulen);
+		if (p) {
+			/* Remove the comment */
+			do {
+				p--;
+			} while (*p == ' ' && p > ctx.user_id);
+			if (*p != ' ')
+				p++;
+			ulen = p - ctx.user_id;
+		}
+
+		if (ulen > 255 - 9)
+			ulen = 255 - 9;
+		prep->description = kmalloc(ulen + 1 + 8 + 1, GFP_KERNEL);
+		ret = -ENOMEM;
+		if (!prep->description)
+			goto error;
+		memcpy(prep->description, ctx.user_id, ulen);
+		prep->description[ulen] = ' ';
+		memcpy(prep->description + ulen + 1,
+		       ctx.fingerprint + flen - 8, 8);
+		prep->description[ulen + 9] = 0;
+		pr_debug("desc '%s'\n", prep->description);
+	}
+
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
 	prep->payload.data[asym_subtype] = &public_key_subtype;
-- 
2.17.1

