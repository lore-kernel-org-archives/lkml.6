Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA70A24098
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="MC/hsqgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA70A24098
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeGFHvB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:51:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:33314 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeGFHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530863455;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JsQ3m24flaQDj8jTcTsjek5lgEh6D7mElqZ87jIS6U4=;
        b=MC/hsqgDHqfN91zQjR0cT1ogykEeWUCZBRnIkh3dO7aQgn8lYpvMRM/YvOYPdKoIyS
        BJa34JgO/zAH5XlnDcPwIWKLBwFYwn2HTzObe6aKml5kx8SxKnJHy/59BDtQl9F953In
        GJM4ClOzrgBA+lRBcirxaC3ciDMuaw4lZYMpI44nHKnUBCpm+xuPQfmNkLdi3bDoufNU
        xMwJldUF1ctqOok42glaFzlqiEgVwnPYX1A//M1KbtZmoYTevUxmlxYOjz/GWdIL1dap
        Z5/eNGVDsw0Rh4BYrkwvnEC6H9PgHX61O4hDDbkqTJbwRzn/o7CeeEoeGWlsDBY9903K
        0fUg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZGrithBFZUqsJvVgrVBA+rnA/uRhRK66bGPZWXM="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u667orFMv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 6 Jul 2018 09:50:53 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH v3] AF_ALG: Initialize sg_num_bytes in error code path
Date:   Fri, 06 Jul 2018 09:50:55 +0200
Message-ID: <1616306.R4SzcgHSdy@positron.chronox.de>
In-Reply-To: <00000000000092ad87056950ef9e@google.com>
References: <00000000000092ad87056950ef9e@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v3:
* Fix syz testing line

Changes v2:
* Addition of syz testing line

---8<---

The RX SGL in processing is already registered with the RX SGL tracking
list to support proper cleanup. The cleanup code path uses the
sg_num_bytes variable which must therefore be always initialized, even
in the error code path.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
Reported-by: syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com
#syz test: https://github.com/google/kmsan.git master
---
 crypto/af_alg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 49fa8582138b..bd6795ff406a 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1148,8 +1148,10 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 
 		/* make one iovec available as scatterlist */
 		err = af_alg_make_sg(&rsgl->sgl, &msg->msg_iter, seglen);
-		if (err < 0)
+		if (err < 0) {
+			rsgl->sg_num_bytes = 0;
 			return err;
+		}
 
 		/* chain the new scatterlist with previous one */
 		if (areq->last_rsgl)
-- 
2.17.1




