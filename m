Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676782-2-6853210614904572089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676782; b=JQ5ekU55IYAtRzfqeauRF6PpqknunSOR/XhDFQasTrIPJDc
    krceI5W4ddSybejCowAVIuTOemvASZn0oVULdgIOlD04pt1fUsIHYsawD0bUGdhs
    5Aolgtwt595k4MJOCX5x6biJDY0aq6FkU+og6tIkrSmHkcZOgLh0hs+261McSwuP
    916S5No8uGoN13dW9YY05ig0IZRJoUFfHoJA2wpLtXSiJLMIIsql8IUQmUQCTxnQ
    bVX8fZquLaIlt2YTYNEU9SMs/M+xzgY7xTfdR2Gdbw+bptSVhneX56VqOHIUS/de
    oqLthk5qQmzJgETxA0USUO7zytw3zFaSoo3uuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676782; bh=4AQMnCr2waf20oaeK3AyCqVCPq
    GMX00vnFrEzPf/tDI=; b=Z9iyozMFNtW06N5uLATsP4AqFPgNHttNDyfujf6CTC
    OXtf1AaIwvWbtQmGKnywI4agKip30YQDwYmllI6oc2OpqZRldks55NbQcNSoUFui
    8mZqviDKr/MAeodQsGT5ika7DedVwUkQWjOFxMEGjiXTrnB3Uart/rlrSWhAFqDW
    lLLXvdfZBM8czW33JMhO0xAuUNHikXk11i0Zg5syxViI03csIuuY0xjcADS4RsEE
    XSKpmZ/3oxyYtGVfuXfuxALs3dUC7g4B74GoTb9tA8ViSL+vny73zBeAhH4Q7iCk
    RxD2UeY7XEPanWzgxULgE8MGHJvN3hJK25IlSP8WcwOA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeBZU0Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:26:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeBZU0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:26:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 4.15 12/64] X.509: fix NULL dereference when restricting key with unsupported_sig
Date: Mon, 26 Feb 2018 21:21:49 +0100
Message-Id: <20180226202153.962932820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 4b34968e77ad09628cfb3c4a7daf2adc2cefc6e8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/asymmetric_keys/restrict.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

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
@@ -88,6 +89,8 @@ int restrict_link_by_signature(struct ke
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -139,6 +142,8 @@ static int key_or_keyring_common(struct
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -222,9 +227,9 @@ static int key_or_keyring_common(struct
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
@@ -249,9 +254,9 @@ int restrict_link_by_key_or_keyring(stru
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
