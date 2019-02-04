Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21A72075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276867;
	bh=LVGO79lIEl8oiqY3O265wcTWk8MtzQ7GdxAfVOoK5rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lgXKyAaha8Q4PGDJq4ae67bdQIVZI82pKgdjo6XkcK4pR91ywJJ5lI7HKb7AWQDhF
	 j0cyFamop7O24xwoaEL8dMuDjjOyfasctw3TrVqp1LMjp3CWR5UIf4lbtnkhY+7Jvi
	 h07fF4O7plJtN2cRlMHclh8UqU63lHCbzGcWqC9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfBDKlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfBDKlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E92B2075B;
        Mon,  4 Feb 2019 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276862;
        bh=LVGO79lIEl8oiqY3O265wcTWk8MtzQ7GdxAfVOoK5rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xRYI4sFTe9Fk/yntdBJkogkacuvIolIsxMSBYf9+qI5mKE99g34v8vv3zuJyU9+jN
         SFA5g8+xnsvWuvvZZjS9x5fzYNbveUujfC89rZd0yI0FbXI8SuO7XsQZnBFwgxPsEz
         UsfLQrtF2ANvpfX8iJxw7dmJed5Jf6gocbqGRN54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Thore <mathias.thore@infinera.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 4.4 39/65] ucc_geth: Reset BQL queue when stopping device
Date:   Mon,  4 Feb 2019 11:36:32 +0100
Message-Id: <20190204103617.367653957@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1888,6 +1888,8 @@ static void ucc_geth_free_tx(struct ucc_
 	u16 i, j;
 	u8 __iomem *bd;
 
+	netdev_reset_queue(ugeth->ndev);
+
 	ug_info = ugeth->ug_info;
 	uf_info = &ug_info->uf_info;
 


