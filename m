Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09378C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F5220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="n7SLib3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbfAKTOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:14:08 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.174]:14454 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390318AbfAKTN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547234033;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=4AYi+MkUrKf+lfwSEQQdfE9a2fKEILbeYVFC8+EZ1GY=;
        b=n7SLib3xWjsNanqT0jce6PpC5tZ72dCLOYHMxw1PKMsbdrsVMvXp1j25tF+M9wXzuT
        kwB4XDVg5l7kvE/2sI+7pno9qsy7Bz9KgzV0h70jyNAX67Bw4NnQXIrMvGvEjbK0dj8s
        KIXqP/4Ezx6pjxc7wM4tZtmljy+90/zLYbXazCN/NkcJMjq7xCtfbVUvxD17Ee0uJYy1
        dDJlX4aWKo/nE9Po8YcQSkbNTd/yt5nxBf0iozEFLMDg/RYooSGMvQB2ZZmcsNI3YSd3
        1NbO6/0F4kNZT8xgg951EWCKimy3fXQAqJbqZhWXJWfipxtX7rHGYjiLQfPB4kgiSABh
        zd1g==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaLvSbdkg="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv0BJDXflE
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 11 Jan 2019 20:13:33 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
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
Subject: [PATCH 0/6] General Key Derivation Function Support
Date:   Fri, 11 Jan 2019 20:08:16 +0100
Message-ID: <9733066.Vrs4h5eWcW@positron.chronox.de>
In-Reply-To: <20190109082103.GA8586@sol.localdomain>
References: <20190103143227.9138-1-jlee@suse.com> <1894062.aDvIuj92vB@tauon.chronox.de> <20190109082103.GA8586@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert, Eric,

key derivation functions behave like a random number generator requiring
a seed and can generate arbitrarily-sized bit sequences. As KDFs wrap
ciphers, the first patch adds template support for the RNG part of the
kernel crypto API. This allows the KDFs to be implemented as templates.

The patches two through five add different KDFs. The immediate use in
the kernel are:

- SP800-108: security/keys/dh.c

- HKDF: As Eric Biggers outlined, he wants to use HKDF for Ext4 FBE

Other areas of the kernel implement KDFs which should be migrated to the
common code base offered with this patch.

The last patch adds the KDF invocation to tcrypt to allow an immediate
test invocation of the KDFs which is at least needed for FIPS 140-2
compliance where the tcrypt module is insmod'ed during boot time to
trigger the self tests.

Eric, considering your request for supporting parallel use of HKDF, I
instantiate the HMAC twice: once for the extract and once for the expand
phase. The idea is that an extract operation does not collide too much
with the expand operation (when using one instance of HMAC, the extract
phase would invoke setkey with the salt and thus affect the expand phase).
Though, the final extract phase setkey call with the PRK is non-atomic (at
least in the software HMAC implementation). Thus, the caller would need
to guarantee to invoke the extract phase while no expand phase operation
is performed. So, maintaining two HMAC instances is not really required
after all. What is your take on that?

Stephan Mueller (6):
  crypto: add template handling for RNGs
  crypto: kdf - SP800-108 Key Derivation Function
  crypto: kdf - add known answer tests
  crypto: hkdf - RFC5869 Key Derivation Function
  crypto: hkdf - add known answer tests
  crypto: tcrypt - add KDF test invocation

 crypto/Kconfig                |  13 +
 crypto/Makefile               |   2 +
 crypto/hkdf.c                 | 290 ++++++++++++++++++++
 crypto/kdf.c                  | 492 ++++++++++++++++++++++++++++++++++
 crypto/rng.c                  |  44 +++
 crypto/tcrypt.c               |   8 +
 crypto/testmgr.c              | 258 ++++++++++++++++++
 crypto/testmgr.h              | 225 ++++++++++++++++
 include/crypto/internal/rng.h |  26 ++
 9 files changed, 1358 insertions(+)
 create mode 100644 crypto/hkdf.c
 create mode 100644 crypto/kdf.c

-- 
2.20.1




