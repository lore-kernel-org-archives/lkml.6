Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C630C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797220859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="P/TRbXXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392459AbfAPLMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:12:25 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:26740 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389696AbfAPLMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547637119;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=pSfduHW8di1A56/Fcff8gBYrw/e7p9TbH/mFZ8R2KMQ=;
        b=P/TRbXXWA4LEkLQ0T188OtZ1APiZ4lc6V0l7tgCR/oP9igZvP0eCy3F0/I/s+oRFHu
        DpMoNhUo9xSnGQal7JKvF4tnFtUfHUHkAm1DBgHcBS9fyWCd0WLbBEM0/c17P5E/zc7t
        Hu+j3rxQnSplrFXmRpkasddFEF17lxwRZ54dKgG2ZmkGys93dVseJHhLvOAvVBoms8ms
        TGuTmH6jpskSxaERLroDx1vC57HSHiEECPDOD7Mu16Z4yYN10v39crpU0tAAfzIqOvL0
        nk5gqpwUhHTv5FlQsxJbroHYMHod/VUAi85TlT/IM74tm0Hf54vwUMMgkjpKhu6QHXXp
        I6nQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWgdNs16dfA/c7fW145n"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 309bcfv0GBBg4Ne
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 16 Jan 2019 12:11:42 +0100 (CET)
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
Subject: [PATCH v2 1/6] crypto: add template handling for RNGs
Date:   Wed, 16 Jan 2019 12:07:34 +0100
Message-ID: <61907509.O7QvflLhaU@positron.chronox.de>
In-Reply-To: <2082192.jPI8ve1O8G@positron.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <9733066.Vrs4h5eWcW@positron.chronox.de> <2082192.jPI8ve1O8G@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds ability to register templates for pseudo random number generators
(PRNG). PRNGs are "meta" mechanisms using raw cipher primitives. Thus,
PRNGs can now be implemented as templates to allow the complete
flexibility the kernel crypto API provides.

The RNG API provides access to the PRNG algorithms without an entropy
management.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/rng.c                  | 44 +++++++++++++++++++++++++++++++++++
 include/crypto/internal/rng.h | 26 +++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/crypto/rng.c b/crypto/rng.c
index 33c38a72bff5..da4fd03c0acd 100644
--- a/crypto/rng.c
+++ b/crypto/rng.c
@@ -64,6 +64,25 @@ static int crypto_rng_init_tfm(struct crypto_tfm *tfm)
 	return 0;
 }
 
+static inline struct rng_alg *__crypto_rng_alg(struct crypto_alg *alg)
+{
+	return container_of(alg, struct rng_alg, base);
+}
+
+static inline struct rng_instance *rng_instance(
+	struct crypto_instance *inst)
+{
+	return container_of(__crypto_rng_alg(&inst->alg),
+			    struct rng_instance, alg);
+}
+
+static void crypto_rng_free_instance(struct crypto_instance *inst)
+{
+	struct rng_instance *rng = rng_instance(inst);
+
+	rng->free(rng);
+}
+
 static unsigned int seedsize(struct crypto_alg *alg)
 {
 	struct rng_alg *ralg = container_of(alg, struct rng_alg, base);
@@ -102,6 +121,7 @@ static void crypto_rng_show(struct seq_file *m, struct crypto_alg *alg)
 static const struct crypto_type crypto_rng_type = {
 	.extsize = crypto_alg_extsize,
 	.init_tfm = crypto_rng_init_tfm,
+	.free = crypto_rng_free_instance,
 #ifdef CONFIG_PROC_FS
 	.show = crypto_rng_show,
 #endif
@@ -229,5 +249,29 @@ void crypto_unregister_rngs(struct rng_alg *algs, int count)
 }
 EXPORT_SYMBOL_GPL(crypto_unregister_rngs);
 
+static int rng_prepare_alg(struct rng_alg *alg)
+{
+	struct crypto_alg *base = &alg->base;
+
+	base->cra_type = &crypto_rng_type;
+	base->cra_flags &= ~CRYPTO_ALG_TYPE_MASK;
+	base->cra_flags |= CRYPTO_ALG_TYPE_RNG;
+
+	return 0;
+}
+
+int rng_register_instance(struct crypto_template *tmpl,
+			  struct rng_instance *inst)
+{
+	int err;
+
+	err = rng_prepare_alg(&inst->alg);
+	if (err)
+		return err;
+
+	return crypto_register_instance(tmpl, rng_crypto_instance(inst));
+}
+EXPORT_SYMBOL_GPL(rng_register_instance);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Random Number Generator");
diff --git a/include/crypto/internal/rng.h b/include/crypto/internal/rng.h
index a52ef3483dd7..bfe4482ad336 100644
--- a/include/crypto/internal/rng.h
+++ b/include/crypto/internal/rng.h
@@ -42,4 +42,30 @@ static inline void crypto_rng_set_entropy(struct crypto_rng *tfm,
 	crypto_rng_alg(tfm)->set_ent(tfm, data, len);
 }
 
+struct rng_instance {
+	void (*free)(struct rng_instance *inst);
+	struct rng_alg alg;
+};
+
+static inline struct rng_instance *rng_alloc_instance(
+	const char *name, struct crypto_alg *alg)
+{
+	return crypto_alloc_instance(name, alg,
+			      sizeof(struct rng_instance) - sizeof(*alg));
+}
+
+static inline struct crypto_instance *rng_crypto_instance(
+	struct rng_instance *inst)
+{
+	return container_of(&inst->alg.base, struct crypto_instance, alg);
+}
+
+static inline void *rng_instance_ctx(struct rng_instance *inst)
+{
+	return crypto_instance_ctx(rng_crypto_instance(inst));
+}
+
+int rng_register_instance(struct crypto_template *tmpl,
+			  struct rng_instance *inst);
+
 #endif
-- 
2.20.1




