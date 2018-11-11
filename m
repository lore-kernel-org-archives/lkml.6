Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F16EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193D220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyEPbJkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193D220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbeKLJfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387486AbeKLITJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:09 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3429F21104;
        Sun, 11 Nov 2018 22:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975353;
        bh=ABn80GdSO7dJx636QoMgIF/BB7AxBFq89Pnuiy7JEhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyEPbJkPiBboimTFriSqcq4InpFqaAuCvHAYFxJKkW9SGEl8tlgppzna83NjfURxC
         hbIMzV3MqqLSx9NKgBHg0y7/beLx40JWtoRb01Q3JdobvuR+ewfql2Vfq5Y2oCEUip
         6TNGLaMr9L+fe6+4Bc/n84ZIKQ3q789d2TniVr5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuanhua Han <chuanhua.han@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 005/350] spi: spi-mem: Adjust op len based on message/transfer size limitations
Date:   Sun, 11 Nov 2018 14:17:49 -0800
Message-Id: <20181111221707.324640841@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Chuanhua Han <chuanhua.han@nxp.com>

commit e757996cafbeb6b71234a17130674bcd8f44c59e upstream.

We need that to adjust the len of the 2nd transfer (called data in
spi-mem) if it's too long to fit in a SPI message or SPI transfer.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-mem.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -328,10 +328,25 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	size_t len;
+
+	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		if (len > spi_max_transfer_size(mem->spi))
+			return -EINVAL;
+
+		op->data.nbytes = min3((size_t)op->data.nbytes,
+				       spi_max_transfer_size(mem->spi),
+				       spi_max_message_size(mem->spi) -
+				       len);
+		if (!op->data.nbytes)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);


