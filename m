Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D26BC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFA0206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfANB0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:26:03 -0500
Received: from muru.com ([72.249.23.125]:33560 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfANB0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 20:26:01 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9E5138139;
        Mon, 14 Jan 2019 01:26:04 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>, Jiri Slaby <jslaby@suse.cz>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/3] tty: n_gsm: Add support for serdev drivers
Date:   Sun, 13 Jan 2019 17:25:28 -0800
Message-Id: <20190114012528.2367-4-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114012528.2367-1-tony@atomide.com>
References: <20190114012528.2367-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can make use of serdev drivers to do simple device drivers for
TS 27.010 chanels, and we can handle vendor specific protocols on top
of TS 27.010 with serdev drivers.

Serdev device drivers can be done for channel specific features, such
as GNSS framework and Alsa ASoC voice call audio mixer found on some
modems. And serdev drivers can be used to provide character devices
for things like AT modems on TS 27.010 channels.

So far this has been tested with Motorola droid4 where there is a custom
packet numbering protocol on top of TS 27.010 for the MDM6600 modem. I'll
be posting the motorola-mdm MFD driver separately followed by channel
specific drivers for Alsa ASoC and GNSS frameworks.

I initially though about adding the serdev support into a separate file,
but that will take some refactoring of n_gsm.c. And I'd like to have
things working first. Then later on we might want to consider splitting
n_gsm.c into three pieces for core, tty and serdev parts.

Cc: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/n_gsm.c        | 317 +++++++++++++++++++++++++++++++++++++
 include/linux/serdev-gsm.h | 227 ++++++++++++++++++++++++++
 2 files changed, 544 insertions(+)
 create mode 100644 include/linux/serdev-gsm.h

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -39,6 +39,7 @@
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/serdev.h>
 #include <linux/timer.h>
 #include <linux/tty_flip.h>
 #include <linux/tty_driver.h>
@@ -50,6 +51,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/gsmmux.h>
+#include <linux/serdev-gsm.h>
 
 static int debug;
 module_param(debug, int, 0600);
@@ -145,6 +147,7 @@ struct gsm_dlci {
 	/* Data handling callback */
 	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
+	struct gsm_serdev_dlci *ops; /* serdev dlci ops, if used */
 	struct net_device *net; /* network interface, if created */
 };
 
