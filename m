Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9257EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95320865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNFSgxpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A95320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407028AbeKWGgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733189AbeKWGgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:36:02 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5138720866;
        Thu, 22 Nov 2018 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916510;
        bh=eMn/bQh9gN6/dFhmJyB0yR7tfx1uLBZsBC1De655cjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNFSgxpjyMmA2SLYyanEGNDXDUByr7nXYUjfCFlctmQSS4E1LgFThAy2yAD909GE7
         u/Pwxwww9AbVys/1n+ugLo5I0B4ceNU2AzGwrpjo2fLCOipvl286Mc3Nc13jxS1RAA
         9nmaDsW5a2+SrOGNfG4TwPk/gX+F7Ppmz7JILXmI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xulin Sun <xulin.sun@windriver.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/21] rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write
Date:   Thu, 22 Nov 2018 14:54:36 -0500
Message-Id: <20181122195452.13520-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xulin Sun <xulin.sun@windriver.com>

[ Upstream commit 9bde0afb7a906f1dabdba37162551565740b862d ]

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
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf2127.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index f33447c5db85..9f1b14bf91ae 100644
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
2.17.1

