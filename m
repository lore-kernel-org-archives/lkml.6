Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB43C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7842089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7842089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbeJBUS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:18:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732482AbeJBUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:25 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71BCEC47;
        Tue,  2 Oct 2018 13:35:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 127/137] hwmon: (adt7475) Make adt7475_read_word() return errors
Date:   Tue,  2 Oct 2018 06:25:28 -0700
Message-Id: <20181002132507.407561737@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f196dec6d50abb2e65fb54a0621b2f1b4d922995 ]

The adt7475_read_word() function was meant to return negative error
codes on failure.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/adt7475.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -303,14 +303,18 @@ static inline u16 volt2reg(int channel,
 	return clamp_val(reg, 0, 1023) & (0xff << 2);
 }
 
-static u16 adt7475_read_word(struct i2c_client *client, int reg)
+static int adt7475_read_word(struct i2c_client *client, int reg)
 {
-	u16 val;
+	int val1, val2;
 
-	val = i2c_smbus_read_byte_data(client, reg);
-	val |= (i2c_smbus_read_byte_data(client, reg + 1) << 8);
+	val1 = i2c_smbus_read_byte_data(client, reg);
+	if (val1 < 0)
+		return val1;
+	val2 = i2c_smbus_read_byte_data(client, reg + 1);
+	if (val2 < 0)
+		return val2;
 
-	return val;
+	return val1 | (val2 << 8);
 }
 
 static void adt7475_write_word(struct i2c_client *client, int reg, u16 val)


