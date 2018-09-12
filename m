Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115D7C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC502087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFkUj0jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC502087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeILVCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:02:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37653 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILVCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:02:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so1228973pfd.4;
        Wed, 12 Sep 2018 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tGAgMY05YhW38Fqt/+chyWnlZ8JN2BtuqCbB6fIC4mQ=;
        b=gFkUj0jz7uMbGdBbDJ0b54X32cySZFqitdFh47DcsGv4Gm+TCqfBOv5rh2IY1Wnmpf
         nYsXcDML3ap2sS3wv+BAbN3WV0ELr7XwclJSR6MBI6sPSNqJcq6ayUc7JZr8vSOpyD0N
         b3pQc7vNi9HbP1Pp5A+jrTFSMZUPBH7BtJLrAAae4UUxjaKBidpDxFdgx7shcHeXNcdP
         vvG3jCRKJuQIYz3KrCM3uiX01VPWNcIBfYQzxp6H31rc/Jj62UBOfRByLsqiG0srjPC9
         uO1llgBuX3p3YW6J+AbJtXs2909p50Bv9HEXG44TWNj3G0Q8NKsp4Oa8tcLarFL+1g6V
         IqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tGAgMY05YhW38Fqt/+chyWnlZ8JN2BtuqCbB6fIC4mQ=;
        b=j99hE9uxZP/a+H5Ig4aQPf4c1GUgUgBvTI0RXRNAKz52cqxFt+E76R2AWxMcRT2sL+
         h3Rn6HjPF1QchuSjD0Vm91FmCd29i2YFEMecD9oUMPDbTAWKfLjh6PsK4/H4lnSO0Doi
         NJO1G4ytp1DhmxACs9Q+loXCr2gT8Jbb1QnQ2Y8Oe3Eu45RAdvah+h3OSReqquUKX4xj
         XdnJqVTph+sAa6NCzfo3mEqxCkbJZaOJhqIGG5F3niOAG5HSKVZo0cI33XmTNPo6iehQ
         yFQA01ydLWCFmRJ8zfaly4SIIXRXO3vRh9flQ+FqnN9Mr9+xnFxBaVHos0MEwMpFU2qk
         /0tA==
X-Gm-Message-State: APzg51Bjl7mGsPG9LV2huTDWaHk+NiNFq2cmbsqBRt/l94pHFezJzNhA
        17gguEll1BTRbFJcsHgvGsPvL4ydEz4=
X-Google-Smtp-Source: ANB0VdbRiDhmIjkJH0HwLKb9fKPKEPJUASEWveX1H0lNL2Bl8YCRi4CzwiXCH4lVh7yAkQoerR+YYA==
X-Received: by 2002:a62:20f:: with SMTP id 15-v6mr3162292pfc.100.1536767859099;
        Wed, 12 Sep 2018 08:57:39 -0700 (PDT)
Received: from localhost.localdomain ([103.224.155.47])
        by smtp.googlemail.com with ESMTPSA id k185-v6sm2706892pfc.160.2018.09.12.08.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:57:38 -0700 (PDT)
From:   Jagdish Tirumala <t.jag587@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        yamada.masahiro@socionext.com
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] WATCHDOG: DIAG288_WDT: Fixed error POINTER_LOCATION
Date:   Wed, 12 Sep 2018 08:56:32 -0700
Message-Id: <20180912155632.8060-1-t.jag587@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed ERROR:POINTER_LOCATION: "foo * bar" should be "foo *bar" in
file drivers/watchdog/diag288_wdt.c

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/watchdog/diag288_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 806a04a676b7..046333d1beb2 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -199,7 +199,7 @@ static int wdt_ping(struct watchdog_device *dev)
 	return ret;
 }
 
-static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
+static int wdt_set_timeout(struct watchdog_device *dev, unsigned int new_to)
 {
 	dev->timeout = new_to;
 	return wdt_ping(dev);
-- 
2.17.1

