Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD54C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1827C23C63
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hHyVQiTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1827C23C63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934345AbeFVC1s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:27:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38081 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934266AbeFVC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:27:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id d10-v6so2680216plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 19:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WMyAjY1vl2H1AbFT10CqHLgdfFvChhGoJud0E6JUeAc=;
        b=hHyVQiTOtGPjLtfPkGzxly7aekm3CTGrN5Pc06IBZWSkEzMOAKB7x0DQNk4Pi5Fl43
         weitcItMq7yL/Olt7IDnBOQq7MgwfAx5yCOW+r0Wmq91LLpXxUPCPb1atxWXSQukK0Fu
         pUF3PZFmBXh9E9ngMQgwJgF/JyxJ2Uvus2sWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WMyAjY1vl2H1AbFT10CqHLgdfFvChhGoJud0E6JUeAc=;
        b=WL1EMS2164LsP8IyOKbQrqErlG5JXH11hhYOclLa81v/bxGsGLtxfZVVUohRVaa8SP
         uBGi2XZlTuT57xiVpBVX+/D0LVMXCbigVcGweFgeV51WOTdIYR+K2wqfschPMYKOWBtr
         ag2fxDVbiM8Y/NCoEl+bH+aEt704UDzj7r2l9vBTRFLZziQpv2MTBkS3nyFO3gIVzNds
         qeR71OEsm0fAZ/AeQIOdjLsBV1GfZrBCpkLw6EC9ZB60HTmtWRWv2eQPrRvlCFgY5agV
         p77gRdxybqKj0VMtO8VE4LzwPkCKZyNctTUIpcIms1oMkSandVJwca19Ah9ciPzq03uN
         EUfg==
X-Gm-Message-State: APt69E08aD7YIsqp3Ug++aj9uvf8CSL4o/RqQjBrO615HdY3UVCVxKcu
        n6qJjbPM98C5uZQs30jWSVD9mg==
X-Google-Smtp-Source: ADUXVKKAP1BAmMSauWapuijbIOrafQCbvjqgOHt69yDShBBy6pVVEqLOhS/1vdVtZIHYGg1T79HD0w==
X-Received: by 2002:a17:902:b110:: with SMTP id q16-v6mr31121205plr.286.1529634441268;
        Thu, 21 Jun 2018 19:27:21 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id b74-v6sm13889045pfl.138.2018.06.21.19.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 19:27:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/2] HID: i2c-hid: Use devm to allocate i2c_hid struct
Date:   Thu, 21 Jun 2018 19:27:16 -0700
Message-Id: <20180622022717.134300-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180622022717.134300-1-swboyd@chromium.org>
References: <20180622022717.134300-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/hid/i2c-hid/i2c-hid.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index c1652bb7bd15..c7d6738dc524 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1002,18 +1002,18 @@ static int i2c_hid_probe(struct i2c_client *client,
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
@@ -1126,7 +1126,6 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 err:
 	i2c_hid_free_buffers(ihid);
-	kfree(ihid);
 	return ret;
 }
 
@@ -1150,8 +1149,6 @@ static int i2c_hid_remove(struct i2c_client *client)
 
 	regulator_disable(ihid->pdata.supply);
 
-	kfree(ihid);
-
 	return 0;
 }
 
-- 
Sent by a computer through tubes

