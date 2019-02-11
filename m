Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A03C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E30206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897132;
	bh=aoloXDOheKaCFBTBvO0HrFVbMYz3KQkpCXZ6D6eDmSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gq7dGvE4EWaOwIBZDJ+UX7/Bem4Ha/ZaTtMufIeQG+hue9UclAbrASwDhxzPPtE7f
	 QZk+3v8l5v/T5NJsRfwZrCsBN0RAz6OQNN3ntX+Vjc9z305YyCkWCcthNfaEYlcSQp
	 UjuXE5HNCeGIUGZ6nGDOuCu0L9Dg05u1Bokk5PGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfBKO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389639AbfBKO6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:58:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A0B222A6;
        Mon, 11 Feb 2019 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897126;
        bh=aoloXDOheKaCFBTBvO0HrFVbMYz3KQkpCXZ6D6eDmSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zy6xR/1+wfy3bMyCEo03gHpfekCW6UdI+nJOPkuadm57Gqj3EmQdwBpgwVbeM38+2
         raMH+x/7n0z8/eQhKatSeC63Ael8kZ+brdhRSrye5/oTaQ6DxWQnivmGj13xzo/3CX
         NYlMznUULjpIkAfbwnoVOjS0nYwBUfMjYPbK17F0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beomho Seo <beomho.seo@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 100/205] tty: serial: samsung: Properly set flags in autoCTS mode
Date:   Mon, 11 Feb 2019 15:18:18 +0100
Message-Id: <20190211141835.136540637@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 31e933645742ee6719d37573a27cce0761dcf92b ]

Commit 391f93f2ec9f ("serial: core: Rework hw-assited flow control support")
has changed the way the autoCTS mode is handled.

According to that change, serial drivers which enable H/W autoCTS mode must
set UPSTAT_AUTOCTS to prevent the serial core from inadvertently disabling
TX. This patch adds proper handling of UPSTAT_AUTOCTS flag.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
[mszyprow: rephrased commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 57baa84ccf86..f4b8e4e17a86 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1343,11 +1343,14 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
 
+	port->status &= ~UPSTAT_AUTOCTS;
+
 	umcon = rd_regl(port, S3C2410_UMCON);
 	if (termios->c_cflag & CRTSCTS) {
 		umcon |= S3C2410_UMCOM_AFC;
 		/* Disable RTS when RX FIFO contains 63 bytes */
 		umcon &= ~S3C2412_UMCON_AFC_8;
+		port->status = UPSTAT_AUTOCTS;
 	} else {
 		umcon &= ~S3C2410_UMCOM_AFC;
 	}
-- 
2.19.1



