Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE95ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA25720883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA25720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbeGLWAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:00:39 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:23596 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbeGLWAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:00:39 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 18:00:37 EDT
From:   Tuomas Tynkkynen <tuomas@tuxera.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>
CC:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: [PATCH 1/3] virtio: virtconsole: Use seq_file for debugfs operations
Date:   Fri, 13 Jul 2018 00:39:56 +0300
Message-ID: <20180712213956.21516-1-tuomas@tuxera.com>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Received-SPF: none
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplifies the code and is more conventional to what's used in the rest
of the kernel for debugfs ops.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 drivers/char/virtio_console.c | 60 ++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 21085515814f..f95f980d108d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1310,51 +1310,35 @@ static const struct attribute_group port_attribute_group = {
 	.attrs = port_sysfs_entries,
 };
 
-static ssize_t debugfs_read(struct file *filp, char __user *ubuf,
-			    size_t count, loff_t *offp)
+static int debugfs_show(struct seq_file *s, void *data)
 {
-	struct port *port;
-	char *buf;
-	ssize_t ret, out_offset, out_count;
+	struct port *port = s->private;
+
+	seq_printf(s, "name: %s\n", port->name ? port->name : "");
+	seq_printf(s, "guest_connected: %d\n", port->guest_connected);
+	seq_printf(s, "host_connected: %d\n", port->host_connected);
+	seq_printf(s, "outvq_full: %d\n", port->outvq_full);
+	seq_printf(s, "bytes_sent: %lu\n", port->stats.bytes_sent);
+	seq_printf(s, "bytes_received: %lu\n", port->stats.bytes_received);
+	seq_printf(s, "bytes_discarded: %lu\n", port->stats.bytes_discarded);
+	seq_printf(s, "is_console: %s\n",
+		   is_console_port(port) ? "yes" : "no");
+	seq_printf(s, "console_vtermno: %u\n", port->cons.vtermno);
 
-	out_count = 1024;
-	buf = kmalloc(out_count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	return 0;
+}
 
-	port = filp->private_data;
-	out_offset = 0;
-	out_offset += snprintf(buf + out_offset, out_count,
-			       "name: %s\n", port->name ? port->name : "");
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "guest_connected: %d\n", port->guest_connected);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "host_connected: %d\n", port->host_connected);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "outvq_full: %d\n", port->outvq_full);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "bytes_sent: %lu\n", port->stats.bytes_sent);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "bytes_received: %lu\n",
-			       port->stats.bytes_received);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "bytes_discarded: %lu\n",
-			       port->stats.bytes_discarded);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "is_console: %s\n",
-			       is_console_port(port) ? "yes" : "no");
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "console_vtermno: %u\n", port->cons.vtermno);
-
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
-	kfree(buf);
-	return ret;
+static int debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, debugfs_show, inode->i_private);
 }
 
 static const struct file_operations port_debugfs_ops = {
 	.owner = THIS_MODULE,
-	.open  = simple_open,
-	.read  = debugfs_read,
+	.open = debugfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
 };
 
 static void set_console_size(struct port *port, u16 rows, u16 cols)
-- 
2.16.3

