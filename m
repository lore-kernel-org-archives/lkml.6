Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6AE20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6AE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeKFSK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:10:27 -0500
Received: from mail5.windriver.com ([192.103.53.11]:58982 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFSK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:10:26 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wA68i3kv019618
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 6 Nov 2018 00:44:19 -0800
Received: from pek-lpggp4.wrs.com (128.224.153.77) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.408.0; Tue, 6 Nov 2018
 00:43:59 -0800
From:   Xulin Sun <xulin.sun@windriver.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xulinsun@gmail.com>
Subject: [PATCH] rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write
Date:   Tue, 6 Nov 2018 16:42:19 +0800
Message-ID: <1541493739-85733-1-git-send-email-xulin.sun@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcf2127_i2c_gather_write() allocates memory as local variable
for i2c_master_send(), after finishing the master transfer,
the allocated memory should be freed. The kmemleak is reported:

unreferenced object 0xffff80231e7dba80 (size 64):
  comm "hwclock", pid 27762, jiffies 4296880075 (age 356.944s)
  hex dump (first 32 bytes):
    03 00 12 03 19 02 11 13 00 80 98 18 00 00 ff ff ................
    00 50 00 00 00 00 00 00 02 00 00 00 00 00 00 00 .P..............
  backtrace:
    [<ffff000008221398>] create_object+0xf8/0x278
    [<ffff000008a96264>] kmemleak_alloc+0x74/0xa0
    [<ffff00000821070c>] __kmalloc+0x1ac/0x348
    [<ffff0000087ed1dc>] pcf2127_i2c_gather_write+0x54/0xf8
    [<ffff0000085fd9d4>] _regmap_raw_write+0x464/0x850
    [<ffff0000085fe3f4>] regmap_bulk_write+0x1a4/0x348
    [<ffff0000087ed32c>] pcf2127_rtc_set_time+0xac/0xe8
    [<ffff0000087eaad8>] rtc_set_time+0x80/0x138
    [<ffff0000087ebfb0>] rtc_dev_ioctl+0x398/0x610
    [<ffff00000823f2c0>] do_vfs_ioctl+0xb0/0x848
    [<ffff00000823fae4>] SyS_ioctl+0x8c/0xa8
    [<ffff000008083ac0>] el0_svc_naked+0x34/0x38
    [<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
---
 drivers/rtc/rtc-pcf2127.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index e83be18..598e56e 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -248,6 +248,9 @@ static int pcf2127_i2c_gather_write(void *context,
 	memcpy(buf + 1, val, val_size);
 
 	ret = i2c_master_send(client, buf, val_size + 1);
+
+	kfree(buf);
+
 	if (ret != val_size + 1)
 		return ret < 0 ? ret : -EIO;
 
-- 
2.7.4

