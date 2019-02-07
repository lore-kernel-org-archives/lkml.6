Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DDC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1C2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptpnus77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBGFNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:13:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40756 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfBGFNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:13:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so4252955pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 21:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CtpIN6K6IIawtC+8r9TEhLUPk3h7uPJ/QqHwsa9m2vM=;
        b=ptpnus77A6dmFoclgOAifM1nMBTSMPkAhLqEgHhIE7yY6Exo/+gfk17NwGDMVoT6J1
         UiKz3ffQK9rab8DGb45Xp44pA+PLmd7DGFGfrHyO4FRt84KaY5QCahSUh0KmHzOdH3NZ
         28q0/A2WRH4ibh75z0sjJj6A6ByrW7AwNEd8fLGJN+bfdkfgSNi7xMH8L9uE+N/qIBuj
         0RJgWjW+SSg3lKXEQWPZMbYPzQ1vPgwWsYzzynFnoHNxbCz9CXMgc4qNECHe8ugNJWjn
         e5A0rOHrBNf13LfVacZKx2NKcMGZ0wxDoh34y0TssbJczBIQ3btGaLkUiTgtavc88zJw
         q02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CtpIN6K6IIawtC+8r9TEhLUPk3h7uPJ/QqHwsa9m2vM=;
        b=uLVlVSg32WNQZjTc1+2ZeuP+KB8i6q54CMaAsg1IG1tbnBaJGZr26EyQevVKt0PTJe
         kCFh1N2+dBzea/2PgobFLC0BVZ79/+zAj45sPNmAdlRUd+2+HyIYJzpr1kc1BkRPGvNY
         i3CbaAefNAaNRM/HGd7VyesW9sjqJmyJVge5bbCLKxAfL37lFFqEKji6rqU0kYDifec1
         ykejdvNvbhRi9LJaVbAZzCAYvUJbDZ5XkUMHXqRAzCxUXXGL1aTGOs4XyKUhBeEWangl
         uGID7qEdNEFf+QlM8rKLlriYTx3y7VIRRosxojIXpg0uhzlJ83ddDbNXIBCk1JXxQMNI
         fhxA==
X-Gm-Message-State: AHQUAuZP9VtfUl7vlisTiUZF60qBkrB9T4kQfC1QzY2SH6+Wb2nSkp9j
        KssprdeN2JJtG+tQHFWBTv64tn9Z
X-Google-Smtp-Source: AHgI3IbSJJTp43kg7e9MkxzrzY55Ruix66sAaP4vJvaCfr3NsqBLG5XpwjyaQPdP92ojsRFvJpmw5g==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr13337373pgv.179.1549516433457;
        Wed, 06 Feb 2019 21:13:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 15sm12265039pfr.55.2019.02.06.21.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 21:13:52 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] cdrom: Fix race condition in cdrom_sysctl_register
Date:   Wed,  6 Feb 2019 21:13:49 -0800
Message-Id: <1549516429-6542-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following traceback is sometimes seen when booting an image in qemu:

[   54.608293] cdrom: Uniform CD-ROM driver Revision: 3.20
[   54.611085] Fusion MPT base driver 3.04.20
[   54.611877] Copyright (c) 1999-2008 LSI Corporation
[   54.616234] Fusion MPT SAS Host driver 3.04.20
[   54.635139] sysctl duplicate entry: /dev/cdrom//info
[   54.639578] CPU: 0 PID: 266 Comm: kworker/u4:5 Not tainted 5.0.0-rc5 #1
[   54.639578] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   54.641273] Workqueue: events_unbound async_run_entry_fn
[   54.641273] Call Trace:
[   54.641273]  dump_stack+0x67/0x90
[   54.641273]  __register_sysctl_table+0x50b/0x570
[   54.641273]  ? rcu_read_lock_sched_held+0x6f/0x80
[   54.641273]  ? kmem_cache_alloc_trace+0x1c7/0x1f0
[   54.646814]  __register_sysctl_paths+0x1c8/0x1f0
[   54.646814]  cdrom_sysctl_register.part.7+0xc/0x5f
[   54.646814]  register_cdrom.cold.24+0x2a/0x33
[   54.646814]  sr_probe+0x4bd/0x580
[   54.646814]  ? __driver_attach+0xd0/0xd0
[   54.646814]  really_probe+0xd6/0x260
[   54.646814]  ? __driver_attach+0xd0/0xd0
[   54.646814]  driver_probe_device+0x4a/0xb0
[   54.646814]  ? __driver_attach+0xd0/0xd0
[   54.646814]  bus_for_each_drv+0x73/0xc0
[   54.646814]  __device_attach+0xd6/0x130
[   54.646814]  bus_probe_device+0x9a/0xb0
[   54.646814]  device_add+0x40c/0x670
[   54.646814]  ? __pm_runtime_resume+0x4f/0x80
[   54.646814]  scsi_sysfs_add_sdev+0x81/0x290
[   54.646814]  scsi_probe_and_add_lun+0x888/0xc00
[   54.646814]  ? scsi_autopm_get_host+0x21/0x40
[   54.646814]  __scsi_add_device+0x116/0x130
[   54.646814]  ata_scsi_scan_host+0x93/0x1c0
[   54.646814]  async_run_entry_fn+0x34/0x100
[   54.646814]  process_one_work+0x237/0x5e0
[   54.646814]  worker_thread+0x37/0x380
[   54.646814]  ? rescuer_thread+0x360/0x360
[   54.646814]  kthread+0x118/0x130
[   54.646814]  ? kthread_create_on_node+0x60/0x60
[   54.646814]  ret_from_fork+0x3a/0x50

The only sensible explanation is that cdrom_sysctl_register() is called
twice, once from the module init function and once from register_cdrom().
cdrom_sysctl_register() is not mutex protected and may happily execute
twice if the second call is made before the first call is complete.

Use a static atomic to ensure that the function is executed exactly once.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/cdrom/cdrom.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 614ecdbb4ab7..933268b8d6a5 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -265,6 +265,7 @@
 /* #define ERRLOGMASK (CD_WARNING|CD_OPEN|CD_COUNT_TRACKS|CD_CLOSE) */
 /* #define ERRLOGMASK (CD_WARNING|CD_REG_UNREG|CD_DO_IOCTL|CD_OPEN|CD_CLOSE|CD_COUNT_TRACKS) */
 
+#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/major.h>
@@ -3692,9 +3693,9 @@ static struct ctl_table_header *cdrom_sysctl_header;
 
 static void cdrom_sysctl_register(void)
 {
-	static int initialized;
+	static atomic_t initialized = ATOMIC_INIT(0);
 
-	if (initialized == 1)
+	if (!atomic_add_unless(&initialized, 1, 1))
 		return;
 
 	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table);
@@ -3705,8 +3706,6 @@ static void cdrom_sysctl_register(void)
 	cdrom_sysctl_settings.debug = debug;
 	cdrom_sysctl_settings.lock = lockdoor;
 	cdrom_sysctl_settings.check = check_media_type;
-
-	initialized = 1;
 }
 
 static void cdrom_sysctl_unregister(void)
-- 
2.7.4

