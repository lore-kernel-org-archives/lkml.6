Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56302C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15161206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15161206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeJBULi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeJBULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:37 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AD123A67;
        Tue,  2 Oct 2018 13:28:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 100/228] HID: i2c-hid: Use devm to allocate i2c_hid struct
Date:   Tue,  2 Oct 2018 06:23:17 -0700
Message-Id: <20181002132506.163862933@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit d6f83894110de247a81392ab7ef89e5498df7e80 ]

Use devm here to save some lines and prepare for bulk regulator usage in
this driver. Otherwise, when we devm bulk get regulators we'll free the
containing i2c_hid structure and try to put regulator pointers from
freed memory.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/i2c-hid/i2c-hid.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1004,18 +1004,18 @@ static int i2c_hid_probe(struct i2c_clie
 		return client->irq;
 	}
 
-	ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
+	ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
 
 	if (client->dev.of_node) {
 		ret = i2c_hid_of_probe(client, &ihid->pdata);
 		if (ret)
-			goto err;
+			return ret;
 	} else if (!platform_data) {
 		ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
 		if (ret)
-			goto err;
+			return ret;
 	} else {
 		ihid->pdata = *platform_data;
 	}
@@ -1128,7 +1128,6 @@ err_regulator:
 
 err:
 	i2c_hid_free_buffers(ihid);
-	kfree(ihid);
 	return ret;
 }
 
@@ -1152,8 +1151,6 @@ static int i2c_hid_remove(struct i2c_cli
 
 	regulator_disable(ihid->pdata.supply);
 
-	kfree(ihid);
-
 	return 0;
 }
 


