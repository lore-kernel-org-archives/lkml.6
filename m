Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033676AbeE1KX3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033216AbeE1KXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:23:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 207/268] i2c: mv64xxx: Apply errata delay only in standard mode
Date: Mon, 28 May 2018 12:03:01 +0200
Message-Id: <20180528100225.710813105@linuxfoundation.org>
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

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit 31184d8c6ea49ea0676d100cdd7e1f102ad025b5 ]

The errata FE-8471889 description has been updated. There is still a
timing violation for repeated start. But the errata now states that it
was only the case for the Standard mode (100 kHz), in Fast mode (400 kHz)
there is no issue.

This patch limit the errata fix to the Standard mode.

It has been tesed successfully on the clearfog (Aramda 388 based board).

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -856,12 +856,16 @@ mv64xxx_of_config(struct mv64xxx_i2c_dat
 	 */
 	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
 		drv_data->offload_enabled = true;
-		drv_data->errata_delay = true;
+		/* The delay is only needed in standard mode (100kHz) */
+		if (bus_freq <= 100000)
+			drv_data->errata_delay = true;
 	}
 
 	if (of_device_is_compatible(np, "marvell,mv78230-a0-i2c")) {
 		drv_data->offload_enabled = false;
-		drv_data->errata_delay = true;
+		/* The delay is only needed in standard mode (100kHz) */
+		if (bus_freq <= 100000)
+			drv_data->errata_delay = true;
 	}
 
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
