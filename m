Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C7EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E9720844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695730;
	bh=9sg0RXQ+2peYOaaRG2FbiVcbSHHL7RYsBC+BOtfRIBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0098CByQ1Hk/msT1E3JrfYIiAH/yK6lu+xVVuf5hGmHau7pvCCoCIVkdjPqXxV637
	 WuPYsnCvK57LBXvtua9xqJuvXCQ2nvJCZgEPYY8kde4ot5abRl2QBZLEHAIS3YHTFZ
	 cPDOsGtLzgJkpjbj/KDlQ/l4gxNaIcbJcobbuem0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbfA1RP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbfA1QHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:07:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E355D2171F;
        Mon, 28 Jan 2019 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691625;
        bh=9sg0RXQ+2peYOaaRG2FbiVcbSHHL7RYsBC+BOtfRIBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwBa8VdGL2wzLlRc4cJY7PrRak+ON72fKhUTt0eXva5HdTXtswwUIkWlcH8RN6kPM
         y0VJQ3o3qu/BveJRYwDpffein34n1+344EbpIf74Si/OQO7XC6R+rlYgUi1SgBw26N
         TDvHGiggo9dRbaC2WBce6CyQrkQXgua/mSap1gbA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 164/258] tty: serial: samsung: Properly set flags in autoCTS mode
Date:   Mon, 28 Jan 2019 10:57:50 -0500
Message-Id: <20190128155924.51521-164-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 2f8fa184aafa..c6058b52d5d5 100644
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

