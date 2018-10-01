Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C54C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E82E2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E82E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeJAK3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:29:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59391 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeJAK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:29:05 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g6pGo-0001Gt-DF; Mon, 01 Oct 2018 03:53:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, hdegoede@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the device
Date:   Mon,  1 Oct 2018 11:53:13 +0800
Message-Id: <20181001035313.21453-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
although it works in display manager.

During user logging, the display manager exits, close the HID device,
then the device gets runtime suspended and powered off. The desktop
session begins shortly after, opens the HID device, then the device gets
runtime resumed and powered on.

If the trasition from display manager to desktop sesesion is fast, the
touchpanel cannot switch from powered off to powered on in short
timeframe. So add a small delay to workaround the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index f3076659361a..ff5682cc1bce 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 
 	if (ret)
 		dev_err(&client->dev, "failed to change power setting.\n");
+	else
+		msleep(20);
 
 set_pwr_exit:
 	return ret;
-- 
2.17.1

