Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2552CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7152146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTRswU+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7152146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbeK3Bfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbeK3Bfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58362146D;
        Thu, 29 Nov 2018 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501808;
        bh=aK9HG/37bRM8qOiiNdraJI4L2qEfzloicGqwadoqIgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTRswU+SpnkCg/idhHE3jv5hdLfZqZX2jt+dT74vIHN3JNQLP2+pfBtAaDESVdpKS
         S/MLUFfEiULTRIiljNVPtFd0MaiE+q3ICy1CFXuId1CQ+D8VRTewlHAYVQxVRJ78NY
         oksnzRkhOD1HYSrSGZLQSYBRdaOkbTXt2xydL7F4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 048/110] can: flexcan: Unlock the MB unconditionally
Date:   Thu, 29 Nov 2018 15:12:19 +0100
Message-Id: <20181129135923.203428995@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pankaj Bansal <pankaj.bansal@nxp.com>

commit 5178b7cd8e42448b1041716f124734eaaa36ca50 upstream.

Unlock the MB irrespective of reception method being FIFO or timestamp
based. It is optional but recommended to unlock Mailbox as soon as
possible and make it available for reception.

Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -720,9 +720,14 @@ static unsigned int flexcan_mailbox_read
 			priv->write(BIT(n - 32), &regs->iflag2);
 	} else {
 		priv->write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-		priv->read(&regs->timer);
 	}
 
+	/* Read the Free Running Timer. It is optional but recommended
+	 * to unlock Mailbox as soon as possible and make it available
+	 * for reception.
+	 */
+	priv->read(&regs->timer);
+
 	return 1;
 }
 


