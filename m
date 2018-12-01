Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE18820867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE0SM4hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE18820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLANw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:52:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41399 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLANwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:52:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so3281089pgh.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A1cj+LBialhESkjGxs42x6EXmL4xGr2KXm/79sH7aBw=;
        b=LE0SM4hpeP1f8sctTDh3iF0jyeWvE+zE34QtEIess2cavdw2FYRws1m8+1R1outxm8
         OVWG8V0YnYDB0SaNOnY58if7Ytl+l6f18nBB/DvSgRXOBBXW/q8CFISPyW2ws2BrFVUn
         9cimVxU0MHeWAP4Lp2eFGEcqTUdBDBhiK9sffuUPyWul3i7xGjkELXxkiU7Ndy6IgwMT
         UJQCFJ7imAjCuxeRfxrhTBUo+yKSe4fZbeyYAE+OkNPQ9rib/A+sgvNokiyiOTahmO1Q
         fJET4E4o7G7y7Oyqjh7W2g3HfkObJD2A840vLL7Z7EyEBPUPXoer+CERbogcNFa327sJ
         42lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A1cj+LBialhESkjGxs42x6EXmL4xGr2KXm/79sH7aBw=;
        b=CmHNpYVc4MrQY6WlZKAp14AYJu/SMSds8Gg3j9mPE3sjp//eBFYtx7sg9nPovOgswk
         63s43ck1pEhRQTIfpCcNSf/Jsi7kdkqcXlr/p5ueTq6l+DdaNE96qT1FQOehFHrcrU3c
         kCErYVEUHJ+sSiZhgEmDrLRAFZoaK9wXDIotHr+klpPSOERuS6y+Ryz5FaPlB60c5Zik
         75MhK1HTCC9WTleggAuVgAjkPKeasiZ4CXqQoMpQNnLG9VKf8Y1A5sCHZyY8/egvAvf+
         vYNLJoO4ADMiXINL1lVEWvRUDQLbHTKj5aP5wMlGS3VUQlAQzhzXRCjDsH5ZVpKduTH/
         n+ZA==
X-Gm-Message-State: AA+aEWYBHRChXO74zKNdbKTh4UO+rFC+5dSeGDeWMuK0fGNIcDbe6lX3
        EtfkVARRBKfpkovL8042UxY=
X-Google-Smtp-Source: AFSGD/U1JVig0YBk5i3Hmjkd4XX8UfasHLCh25azoks6SAEl4yABbZCYua7mCKzdTzVCtdLltH1K+A==
X-Received: by 2002:a63:374e:: with SMTP id g14mr6885243pgn.59.1543632091671;
        Fri, 30 Nov 2018 18:41:31 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d21sm7466593pgv.37.2018.11.30.18.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:41:30 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] char: virtio: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 21:41:28 -0500
Message-Id: <20181201024128.5415-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/char/virtio_console.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5b5b5d72eab7..fbeb71953526 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1309,7 +1309,7 @@ static const struct attribute_group port_attribute_group = {
 	.attrs = port_sysfs_entries,
 };
 
-static int debugfs_show(struct seq_file *s, void *data)
+static int port_debugfs_show(struct seq_file *s, void *data)
 {
 	struct port *port = s->private;
 
@@ -1327,18 +1327,7 @@ static int debugfs_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, debugfs_show, inode->i_private);
-}
-
-static const struct file_operations port_debugfs_ops = {
-	.owner = THIS_MODULE,
-	.open = debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(port_debugfs);
 
 static void set_console_size(struct port *port, u16 rows, u16 cols)
 {
@@ -1490,7 +1479,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
 							 pdrvdata.debugfs_dir,
 							 port,
-							 &port_debugfs_ops);
+							 &port_debugfs_fops);
 	}
 	return 0;
 
-- 
2.17.0

