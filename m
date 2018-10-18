Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7CAECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9343221486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIjsX7r3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9343221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeJSCDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbeJSCDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF8821476;
        Thu, 18 Oct 2018 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885700;
        bh=rSV3ES2PlEAx6+o66KLjR4tiiRpDYl3FFWs4SDqwgDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIjsX7r3M3ezNAKn7TpHzdhQV9HuAbOTdSNVZxZXgaHvd28ZAM2L8SdyzC9ae7/Ky
         7kGoXmnnore3OWCryCQxWEBTgqBpzR+VnBNjHi+qzLAxgeDjewcMPnvcYIWQBxsurR
         fggmJLqqMRhEGC3bN+LouNbPKmrgtis5XxahS620=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 37/41] staging: ccree: check DMA pool buf !NULL before free
Date:   Thu, 18 Oct 2018 19:54:52 +0200
Message-Id: <20181018175423.130138270@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 2f7caf6b02145bd9cd9d0b56204f51a5fefe7790 upstream.

If we ran out of DMA pool buffers, we get into the unmap
code path with a NULL before. Deal with this by checking
the virtual mapping is not NULL.

Cc: stable@vger.kernel.org
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/ccree/ssi_buffer_mgr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/ccree/ssi_buffer_mgr.c
+++ b/drivers/staging/ccree/ssi_buffer_mgr.c
@@ -492,7 +492,8 @@ void ssi_buffer_mgr_unmap_blkcipher_requ
 				 DMA_TO_DEVICE);
 	}
 	/* Release pool */
-	if (req_ctx->dma_buf_type == SSI_DMA_BUF_MLLI) {
+	if (req_ctx->dma_buf_type == SSI_DMA_BUF_MLLI &&
+	    req_ctx->mlli_params.mlli_virt_addr) {
 		dma_pool_free(req_ctx->mlli_params.curr_pool,
 			      req_ctx->mlli_params.mlli_virt_addr,
 			      req_ctx->mlli_params.mlli_dma_addr);


