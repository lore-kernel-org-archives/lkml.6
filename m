Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68ECECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FC82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6XCEjJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FC82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJYEH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:07:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36288 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJYEH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:07:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so2709540plt.3;
        Wed, 24 Oct 2018 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQPulZTZv6CkJ1xa+bjPUNKdCn9nrIJ4wulgYItVYrw=;
        b=C6XCEjJNjt5fZx4cj01hIgMJ9KQcu+Kt9Q0LV5tmn5QTCU1kKPb+WXNK1w+gpRtNvQ
         TmBWrj6XbjfN6mj2I/TuCAsAWvRBQzyaOpIGe9+qXxQ16exaaAUF5WbSqvvhXNyeP06G
         /eyBt8XxRQKp38rqpc5ouj1Nxf1Fl1gsiANcxLzH8vPsQmspVRl9B6bAAOg8OVUBkz51
         QeGN3rDM62FkooRgOHVaWvsVs7bYshmOJTo3zdKdF07tV4KAytdPETA2umoB0jB5oym/
         y8iO/WucM1fRV6Xs9hGC1Nk6u1CZoI4OBMj7Tfzs7+SXk6WzkcykD+gdDdevmziRChzt
         zvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQPulZTZv6CkJ1xa+bjPUNKdCn9nrIJ4wulgYItVYrw=;
        b=DWkAO6kb3KtE+cvM0bjUrBMtNUXoYIuueM7w1XYbzqwHVPiS3p0ayMDg5fP2pLs7PS
         vNobJ0HgF+khmqex1SnN/B+TLt8QWZvEzAuj95D+UwaB+YrjIzCxoNf3C2xlrQUK+pNY
         5B4XBeFptwE90TvvEQQspOBnoWitGksYLf8GCdZ06b5AwdiTxc3I35rJWUyt+vA9CG6/
         rkYnRw6TCKJrjKH9UKcOfBWfmid1VVzzcN9bumJBQe4EJJGzDaf0HTjtYjorXhnFj2sm
         lL6sAyyv1LHSRk4uvwYnBxq55FlxUlcrvMO8/i/y2PyWGFiR3nQWioGAgqAdxpNGwNmP
         8MBA==
X-Gm-Message-State: AGRZ1gI4pazAs8BycGbjlPHE3L7ZIsjgYOzQDzunZd9ohat7gyL/A8UT
        Ma34eX6f7RToP3DCdxceZqfASJEU
X-Google-Smtp-Source: AJdET5d276xqb8+84AJW0xveKxyD42poACsHyX3Gaw7R6U0Vssb826ku09XF1jonu68z4CozLJQNhg==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2-v6mr2513334plx.148.1540409914825;
        Wed, 24 Oct 2018 12:38:34 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id i2-v6sm5779089pgq.35.2018.10.24.12.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:38:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] hwmon: Fix double-free in __hwmon_device_register()
Date:   Wed, 24 Oct 2018 22:37:13 +0300
Message-Id: <20181024193713.15625-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix double-free that happens when thermal zone setup fails, see KASAN log
below.

==================================================================
BUG: KASAN: double-free or invalid-free in __hwmon_device_register+0x5dc/0xa7c

