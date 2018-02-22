Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-553228-1519316535-2-6622990790984593673
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
    t=1519316534; b=PawumZCD6HINezsEXddzLskxnZTKKPYYrthfbGElfRNYqFf
    Ou+bqVkUyKgtMIWsM+GndOrxR8vzqrIpU9lE1qj0f8Hu3friEvdKAUodKz3WEYtO
    J6gwLpjYAY65q5HgLrmsGXTtXn+KmkaYuavd0yALSadCYyyiWpRWB05NLHqOspnK
    AcBBGaXLw9RRG0b5bbsbRg1fkmrs/OxCEO9cNuo+LTHcJH8baT0wNBc+OG8Y6mjC
    hegO4Jc4YmH4CPIyJbN46w0N6FNQmfjlbfMEKssvUXhU0g2oJBrCTXWfWucP9dLk
    8EHAL9x8zCHC5zTPdlKJUV9+b9nqikKZPbiPecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519316534; bh=A53B2X7IghRFKRJIEiJOcRjPCD4TKclX/dHbu8CH/OU=; b=e
    u/FNytYGCWlMJxL8/onH09EXJ+AXEWFI+1wq9PxKV3T9OFe9YUKktM6q3oYF0kcH
    gF1jTs1uiJ7TAfbH9ddh0vwC250hInpzSRwLrrjTHPRbyGanHhZmiN5Ulm8cwoZv
    C1L9I2oyHdGI+BVLdESaH5v3IyNKFgACvti1T1uXJkRY8J0iERQeWpo87vBINguX
    mbZJ7WObpbnntaXjjzpbh2ZFNVE615DOGl/6B/FBF6BstBQGdeZsX6Ue4fWO7Aj0
    M6H75p+PFlbmnasVK1nUwD3a2u1fqh5DlPDcggmkIR39h6AvhLE0BisyzWEk3A/3
    4bQASEJYN/ZczdBnANDvw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933395AbeBVQVG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:21:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeBVQVE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:21:04 -0500
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 5/6] X.509: fix NULL dereference when restricting key with unsupported_sig
Date: Thu, 22 Feb 2018 16:21:02 +0000
Message-Id: <151931646253.27713.5857757999911191687.stgit@warthog.procyon.org.uk>
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

The asymmetric key type allows an X.509 certificate to be added even if
its signature's hash algorithm is not available in the crypto API.  In
that case 'payload.data[asym_auth]' will be NULL.  But the key
restriction code failed to check for this case before trying to use the
signature, resulting in a NULL pointer dereference in
key_or_keyring_common() or in restrict_link_by_signature().

Fix this by returning -ENOPKG when the signature is unsupported.

Reproducer when all the CONFIG_CRYPTO_SHA512* options are disabled and
keyctl has support for the 'restrict_keyring' command:

    keyctl new_session
    keyctl restrict_keyring @s asymmetric builtin_trusted
    openssl req -new -sha512 -x509 -batch -nodes -outform der \
        | keyctl padd asymmetric desc @s

Fixes: a511e1af8b12 ("KEYS: Move the point of trust determination to __key_link()")
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/restrict.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 86fb68508952..7c93c7728454 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -67,8 +67,9 @@ __setup("ca_keys=", ca_keys_setup);
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we couldn't find a
  * matching parent certificate in the trusted list, -EKEYREJECTED if the
- * signature check fails or the key is blacklisted and some other error if
- * there is a matching certificate but the signature check cannot be performed.
+ * signature check fails or the key is blacklisted, -ENOPKG if the signature
+ * uses unsupported crypto, or some other error if there is a matching
+ * certificate but the signature check cannot be performed.
  */
 int restrict_link_by_signature(struct key *dest_keyring,
 			       const struct key_type *type,
@@ -88,6 +89,8 @@ int restrict_link_by_signature(struct key *dest_keyring,
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -139,6 +142,8 @@ static int key_or_keyring_common(struct key *dest_keyring,
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -222,9 +227,9 @@ static int key_or_keyring_common(struct key *dest_keyring,
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we
  * couldn't find a matching parent certificate in the trusted list,
- * -EKEYREJECTED if the signature check fails, and some other error if
- * there is a matching certificate but the signature check cannot be
- * performed.
+ * -EKEYREJECTED if the signature check fails, -ENOPKG if the signature uses
+ * unsupported crypto, or some other error if there is a matching certificate
+ * but the signature check cannot be performed.
  */
 int restrict_link_by_key_or_keyring(struct key *dest_keyring,
 				    const struct key_type *type,
@@ -249,9 +254,9 @@ int restrict_link_by_key_or_keyring(struct key *dest_keyring,
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we
  * couldn't find a matching parent certificate in the trusted list,
- * -EKEYREJECTED if the signature check fails, and some other error if
- * there is a matching certificate but the signature check cannot be
- * performed.
+ * -EKEYREJECTED if the signature check fails, -ENOPKG if the signature uses
+ * unsupported crypto, or some other error if there is a matching certificate
+ * but the signature check cannot be performed.
  */
 int restrict_link_by_key_or_keyring_chain(struct key *dest_keyring,
 					  const struct key_type *type,
