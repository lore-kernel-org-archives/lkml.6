Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033913AbeE1PMF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033718AbeE1KXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:23:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 186/268] m68k: set dma and coherent masks for platform FEC ethernets
Date: Mon, 28 May 2018 12:02:40 +0200
Message-Id: <20180528100223.428219253@linuxfoundation.org>
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

From: Greg Ungerer <gerg@linux-m68k.org>

[ Upstream commit f61e64310b75733d782e930d1fb404b84699eed6 ]

As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
coherent_dma_mask") the Freescale FEC driver is issuing the following
warning on driver initialization on ColdFire systems:

WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 0x40159e20
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc7-dirty #4
Stack from 41833dd8:
        41833dd8 40259c53 40025534 40279e26 00000003 00000000 4004e514 41827000
        400255de 40244e42 00000204 40159e20 00000009 00000000 00000000 4024531d
        40159e20 40244e42 00000204 00000000 00000000 00000000 00000007 00000000
        00000000 40279e26 4028d040 40226576 4003ae88 40279e26 418273f6 41833ef8
        7fffffff 418273f2 41867028 4003c9a2 4180ac6c 00000004 41833f8c 4013e71c
        40279e1c 40279e26 40226c16 4013ced2 40279e26 40279e58 4028d040 00000000
Call Trace:
        [<40025534>] 0x40025534
 [<4004e514>] 0x4004e514
 [<400255de>] 0x400255de
 [<40159e20>] 0x40159e20
 [<40159e20>] 0x40159e20

It is not fatal, the driver and the system continue to function normally.

As per the warning the coherent_dma_mask is not set on this device.
There is nothing special about the DMA memory coherency on this hardware
so we can just set the mask to 32bits in the platform data for the FEC
ethernet devices.

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/coldfire/device.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -135,7 +135,11 @@ static struct platform_device mcf_fec0 =
 	.id			= 0,
 	.num_resources		= ARRAY_SIZE(mcf_fec0_resources),
 	.resource		= mcf_fec0_resources,
-	.dev.platform_data	= FEC_PDATA,
+	.dev = {
+		.dma_mask		= &mcf_fec0.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= FEC_PDATA,
+	}
 };
 
 #ifdef MCFFEC_BASE1
@@ -167,7 +171,11 @@ static struct platform_device mcf_fec1 =
 	.id			= 1,
 	.num_resources		= ARRAY_SIZE(mcf_fec1_resources),
 	.resource		= mcf_fec1_resources,
-	.dev.platform_data	= FEC_PDATA,
+	.dev = {
+		.dma_mask		= &mcf_fec1.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= FEC_PDATA,
+	}
 };
 #endif /* MCFFEC_BASE1 */
 #endif /* CONFIG_FEC */
