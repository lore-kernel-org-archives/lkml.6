Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D605BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7562084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zt1/NqmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7562084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeKLKLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:11:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbeKLIQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE193214DB;
        Sun, 11 Nov 2018 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975215;
        bh=tQw1cr1bTY8AbC+jWkZyZ9AlZJErzp8KTznYOri2n+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zt1/NqmBLFE8y3Wf35LrH5GsyNcKtt9UZ0L4nK5+gYi86M87QSPVt3HcESp+4+vvQ
         p4jwyD5rlaR+i4F+cVwPoRk4/ugz0QaLea02YgmyCv/3fjZgerLEgvSYG8Kaf7yWSg
         OaWaq1Zd0sH9SpPdqWvGCHm+N9eCdgYgddMUgkIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 011/361] spi: bcm-qspi: fix calculation of address length
Date:   Sun, 11 Nov 2018 14:15:58 -0800
Message-Id: <20181111221621.515068616@linuxfoundation.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

commit 0976eda7915507fe94e07870c19d717c9994b57a upstream.

During implementation of the new API bcm_qspi_bspi_set_flex_mode() has
been modified breaking calculation of address length. An unnecessary
multiplication was added breaking flash reads.

Fixes: 5f195ee7d830 ("spi: bcm-qspi: Implement the spi_mem interface")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm-qspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -355,7 +355,7 @@ static int bcm_qspi_bspi_set_flex_mode(s
 	int bpc = 0, bpp = 0;
 	u8 command = op->cmd.opcode;
 	int width  = op->cmd.buswidth ? op->cmd.buswidth : SPI_NBITS_SINGLE;
-	int addrlen = op->addr.nbytes * 8;
+	int addrlen = op->addr.nbytes;
 	int flex_mode = 1;
 
 	dev_dbg(&qspi->pdev->dev, "set flex mode w %x addrlen %x hp %d\n",


