Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD56621557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpdVYL0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD56621557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeJHWkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbeJHWkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:40:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B4F21531;
        Mon,  8 Oct 2018 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012471;
        bh=5D91aSH8m5fd+tOOtesuQ0/3RmTalCumlsHH3RulrPo=;
        h=From:To:Cc:Subject:Date:From;
        b=hpdVYL0A0cRvedOyzpPoVYiI6jDKZnBBZWRjbtCnfXzIF/5YlmynBA6MuLBlwFVe6
         pfrmMbSqsjBPEa4knBxmw+IwTL3as+GKERnTS9FTeYHx++QboHeL8jIieF7A8iCRQ+
         /bJlQ0Ap0d/4hWbHiG9ljqcYpMHbsE7oeVUkbKro=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jozef Balga <jozef.balga@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 1/4] media: af9035: prevent buffer overflow on write
Date:   Mon,  8 Oct 2018 11:27:46 -0400
Message-Id: <20181008152749.71018-1-sashal@kernel.org>
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
index 1896ab218b11..efc1545bf29e 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -389,8 +389,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			    msg[0].addr == (state->af9033_i2c_addr[1] >> 1))
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

