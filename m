Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75282C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418A620866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2n+Q40GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418A620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbeJQBIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeJQBIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:08:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C43C20866;
        Tue, 16 Oct 2018 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710217;
        bh=h2xlg0V7YpzBBmdxs0x8ylbGVQOrSW3UgztshJpIthQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2n+Q40GF8NdMLDo67PYVXtd7k8d+gyOZY0C7GQbHncvGIPbPioEwCbGVS4wttAeBh
         Bjtcu5QwwrPzgtMVK8yJKhsDcOvNSprkge7RM92i4TXaKQSb9ph8Drb2H/XTMX/SCe
         gq7kmY9ME0f63d8NLcYC2DGK/5BSUbbKWOvVo/pU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Boot <bootc@bootc.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.18 128/135] mmc: block: avoid multiblock reads for the last sector in SPI mode
Date:   Tue, 16 Oct 2018 19:05:58 +0200
Message-Id: <20181016170524.097183468@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Chris Boot <bootc@bootc.net>

commit 41591b38f5f8f78344954b68582b5f00e56ffe61 upstream.

On some SD cards over SPI, reading with the multiblock read command the last
sector will leave the card in a bad state.

Remove last sectors from the multiblock reading cmd.

Signed-off-by: Chris Boot <bootc@bootc.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/block.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1371,6 +1371,16 @@ static void mmc_blk_data_prep(struct mmc
 
 	if (brq->data.blocks > 1) {
 		/*
+		 * Some SD cards in SPI mode return a CRC error or even lock up
+		 * completely when trying to read the last block using a
+		 * multiblock read command.
+		 */
+		if (mmc_host_is_spi(card->host) && (rq_data_dir(req) == READ) &&
+		    (blk_rq_pos(req) + blk_rq_sectors(req) ==
+		     get_capacity(md->disk)))
+			brq->data.blocks--;
+
+		/*
 		 * After a read error, we redo the request one sector
 		 * at a time in order to accurately determine which
 		 * sectors can be read successfully.


