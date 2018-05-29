Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965504AbeE2CtZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:49:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:58403 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937020AbeE2Csb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:48:31 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 04/15] fsi/fsi-master-gpio: Sample input data on different clock phase
Date: Tue, 29 May 2018 11:30:33 +1000
Message-Id: <20180529013044.23815-5-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently sample the input data right after we toggle the
clock low, then high. The slave establishes the data on the
rising edge, so this is not ideal. We should sample it on
the low phase instead.

This currently works because we have an extra delay, but subsequent
patches will remove it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-master-gpio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 4295a46780cb..d6508bbad1fb 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -86,12 +86,15 @@ static void clock_toggle(struct fsi_master_gpio *master, int count)
 	}
 }
 
-static int sda_in(struct fsi_master_gpio *master)
+static int sda_clock_in(struct fsi_master_gpio *master)
 {
 	int in;
 
 	ndelay(FSI_GPIO_STD_DLY);
+	gpiod_set_value(master->gpio_clk, 0);
 	in = gpiod_get_value(master->gpio_data);
+	ndelay(FSI_GPIO_STD_DLY);
+	gpiod_set_value(master->gpio_clk, 1);
 	return in ? 1 : 0;
 }
 
@@ -126,8 +129,7 @@ static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
 	set_sda_input(master);
 
 	for (bit = 0; bit < num_bits; bit++) {
-		clock_toggle(master, 1);
-		in_bit = sda_in(master);
+		in_bit = sda_clock_in(master);
 		msg->msg <<= 1;
 		msg->msg |= ~in_bit & 0x1;	/* Data is active low */
 	}
-- 
2.17.0
