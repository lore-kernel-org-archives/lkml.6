Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-524998-1519316550-2-17971689625718267061
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
    t=1519316550; b=OB3eaRHa3AdIce5H7YyzMB2hWBuvS0RL5VM748sFq2q14Vw
    X4X+6lNVsvRTHZO98Hxk2oLg5FgEyLzm/zrvEDOYdN0jmZdOkOTg9fMFG2WKeeqh
    Ul8JgrPqT+9C9qI4WoRWyV5aXeglQEkpEXXdRuamk5LLxRwhAABcHtHaRfRmecrc
    T8+Ogi7wKSMNckAUP+vwsTu2CdkJiDuQ994io1m49fIHx1KXGEo19QAVsq1cY12Y
    nN25VCrBYE4H1HYVC07UZu9dme2deppoFRwwvJz88QpwIKdhNaFjkbunEdMsjf7m
    71iZe12IJtXHPmfsM4dApc3WAzdFrlo1l3czgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519316550; bh=Qpj5LHAEDMzukxK2NFsU3ytaH5qwcuWcyxFM+YvOMFw=; b=M
    XeRfP4FU42Kx6AVgvj3cRmdrjCO1+eHRlEuZuPjWrjsM4GJ0Y/bOA7G9UWFgCr8V
    b+q7O0IDVPWG0k/6N6PEjtX7SNuk2ye1aoFJEgi7aF8V7HnmeuXMgMZEveP96sGp
    2yemoRePetcC2u27B4HSm3s9XJ0nKOh++MLpXq0RiyCsuzB8tFcOeHF7LoualngZ
    tfvKtnheySK7wLkc3gkwfy/FhefWVZGPKFl7001F+Kd4bVeJekHxTchKLFgTcdrm
    IPfOZ42e9INOP7bBHM9QZ5N3VX/5/68g3cAHa9ogKzRg6oOSatcxsgXltX0jivGE
    0C8581lYW2E7mkRXMyPrA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeBVQUx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:20:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeBVQUv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:20:51 -0500
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 3/6] PKCS#7: fix direct verification of SignerInfo signature
Date: Thu, 22 Feb 2018 16:20:47 +0000
Message-Id: <151931644754.27713.14995018428445770576.stgit@warthog.procyon.org.uk>
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

If none of the certificates in a SignerInfo's certificate chain match a
trusted key, nor is the last certificate signed by a trusted key, then
pkcs7_validate_trust_one() tries to check whether the SignerInfo's
signature was made directly by a trusted key.  But, it actually fails to
set the 'sig' variable correctly, so it actually verifies the last
signature seen.  That will only be the SignerInfo's signature if the
certificate chain is empty; otherwise it will actually be the last
certificate's signature.

This is not by itself a security problem, since verifying any of the
certificates in the chain should be sufficient to verify the SignerInfo.
Still, it's not working as intended so it should be fixed.

Fix it by setting 'sig' correctly for the direct verification case.

Fixes: 757932e6da6d ("PKCS#7: Handle PKCS#7 messages that contain no X.509 certs")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/pkcs7_trust.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 1f4e25f10049..598906b1e28d 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -106,6 +106,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 		pr_devel("sinfo %u: Direct signer is key %x\n",
 			 sinfo->index, key_serial(key));
 		x509 = NULL;
+		sig = sinfo->sig;
 		goto matched;
 	}
 	if (PTR_ERR(key) != -ENOKEY)
