Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD7C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8271124004
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="iK6MEhXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8271124004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeGEP6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:58:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:19211 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeGEP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530806300;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+LOoDsl7p6OJS6yJ7g0cNOcnvYEg6SbsIdmDH5pcn4I=;
        b=iK6MEhXDbJRZ7DvQUQVjoHdDZainO20f30mH5chpGx097I4m1z2VTkhUO4WFbj5pWE
        BwsDsSj2sC9qGgDtl5R7BAjciG5Y0FFJsqFz/BdoIuv6skpJzpL9zrQwKk9mdqK59KPY
        JRxdGB17Pz54YLohllKK6F82Q5/kyLXz2xExbV+MJYrEpzKsO9U9PM5m3UKJM0MQsziE
        UjM1TMGPeVK6a1aDFRYYqpB80ohtvHr+sN3A1/9uBOdcTsYGZU7vd3ACau6Qct8AzLOK
        Cw/PkqnJkoLura43qWtyHo/FCfQluqmM6aaitOjQoX0QzOK9o1UnCr1L/BQu0HTkJLV1
        Hg6w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZGviLi+9clHWaSvyKYsbBATS5P28vh0MoLa4Uw+f"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u65FwG9px
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 17:58:16 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] AF_ALG: Initialize sg_num_bytes in error code path
Date:   Thu, 05 Jul 2018 17:58:15 +0200
Message-ID: <3579823.yyIR4au8HA@positron.chronox.de>
In-Reply-To: <00000000000092ad87056950ef9e@google.com>
References: <00000000000092ad87056950ef9e@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v2:
* Addition of syz testing line

---8<---

The RX SGL in processing is already registered with the RX SGL tracking
list to support proper cleanup. The cleanup code path uses the
sg_num_bytes variable which must therefore be always initialized, even
in the error code path.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
Reported-by: syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com
#syz test: https://github.com/google/kmsan.git
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




