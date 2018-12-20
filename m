Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47634C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158D7218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y70W0Xom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbeLTRVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:21:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39762 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbeLTRUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so2401190edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gR5GoNtNgIqnBlGdnudI3GvETIMd7aLXVYzcXr7mRVI=;
        b=Y70W0XomGOuYT1pdSuDAGg6aqYWCWCIYkWgF/CbMgZTHuSrqy+gUzXbSQr/7U3w0Up
         8GcNZmsISxrJnBUIZXOSPsklrUo9vvpNwJuHUtW5ml1BWAaMvYr8Mo78vZdx5p1Z7NTf
         8xfCC1HH3WJqpZGBixnlgoqS3CH4imBITUHMsefk60HPWo66xlpIHm8jWTuA+OFrKN9F
         BimRrFMbiwG9DKVvyyPN5zXWnON/s5Jii/sT5JcDcw/QuIwvJF6HA+V/bYTXrON5NBHk
         RdvcsD+PbvIIkQWs4yxPCgrglKJMuY/php/AFHdvsLabvTfV0Ql0lZpC9bW2S/5ZgH/T
         SMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gR5GoNtNgIqnBlGdnudI3GvETIMd7aLXVYzcXr7mRVI=;
        b=EIXA9HRxZ/hlSdCVdSKU+BDU0jrfBZ1NTadJEQhRvek6sDukLtyfcwegAx9C0NQ62i
         GwfeHR5tBuRNWXetthS/hkgwuwpGRyCdzdi7zXRzKv/3mkOmVHxvD35BP0RHo62KN5lp
         8x4pPhhiOJ4doClF4S+3QmwwmqFryQKWmOjHoPMZP7wyNLGFIiNdzH9xgCFjtdEY60+q
         DYz2t3uXf6BCcPBJMhk76dAXA4tyJIFg1bKxDbJkDkhoTgOWgLKrab8YHRGzalRiPh2B
         o4MSNxTkyIR42WSjKVfA5rnJ/gnPcWrlssWSNORvxfshMs1w7egQJyQc7QztANDRvGwh
         ibLw==
X-Gm-Message-State: AA+aEWbD9+bBqiX4qhDp+/8Qmp1ARGJoCK3h9CntyTFvIE6MgG33p66T
        hxxP9hQDwCJ0R0mc4XkZYc8=
X-Google-Smtp-Source: AFSGD/VwAiW1tWMocDzFLTsZrCKMolrRSHI3QuG2x6q/ui24qDk50+nbwPmEQFcpftFgfuWS7xCwzw==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr23835601ede.27.1545326412654;
        Thu, 20 Dec 2018 09:20:12 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h47sm6234760eda.8.2018.12.20.09.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:12 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH v3 05/19] mailbox: bcm-pdc: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:48 +0100
Message-Id: <20181220172002.9016-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Rice <rob.rice@broadcom.com>
Cc: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 4fe7be0bdd11..ccf3d62af7e7 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -1471,7 +1471,7 @@ static int pdc_mb_init(struct pdc_state *pdcs)
 		mbc->chans[chan_index].con_priv = pdcs;
 
 	/* Register mailbox controller */
-	err = mbox_controller_register(mbc);
+	err = devm_mbox_controller_register(dev, mbc);
 	if (err) {
 		dev_crit(dev,
 			 "Failed to register PDC mailbox controller. Error %d.",
@@ -1641,8 +1641,6 @@ static int pdc_remove(struct platform_device *pdev)
 
 	pdc_hw_disable(pdcs);
 
-	mbox_controller_unregister(&pdcs->mbc);
-
 	dma_pool_destroy(pdcs->rx_buf_pool);
 	dma_pool_destroy(pdcs->ring_pool);
 	return 0;
-- 
2.19.1

