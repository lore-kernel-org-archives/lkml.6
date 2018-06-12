Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB3FDC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AE0208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gepWqnQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AE0208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935270AbeFLQyG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935248AbeFLQx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA873208B7;
        Tue, 12 Jun 2018 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822439;
        bh=dZWghrp4WiVCNTAKkJFsDg/S4BslHoc69bKYKWCGVwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gepWqnQI976yL1B9CsQnpmPeqOZ2I2TGp4jBZnXAKMHqlY7O5ogZvrOE4bjVYPucw
         3fLrNXsoKQk7uLIpdZeZzStMwQOb8f0BudklprIs4SayZfCVScbdSqzECScO2dnQwO
         s0qKAUJ5zUtU1je5OQVQ5ms9niN7Z1VyIuOgCnqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 12/21] bnx2x: use the right constant
Date:   Tue, 12 Jun 2018 18:52:09 +0200
Message-Id: <20180612164825.904467054@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit dd612f18a49b63af8b3a5f572d999bdb197385bc ]

Nearby code that also tests port suggests that the P0 constant should be
used when port is zero.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
@@

* e ? e1 : e1
// </smpl>

Fixes: 6c3218c6f7e5 ("bnx2x: Adjust ETS to 578xx")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -588,7 +588,7 @@ static void bnx2x_ets_e3b0_nig_disabled(
 	 * slots for the highest priority.
 	 */
 	REG_WR(bp, (port) ? NIG_REG_P1_TX_ARB_NUM_STRICT_ARB_SLOTS :
-		   NIG_REG_P1_TX_ARB_NUM_STRICT_ARB_SLOTS, 0x100);
+		   NIG_REG_P0_TX_ARB_NUM_STRICT_ARB_SLOTS, 0x100);
 	/* Mapping between the CREDIT_WEIGHT registers and actual client
 	 * numbers
 	 */


