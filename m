Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC79C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA412089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1/vYH4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA412089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeJHWis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbeJHWir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF11E2075E;
        Mon,  8 Oct 2018 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012392;
        bh=M1jApAVtan0XKlgYCvGn5G86G6AkNHO2606FWYNvuZM=;
        h=From:To:Cc:Subject:Date:From;
        b=W1/vYH4CIQKEtQArW+hbpmJ/01LYdimGPBfqqQyT5DurdfVe5bcUNMf5LEdw7dnsV
         AGxIid2XaLvKsZuGzDEdyQ2ZqAdsf2eas+Ps5BkY1kdL0gVsMrMNGk5gNnJMzTUqby
         tDR4YgF4z4kY0Jv5PNtpdpV1zQs/n0vQ1qhI8bO4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jozef Balga <jozef.balga@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/32] media: af9035: prevent buffer overflow on write
Date:   Mon,  8 Oct 2018 11:25:58 -0400
Message-Id: <20181008152629.70812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jozef Balga <jozef.balga@gmail.com>

[ Upstream commit 312f73b648626a0526a3aceebb0a3192aaba05ce ]

When less than 3 bytes are written to the device, memcpy is called with
negative array size which leads to buffer overflow and kernel panic. This
patch adds a condition and returns -EOPNOTSUPP instead.
Fixes bugzilla issue 64871

[mchehab+samsung@kernel.org: fix a merge conflict and changed the
 condition to match the patch's comment, e. g. len == 3 could
 also be valid]
Signed-off-by: Jozef Balga <jozef.balga@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 666d319d3d1a..1f6c1eefe389 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -402,8 +402,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
 
-			ret = af9035_wr_regs(d, reg, &msg[0].buf[3],
-					msg[0].len - 3);
+			ret = (msg[0].len >= 3) ? af9035_wr_regs(d, reg,
+							         &msg[0].buf[3],
+							         msg[0].len - 3)
+					        : -EOPNOTSUPP;
 		} else {
 			/* I2C write */
 			u8 buf[MAX_XFER_SIZE];
-- 
2.17.1

