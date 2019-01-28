Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5973BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232AA2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690803;
	bh=//uCo7dUNmQtUHBUHI2xZ3aYwk85q/IwAmVLHEjFoUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iJqB5ohIXW/0YpCYe/2N81lF5Rx9JBes0l/l0gPLFf+mIMX4M4CvvFX7TjeLDL3GZ
	 EN9FCGkQWMla9+gmfEdMddC4IlwXHY5QetM6bNhRV5tkQkKKhxWcMWSh2N+uLuYBvo
	 JYHufwu4y+OgxOByPgDG0asitwB30icbsEjNaudI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfA1PxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfA1PxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D72C2147A;
        Mon, 28 Jan 2019 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690794;
        bh=//uCo7dUNmQtUHBUHI2xZ3aYwk85q/IwAmVLHEjFoUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzOoIHksRVTxZDQ/rKol+x+h9LVkqK9+LORlXxS16wXWkPlAm8b1Pev9zZc+q2xKq
         7MgAPrOmYSJ+7QpX2d1Ek0jdYr6+sBu8LT2y1sQGgvEWdnZdPRzoiBPKsPgwhMk84y
         APvy9GgrPy8q4YiXKFbH8t/Bsq+iiEdHotV8bcyc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 195/304] tty: serial: samsung: Properly set flags in autoCTS mode
Date:   Mon, 28 Jan 2019 10:41:52 -0500
Message-Id: <20190128154341.47195-195-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beomho Seo <beomho.seo@samsung.com>

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

