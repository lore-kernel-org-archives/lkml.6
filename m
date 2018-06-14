Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 52C11C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F202A208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcu39w5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F202A208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965766AbeFNOLG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965656AbeFNOLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34488208DB;
        Thu, 14 Jun 2018 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985463;
        bh=VORNQ85nl4eyPLFQ+JeCbc3nhBQ2PQXRYtcuV517hSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcu39w5Y7j7y/QWPt5/+q72Rjx5xnM/XKBXsUwHxjN4nEkXYhhB0n519kkmQLffT9
         k2vIN2ajlOtitJLIl82Fh4b9b8n1Hmq3cQNBv+lEdNs6vdDUHUSQk61tCYnQGapKEh
         yVsZ4aQeOMVfk8Lj4Jg+kqMvEZpwD+T61bsNjnFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 35/36] crypto: vmx - Remove overly verbose printk from AES XTS init
Date:   Thu, 14 Jun 2018 16:04:58 +0200
Message-Id: <20180614132158.882099616@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 730f23b66095a700e2f0786abda6bca011b31558 upstream.

In p8_aes_xts_init() we do a printk(KERN_INFO ...) to report the
fallback implementation we're using. However with a slow console this
can significantly affect the speed of crypto operations. So remove it.

Fixes: c07f5d3da643 ("crypto: vmx - Adding support for XTS")
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/vmx/aes_xts.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/crypto/vmx/aes_xts.c
+++ b/drivers/crypto/vmx/aes_xts.c
@@ -53,8 +53,6 @@ static int p8_aes_xts_init(struct crypto
 			alg, PTR_ERR(fallback));
 		return PTR_ERR(fallback);
 	}
-	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
-		crypto_skcipher_driver_name(fallback));
 
 	crypto_skcipher_set_flags(
 		fallback,


