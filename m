Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033393AbeE1KY1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033526AbeE1KYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:24:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 229/268] media: cx23885: Set subdev host data to clk_freq pointer
Date: Mon, 28 May 2018 12:03:23 +0200
Message-Id: <20180528100229.115203250@linuxfoundation.org>
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

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 5ceade1d97fc6687e050c44c257382c192f56276 ]

Currently clk_freq is ignored entirely, because the cx235840 driver
configures the xtal at the chip defaults. This is an issue if a
board is produced with a non-default frequency crystal. If clk_freq
is not zero the cx25840 will attempt to use the setting provided,
or fall back to defaults otherwise.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx23885/cx23885-cards.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/pci/cx23885/cx23885-cards.c
+++ b/drivers/media/pci/cx23885/cx23885-cards.c
@@ -2124,6 +2124,10 @@ void cx23885_card_setup(struct cx23885_d
 				&dev->i2c_bus[2].i2c_adap,
 				"cx25840", 0x88 >> 1, NULL);
 		if (dev->sd_cx25840) {
+			/* set host data for clk_freq configuration */
+			v4l2_set_subdev_hostdata(dev->sd_cx25840,
+						&dev->clk_freq);
+
 			dev->sd_cx25840->grp_id = CX23885_HW_AV_CORE;
 			v4l2_subdev_call(dev->sd_cx25840, core, load_fw);
 		}
