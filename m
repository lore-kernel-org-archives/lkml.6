Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742EAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467BA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895475;
	bh=Enu4ctradxyBZdgzdrzNB4zd6gHjAy/IJFIWQJzxvBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P4iYRZykom4ltmgJuYyEBsxE2jqy9AlsVFnXwQIzcwHh44dkbToKY1kWbFSTbdyY+
	 Bz6CghPg5hvsc1klqM1EgOg/esOobco1TYv6XCBx2LPzn5JGI8ws0gCkqgIEjXvmh2
	 SM811DopWhhuhp1/IOVkmTlgbH2vL/ii1+pZOOmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfBKObN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbfBKObK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8969C20838;
        Mon, 11 Feb 2019 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895470;
        bh=Enu4ctradxyBZdgzdrzNB4zd6gHjAy/IJFIWQJzxvBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6j5MfQENwa0KCLLz5T+aaLTHrELWZUwP7LDCP2qSc6NlRh52buNPLhjfXoVKWzNm
         tdXUXtsFtEZ2/9Th7qheijK1t376KI7Z5jZZG/wi83KkwjtbG8AYFqPn6XJqUrpQ9e
         kvZs516Ulqzgil+mzjMGKfeKQA/6ie39lx2d56Q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beomho Seo <beomho.seo@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 184/352] tty: serial: samsung: Properly set flags in autoCTS mode
Date:   Mon, 11 Feb 2019 15:16:51 +0100
Message-Id: <20190211141858.828673041@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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
index da1bd4bba8a9..2a49b6d876b8 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1365,11 +1365,14 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
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



