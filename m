Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9C46C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F959208E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMuHB6Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F959208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966161AbeFNOM5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966134AbeFNOMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C803208DE;
        Thu, 14 Jun 2018 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985573;
        bh=E2Q9/1gwUSvIs4V07Zrp1vbESfm/F6Kmm5bg5PmEUkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMuHB6JwOJi0TUsCrSID+ZOk8hqeHgxcQwogSlVZUGue3WrQgwKrVYAjnNFau4PP+
         l7RvOm+dmwitbxy4h+X4dEqYGbYJnfOpeqJaWLwLGvgmvDASxW9Y2rcTBJe7fR+jpW
         4Bl5QBDDN1Si4Quu7ulK1aFxYbyQZraMQpyo5H0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 29/30] crypto: omap-sham - fix memleak
Date:   Thu, 14 Jun 2018 16:05:10 +0200
Message-Id: <20180614132601.476310155@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 9dbc8a0328efa485a6f5b68b867f9f523a3fbeff upstream.

Fixes: 8043bb1ae03cb ("crypto: omap-sham - convert driver logic to use sgs for data xmit")

The memory pages freed in omap_sham_finish_req() were less than those
allocated in omap_sham_copy_sgs().

Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/omap-sham.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1081,7 +1081,7 @@ static void omap_sham_finish_req(struct
 
 	if (test_bit(FLAGS_SGS_COPIED, &dd->flags))
 		free_pages((unsigned long)sg_virt(ctx->sg),
-			   get_order(ctx->sg->length));
+			   get_order(ctx->sg->length + ctx->bufcnt));
 
 	if (test_bit(FLAGS_SGS_ALLOCED, &dd->flags))
 		kfree(ctx->sg);