@@ -179,6 +182,7 @@ struct gsm_control {
  */
 
 struct gsm_mux {
+	struct gsm_serdev *gsd;		/* Serial device bus data */
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
 	spinlock_t lock;
 	struct mutex mutex;
@@ -2319,6 +2323,319 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	return 0;
 }
 
+#ifdef CONFIG_SERIAL_DEV_BUS
+static int gsd_get_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	struct gsm_mux *gsm;
+
+	if (!gsd || !gsd->gsm)
+		return -ENODEV;
+
+	gsm = gsd->gsm;
+
+	if (!c)
+		return -EINVAL;
+
+	gsm_copy_config_values(gsm, c);
+
+	return 0;
+}
+
+static int gsd_set_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	struct gsm_mux *gsm;
+
+	if (!gsd || !gsd->serdev || !gsd->gsm)
+		return -ENODEV;
+
+	gsm = gsd->gsm;
+
+	if (!c)
+		return -EINVAL;
+
+	return gsm_config(gsm, c);
+}
+
+static struct gsm_dlci *gsd_dlci_get(struct gsm_serdev *gsd, int line,
+				     bool allocate)
+{
+	struct gsm_mux *gsm;
+	struct gsm_dlci *dlci;
+
+	if (!gsd || !gsd->gsm)
+		return ERR_PTR(-ENODEV);
+
+	gsm = gsd->gsm;
+
+	if (line < 1 || line >= 63)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&gsm->mutex);
+
+	if (gsm->dlci[line]) {
+		dlci = gsm->dlci[line];
+		goto unlock;
+	} else if (!allocate) {
+		dlci = ERR_PTR(-ENODEV);
+		goto unlock;
+	}
+
+	dlci = gsm_dlci_alloc(gsm, line);
+	if (!dlci) {
+		gsm = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
+
+	gsm->dlci[line] = dlci;
+
+unlock:
+	mutex_unlock(&gsm->mutex);
+
+	return dlci;
+}
+
+static void gsd_dlci_data(struct gsm_dlci *dlci, const u8 *buf, int len)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	struct gsm_serdev *gsd = gsm->gsd;
+
+	if (!gsd || !dlci->ops)
+		return;
+
+	switch (dlci->adaption) {
+	case 0:
+	case 1:
+		if (dlci->ops->receive_buf)
+			dlci->ops->receive_buf(dlci->ops, buf, len);
+		break;
+	default:
+		pr_warn("dlci%i adaption %i not yet implemented\n",
+			dlci->addr, dlci->adaption);
+		break;
+	}
+}
+
+static int gsd_write(struct gsm_serdev *gsd, struct gsm_serdev_dlci *sd,
+		     const u8 *buf, int len)
+{
+	struct gsm_mux *gsm;
+	struct gsm_dlci *dlci;
+	struct gsm_msg *msg;
+	int h, size, total_size = 0;
+	u8 *dp;
+
+	if (!gsd || !gsd->gsm)
+		return -ENODEV;
+
+	gsm = gsd->gsm;
+
+	dlci = gsd_dlci_get(gsd, sd->line, false);
+	if (IS_ERR(dlci))
+		return PTR_ERR(dlci);
+
+	h = dlci->adaption - 1;
+
+	if (len > gsm->mtu)
+		len = gsm->mtu;
+
+	size = len + h;
+
+	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+	if (!msg)
+		return -ENOMEM;
+
+	dp = msg->data;
+	switch (dlci->adaption) {
+	case 1:
+		break;
+	case 2:
+		*dp++ = gsm_encode_modem(dlci);
+		break;
+	}
+	memcpy(dp, buf, len);
+	__gsm_data_queue(dlci, msg);
+	total_size += size;
+
+	return total_size;
+}
+
+static void gsd_data_kick(struct gsm_serdev *gsd)
+{
+	struct gsm_mux *gsm;
+	unsigned long flags;
+
+	if (!gsd || !gsd->gsm)
+		return;
+
+	gsm = gsd->gsm;
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	gsm_data_kick(gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+}
+
+static int gsd_register_dlci(struct gsm_serdev *gsd,
+			     struct gsm_serdev_dlci *ops)
+{
+	struct gsm_dlci *dlci;
+	struct gsm_mux *gsm;
+
+	if (!gsd || !gsd->gsm || !gsd->serdev)
+		return -ENODEV;
+
+	gsm = gsd->gsm;
+
+	if (!ops || !ops->line || !ops->receive_buf)
+		return -EINVAL;
+
+	dlci = gsd_dlci_get(gsd, ops->line, true);
+	if (IS_ERR(dlci))
+		return PTR_ERR(dlci);
+
+	if (dlci->state == DLCI_OPENING || dlci->state == DLCI_OPEN ||
+	    dlci->state == DLCI_CLOSING)
+		return -EBUSY;
+
+	mutex_lock(&dlci->mutex);
+	dlci->ops = ops;
+	dlci->modem_rx = 0;
+	dlci->prev_data = dlci->data;
+	dlci->data = gsd_dlci_data;
+	mutex_unlock(&dlci->mutex);
+
+	gsm_dlci_begin_open(dlci);
+
+	return 0;
+}
+
+static void gsd_unregister_dlci(struct gsm_serdev *gsd,
+				struct gsm_serdev_dlci *ops)
+{
+	struct gsm_mux *gsm;
+	struct gsm_dlci *dlci;
+
+	if (!gsd || !gsd->gsm || !gsd->serdev || !gsd->unregister_dlci)
+		return;
+
+	gsm = gsd->gsm;
+
+	if (!ops || !ops->line)
+		return;
+
+	dlci = gsd_dlci_get(gsd, ops->line, false);
+	if (IS_ERR(dlci))
+		return;
+
+	mutex_lock(&dlci->mutex);
+	gsm_destroy_network(dlci);
+	dlci->data = dlci->prev_data;
+	dlci->ops = NULL;
+	mutex_unlock(&dlci->mutex);
+
+	gsm_dlci_begin_close(dlci);
+}
+
+static int gsm_serdev_output(struct gsm_mux *gsm, u8 *data, int len)
+{
+	struct gsm_serdev *gsd = gsm->gsd;
+	struct serdev_device *serdev = gsm->gsd->serdev;
+	bool asleep;
+
+	asleep = atomic_read(&gsd->asleep);
+	if (asleep)
+		return -ENOSPC;
+
+	if (gsm->gsd->output)
+		return gsm->gsd->output(gsm->gsd, data, len);
+	else
+		return serdev_device_write_buf(serdev, data, len);
+}
+
+static int gsd_receive_buf(struct serdev_device *serdev, const u8 *data,
+			   size_t count)
+{
+	struct gsm_serdev *gsd = serdev_device_get_drvdata(serdev);
+	struct gsm_mux *gsm;
+	const unsigned char *dp;
+	int i;
+
+	if (WARN_ON(!gsd))
+		return 0;
+
+	gsm = gsd->gsm;
+
+	if (debug & 4)
+		print_hex_dump_bytes("gsd_receive_buf: ",
+				     DUMP_PREFIX_OFFSET,
+				     data, count);
+
+	for (i = count, dp = data; i; i--, dp++)
+		gsm->receive(gsm, *dp);
+
+	return count;
+}
+
+static void gsd_write_wakeup(struct serdev_device *serdev)
+{
+	serdev_device_write_wakeup(serdev);
+}
+
+static struct serdev_device_ops gsd_client_ops = {
+	.receive_buf = gsd_receive_buf,
+	.write_wakeup = gsd_write_wakeup,
+};
+
+int gsm_serdev_register_device(struct gsm_serdev *gsd)
+{
+	struct gsm_mux *gsm;
+	int error;
+
+	if (WARN(!gsd || !gsd->serdev || !gsd->output,
+		 "serdev and output must be initialized\n"))
+		return -EINVAL;
+
+	serdev_device_set_client_ops(gsd->serdev, &gsd_client_ops);
+
+	gsm = gsm_alloc_mux();
+	if (!gsm)
+		return -ENOMEM;
+
+	gsm->encoding = 1;
+	gsm->tty = NULL;
+	gsm->gsd = gsd;
+	atomic_set(&gsd->asleep, 0);
+	gsd->gsm = gsm;
+	gsd->get_config = gsd_get_config;
+	gsd->set_config = gsd_set_config;
+	gsd->register_dlci = gsd_register_dlci;
+	gsd->unregister_dlci = gsd_unregister_dlci;
+	gsm->output = gsm_serdev_output;
+	gsd->write = gsd_write;
+	gsd->kick = gsd_data_kick;
+	mux_get(gsd->gsm);
+
+	error = gsm_activate_mux(gsd->gsm);
+	if (error) {
+		gsm_cleanup_mux(gsd->gsm);
+		mux_put(gsd->gsm);
+
+		return error;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_register_device);
+
+void gsm_serdev_unregister_device(struct gsm_serdev *gsd)
+{
+	gsm_cleanup_mux(gsd->gsm);
+	mux_put(gsd->gsm);
+	gsd->gsm = NULL;
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_unregister_device);
+
+#endif	/* CONFIG_SERIAL_DEV_BUS */
+
 /**
  *	gsmld_output		-	write to link
  *	@gsm: our mux
diff --git a/include/linux/serdev-gsm.h b/include/linux/serdev-gsm.h
new file mode 100644
--- /dev/null
+++ b/include/linux/serdev-gsm.h
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct serdev_device;
+struct gsm_mux;
+struct gsm_config;
+struct gsm_dlci;
+struct gsm_serdev_dlci;
+
+/**
+ * struct gsm_serdev - serdev-gsm instance
+ * @serdev:		serdev instance
+ * @gsm:		ts 27.010 n_gsm instance
+ * @asleep:		device is in idle state
+ * @drvdata:		serdev-gsm consumer driver data
+ * @get_config:		get ts 27.010 config
+ * @set_config:		set ts 27.010 config
+ * @register_dlci:	register ts 27.010 channel
+ * @unregister_dlci:	unregister ts 27.010 channel
+ * @output:		read data from ts 27.010 channel
+ * @write:		write data to a ts 27.010 channel
+ * @kick:		indicate more data is ready
+ *
+ * Currently only serdev and output must be initialized, the rest are
+ * are initialized by gsm_serdev_register_dlci().
+ */
+struct gsm_serdev {
+	struct serdev_device *serdev;
+	struct gsm_mux *gsm;
+	atomic_t asleep;
+	void *drvdata;
+	int (*get_config)(struct gsm_serdev *gsd, struct gsm_config *c);
+	int (*set_config)(struct gsm_serdev *gsd, struct gsm_config *c);
+	int (*register_dlci)(struct gsm_serdev *gsd,
+			     struct gsm_serdev_dlci *ops);
+	void (*unregister_dlci)(struct gsm_serdev *gsd,
+				struct gsm_serdev_dlci *ops);
+	int (*output)(struct gsm_serdev *gsd, u8 *data, int len);
+	int (*write)(struct gsm_serdev *gsd, struct gsm_serdev_dlci *ops,
+		     const u8 *buf, int len);
+	void (*kick)(struct gsm_serdev *gsd);
+};
+
+/**
+ * struct gsm_serdev_dlci - serdev-gsm ts 27.010 channel data
+ * @line:		ts 27.010 channel, control channel 0 is not available
+ * @receive_buf:	function to handle data received for the channel
+ */
+struct gsm_serdev_dlci {
+	int line;
+	int (*receive_buf)(struct gsm_serdev_dlci *ops,
+			   const unsigned char *buf,
+			   size_t len);
+};
+
+#ifdef CONFIG_SERIAL_DEV_BUS
+
+int gsm_serdev_register_device(struct gsm_serdev *gsd);
+void gsm_serdev_unregister_device(struct gsm_serdev *gsd);
+
+static inline void *gsm_serdev_get_drvdata(struct device *dev)
+{
+	struct serdev_device *serdev = to_serdev_device(dev);
+	struct gsm_serdev *gsd = serdev_device_get_drvdata(serdev);
+
+	if (gsd)
+		return gsd->drvdata;
+
+	return NULL;
+}
+
+static inline void gsm_serdev_set_drvdata(struct device *dev, void *drvdata)
+{
+	struct serdev_device *serdev = to_serdev_device(dev);
+	struct gsm_serdev *gsd = serdev_device_get_drvdata(serdev);
+
+	if (gsd)
+		gsd->drvdata = drvdata;
+}
+
+/**
+ * gsm_serdev_get_config - read ts 27.010 config
+ * @gsd:	serdev-gsm instance
+ * @c:		ts 27.010 config data
+ *
+ * See gsm_copy_config_values() for more information.
+ */
+static inline
+int gsm_serdev_get_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	return gsd->get_config(gsd, c);
+}
+
+/**
+ * gsm_serdev_set_config - set ts 27.010 config
+ * @gsd:	serdev-gsm instance
+ * @c:		ts 27.010 config data
+ *
+ * See gsm_config() for more information.
+ */
+static inline
+int gsm_serdev_set_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	if (gsd && gsd->set_config)
+		return gsd->set_config(gsd, c);
+
+	return -ENODEV;
+}
+
+/**
+ * gsm_serdev_register_dlci - register a ts 27.010 channel
+ * @gsd:	serdev-gsm instance
+ * @ops:	channel ops
+ */
+static inline
+int gsm_serdev_register_dlci(struct gsm_serdev *gsd,
+			     struct gsm_serdev_dlci *ops)
+{
+	if (gsd && gsd->register_dlci)
+		return gsd->register_dlci(gsd, ops);
+
+	return -ENODEV;
+}
+
+/**
+ * gsm_serdev_unregister_dlci - unregister a ts 27.010 channel
+ * @gsd:	serdev-gsm instance
+ * @ops:	channel ops
+ */
+static inline
+void gsm_serdev_unregister_dlci(struct gsm_serdev *gsd,
+				struct gsm_serdev_dlci *ops)
+{
+	if (gsd && gsd->unregister_dlci)
+		gsd->unregister_dlci(gsd, ops);
+}
+
+/**
+ * gsm_serdev_write - write data to a ts 27.010 channel
+ * @gsd:	serdev-gsm instance
+ * @ops:	channel ops
+ * @buf:	write buffer
+ * @len:	buffer length
+ */
+static inline
+int gsm_serdev_write(struct gsm_serdev *gsd, struct gsm_serdev_dlci *ops,
+		     const u8 *buf, int len)
+{
+	if (gsd && gsd->write)
+		return gsd->write(gsd, ops, buf, len);
+
+	return -ENODEV;
+}
+
+/**
+ * gsm_serdev_data_kick - indicate more data can be trasmitted
+ * @gsd:	serdev-gsm instance
+ *
+ * See gsm_data_kick() for more information.
+ */
+static inline
+void gsm_serdev_data_kick(struct gsm_serdev *gsd)
+{
+	if (gsd && gsd->kick)
+		gsd->kick(gsd);
+}
+
+#else	/* CONFIG_SERIAL_DEV_BUS */
+
+static inline
+int gsm_serdev_register_device(struct gsm_serdev *gsd)
+{
+	return -ENODEV;
+}
+
+static inline
+void gsm_serdev_unregister_device(struct gsm_serdev *gsd)
+{
+}
+
+static inline void *gsm_serdev_get_drvdata(struct device *dev)
+{
+	return NULL;
+}
+
+static inline
+void gsm_serdev_set_drvdata(struct device *dev, void *drvdata)
+{
+}
+
+static inline
+int gsm_serdev_get_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	return -ENODEV;
+}
+
+static inline
+int gsm_serdev_set_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	return -ENODEV;
+}
+
+static inline
+int gsm_serdev_register_dlci(struct gsm_serdev *gsd,
+			     struct gsm_serdev_dlci *ops)
+{
+	return -ENODEV;
+}
+
+static inline
+void gsm_serdev_unregister_dlci(struct gsm_serdev *gsd,
+				struct gsm_serdev_dlci *ops)
+{
+}
+
+static inline
+int gsm_serdev_write(struct gsm_serdev *gsd, struct gsm_serdev_dlci *ops,
+		     const u8 *buf, int len)
+{
+	return -ENODEV;
+}
+
+static inline
+void gsm_serdev_data_kick(struct gsm_serdev *gsd)
+{
+}
+
+#endif	/* CONFIG_SERIAL_DEV_BUS */
-- 
2.20.1
