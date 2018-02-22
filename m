Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-524998-1519316540-2-14032205252271716370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519316540; b=aKHE1GHR1PwbFPkYohMHhtmhgQ5mFQ85ppupA7mOjYn1NeX
    YQ3kE+VffYl/dbotsCDa1hb8JCq37tVn6hCPycKgqcUh6d34FAjfgWlxOLBQ0qht
    jBpIoSTGJS8lmsGCYkDE8FV52v046fNLbUTesbIVybcZPy7gmQhnq6oYo3TPpIB3
    A4VrvTrPlZHNBe9YHOecF5VV9cI8QmeFezEfoCubxV0PuGlDKJwzvgSqiQwBoIsB
    PTpEwMTdCaXzS5oaHRhD9e3rtKyQ4Isxhr54FWzAKzAjPurEv3eWSJfsxQY9IBVr
    IyD+RUWjFdR17euuDcFr8DjC/8+J6FXZTVXRHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519316540; bh=8F1aLesqNETVIOIuy2z+zVr7gfAKhjharxa1qSBjLT0=; b=R
    C/e1Uf2kuFvYrrbbQYeUu510SJYscmUCObLdpPC3qSh1EOZ/YnJhFc4P/bGiE0TY
    58NcIAX2j0q0NoQAR9lt0uupYFaKJfvo8VCr3Rfo2MC7gTKfPrSR3Hf0wrt9sskn
    jy0Gi1Pg8kIispi1MSjs0OX9rTscxM5LxN3D6+qdMjZ/P9qU7vV2KdYGn9NlLNJa
    J0Fle8xS4O8lVJqIupzZuU0MwNXVNVWpDW/gzywqhuAFz5GPdwZ1KC1Q1fOmr576
    zSr8hbxOhjrUUP1tSPzDC+tPSLrTWJ4s1Ef1cfeeFTevt4ohBeWIt9+oxUiSsm4N
    7XxsWgDtcVZb76natgN5A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933169AbeBVQU7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:20:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeBVQU5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:20:57 -0500
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4/6] X.509: fix BUG_ON() when hash algorithm is unsupported
Date: Thu, 22 Feb 2018 16:20:55 +0000
Message-Id: <151931645546.27713.15009973131656269423.stgit@warthog.procyon.org.uk>
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United Kingdom. Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
References: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The X.509 parser mishandles the case where the certificate's signature's
hash algorithm is not available in the crypto API.  In this case,
x509_get_sig_params() doesn't allocate the cert->sig->digest buffer;
this part seems to be intentional.  However,
public_key_verify_signature() is still called via
x509_check_for_self_signed(), which triggers the 'BUG_ON(!sig->digest)'.

Fix this by making public_key_verify_signature() return -ENOPKG if the
hash buffer has not been allocated.

Reproducer when all the CONFIG_CRYPTO_SHA512* options are disabled:

    openssl req -new -sha512 -x509 -batch -nodes -outform der \
        | keyctl padd asymmetric desc @s

Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed cert checks earlier")
Reported-by: Paolo Valente <paolo.valente@linaro.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/public_key.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index de996586762a..e929fe1e4106 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -79,9 +79,11 @@ int public_key_verify_signature(const struct public_key *pkey,
 
 	BUG_ON(!pkey);
 	BUG_ON(!sig);
-	BUG_ON(!sig->digest);
 	BUG_ON(!sig->s);
 
+	if (!sig->digest)
+		return -ENOPKG;
+
 	alg_name = sig->pkey_algo;
 	if (strcmp(sig->pkey_algo, "rsa") == 0) {
 		/* The data wangled by the RSA algorithm is typically padded
