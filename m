Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9A52DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466AC208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="knR5mIPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466AC208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934758AbeFLQrh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933748AbeFLQrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89769208B9;
        Tue, 12 Jun 2018 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822053;
        bh=Hc6c4YC2FoNa4Wq6ObLvulCVohmVkhOsEBOaoMcSokQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knR5mIPYxe9CJCBbJyjQ41zRjG8egBTAqCQtBg5vaNy4TWDDJIIvBtubGIswniY15
         Fn+2DnlJCT5UDb/a/rVKvi6Y9gyMZDQiTtlaCEZ9dlDOu1Y7E0GRFTOqDBJW1+xR1K
         fzM2e5/mLTbCl6XvWNX0aqVdoNFwuJ3fQkQQ/Ris=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahed Shaikh <shahed.shaikh@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 19/31] qed: Fix mask for physical address in ILT entry
Date:   Tue, 12 Jun 2018 18:46:22 +0200
Message-Id: <20180612164621.554027038@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shahed Shaikh <shahed.shaikh@cavium.com>

[ Upstream commit fdd13dd350dda1826579eb5c333d76b14513b812 ]

ILT entry requires 12 bit right shifted physical address.
Existing mask for ILT entry of physical address i.e.
ILT_ENTRY_PHY_ADDR_MASK is not sufficient to handle 64bit
address because upper 8 bits of 64 bit address were getting
masked which resulted in completer abort error on
PCIe bus due to invalid address.

Fix that mask to handle 64bit physical address.

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Signed-off-by: Shahed Shaikh <shahed.shaikh@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -54,7 +54,7 @@
 #define ILT_CFG_REG(cli, reg)	PSWRQ2_REG_ ## cli ## _ ## reg ## _RT_OFFSET
 
 /* ILT entry structure */
-#define ILT_ENTRY_PHY_ADDR_MASK		0x000FFFFFFFFFFFULL
+#define ILT_ENTRY_PHY_ADDR_MASK		(~0ULL >> 12)
 #define ILT_ENTRY_PHY_ADDR_SHIFT	0
 #define ILT_ENTRY_VALID_MASK		0x1ULL
 #define ILT_ENTRY_VALID_SHIFT		52


