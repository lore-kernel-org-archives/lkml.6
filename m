Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA71C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1E620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277847;
	bh=sw3goz/kIZoemckpjqj5FUPdI7wp6E1NLWTm604a+2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t/aquonynLinTi2airX4vjgji7mPbyYUNRDs/1ilUwNAHfjYTIVS1wo23gdajsHY2
	 SUgaRZkikns/tx8rdJEymGyZmhU72IYvRYj0G3chAiQuBjUG7aotsoCdTsfZ7izcmf
	 FBKzkOG0jUO+ViLK6qD7D2pqc7JZteSjhWk35AQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbfBDK5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732486AbfBDKvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C552B2070C;
        Mon,  4 Feb 2019 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277510;
        bh=sw3goz/kIZoemckpjqj5FUPdI7wp6E1NLWTm604a+2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5mVRLJcCNP2MhDlIQPLGuPI+fLnHAbTc8bjeSfL6e0Uw1DXLYKD1xOQcnp5roe/P
         sVTyQoAFKI4Ce2zZSYwehkO6iJ7OVvoYhRpyZEu8hKYOpYTY+F+JNaLiefuVtANIFZ
         zuGmlEtIpOmmnOjAdHhoWpdx67bC9FDSPnRb+mhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Thore <mathias.thore@infinera.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 4.20 16/80] ucc_geth: Reset BQL queue when stopping device
Date:   Mon,  4 Feb 2019 11:36:36 +0100
Message-Id: <20190204103622.613850160@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Mathias Thore <mathias.thore@infinera.com>

[ Upstream commit e15aa3b2b1388c399c1a2ce08550d2cc4f7e3e14 ]

After a timeout event caused by for example a broadcast storm, when
the MAC and PHY are reset, the BQL TX queue needs to be reset as
well. Otherwise, the device will exhibit severe performance issues
even after the storm has ended.

Co-authored-by: David Gounaris <david.gounaris@infinera.com>
Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/ucc_geth.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1883,6 +1883,8 @@ static void ucc_geth_free_tx(struct ucc_
 	u16 i, j;
 	u8 __iomem *bd;
 
+	netdev_reset_queue(ugeth->ndev);
+
 	ug_info = ugeth->ug_info;
 	uf_info = &ug_info->uf_info;
 


