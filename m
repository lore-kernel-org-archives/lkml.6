Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2369F20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="MSQydjtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbfAKTN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:13:59 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:15915 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390316AbfAKTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547234033;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=z1JSnWMAdIBaOoX07NP+bwCKYNTj6YxEKLWL5bKCEIo=;
        b=MSQydjtdFivNpvUE7oCRv0hNtvFzhbhGJfF3I9zH1LZD5PRhdOvI0Q5gX2jTAW6PK0
        EK2TG5Cnwk6fhZGggldxtSaT6bBu0m1NutnZzlrpzWuQbIdDcHr+gSqcEDgJ8oLOwdEM
        1Nrv+h94DWLKobEj0ew9DDZY06Hc3Kouu5g/bg+uWJxRTp26UJIBLsY10fGi1jdStaUo
        x8DX6KR771bszv6QVw8idxr1MyL9DiY8B6AhugGSswpzcdoJ80Pu8bcZcvflRJ2szEeB
        EfXEUBDPupEAmTKDChZ8aWPaVXa8XbEaZMyiGij6iJeIQfCNmrvL4Q1kslmSCPKF1fJs
        e0tQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaLvSbdkg="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv0BJDQfl8
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 11 Jan 2019 20:13:26 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH 6/6] crypto: tcrypt - add KDF test invocation
Date:   Fri, 11 Jan 2019 20:11:12 +0100
Message-ID: <2181239.cWAz3ldHXA@positron.chronox.de>
In-Reply-To: <9733066.Vrs4h5eWcW@positron.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <20190109082103.GA8586@sol.localdomain> <9733066.Vrs4h5eWcW@positron.chronox.de>
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




