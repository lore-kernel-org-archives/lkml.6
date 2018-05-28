Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033919AbeE1KZA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033885AbeE1KYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:24:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 240/268] serial: mxs-auart: Fix out-of-bounds access through serial port index
Date: Mon, 28 May 2018 12:03:34 +0200
Message-Id: <20180528100230.477792520@linuxfoundation.org>
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

[ Upstream commit dd345a31bfdec350d2593e6de5964e55c7f19c76 ]

The auart_port[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: 1ea6607d4cdc9179 ("serial: mxs-auart: Allow device tree probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/mxs-auart.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1274,6 +1274,10 @@ static int mxs_auart_probe(struct platfo
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
 		return ret;
+	if (s->port.line >= ARRAY_SIZE(auart_port)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
+		return -EINVAL;
+	}
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
