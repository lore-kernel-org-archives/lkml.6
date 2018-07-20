Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709A920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709A920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbeGTNeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:34:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390372AbeGTNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:34:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F23DD8E;
        Fri, 20 Jul 2018 12:40:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
        syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.17 066/101] crypto: af_alg - Initialize sg_num_bytes in error code path
Date:   Fri, 20 Jul 2018 14:14:12 +0200
Message-Id: <20180720121426.110184758@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit 2546da99212f22034aecf279da9c47cbfac6c981 upstream.

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
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/af_alg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1156,8 +1156,10 @@ int af_alg_get_rsgl(struct sock *sk, str
 
 		/* make one iovec available as scatterlist */
 		err = af_alg_make_sg(&rsgl->sgl, &msg->msg_iter, seglen);
-		if (err < 0)
+		if (err < 0) {
+			rsgl->sg_num_bytes = 0;
 			return err;
+		}
 
 		/* chain the new scatterlist with previous one */
 		if (areq->last_rsgl)


