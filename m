Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB925C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35912177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499410;
	bh=OswJ3PrXTJF0EI1ucVQ60Z5hEMjARhehUHfESEwW8Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RW7EXV8Om/xOb9MaPzoKLOc0gjJWct3zRnEKfkj56CI3kQmFpOZbS62wff+qXBwyj
	 OO1fYs45gzzjuuwnz3Qh4RIDIeoAxdVrjuMXfQez9Y8F7cTB714cdRk5MmdA6V4/tn
	 nD1EoQxbEyxi9+KA3cAD5Cxgz2RKt12TBFvvh4JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfBROQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391515AbfBROKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:10:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39A8217D7;
        Mon, 18 Feb 2019 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499040;
        bh=OswJ3PrXTJF0EI1ucVQ60Z5hEMjARhehUHfESEwW8Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9P1j9t7viTPZH64Bycsl03J5NuCqXTr1WuhJMzBfGtxgqe2QkT2tCYugMtk3Uhol
         AShusK91aJPnvklz9gCKorrW5GJ1Tg9/2SRxEZf2shT+npWzzQe3o8a7jNH6ZUEL7s
         dAcJ6/0JTWC923AjkPVxfn5hysOUJDjUm9N1JMm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 058/108] skge: potential memory corruption in skge_get_regs()
Date:   Mon, 18 Feb 2019 14:43:54 +0100
Message-Id: <20190218133522.204530410@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 294c149a209c6196c2de85f512b52ef50f519949 ]

The "p" buffer is 0x4000 bytes long.  B3_RI_WTO_R1 is 0x190.  The value
of "regs->len" is in the 1-0x4000 range.  The bug here is that
"regs->len - B3_RI_WTO_R1" can be a negative value which would lead to
memory corruption and an abrupt crash.

Fixes: c3f8be961808 ("[PATCH] skge: expand ethtool debug register dump")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/skge.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -152,8 +152,10 @@ static void skge_get_regs(struct net_dev
 	memset(p, 0, regs->len);
 	memcpy_fromio(p, io, B3_RAM_ADDR);
 
-	memcpy_fromio(p + B3_RI_WTO_R1, io + B3_RI_WTO_R1,
-		      regs->len - B3_RI_WTO_R1);
+	if (regs->len > B3_RI_WTO_R1) {
+		memcpy_fromio(p + B3_RI_WTO_R1, io + B3_RI_WTO_R1,
+			      regs->len - B3_RI_WTO_R1);
+	}
 }
 
 /* Wake on Lan only supported on Yukon chips with rev 1 or above */


