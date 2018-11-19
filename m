Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CB021479
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcjxDZy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CB021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbeKTDAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbeKTDAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:00:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08EC62086A;
        Mon, 19 Nov 2018 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645396;
        bh=CNGFnL/rVrB7WC8TrTEuo5JL1Z9mcXr1+4MmKjcalgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcjxDZy2usKVCy3i2M0ccJ6Tg1osYjvwv14au5qoxJFt0AJmfj4dhzMqjQti0phhv
         UdVK8bYkiN4NH5jii0Z7m3tt66pG5ryGQ2DlptXc+7B5iYtKpS1Uic2+lH0mynQ2Bx
         We7tkAiCRTPRPPoyItWD/Iv/YGArIn00cev1Nqko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 108/205] mtd: spi-nor: cadence-quadspi: Return error code in cqspi_direct_read_execute()
Date:   Mon, 19 Nov 2018 17:26:55 +0100
Message-Id: <20181119162634.269328495@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 91d7b67000c6e9bd605624079fee5a084238ad92 upstream.

We return 0 unconditionally in 'cqspi_direct_read_execute()'.
However, 'ret' is set to some error codes in several error handling
paths.

Return 'ret' instead to propagate the error code.

Fixes: ffa639e069fb ("mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/cadence-quadspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -996,7 +996,7 @@ static int cqspi_direct_read_execute(str
 err_unmap:
 	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
 
-	return 0;
+	return ret;
 }
 
 static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,


