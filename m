Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518708892-2-17262205441628177290
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
    t=1518708891; b=rD9DZ3VOIExRVf7+5JetgKRjg6hiQTDc1pxd6FxikpuG1x7
    dv9uWT2TiVuC8xZrI7fiX4HMFKRKcKeR13CuCUykX2jsymwvdhYykvcuHc0KdxEu
    S6cd1l2Kpd4FnHSib+9gLpB33XWU3DHtgJZAexcsQ5EcStkS0jVoW7sqPU1iAY8i
    dKcHhXAdH43glKalM0KWMvvKCYKtKA888hDVqG82l6F16EgSR54I2rAqPV1vEV+X
    wK5Mnclm5RU4qFYXR/24mLi3rguYvhz7Ix2HA6sFAg/Cwpj/WDqSRPwUcShgjTix
    O0bxCjfORWSTy+fRBnC7ighvFUAYJILEHIX+CTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708891; bh=yiwGUdV4mQCvPKlg4ZI6pxfVx2
    Alc5EWP4MF/acepUQ=; b=Acv7FVkQb4ES6w92kjxpMYpNqPjENnGbkhwywJ3ESM
    2tFm71b+6H4/+YsIdUi6B0GhsIvb5LaQJDr55nUiz6c1buSd5tGbiWTkuCmW0qcD
    pxWvu317UsElR8gl86IUJWFqnaYISNgZ2wuvR9ukyA1fclcRKe/j+cMPPC1Q8Gdy
    q9b7CqASyGaT+HWIGP1vFqN16i4yrSAor6Iqc+3SihIou4k7d3s95fJ7EgZIUYlm
    N6vej7DZh65KLSwilBisz8HrRQp0xz4zVS1GUkcyGStPutrafJEmGG0QE8y3dDRa
    Cs0gNhvsoE7Sr6Yq02QUsHFp3ZGzIuDXYAvjluVjOU+g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165145AbeBOPep (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:34:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165143AbeBOPen (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:34:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 115/195] crypto: cryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:16:46 +0100
Message-Id: <20180215151711.453276487@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -913,7 +913,8 @@ static int cryptd_create_hash(struct cry
 	inst->alg.finup  = cryptd_hash_finup_enqueue;
 	inst->alg.export = cryptd_hash_export;
 	inst->alg.import = cryptd_hash_import;
-	inst->alg.setkey = cryptd_hash_setkey;
+	if (crypto_shash_alg_has_setkey(salg))
+		inst->alg.setkey = cryptd_hash_setkey;
 	inst->alg.digest = cryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
