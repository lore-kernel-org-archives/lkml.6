Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033902AbeE1KY5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033673AbeE1KYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:24:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 239/268] serial: samsung: Fix out-of-bounds access through serial port index
Date: Mon, 28 May 2018 12:03:33 +0200
Message-Id: <20180528100230.370107414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 49ee23b71877831ac087d6083f6f397dc19c9664 ]

The s3c24xx_serial_ports[] array is indexed using a value derived from
the "serialN" alias in DT, or from an incrementing probe index, which
may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using
a legitimate DTB or legitimate board code.

Fixes: 13a9f6c64fdc55eb ("serial: samsung: Consider DT alias when probing ports")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1807,6 +1807,10 @@ static int s3c24xx_serial_probe(struct p
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= ARRAY_SIZE(s3c24xx_serial_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
