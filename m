Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033339AbeE2Bsc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:48:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:44122 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033268AbeE2BsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:48:25 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 08/15] fsi/fsi-master-gpio: Delay sampling of FSI data input
Date: Tue, 29 May 2018 11:30:37 +1000
Message-Id: <20180529013044.23815-9-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most SoC GPIO implementations, including the Aspeed one, have
synchronizers on the GPIO inputs. This means that the value
read from a GPIO is a couple of clocks old, from whatever clock
source feeds those synchronizers.

In practice, this means that in no-delay mode, we are using a
value that can potentially be a bit too old and too close to
the clock edge establishing the data on the other side of the link.

The voltage converters we use on some systems make this worse
and sensitive to things like voltage fluctuations etc... This is,
we believe, the cause of occasional CRC errors encountered during
heavy activity on the LPC bus.

This is fixed by introducing a dummy GPIO read before the actual
data read. It slows down SBEFIFO by about 15% (less than any delay
primitive) and the end result is so far solid.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-master-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index bd2b2cbd5eb5..e1bde9e3f855 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -97,6 +97,11 @@ static int sda_clock_in(struct fsi_master_gpio *master)
 	if (!master->no_delays)
 		ndelay(FSI_GPIO_STD_DLY);
 	gpiod_set_value(master->gpio_clk, 0);
+
+	/* Dummy read to feed the synchronizers */
+	gpiod_get_value(master->gpio_data);
+
+	/* Actual data read */
 	in = gpiod_get_value(master->gpio_data);
 	if (!master->no_delays)
 		ndelay(FSI_GPIO_STD_DLY);
-- 
2.17.0