CPU: 0 PID: 132 Comm: kworker/0:2 Tainted: G    B             4.19.0-rc8-next-20181016-00042-gb52cd80401e9-dirty #41
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
Workqueue: events deferred_probe_work_func
Backtrace:
[<c0110540>] (dump_backtrace) from [<c0110944>] (show_stack+0x20/0x24)
[<c0110924>] (show_stack) from [<c105cb08>] (dump_stack+0x9c/0xb0)
[<c105ca6c>] (dump_stack) from [<c02fdaec>] (print_address_description+0x68/0x250)
[<c02fda84>] (print_address_description) from [<c02fd4ac>] (kasan_report_invalid_free+0x68/0x88)
[<c02fd444>] (kasan_report_invalid_free) from [<c02fc85c>] (__kasan_slab_free+0x1f4/0x200)
[<c02fc668>] (__kasan_slab_free) from [<c02fd0c0>] (kasan_slab_free+0x14/0x18)
[<c02fd0ac>] (kasan_slab_free) from [<c02f9c6c>] (kfree+0x90/0x294)
[<c02f9bdc>] (kfree) from [<c0b41bbc>] (__hwmon_device_register+0x5dc/0xa7c)
[<c0b415e0>] (__hwmon_device_register) from [<c0b421e8>] (hwmon_device_register_with_info+0xa0/0xa8)
[<c0b42148>] (hwmon_device_register_with_info) from [<c0b42324>] (devm_hwmon_device_register_with_info+0x74/0xb4)
[<c0b422b0>] (devm_hwmon_device_register_with_info) from [<c0b4481c>] (lm90_probe+0x414/0x578)
[<c0b44408>] (lm90_probe) from [<c0aeeff4>] (i2c_device_probe+0x35c/0x384)
[<c0aeec98>] (i2c_device_probe) from [<c08776cc>] (really_probe+0x290/0x3e4)
[<c087743c>] (really_probe) from [<c0877a2c>] (driver_probe_device+0x80/0x1c4)
[<c08779ac>] (driver_probe_device) from [<c0877da8>] (__device_attach_driver+0x104/0x11c)
[<c0877ca4>] (__device_attach_driver) from [<c0874dd8>] (bus_for_each_drv+0xa4/0xc8)
[<c0874d34>] (bus_for_each_drv) from [<c08773b0>] (__device_attach+0xf0/0x15c)
[<c08772c0>] (__device_attach) from [<c0877e24>] (device_initial_probe+0x1c/0x20)
[<c0877e08>] (device_initial_probe) from [<c08762f4>] (bus_probe_device+0xdc/0xec)
[<c0876218>] (bus_probe_device) from [<c0876a08>] (deferred_probe_work_func+0xa8/0xd4)
[<c0876960>] (deferred_probe_work_func) from [<c01527c4>] (process_one_work+0x3dc/0x96c)
[<c01523e8>] (process_one_work) from [<c01541e0>] (worker_thread+0x4ec/0x8bc)
[<c0153cf4>] (worker_thread) from [<c015b238>] (kthread+0x230/0x240)
[<c015b008>] (kthread) from [<c01010bc>] (ret_from_fork+0x14/0x38)
Exception stack(0xcf743fb0 to 0xcf743ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000

Allocated by task 132:
 kasan_kmalloc.part.1+0x58/0xf4
 kasan_kmalloc+0x90/0xa4
 kmem_cache_alloc_trace+0x90/0x2a0
 __hwmon_device_register+0xbc/0xa7c
 hwmon_device_register_with_info+0xa0/0xa8
 devm_hwmon_device_register_with_info+0x74/0xb4
 lm90_probe+0x414/0x578
 i2c_device_probe+0x35c/0x384
 really_probe+0x290/0x3e4
 driver_probe_device+0x80/0x1c4
 __device_attach_driver+0x104/0x11c
 bus_for_each_drv+0xa4/0xc8
 __device_attach+0xf0/0x15c
 device_initial_probe+0x1c/0x20
 bus_probe_device+0xdc/0xec
 deferred_probe_work_func+0xa8/0xd4
 process_one_work+0x3dc/0x96c
 worker_thread+0x4ec/0x8bc
 kthread+0x230/0x240
 ret_from_fork+0x14/0x38
   (null)

Freed by task 132:
 __kasan_slab_free+0x12c/0x200
 kasan_slab_free+0x14/0x18
 kfree+0x90/0x294
 hwmon_dev_release+0x1c/0x20
 device_release+0x4c/0xe8
 kobject_put+0xac/0x11c
 device_unregister+0x2c/0x30
 __hwmon_device_register+0xa58/0xa7c
 hwmon_device_register_with_info+0xa0/0xa8
 devm_hwmon_device_register_with_info+0x74/0xb4
 lm90_probe+0x414/0x578
 i2c_device_probe+0x35c/0x384
 really_probe+0x290/0x3e4
 driver_probe_device+0x80/0x1c4
 __device_attach_driver+0x104/0x11c
 bus_for_each_drv+0xa4/0xc8
 __device_attach+0xf0/0x15c
 device_initial_probe+0x1c/0x20
 bus_probe_device+0xdc/0xec
 deferred_probe_work_func+0xa8/0xd4
 process_one_work+0x3dc/0x96c
 worker_thread+0x4ec/0x8bc
 kthread+0x230/0x240
 ret_from_fork+0x14/0x38
   (null)

Cc: <stable@vger.kernel.org> # v4.15+
Fixes: 47c332deb8e8 ("hwmon: Deal with errors from the thermal subsystem")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/hwmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 975c95169884..84f61cec6319 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -649,8 +649,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 				if (info[i]->config[j] & HWMON_T_INPUT) {
 					err = hwmon_thermal_add_sensor(dev,
 								hwdev, j);
-					if (err)
-						goto free_device;
+					if (err) {
+						device_unregister(hdev);
+						goto ida_remove;
+					}
 				}
 			}
 		}
@@ -658,8 +660,6 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 
 	return hdev;
 
-free_device:
-	device_unregister(hdev);
 free_hwmon:
 	kfree(hwdev);
 ida_remove:
-- 
2.19.0

