Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053BEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE75220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkyrKCXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE75220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbeKLJb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387826AbeKLITi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4408421582;
        Sun, 11 Nov 2018 22:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975382;
        bh=ddIRAvoHZKC+cgbhrbWf3KfpSzzmWRQF5cbjaMaMM84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkyrKCXvxK9mSBYRaszBFaP4esuW6WHQG967m/7Hr+MAavdFDqufh4qWkiSe7pfaI
         U9gQFpX4iMQdKGxjqbwqkjwZrtAbak3tOOBtK7Kaw7IF/zOieZu6etk1VEl2UmTcl/
         PJo/TQci2lAfsq34cItvPECUS72jp5XV3RcHtVH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Bazhenov <bazhenov.dn@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.18 011/350] hwmon: (pmbus) Fix page count auto-detection.
Date:   Sun, 11 Nov 2018 14:17:55 -0800
Message-Id: <20181111221707.619440017@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2015,7 +2015,10 @@ static int pmbus_init_common(struct i2c_
 	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
 		client->flags |= I2C_CLIENT_PEC;
 
-	pmbus_clear_faults(client);
+	if (data->info->pages)
+		pmbus_clear_faults(client);
+	else
+		pmbus_clear_fault_page(client, -1);
 
 	if (info->identify) {
 		ret = (*info->identify)(client, info);


