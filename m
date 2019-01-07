Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7601C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7946920651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865492;
	bh=2oWf+xew/4LA/jFW8uQrv3PuSMrJvh/kOoVgXa4Yhdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gc3DUKzwccWkDLODjgSvQx4Gddcr8kIBCCI+uI+jwkeKSJPYiorlRCNG3iwo0ycLm
	 UV933RxIIt2aB1BUELvZHdnnRa91F6UTs7BtGEi6lCRyfjy+/yYWnaArAnmzi3rTOW
	 7zG8MWmUvH8EUicz43z3X8IJviVEnYRfXlNV6UDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfAGMvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbfAGMv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:51:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FCF20651;
        Mon,  7 Jan 2019 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865489;
        bh=2oWf+xew/4LA/jFW8uQrv3PuSMrJvh/kOoVgXa4Yhdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JeoDd48q4SZS/OzxqcU5zgFLUktt1ugPJYGWa7w+44p9jPkWkKAd/rwtYCmTFRZSF
         7Gsg2TlOhnA8/Zc6L3emCv6Sm/VOUrHdCW0ChVFB6ZKitceKiqfasnr9JKoAaklm98
         OcByizh9AVuTvGc/ZBO9XHYmqvZ1M3SongktcEZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Subject: [PATCH 4.19 084/170] staging: wilc1000: fix missing read_write setting when reading data
Date:   Mon,  7 Jan 2019 13:31:51 +0100
Message-Id: <20190107104502.942350207@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit c58eef061dda7d843dcc0ad6fea7e597d4c377c0 upstream.

Currently the cmd.read_write setting is not initialized so it contains
garbage from the stack.  Fix this by setting it to 0 to indicate a
read is required.

Detected by CoverityScan, CID#1357925 ("Uninitialized scalar variable")

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wilc1000/wilc_sdio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/wilc1000/wilc_sdio.c
+++ b/drivers/staging/wilc1000/wilc_sdio.c
@@ -831,6 +831,7 @@ static int sdio_read_int(struct wilc *wi
 	if (!g_sdio.irq_gpio) {
 		int i;
 
+		cmd.read_write = 0;
 		cmd.function = 1;
 		cmd.address = 0x04;
 		cmd.data = 0;


