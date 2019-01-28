Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C25C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1945621741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695243;
	bh=x1TrWQ5QGa3Kz5v2C5GsoamHgnS6WH81ku5mw0Ce7bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xEUu1+vKXM/cZqahMSb5dyi35Ked2pmUX2HBUW5WnRI97Xep8KJpRzc3NGhoVGpg4
	 MFTeHGc5MheuOz8Spmpn+wpku6NyOdR95LCQ1smb9fwGh6qPTPTgfgACpRoN9NrBoQ
	 WbxdRU3e2XMtHQlFCU87YERi+0xugCv16ljTjuKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbfA1QMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:12:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733223AbfA1QMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49F72175B;
        Mon, 28 Jan 2019 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691969;
        bh=x1TrWQ5QGa3Kz5v2C5GsoamHgnS6WH81ku5mw0Ce7bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WO4ZFu5YNSX+lFrqUtnkuP0MZR//nlQoB8XkNn7svUHASvZPzBRWFQnMD5XuC5f7/
         J4ln4tLN51LBDQ22ndnElzd7WxLDE4G5G1jpc3cXWLEexeciJC0vZ+1nT4PS+Mh5o9
         Sq2nAaDv5Lf996kAVBsja4MPAuhjynvAgYcKEGhc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Duan <fugang.duan@nxp.com>, Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 020/170] serial: fsl_lpuart: clear parity enable bit when disable parity
Date:   Mon, 28 Jan 2019 11:09:30 -0500
Message-Id: <20190128161200.55107-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

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
index fd64ac2c1a74..716c33b2a11c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1482,6 +1482,8 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				cr1 &= ~UARTCR1_PT;
 		}
+	} else {
+		cr1 &= ~UARTCR1_PE;
 	}
 
 	/* ask the core to calculate the divisor */
@@ -1694,6 +1696,8 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				ctrl &= ~UARTCTRL_PT;
 		}
+	} else {
+		ctrl &= ~UARTCTRL_PE;
 	}
 
 	/* ask the core to calculate the divisor */
-- 
2.19.1

