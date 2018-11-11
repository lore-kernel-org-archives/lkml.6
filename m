Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3846AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9F920871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiyXmSNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9F920871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeKLKJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbeKLIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:57 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E8521731;
        Sun, 11 Nov 2018 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975222;
        bh=BHNq+GDFzR0QRWd6NoJiSBBizD81GsGqZvbRTABu1n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiyXmSNcZSeUWXyVZXa6IzIet0Lka3gXAcwFWvrZmFZTwOmwOSgaJsQY+BJ8Egx/v
         TySSIyU4/pW8nxCJ+Tbo3R2q6cSapmjjfWtB0T8RUScRb//jKy71IRkHimXHmR49hC
         DVsaYix4mxiPhb7cgnBHUCPRW5vYwrQ7BDNL1+sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Xiang <liu.xiang6@zte.com.cn>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 006/361] mtd: spi-nor: fsl-quadspi: fix read error for flash size larger than 16MB
Date:   Sun, 11 Nov 2018 14:15:53 -0800
Message-Id: <20181111221620.907362168@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Xiang <liu.xiang6@zte.com.cn>

commit 41fe242979e463d6ad251077ded01b825a330b7e upstream.

If the size of spi-nor flash is larger than 16MB, the read_opcode
is set to SPINOR_OP_READ_1_1_4_4B, and fsl_qspi_get_seqid() will
return -EINVAL when cmd is SPINOR_OP_READ_1_1_4_4B. This can
cause read operation fail.

Fixes: e46ecda764dc ("mtd: spi-nor: Add Freescale QuadSPI driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/fsl-quadspi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -478,6 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl
 {
 	switch (cmd) {
 	case SPINOR_OP_READ_1_1_4:
+	case SPINOR_OP_READ_1_1_4_4B:
 		return SEQID_READ;
 	case SPINOR_OP_WREN:
 		return SEQID_WREN;


