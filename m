Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-524998-1519316635-2-498617369235056237
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
    t=1519316634; b=roUFNmJKiqt97/st5YnEmpVwLX4GiECbYGEg8bJbv5dkmbq
    Bywjll2zZx6RgerjwCEPAdcIiLt2hjqbMEbbR0ayxAX/TJDih7qTRqgGoBGKcG+F
    xCcbjLlnbp6c5ZwidFodtMwkBm5cvfRJ+97WySy8RFEATK4jOaxi9qe917cp5VcB
    0xOvlthqZTuVGh7dFYXBxthj+Awr+ezM4TRcOFhwsl8bV1HASaP/RcLCoPSmnNdg
    ZbFrPDfmVoGA4C62e7H01KOxKOnkKRIgHchnMhrvPRWgjKiojp0+7BnmOpCWNvZ4
    KZG2XtdpsWgS5aCK3vRr3diKVTCDMcyVC0DKjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519316634; bh=Lk7Q4ZOsUyf8FMN8jyiPm+jIOhWw9ysyaPVw3/OhVxo=; b=f
    fPsOzdbLE+MbTzibiKFkCoqBGbau9/LyeieIYBPSbEPsL30gWpNppx38kVeUOogU
    q8Y8+bgptoslvCYuJJ5nAlo5Zj9JnHif7sCHF1z1KECg4y9Jnmlxl1b/pWufqpxc
    oeF0Iff2nsYY9NTXVfxwhlEQuqrhqLsxmgu5KMZkJJg1g6l2BB4KGv4Ffz2WgQ4O
    XW01Wn+5EY9QLEKduRrV/beBsmIZWAISbRNwlmg5Oc3qGkXi/K1ifPXiPVxz4xN8
    ym4YXQyGCqh7GUNF44z6uc6XZx5Flb6k2BintmFK3nsU5dpOs8W0u81dfOc3G+OC
    EJleQ4FncfYl+0rWSbTQw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933286AbeBVQUp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:20:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeBVQUn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:20:43 -0500
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 2/6] PKCS#7: fix certificate blacklisting
Date: Thu, 22 Feb 2018 16:20:41 +0000
Message-Id: <151931644086.27713.11709941422438272479.stgit@warthog.procyon.org.uk>
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

If there is a blacklisted certificate in a SignerInfo's certificate
chain, then pkcs7_verify_sig_chain() sets sinfo->blacklisted and returns
0.  But, pkcs7_verify() fails to handle this case appropriately, as it
actually continues on to the line 'actual_ret = 0;', indicating that the
SignerInfo has passed verification.  Consequently, PKCS#7 signature
verification ignores the certificate blacklist.

Fix this by not considering blacklisted SignerInfos to have passed
verification.

Also fix the function comment with regards to when 0 is returned.

Fixes: 03bb79315ddc ("PKCS#7: Handle blacklisted certificates")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/pkcs7_verify.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 2f6a768b91d7..97c77f66b20d 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -366,8 +366,7 @@ static int pkcs7_verify_one(struct pkcs7_message *pkcs7,
  *
  *  (*) -EBADMSG if some part of the message was invalid, or:
  *
- *  (*) 0 if no signature chains were found to be blacklisted or to contain
- *	unsupported crypto, or:
+ *  (*) 0 if a signature chain passed verification, or:
  *
  *  (*) -EKEYREJECTED if a blacklisted key was encountered, or:
  *
@@ -423,8 +422,11 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 
 	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
 		ret = pkcs7_verify_one(pkcs7, sinfo);
-		if (sinfo->blacklisted && actual_ret == -ENOPKG)
-			actual_ret = -EKEYREJECTED;
+		if (sinfo->blacklisted) {
+			if (actual_ret == -ENOPKG)
+				actual_ret = -EKEYREJECTED;
+			continue;
+		}
 		if (ret < 0) {
 			if (ret == -ENOPKG) {
 				sinfo->unsupported_crypto = true;
