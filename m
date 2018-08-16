Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E82C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9900721473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9900721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeHPVmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:42:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbeHPVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:42:19 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BB99CB7;
        Thu, 16 Aug 2018 18:42:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3.18 11/15] crypto: vmac - require a block cipher with 128-bit block size
Date:   Thu, 16 Aug 2018 20:41:48 +0200
Message-Id: <20180816171633.974230377@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171633.546734046@linuxfoundation.org>
References: <20180816171633.546734046@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 73bf20ef3df262026c3470241ae4ac8196943ffa upstream.

The VMAC template assumes the block cipher has a 128-bit block size, but
it failed to check for that.  Thus it was possible to instantiate it
using a 64-bit block size cipher, e.g. "vmac(cast5)", causing
uninitialized memory to be used.

Add the needed check when instantiating the template.

Fixes: f1939f7c5645 ("crypto: vmac - New hash algorithm for intel_txt support")
Cc: <stable@vger.kernel.org> # v2.6.32+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/vmac.c |    4 ++++
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


