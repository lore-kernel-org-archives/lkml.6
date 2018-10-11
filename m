Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B468C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4463020835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4463020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeJKQvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:51:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41980 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:51:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aragua)
        with ESMTPSA id B811427D502
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: [PATCH v3 1/1] serial: imx - Add dma buffer confugration via sysfs
Date:   Thu, 11 Oct 2018 11:25:03 +0200
Message-Id: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to optimize serial communication on imx53 and imx6, we may
need to tweak DMA period and buffer length per period.
This patch add sysfs attributes to configure thoses values before
initialising DMA.

For example, you can access values by reading/writing:

/sys/class/tty/ttymxc*/dma_buffer_size
/sys/class/tty/ttymxc*/dma_buffer_count

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
Changes since v2:
  - Improve attribute documentation
  - Fix various typo
  - Remove useless debug message
  - Clean code

 Documentation/ABI/stable/sysfs-driver-imx-uart | 13 ++++
 drivers/tty/serial/imx.c                       | 89 ++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-imx-uart

diff --git a/Documentation/ABI/stable/sysfs-driver-imx-uart b/Documentation/ABI/stable/sysfs-driver-imx-uart
new file mode 100644
index 0000000..0a55fcf
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-imx-uart
@@ -0,0 +1,13 @@
+What:		/sys/class/tty/ttymxc*/dma_buffer_count
+Date:		October 2018
+Contact:	Fabien Lahoudere <fabien.lahoudere@collabora.com>
+Description:	imx serial use dma buffer for rx communication. The size of this
+		buffer is splited in several chunk. The number of chunk is
+		determined by the field rx_periods (in struct imx_uart). This
+		attribute allows to modify rx_periods.
+
+What:		/sys/class/tty/ttymxc*/dma_buffer_size
+Date:		October 2018
+Contact:	Fabien Lahoudere <fabien.lahoudere@collabora.com>
+Description:	Field rx_period_length (in struct imx_uart) allows us to
+		determine the size of each chunk of rx DMA buffer.
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d4e051b..9622492 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -220,6 +220,8 @@ struct imx_port {
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	void			*rx_buf;
 	struct circ_buf		rx_ring;
+	unsigned int		rx_buf_size;
+	unsigned int		rx_period_length;
 	unsigned int		rx_periods;
 	dma_cookie_t		rx_cookie;
 	unsigned int		tx_bytes;
@@ -1025,8 +1027,6 @@ static void imx_uart_timeout(struct timer_list *t)
 	}
 }
 
-#define RX_BUF_SIZE	(PAGE_SIZE)
-
 /*
  * There are two kinds of RX DMA interrupts(such as in the MX6Q):
  *   [1] the RX DMA buffer is full.
@@ -1121,9 +1121,8 @@ static int imx_uart_start_rx_dma(struct imx_port *sport)
 
 	sport->rx_ring.head = 0;
 	sport->rx_ring.tail = 0;
-	sport->rx_periods = RX_DMA_PERIODS;
 
-	sg_init_one(sgl, sport->rx_buf, RX_BUF_SIZE);
+	sg_init_one(sgl, sport->rx_buf, sport->rx_buf_size);
 	ret = dma_map_sg(dev, sgl, 1, DMA_FROM_DEVICE);
 	if (ret == 0) {
 		dev_err(dev, "DMA mapping error for RX.\n");
@@ -1241,7 +1240,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
 		goto err;
 	}
 
-	sport->rx_buf = kzalloc(RX_BUF_SIZE, GFP_KERNEL);
+	sport->rx_buf_size = sport->rx_period_length * sport->rx_periods;
+	sport->rx_buf = kzalloc(sport->rx_buf_size, GFP_KERNEL);
 	if (!sport->rx_buf) {
 		ret = -ENOMEM;
 		goto err;
@@ -1702,6 +1702,82 @@ static const char *imx_uart_type(struct uart_port *port)
 	return sport->port.type == PORT_IMX ? "IMX" : NULL;
 }
 
+
+static ssize_t dma_buffer_size_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	unsigned int plen;
+	int ret;
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	if (sport->dma_chan_rx) {
+		dev_warn(dev, "DMA channel is not initialized\n");
+		return -EBUSY;
+	}
+	ret = kstrtou32(buf, 0, &plen);
+	if (ret == 0) {
+		sport->rx_period_length = plen;
+		ret = count;
+	}
+	return ret;
+}
+
+static ssize_t dma_buffer_size_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	return sprintf(buf, "%u\n", sport->rx_period_length);
+}
+
+static DEVICE_ATTR_RW(dma_buffer_size);
+
+static ssize_t dma_buffer_count_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	unsigned int periods;
+	int ret;
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	if (sport->dma_chan_rx) {
+		dev_warn(dev, "DMA channel is not initialized\n");
+		return -EBUSY;
+	}
+	ret = kstrtou32(buf, 0, &periods);
+	if (ret == 0) {
+		sport->rx_periods = periods;
+		ret = count;
+	}
+	return ret;
+}
+
+static ssize_t dma_buffer_count_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct device *port_device = dev->parent;
+	struct imx_port *sport = dev_get_drvdata(port_device);
+
+	return sprintf(buf, "%u\n", sport->rx_periods);
+}
+
+static DEVICE_ATTR_RW(dma_buffer_count);
+
+static struct attribute *imx_uart_attrs[] = {
+	&dev_attr_dma_buffer_size.attr,
+	&dev_attr_dma_buffer_count.attr,
+	NULL
+};
+static struct attribute_group imx_uart_attr_group = {
+	.attrs = imx_uart_attrs,
+};
+
 /*
  * Configure/autoconfigure the port.
  */
@@ -2233,6 +2309,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->port.rs485_config = imx_uart_rs485_config;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	timer_setup(&sport->timer, imx_uart_timeout, 0);
+	sport->rx_period_length = PAGE_SIZE / RX_DMA_PERIODS;
+	sport->rx_periods = RX_DMA_PERIODS;
+	sport->port.attr_group = &imx_uart_attr_group;
 
 	sport->gpios = mctrl_gpio_init(&sport->port, 0);
 	if (IS_ERR(sport->gpios))
-- 
1.8.3.1

