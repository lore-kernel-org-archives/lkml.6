Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F695C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F92621855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900093;
	bh=xUFmMQWthcndDkJmIc16aTtyltelucZxbYJNPgXLW9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sul9fx1ucQqdrFAAEnFsMx4D8mTeZKUCBnJgAkDSKm+86nGWox5hX4U77/w20hTkO
	 vdxqZWMmcU7Xt4e7K7XMUNBPDso7CC2O+ZpTOABg9muSoBvUyjKrXap2VgKiPCiFet
	 vwLARWRrnJCgPGl+9kZbAQLQsJ+eXWHQbGJN7sNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfBKOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbfBKOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B92020700;
        Mon, 11 Feb 2019 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896047;
        bh=xUFmMQWthcndDkJmIc16aTtyltelucZxbYJNPgXLW9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzzvzQUXWqU97I47b/7zxkuhU3voctc5bjHgcvyNUiMRVBsJuvEJapDfR8y3q451H
         WxVtdzl6ArlDBJkpN1gRcdNvjwdbcjllY25w7Lj3KlII4tJbheAUyw81hipGl3HPyO
         dRvyv8CnBSrfY8y2OfxmvFaybOI4XLzrGaF32Hmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/313] serial: fsl_lpuart: clear parity enable bit when disable parity
Date:   Mon, 11 Feb 2019 15:15:06 +0100
Message-Id: <20190211141855.165321028@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 397bd9211fe014b347ca8f95a8f4e1017bac1aeb ]

Current driver only enable parity enable bit and never clear it
when user set the termios. The fix clear the parity enable bit when
PARENB flag is not set in termios->c_cflag.

Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Andy Duan <fugang.duan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3f8d1274fc85..7d030c2e42ff 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1477,6 +1477,8 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				cr1 &= ~UARTCR1_PT;
 		}
+	} else {
+		cr1 &= ~UARTCR1_PE;
 	}
 
 	/* ask the core to calculate the divisor */
@@ -1688,6 +1690,8 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				ctrl &= ~UARTCTRL_PT;
 		}
+	} else {
+		ctrl &= ~UARTCTRL_PE;
 	}
 
 	/* ask the core to calculate the divisor */
-- 
2.19.1



