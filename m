Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42047C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBB72080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLlHdZt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbeLOIvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:51:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:51:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so3972943pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FRWvfOfrxJPZfbDsVrmXXGRC8gbGGhlFQvVI/c2rdS8=;
        b=YLlHdZt0IKYhO3aGZZMnhcEX7/c/mKd6y1jVXvPs7YojdbNjyLwmEC6CzLeQBcKhgg
         H+Z4FVrj36IQ3rmG/R4uO9eKqC2qa1qO/lteOlh/yEiqK4q/KG+ZYpPbsbu8ChseK3m9
         caH6Tuaa5p0uZj/Aoy2PacskQAsaAxqyzDZZZR+DrCT5hv4LzPOuSTykLCe5qGpFXJ+h
         19qLyr1yhL+yC4J+wyBlVWE/dAbo104MxTgSok0ECSTm8FM9jad+3wD/KssB2TnO3bD6
         Y1uAflrxSWG00bQgyJzPIs2XY6TINxcJvKLIwvDvMOo7jXPC02he5a29PuE+P40zeTsV
         gq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FRWvfOfrxJPZfbDsVrmXXGRC8gbGGhlFQvVI/c2rdS8=;
        b=rQdiPUb8mDIjvCWZmzzttv9duWMLfQSHVs423FPnFb1FvvJ8zZIZ1XMgc2PetlE4Pz
         Z5RwTB2L0KIC+8QyOYeOSzbIsb0CV1+krnG+VXjTDysN2BKAiSDfRg5lPQdkp0Xxi0X0
         8JeKGf+u8Kk8cEHVwFW18NZZ9IitcJLtV9fiQ7AZ7j5vSRWbCOfb7rALLCYCkGrG0MqX
         gKC4HdRVq5A3tRZzLRCAMZTcQn2Xcuav3bpl6NTFjUDkXX0DqvDNUEjRWvl4Z0sL/pN/
         hFh6q12H7zr4czeBKEhpK5offYtNFAlSL33NI6mWykTIyBQZVT3WsMKtLHLVSDAnkdV5
         07Bw==
X-Gm-Message-State: AA+aEWbT+7bRj+Ad+NHzj/B14vlSyXq0UGqjxm1g517sY3P8Xg7GfsyK
        ohCprOcFNxGR3X3GWketF9M=
X-Google-Smtp-Source: AFSGD/VbUApHvQNetcHa0yxburviNzzb9uOlz+NalEEi3r0HbW+hnS637jx1JJVb8BXVFVnAT3djiA==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr5713836pfm.71.1544863869905;
        Sat, 15 Dec 2018 00:51:09 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q187sm13662145pfq.128.2018.12.15.00.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:51:09 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] staging: fwserial: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 03:51:07 -0500
Message-Id: <20181215085107.27337-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 32 ++++-------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 173f451b86b7..3e416f5bbcba 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1458,7 +1458,7 @@ static int fwtty_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int fwtty_debugfs_stats_show(struct seq_file *m, void *v)
+static int fwtty_stats_show(struct seq_file *m, void *v)
 {
 	struct fw_serial *serial = m->private;
 	struct fwtty_port *port;
@@ -1476,8 +1476,9 @@ static int fwtty_debugfs_stats_show(struct seq_file *m, void *v)
 	}
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(fwtty_stats);
 
-static int fwtty_debugfs_peers_show(struct seq_file *m, void *v)
+static int fwtty_peers_show(struct seq_file *m, void *v)
 {
 	struct fw_serial *serial = m->private;
 	struct fwtty_peer *peer;
@@ -1491,32 +1492,7 @@ static int fwtty_debugfs_peers_show(struct seq_file *m, void *v)
 	rcu_read_unlock();
 	return 0;
 }
-
-static int fwtty_stats_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, fwtty_debugfs_stats_show, inode->i_private);
-}
-
-static int fwtty_peers_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, fwtty_debugfs_peers_show, inode->i_private);
-}
-
-static const struct file_operations fwtty_stats_fops = {
-	.owner =	THIS_MODULE,
-	.open =		fwtty_stats_open,
-	.read =		seq_read,
-	.llseek =	seq_lseek,
-	.release =	single_release,
-};
-
-static const struct file_operations fwtty_peers_fops = {
-	.owner =	THIS_MODULE,
-	.open =		fwtty_peers_open,
-	.read =		seq_read,
-	.llseek =	seq_lseek,
-	.release =	single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fwtty_peers);
 
 static const struct tty_port_operations fwtty_port_ops = {
 	.dtr_rts =		fwtty_port_dtr_rts,
-- 
2.17.0

