Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17933C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C580421508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1Bnwj4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C580421508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbeKLIhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390930AbeKLIX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:28 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1E9522419;
        Sun, 11 Nov 2018 22:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975611;
        bh=Tuc2PztlbTw7OTHN6egUrITQCk26b7aktu1BeNQ90WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1Bnwj4NSofm0mFF1llPnTdOJvOnPGRXAokThHeKLr5kZcU1GttMPs0mWJGIMYc7n
         I+q/H0ioSq3t9tvba0SM+/vPXCsQRW2wTqdEHFgUYbVutZg3XBDfJcCCcP+cdkzguJ
         XQDfP6mIdeIT8a22ZgPWV67g71FJfGWyPdPdu1Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Bazhenov <bazhenov.dn@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 002/141] hwmon: (pmbus) Fix page count auto-detection.
Date:   Sun, 11 Nov 2018 14:24:21 -0800
Message-Id: <20181111221628.085321789@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Bazhenov <bazhenov.dn@gmail.com>

commit e7c6a55606b5c46b449d76588968b4d8caae903f upstream.

Devices with compatible="pmbus" field have zero initial page count,
and pmbus_clear_faults() being called before the page count auto-
detection does not actually clear faults because it depends on the
page count. Non-cleared faults in its turn may fail the subsequent
page count auto-detection.

This patch fixes this problem by calling pmbus_clear_fault_page()
for currently set page and calling pmbus_clear_faults() after the
page count was detected.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Bazhenov <bazhenov.dn@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/pmbus/pmbus.c      |    2 ++
 drivers/hwmon/pmbus/pmbus_core.c |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -118,6 +118,8 @@ static int pmbus_identify(struct i2c_cli
 		} else {
 			info->pages = 1;
 		}
+
+		pmbus_clear_faults(client);
 	}
 
 	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1759,7 +1759,10 @@ static int pmbus_init_common(struct i2c_
 	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
 		client->flags |= I2C_CLIENT_PEC;
 
-	pmbus_clear_faults(client);
+	if (data->info->pages)
+		pmbus_clear_faults(client);
+	else
+		pmbus_clear_fault_page(client, -1);
 
 	if (info->identify) {
 		ret = (*info->identify)(client, info);


