Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4109FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C962083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762365;
	bh=BI1hV1CLylRtIOOzHA2tuWI36v+ZwSyVJxSHsRcoUtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrUcgaQxS9kUfE/Fa7w/8gYJzd2R3hIYGXAx6PJeEwCy79Jvcw1BIXr6nmWH9tgWp
	 sA1emjBa8wlJUIKjWIkd+B7jiK0WEYHXe+b8JljjgK+iY2zlciqN/e5HLAne1x6mhV
	 KX8w+qDNQhQJ1QXYEWmcPONt52LZedjTBi3a3Kt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfA2LqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbfA2LqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC9A120882;
        Tue, 29 Jan 2019 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762360;
        bh=BI1hV1CLylRtIOOzHA2tuWI36v+ZwSyVJxSHsRcoUtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AN3z9IayRLuCyq+Ydckb287McW+fF3PwBNx1T3ufxvtr5eoLJJ/3IA7WyUekx7R7l
         01+5YqR/1GKOo2EMnnWr9iU4v53KQpElmHJ5zmdZB2BwppOZx0oVrP6YkW6Os/sd23
         BhUzAKSS+hdre/FV7VX6nexcwx9OskJWQrRAZQ/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 081/103] can: flexcan: fix NULL pointer exception during bringup
Date:   Tue, 29 Jan 2019 12:35:58 +0100
Message-Id: <20190129113206.197578898@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit a55234dabe1f72cf22f9197980751d37e38ba020 upstream.

Commit cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
introduced a loop letting i run up to (including) ARRAY_SIZE(regs->mb)
and in the body accessed regs->mb[i] which is an out-of-bounds array
access that then resulted in an access to an reserved register area.

Later this was changed by commit 0517961ccdf1 ("can: flexcan: Add
provision for variable payload size") to iterate a bit differently but
still runs one iteration too much resulting to call

	flexcan_get_mb(priv, priv->mb_count)

which results in a WARN_ON and then a NULL pointer exception. This
only affects devices compatible with "fsl,p1010-flexcan",
"fsl,imx53-flexcan", "fsl,imx35-flexcan", "fsl,imx25-flexcan",
"fsl,imx28-flexcan", so newer i.MX SoCs are not affected.

Fixes: cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org> # >= 4.20
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/net/can/flexcan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1004,7 +1004,7 @@ static int flexcan_chip_start(struct net
 		}
 	} else {
 		/* clear and invalidate unused mailboxes first */
-		for (i = FLEXCAN_TX_MB_RESERVED_OFF_FIFO; i <= ARRAY_SIZE(regs->mb); i++) {
+		for (i = FLEXCAN_TX_MB_RESERVED_OFF_FIFO; i < ARRAY_SIZE(regs->mb); i++) {
 			priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
 				    &regs->mb[i].can_ctrl);
 		}


