Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68471C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF162087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="bISk0sGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF162087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeH1PVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:21:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36352 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1PVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:21:12 -0400
Received: from localhost.localdomain (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 245295C0487;
        Tue, 28 Aug 2018 13:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1535455797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=QOFu4zU2bwN48uG96Lnvk4hq7P9g40XWf6UlYPNJVA8=;
        b=bISk0sGUHj8HJjRiKgolCmagRulJhjG9wRJ5uoPKBAtrDOxKxU8U94nIy+Npc/9qsAMMJU
        u/+hAgOEvxH05nBd+zHotS3I4wxu+BwTWyIui+/1ErDWQg7FXWnYQILgD0fsUkwpl+IBxf
        0rMqSJ0D++gDqVzIOLI56TNcWlnBb/Y=
From:   Stefan Agner <stefan@agner.ch>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] HID: core: fix memory leak on probe
Date:   Tue, 28 Aug 2018 13:29:54 +0200
Message-Id: <20180828112955.11318-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamically allocted collection stack does not get freed in
all situations. Make sure to also free the collection stack when
using the parser in hid_open_report().

Fixes: 08a8a7cf1459 ("HID: core: do not upper bound the collection stack")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Found with kmemleak:

unreferenced object 0xc57f0700 (size 64):
  comm "kworker/0:1", pid 20, jiffies 131383 (age 28.750s)
  hex dump (first 32 bytes):
    02 00 00 00 00 02 00 00 00 00 00 00 00 68 80 c5  .............h..
    80 07 7f c5 01 00 00 00 08 48 80 c5 08 48 80 c5  .........H...H..
  backtrace:
    [<1b437483>] __kmalloc_track_caller+0x1dc/0x300
    [<ecd3baad>] krealloc+0x54/0xc0
    [<c565bd75>] hid_parser_main+0x258/0x2c8
    [<210b9aaa>] hid_open_report+0x134/0x2ac
    [<61cd8964>] hid_generic_probe+0x20/0x38
    [<e02107d6>] hid_device_probe+0xdc/0x13c
    [<334f035e>] really_probe+0x1d8/0x2c4
    [<351dc2c0>] driver_probe_device+0x68/0x184
    [<7e3e3d3c>] __device_attach_driver+0xa0/0xd4
    [<1b053a89>] bus_for_each_drv+0x60/0xc0
    [<732716d8>] __device_attach+0xdc/0x144
    [<dd3a0e76>] device_initial_probe+0x14/0x18
    [<f3a47b76>] bus_probe_device+0x90/0x98
    [<d5a1f0b4>] device_add+0x424/0x62c
    [<46595a15>] hid_add_device+0x108/0x2b8
    [<a0e2824c>] usbhid_probe+0x2d4/0x3bc

 drivers/hid/hid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3da354af7a0a..44a465db3f96 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1039,6 +1039,7 @@ int hid_open_report(struct hid_device *device)
 				hid_err(device, "unbalanced delimiter at end of report description\n");
 				goto err;
 			}
+			kfree(parser->collection_stack);
 			vfree(parser);
 			device->status |= HID_STAT_PARSED;
 			return 0;
@@ -1047,6 +1048,7 @@ int hid_open_report(struct hid_device *device)
 
 	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
 err:
+	kfree(parser->collection_stack);
 	vfree(parser);
 	hid_close_report(device);
 	return ret;
-- 
2.18.0

