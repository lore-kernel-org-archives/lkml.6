Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C75BC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E62B20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="R9zxaQ4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392434AbfAPLMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:12:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:16829 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbfAPLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547637120;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=z1JSnWMAdIBaOoX07NP+bwCKYNTj6YxEKLWL5bKCEIo=;
        b=R9zxaQ4ZbtKJVeqA/LKP9r9bKj1vKShb2M/oJuPrsV75zhxLtG+Al1L1b0WFPi06MT
        ImFWZr4owgGcN3Ro+D6P954QjNBjkDbcbbQWIM/PiNeez5zvDVtDYrj2CBuIqGz5bua2
        FF9mwjsheMf9M1LqZOvW/RSnjGTHix3aIwprCqNLPQ4tb03fgdCm+rQ1r/Z961EwjQec
        VfE4MdFQQruwKSs9Y9TVT90Bd7ocwigoYYgeS29ltWOhS+oVWmEc3yb2kgm6DQ8v/eRt
        4mYWaxfn5q2kySDDPjFExHDzowB4CRJj7Ptci/7gP28+KHRz1y4YGQ073dprX8NnIQZi
        SUHw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWgdNs16dfA/c7fW145n"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 309bcfv0GBBD4NM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 16 Jan 2019 12:11:13 +0100 (CET)
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
Subject: [PATCH v2 6/6] crypto: tcrypt - add KDF test invocation
Date:   Wed, 16 Jan 2019 12:09:33 +0100
Message-ID: <8600018.3ZaGsXI4pz@positron.chronox.de>
In-Reply-To: <2082192.jPI8ve1O8G@positron.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <9733066.Vrs4h5eWcW@positron.chronox.de> <2082192.jPI8ve1O8G@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable testing of the SP800-108 and RFC5869 KDFs.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/tcrypt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index e7fb87e114a5..5606e59e80ec 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -2054,6 +2054,14 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("cbc(sm4)");
 		ret += tcrypt_test("ctr(sm4)");
 		break;
+	case 192:
+		ret += tcrypt_test("kdf_ctr(hmac(sha256))");
+		ret += tcrypt_test("kdf_dpi(hmac(sha256))");
+		ret += tcrypt_test("kdf_fb(hmac(sha256))");
+		break;
+	case 193:
+		ret += tcrypt_test("hkdf(hmac(sha256))");
+		break;
 	case 200:
 		test_cipher_speed("ecb(aes)", ENCRYPT, sec, NULL, 0,
 				speed_template_16_24_32);
-- 
2.20.1




