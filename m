Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07841C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11342086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZBfbsME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeLOIxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:53:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44666 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbeLOIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:53:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so3777232pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9U3uvT6zrPqp0P1HU9+D41u6306krIKZi7mqEDWsETM=;
        b=HZBfbsME6uAPYBJjwGYaJjM87sJoT8coneCZ7QDTZn4pps6AX4wvHHYvQG8sjyK4dM
         yB+k0KoooTWyH23yus+yQ9+ezJJO8xUGjjLrj6K6ENQSkvzVJEHuTozkaY3ZtPHAZFZQ
         LQ6DCNwCwQsAQqTb4Nb1qBBPu5S/hTQuncTmeovI8p552F8nebuyEIh0C0K27XqIvjTo
         UTLUYBRExdyDmHjxfJrPOPrSCvqZnVhFTbumXt6yDFRTGNqS6jIfFLjUW3kagcvtjM52
         UGTjw6EOMWr470/8PJvTgV5ltw7Q75SL+vVUS+nzBPla1r2+rRnZVw2dEBRq5rcDIbQa
         1cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9U3uvT6zrPqp0P1HU9+D41u6306krIKZi7mqEDWsETM=;
        b=IGW+/UoZNwZYc1NkNQoNwIZW22bsz/P/yIqa5IwyzyreMCeGXlQetvM0wn3YGqacZ5
         W9bAMi8k+tinYiS6/xup0unVJDg79HWvRqMULEd3aA6U6SnCAJJo5PSIsU4IklOnjaTu
         JFtwxJSqXdPj2On3Siz+byohwfgDX4e2Vkp55/MYexqgezViueEji9PqaWDaJkC1fkLP
         +GiiZrwoTVGWkCM1snFNElKbjdJGfkmHfzIoerAe284C3nK41Y/7yvOaOqvinAWs5Rev
         4rexD4p3YvDopPnBpczi/zO5J4OvYav7moQ6CoaDBY35YACiAJ1i53w1rsX2Yjlw8gaw
         VvBg==
X-Gm-Message-State: AA+aEWY+JK1qR6I9jvR2SYD7nDubqCUcuISkG18e4yb3GX3qlqgP8dgv
        E13ENyu4+M7mWWoFjFbY6iU=
X-Google-Smtp-Source: AFSGD/W0j+oODEv4GHW+tZBtwBFLSDi5uHdMRbbAZZ7ttjGVYHvQEK5RptQFNKhKbsFTs3hG8u6j3w==
X-Received: by 2002:a62:be15:: with SMTP id l21mr5616708pff.51.1544863995098;
        Sat, 15 Dec 2018 00:53:15 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i123sm12032332pfg.164.2018.12.15.00.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:53:14 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] staging: greybus: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 03:53:12 -0500
Message-Id: <20181215085312.27493-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/greybus/loopback.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 7080294f705c..33cda7527714 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -973,19 +973,7 @@ static int gb_loopback_dbgfs_latency_show(struct seq_file *s, void *unused)
 	return gb_loopback_dbgfs_latency_show_common(s, &gb->kfifo_lat,
 						     &gb->mutex);
 }
-
-static int gb_loopback_latency_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, gb_loopback_dbgfs_latency_show,
-			   inode->i_private);
-}
-
-static const struct file_operations gb_loopback_debugfs_latency_ops = {
-	.open		= gb_loopback_latency_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(gb_loopback_dbgfs_latency);
 
 static int gb_loopback_bus_id_compare(void *priv, struct list_head *lha,
 				      struct list_head *lhb)
@@ -1076,7 +1064,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 	snprintf(name, sizeof(name), "raw_latency_%s",
 		 dev_name(&connection->bundle->dev));
 	gb->file = debugfs_create_file(name, S_IFREG | 0444, gb_dev.root, gb,
-				       &gb_loopback_debugfs_latency_ops);
+				       &gb_loopback_dbgfs_latency_fops);
 
 	gb->id = ida_simple_get(&loopback_ida, 0, 0, GFP_KERNEL);
 	if (gb->id < 0) {
-- 
2.17.0

