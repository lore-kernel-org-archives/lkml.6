Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F6C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C4921479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoU+Sqn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C4921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbeJICGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732766AbeJICGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2AB204FD;
        Mon,  8 Oct 2018 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024811;
        bh=izqbiM9eBhziAm0ScT1pajbUganM5hk6Zphmos+/0eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoU+Sqn+bGIvmdbJj86SOirHzn8ReaWEUrkkISSpSm7VpxxvoV356c15hOQIPbw8w
         FH6brNBIBU65sewL0WyUwVVf7/N2PLvhi9QlR8e9YzL5ro7jCLkPWs5iscIRQON1iR
         Tx3Hl894UeVdfKdKe3cRpdU4cmKdjStzKahYXXlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 161/168] crypto: caam/jr - fix ablkcipher_edesc pointer arithmetic
Date:   Mon,  8 Oct 2018 20:32:21 +0200
Message-Id: <20181008175626.173258169@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horia Geantă <horia.geanta@nxp.com>

commit 13cc6f48c7434ce46ba6dbc90003a136a263d75a upstream.

In some cases the zero-length hw_desc array at the end of
ablkcipher_edesc struct requires for 4B of tail padding.

Due to tail padding and the way pointers to S/G table and IV
are computed:
	edesc->sec4_sg = (void *)edesc + sizeof(struct ablkcipher_edesc) +
			 desc_bytes;
	iv = (u8 *)edesc->hw_desc + desc_bytes + sec4_sg_bytes;
first 4 bytes of IV are overwritten by S/G table.

Update computation of pointer to S/G table to rely on offset of hw_desc
member and not on sizeof() operator.

Cc: <stable@vger.kernel.org> # 4.13+
Fixes: 115957bb3e59 ("crypto: caam - fix IV DMA mapping and updating")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/caamalg.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1553,8 +1553,8 @@ static struct ablkcipher_edesc *ablkciph
 	edesc->src_nents = src_nents;
 	edesc->dst_nents = dst_nents;
 	edesc->sec4_sg_bytes = sec4_sg_bytes;
-	edesc->sec4_sg = (void *)edesc + sizeof(struct ablkcipher_edesc) +
-			 desc_bytes;
+	edesc->sec4_sg = (struct sec4_sg_entry *)((u8 *)edesc->hw_desc +
+						  desc_bytes);
 	edesc->iv_dir = DMA_TO_DEVICE;
 
 	/* Make sure IV is located in a DMAable area */
@@ -1757,8 +1757,8 @@ static struct ablkcipher_edesc *ablkciph
 	edesc->src_nents = src_nents;
 	edesc->dst_nents = dst_nents;
 	edesc->sec4_sg_bytes = sec4_sg_bytes;
-	edesc->sec4_sg = (void *)edesc + sizeof(struct ablkcipher_edesc) +
-			 desc_bytes;
+	edesc->sec4_sg = (struct sec4_sg_entry *)((u8 *)edesc->hw_desc +
+						  desc_bytes);
 	edesc->iv_dir = DMA_FROM_DEVICE;
 
 	/* Make sure IV is located in a DMAable area */


