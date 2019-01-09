Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A79C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C71620883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="p+yQ60WG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfAIKSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:18:21 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:26017 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfAIKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547029095;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8Gpp2jSMjw9TDIVQ8ToVBHpCNa7x4sUYs9CLaHwsbeo=;
        b=p+yQ60WG1fr6sW+UXfAh2M9cGjaQTTGC+JVTEZCujEPnkf7xI9a2EVFE3mP1DHwh08
        /Df5zFE9oFTOGtmLK0VWfFObZxalPGshkiNDocGpt7MP5Su/xifZufLFYINjuasbN/7f
        Lle233JAriSQmvo88YV+LHK3NIBNUprJUOdMKrRuJoGOq5Ooj2J308YnTVbof+7bPBKV
        dr3DXAcdLhb7ywfvjSIC1NaOQ6SDcV5/guO8qox0SILG7dqxL0Hf+g3zOX2/xUzwN2eA
        2N8FAvexEt2fujVc/TgJZGhTZ0qFZb1IUHSXSgrMOsmgNW1DEkHhWb98Zl5T1+OXgv0t
        1UXQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9x24dNoX176cAx2h1qXJ5"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 SBL|AUTH)
        with ESMTPSA id 309bcfv09AHoPOB
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 11:17:50 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date:   Wed, 09 Jan 2019 11:17:45 +0100
Message-ID: <2344329.gmPllosFfp@tauon.chronox.de>
In-Reply-To: <20190109082103.GA8586@sol.localdomain>
References: <20190103143227.9138-1-jlee@suse.com> <1894062.aDvIuj92vB@tauon.chronox.de> <20190109082103.GA8586@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 09:21:04 CET schrieb Eric Biggers:

Hi Eric,
> 
> FWIW, it's been very slow going since I've been working on other projects
> and I also need to be very sure to get the API changes right, but I still
> plan to change the KDF in fscrypt (a.k.a. ext4/f2fs/ubifs encryption) to
> HKDF-SHA512 as part of a larger set of improvements to how fscrypt
> encryption keys are managed. I sent the last patchset a year ago
> (https://marc.info/?l=linux-fsdevel&m=150879493206257) but I'm working to
> revive it.  In the work-in-progress version in my git tree, this is the
> commit that adds a HKDF implementation as fs/crypto/hkdf.c:
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?i
> d=e8a78767131c9717ee838f0c4e307948d65a4427 It basically just wraps a
> crypto_shash for "hmac(sha512)".
> 
> I'd be fine with using a common implementation instead, provided that it
> gives the same functionality, including supporting user-specified salt and
> application-specific info strings, and isn't slower or more complex to use.
> 
> (This comment is solely on the tangential discussion about KDF
> implementations; I've not looked at the hibernation image encryption stuff
> yet.)

Thanks for the clarification. I have started a generic HKDF implementation for 
the kernel crypto API which lead to the questions above. I would then also try 
to provide a HKDF proposal.

To use the (H)KDF, I currently envision 2 calls apart from alloc/free. The 
following code would serve as an example.

 * Example without proper error handling:
 *      char *keying_material = "\x00\x11\x22\x33\x44\x55\x66\x77";
 *      char *label_context = "\xde\xad\xbe\xef\x00\xde\xad\xbe\xef";
 *      kdf = crypto_alloc_rng(name, 0, 0);
 *      crypto_rng_reset(kdf, keying_material, 8);
 *      crypto_rng_generate(kdf, label_context, 9, outbuf, outbuflen);

That hopefully should be simple enough.

For HKDF, as mentioned, I would envision to use a struct instead of a char * 
for the label_context to communicate IKM, Salt, and the label/info 
information.

Ciao
Stephan


