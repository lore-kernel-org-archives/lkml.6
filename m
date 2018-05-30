Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeE3LOO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:14:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60719 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752080AbeE3LH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:29 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.333545401@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 043/153] crypto: cryptd - pass through absence of
 ->setkey()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 841a3ff329713f796a63356fef6e2f72e4a3f6a3 upstream.

When the cryptd template is used to wrap an unkeyed hash algorithm,
don't install a ->setkey() method to the cryptd instance.  This change
is necessary for cryptd to keep working with unkeyed hash algorithms
once we start enforcing that ->setkey() is called when present.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/cryptd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -617,7 +617,8 @@ static int cryptd_create_hash(struct cry
 	inst->alg.finup  = cryptd_hash_finup_enqueue;
 	inst->alg.export = cryptd_hash_export;
 	inst->alg.import = cryptd_hash_import;
-	inst->alg.setkey = cryptd_hash_setkey;
+	if (crypto_shash_alg_has_setkey(salg))
+		inst->alg.setkey = cryptd_hash_setkey;
 	inst->alg.digest = cryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
