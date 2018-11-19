Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936032145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yDUVPg6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936032145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbeKTDHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbeKTDHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC2F2086A;
        Mon, 19 Nov 2018 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645786;
        bh=sW01/0U6M+HEoddLsDRArGRbmHKdflvHU+zQlcjB0nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDUVPg6XFV2MeH0OWXVtctITKbhOCoghVgP6mkrwDZYxvbp7av069KiTHVne2BQ8G
         K0SkAjiURkpg2kucKoU4t0ouuJRZ5YqKsjVKzrULxFJVCLhhO1xDvmopH6oAdG7wLt
         Sz2p7E5Bqnwx+twW3OuXCfiBpvcyXNcsPSHhIEk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.18 089/171] mtd: spi-nor: cadence-quadspi: Return error code in cqspi_direct_read_execute()
Date:   Mon, 19 Nov 2018 17:28:05 +0100
Message-Id: <20181119162633.536912550@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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
@@ -1000,7 +1000,7 @@ static int cqspi_direct_read_execute(str
 err_unmap:
 	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
 
-	return 0;
+	return ret;
 }
 
 static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,


