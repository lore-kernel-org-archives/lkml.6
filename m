Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF0C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF91C2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF91C2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeLIW2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:28:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34616 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbeLIVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002in-RH; Sun, 09 Dec 2018 21:55:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003DI-7Z; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.533534214@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 015/328] crypto: vmac - require a block cipher with
 128-bit block size
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 73bf20ef3df262026c3470241ae4ac8196943ffa upstream.

The VMAC template assumes the block cipher has a 128-bit block size, but
it failed to check for that.  Thus it was possible to instantiate it
using a 64-bit block size cipher, e.g. "vmac(cast5)", causing
uninitialized memory to be used.

Add the needed check when instantiating the template.

Fixes: f1939f7c5645 ("crypto: vmac - New hash algorithm for intel_txt support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/vmac.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/crypto/vmac.c
+++ b/crypto/vmac.c
@@ -655,6 +655,10 @@ static int vmac_create(struct crypto_tem
 	if (IS_ERR(alg))
 		return PTR_ERR(alg);
 
+	err = -EINVAL;
+	if (alg->cra_blocksize != 16)
+		goto out_put_alg;
+
 	inst = shash_alloc_instance("vmac", alg);
 	err = PTR_ERR(inst);
 	if (IS_ERR(inst))

