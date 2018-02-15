Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708232-6-2775682526258858993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708232; b=EFT8IH0gBAezAZLa20IzJ5sXAzgpme0ZF5mSujPKnjXAU2m
    Jj9kiEONRB+MvXbm9vxKp55vBmrveqfjKYVq5bwJeqI8AYj8vVzof9lbT78IZILU
    bh0HBUCyBMsacZckZEGw/31QN4fs93r6pUX4C9A5c6VU9NeIdWQGvet4cQSISyPF
    owNrMG8xZ8gGUCF05CL2COSoGe2IBr1JoKn7rs3Npx7TRKk4iXODNdrUMvRJ8hLu
    2I9dIBw+DKBEOVk4bhQfSZknALNbzrfskfs1nTfNi1N8nnlejMmsMpNJ6EYWgR9D
    5cnb20oIu1ktv1sjKQdiVNbCoNtkjF1iQGIGz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708232; bh=58fIRHR8UFspMMwJva0KwqIneo
    syEpKy9CJye+C+HKU=; b=FBHeq2IjS3TWhyruIuer/CmFSsANCy7JGLESCMHNLD
    q+kg46lHtjfGoe41iyKnoxRWpJ7OdLsA4OCfKgiVjcZK0v3J/R3JamWK64Uw5bHb
    iOPJMR5ZCRVQ2P++FN0xU5ykopvK3CMnQMjTUMPCxkc96tuLGK4vmZdFPxzhfLPL
    UU7gZl6doLDrpw0wMfDBQm3sw8gvkowFwxi8/p4mE7qRPtetq5y5wOKzbb9P/QLi
    89pK0xX4Ax5205k58lpl5PDyakAzWyOSkH+E0T+/YJ3lN+iHOAHcv9W+KWTAsthn
    q7WthukSpeDA/EIqtjT6jlZyzpdGkQdRk/3I4atnr+Aw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162764AbeBOPXt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162688AbeBOPXq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 068/108] crypto: cryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:17:05 +0100
Message-Id: <20180215151231.878836858@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 841a3ff329713f796a63356fef6e2f72e4a3f6a3 upstream.

When the cryptd template is used to wrap an unkeyed hash algorithm,
don't install a ->setkey() method to the cryptd instance.  This change
is necessary for cryptd to keep working with unkeyed hash algorithms
once we start enforcing that ->setkey() is called when present.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/cryptd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -654,7 +654,8 @@ static int cryptd_create_hash(struct cry
 	inst->alg.finup  = cryptd_hash_finup_enqueue;
 	inst->alg.export = cryptd_hash_export;
 	inst->alg.import = cryptd_hash_import;
-	inst->alg.setkey = cryptd_hash_setkey;
+	if (crypto_shash_alg_has_setkey(salg))
+		inst->alg.setkey = cryptd_hash_setkey;
 	inst->alg.digest = cryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
