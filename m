Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5484C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8400320862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO0KhHod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8400320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbeKLI7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390209AbeKLIWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D544822353;
        Sun, 11 Nov 2018 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975526;
        bh=TEfD6+5dup8DumQYr9j7LRx7F8pDE17zjFDUrocR7ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bO0KhHodtI6jcUG8VY7fWD0jhMbEE9Fc4GP5rOplAuutBd7ooNBjZA+FgPvPHWPDN
         dO8ba1xWTIj4QjkujPzd1ndcJePx9c7S24Ca9rBjlG4c5ED3WO+cgmNU/f+4AztVpW
         TSyHzaUIT3onRPl0qXuuBcJKIgK/X4Xco2zGW/Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Bazhenov <bazhenov.dn@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 005/222] hwmon: (pmbus) Fix page count auto-detection.
Date:   Sun, 11 Nov 2018 14:21:42 -0800
Message-Id: <20181111221648.339509495@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
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
@@ -1802,7 +1802,10 @@ static int pmbus_init_common(struct i2c_
 	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
 		client->flags |= I2C_CLIENT_PEC;
 
-	pmbus_clear_faults(client);
+	if (data->info->pages)
+		pmbus_clear_faults(client);
+	else
+		pmbus_clear_fault_page(client, -1);
 
 	if (info->identify) {
 		ret = (*info->identify)(client, info);


