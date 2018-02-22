Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-524998-1519316645-2-6873191570473602944
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
    t=1519316645; b=uzZjBMePwrNl/vst8winmxnMP8ZmWz3PevjYvGa+G8BW3KG
    RN+CGl2YguREsEme6C4taY/ZM52xJFCIsaHjF3JQTBfg4ap45rG66T6k9HFYH1TE
    ho5aWVnFJZspKC3PdN3JwvvWnxz7QiJEiQraeXA2dfKzEVTdZ9tggRM9IfYrY8kc
    hqbT/zalFZ430tRGu0Y5zKc+ixR+iegdIY3fOuHn0H/ON24pNgh7JVbF/DesHKIs
    q32LT0pNwm8tJc+75guczRcMw8NMSm/n3iRkd+tdTFSM8FTnkyHBff15AUM/lmud
    wzLkQ1hqO7n0G6KqG22Iwxjd1IRa8wdk1vL5QqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519316645; bh=wcLpE8zKYVFzrkBZaWmTe3ObKsm9jjTm6XfWtpTbjDs=; b=w
    RFzKP0oohGsKBrsO6u9EuObJHROOq4g2DnHE5psC/byusu9bIsUetOaLFRMy1fRL
    wzUXMO3dRnhHndL1axjfZbO1X8GSDabVt4+gHcfAy4+Hh89Cm1yIbxyGF+uE2aje
    XsJql4pJ2CNRmTS+ncC3wtoXOEiH9mz1eOE5wrg7Ok/O+eJ4WVJZyHA66v8MaIGi
    /HaLf/w38DU5riunP1BsYDSymp77umwPrLSTy/nf9AABcZ72CFAEvwXMGbqd8h8X
    6xbFY9msfS4wR9nxEPr871mhY+5JJlrS4g7X+Gv9vz62I0gy8/STKA9XpXKec5O5
    SFIx5jKi5dK3bJalvvTfw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeBVQUk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:20:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933317AbeBVQUg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:20:36 -0500
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 1/6] PKCS#7: fix certificate chain verification
Date: Thu, 22 Feb 2018 16:20:34 +0000
Message-Id: <151931643415.27713.4671836834877309737.stgit@warthog.procyon.org.uk>
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

When pkcs7_verify_sig_chain() is building the certificate chain for a
SignerInfo using the certificates in the PKCS#7 message, it is passing
the wrong arguments to public_key_verify_signature().  Consequently,
when the next certificate is supposed to be used to verify the previous
certificate, the next certificate is actually used to verify itself.

An attacker can use this bug to create a bogus certificate chain that
has no cryptographic relationship between the beginning and end.

Fortunately I couldn't quite find a way to use this to bypass the
overall signature verification, though it comes very close.  Here's the
reasoning: due to the bug, every certificate in the chain beyond the
first actually has to be self-signed (where "self-signed" here refers to
the actual key and signature; an attacker might still manipulate the
certificate fields such that the self_signed flag doesn't actually get
set, and thus the chain doesn't end immediately).  But to pass trust
validation (pkcs7_validate_trust()), either the SignerInfo or one of the
certificates has to actually be signed by a trusted key.  Since only
self-signed certificates can be added to the chain, the only way for an
attacker to introduce a trusted signature is to include a self-signed
trusted certificate.

But, when pkcs7_validate_trust_one() reaches that certificate, instead
of trying to verify the signature on that certificate, it will actually
look up the corresponding trusted key, which will succeed, and then try
to verify the *previous* certificate, which will fail.  Thus, disaster
is narrowly averted (as far as I could tell).

Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed cert checks earlier")
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/pkcs7_verify.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 39e6de0c2761..2f6a768b91d7 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -270,7 +270,7 @@ static int pkcs7_verify_sig_chain(struct pkcs7_message *pkcs7,
 				sinfo->index);
 			return 0;
 		}
-		ret = public_key_verify_signature(p->pub, p->sig);
+		ret = public_key_verify_signature(p->pub, x509->sig);
 		if (ret < 0)
 			return ret;
 		x509->signer = p;
