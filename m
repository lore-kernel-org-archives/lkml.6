Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C48C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721CF223D8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntSHw5Yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721CF223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbeKLIWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390163AbeKLIWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:01 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D69224B3;
        Sun, 11 Nov 2018 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975524;
        bh=TCP94yQQWovgmiDxT8EHbrVs4urTMV4n0MswR9l+IhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntSHw5YgAEPAgfTn1EfA0LWQr+ev1hLh2koCVZSS4gcN9T6B85wlaTVfz4DRYBq2G
         XwSJqZPF13bsUUFAmHdTVr9UhQH8jlmjzU724txil1oBvECFCa5BIZNuzj/aQm6Xyh
         SbwzzAaVs4gThcUygC667W0/3DUcBU2DFLrfHA/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 002/222] spi: bcm-qspi: switch back to reading flash using smaller chunks
Date:   Sun, 11 Nov 2018 14:21:39 -0800
Message-Id: <20181111221647.987120977@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

commit 940ec770c295682993d1cccce3081fd7c74fece8 upstream.

Fixing/optimizing bcm_qspi_bspi_read() performance introduced two
changes:
1) It added a loop to read all requested data using multiple BSPI ops.
2) It bumped max size of a single BSPI block request from 256 to 512 B.

The later change resulted in occasional BSPI timeouts causing a
regression.

For some unknown reason hardware doesn't always handle reads as expected
when using 512 B chunks. In such cases it may happen that BSPI returns
amount of requested bytes without the last 1-3 ones. It provides the
remaining bytes later but doesn't raise an interrupt until another LR
start.

Switching back to 256 B reads fixes that problem and regression.

Fixes: 345309fa7c0c ("spi: bcm-qspi: Fix bcm_qspi_bspi_read() performance")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm-qspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -88,7 +88,7 @@
 #define BSPI_BPP_MODE_SELECT_MASK		BIT(8)
 #define BSPI_BPP_ADDR_SELECT_MASK		BIT(16)
 
-#define BSPI_READ_LENGTH			512
+#define BSPI_READ_LENGTH			256
 
 /* MSPI register offsets */
 #define MSPI_SPCR0_LSB				0x000


