Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B66FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A11920859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="AYbkWyCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392448AbfAPLML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:12:11 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:28424 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392416AbfAPLMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547637124;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=eesP4mykcRiBPadlebKcR6prmgo/1n8B4uV1dOGI9ZY=;
        b=AYbkWyCRe9bf4v42uSA1XjZcCAcGjFNCDelU7Zn9Ts3xKLs64gtr00dn0vz+TJ1q2u
        uenqOv4gE9cZT6rttzcanafjpWcjMNPW3FXCl6BLBIrovtREcD4pxs2aXDZjXioUWm6x
        rpAPQwk24LR/iB3TzmqSc6DQl8f2RWVvK6sUsTB1qzfB3Qn/VACL5Pc/maqycDb0pNVd
        CTtOxLjoGLKpRAccQa16d7wyS+XzmTeMvXu3DoSjAXbh2KV9GHEEADz/1rfwpjnencj3
        Ynjo53rf5+waTuvJxaYywqRsTfxAjkATA9aBdpFU5C1I+psMH5Zj8BE+7X2UD3pjbdCx
        0f3w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWgdNs16dfA/c7fW145n"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 309bcfv0GBBm4Ng
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 16 Jan 2019 12:11:48 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH v2 0/6] General Key Derivation Function Support
Date:   Wed, 16 Jan 2019 12:06:54 +0100
Message-ID: <2082192.jPI8ve1O8G@positron.chronox.de>
In-Reply-To: <9733066.Vrs4h5eWcW@positron.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <20190109082103.GA8586@sol.localdomain> <9733066.Vrs4h5eWcW@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v2:
* Incorporation of all comments from Eric Biggers

Stephan Mueller (6):
  crypto: add template handling for RNGs
  crypto: kdf - SP800-108 Key Derivation Function
  crypto: kdf - add known answer tests
  crypto: hkdf - HMAC-based Extract-and-Expand KDF
  crypto: hkdf - add known answer tests
  crypto: tcrypt - add KDF test invocation

 crypto/Kconfig                |  13 +
 crypto/Makefile               |   2 +
 crypto/hkdf.c                 | 272 +++++++++++++++++++
 crypto/kdf_sp800108.c         | 491 ++++++++++++++++++++++++++++++++++
 crypto/rng.c                  |  44 +++
 crypto/tcrypt.c               |   8 +
 crypto/testmgr.c              | 245 +++++++++++++++++
 crypto/testmgr.h              | 198 ++++++++++++++
 include/crypto/internal/rng.h |  26 ++
 9 files changed, 1299 insertions(+)
 create mode 100644 crypto/hkdf.c
 create mode 100644 crypto/kdf_sp800108.c

-- 
2.20.1




