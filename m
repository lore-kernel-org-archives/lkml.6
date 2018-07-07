Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B6C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B272150A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="nxYYQHNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B272150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeGGSmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 14:42:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:28971 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeGGSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 14:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530988916;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6uAT555zkQpz/Tj7cjRg7imbXbYWpqW7M6cOLpmkhks=;
        b=nxYYQHNchneWFMaKKGrh3yVuBhUzgh6bgT5JXelmp3lzKmy+ehwzra8UiDij5K/Zxt
        WEtQ2R6DRCnXN5hL/O3tDIv3juOlS0gZR+LF5g/DJPgWfRN0LDlTyjGXsX+ewiiNVQr/
        EYWB7/Y/KKUVyiO6SC1MlteP0XW+jbUrlZFrc8WnV16/sBkSiqSnR/Z01+GuAz/aHPMp
        KhHylkkj4oWxZJdPf28uBnPzaAEwwaMSjmMLYPnmrHfY9xr53a6i1dnc/QJ1ANWAfSiR
        5wNl0PgDmVvkWArUKc43Wbkz17qdOTTiSHK1Qrug0BhmAcdffKjNCsmH9KOL6kbdpnWo
        Gd7g==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIPmPqerSb6i1RXNPRx4ywMJRUPVqeoQCjXPfNPtNr"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u67IfrPnP
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 7 Jul 2018 20:41:53 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH v4] AF_ALG: Initialize sg_num_bytes in error code path
Date:   Sat, 07 Jul 2018 20:41:47 +0200
Message-ID: <1612449.5GibSviISC@positron.chronox.de>
In-Reply-To: <00000000000092ad87056950ef9e@google.com>
References: <00000000000092ad87056950ef9e@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v4:
* Add Fixes and CC line

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
CC: <stable@vger.kernel.org> #4.14
Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory management")
Fixes: d887c52d6ae4 ("crypto: algif_aead - overhaul memory management")
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




