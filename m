Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C65ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A002148E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKOP3nrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A002148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeKIHig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbeKIHif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:35 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C3520989;
        Thu,  8 Nov 2018 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714466;
        bh=cH1rxjmgf+yrt4cmzOS2KuKuZS4NhECRjKyi79xIlCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKOP3nrz0osM7tdeYRgOXHx+KvnTQEaLu8R2YudKSsMmRKaPmRNanpm+7E74yCyly
         MN3IjeuUvsaPAV4Z6NRqoDA7KvaRSU7Lv09EQBP0dJy+Nq/jWcI0Zpt59qbmE4ii9X
         zlfHh6WaFqnRXtvZDh7BOTww95bLfrc8y3IRY234=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 102/114] crypto: shash - Fix a sleep-in-atomic bug in shash_setkey_unaligned
Date:   Thu,  8 Nov 2018 13:51:57 -0800
Message-Id: <20181108215109.932145213@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9039f3ef446e9ffa200200c934f049add9e58426 ]

The SCTP program may sleep under a spinlock, and the function call path is:
sctp_generate_t3_rtx_event (acquire the spinlock)
  sctp_do_sm
    sctp_side_effects
      sctp_cmd_interpreter
        sctp_make_init_ack
          sctp_pack_cookie
            crypto_shash_setkey
              shash_setkey_unaligned
                kmalloc(GFP_KERNEL)

For the same reason, the orinoco driver may sleep in interrupt handler,
and the function call path is:
orinoco_rx_isr_tasklet
  orinoco_rx
    orinoco_mic
      crypto_shash_setkey
        shash_setkey_unaligned
          kmalloc(GFP_KERNEL)

To fix it, GFP_KERNEL is replaced with GFP_ATOMIC.
This bug is found by my static analysis tool and my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/shash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index 5444b429e35d..4f89f78031e2 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -41,7 +41,7 @@ static int shash_setkey_unaligned(struct crypto_shash *tfm, const u8 *key,
 	int err;
 
 	absize = keylen + (alignmask & ~(crypto_tfm_ctx_alignment() - 1));
-	buffer = kmalloc(absize, GFP_KERNEL);
+	buffer = kmalloc(absize, GFP_ATOMIC);
 	if (!buffer)
 		return -ENOMEM;
 
-- 
2.17.1



