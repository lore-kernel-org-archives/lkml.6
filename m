Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585DC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3472089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864564;
	bh=UAxpufE2GhHCNlV03/R+jHXwwtJoSqSJCuOucvszEDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z9W6GUmG8CsQAJ2fVqtOGUeHdUoWYJwtdhtBAIecuaKfqkA3zdEKUtiTC8iVJhoVY
	 fXrxRraKmAHHaI38H+yxf32aisgK7N46m+RVkPntnzNfhCmMPLsjEA1wtrwt5PPBPq
	 c+lV/Gr/LQ/d/YIyDkD+zOQ3jBYDq6T0s8fwK65k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfAGMgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfAGMfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33EC20859;
        Mon,  7 Jan 2019 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864551;
        bh=UAxpufE2GhHCNlV03/R+jHXwwtJoSqSJCuOucvszEDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9ennBvU6EqXmDfdcN/Hma63VBEBNSu3M/VPuEBmM2Be9WoU/2ah3+siam6HHHgT5
         lviYLTaMjQC/t2n1wfHyBvuju/eV4sx3gop1d5/p8FutKkz+/qucw4Jv3ILWdoPLuL
         jxWORrOxDXubO951naMWm8o+LVhajMDaH8IM8CnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Subject: [PATCH 4.20 047/145] staging: wilc1000: fix missing read_write setting when reading data
Date:   Mon,  7 Jan 2019 13:31:24 +0100
Message-Id: <20190107104443.593812291@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -841,6 +841,7 @@ static int sdio_read_int(struct wilc *wi
 	if (!sdio_priv->irq_gpio) {
 		int i;
 
+		cmd.read_write = 0;
 		cmd.function = 1;
 		cmd.address = 0x04;
 		cmd.data = 0;


