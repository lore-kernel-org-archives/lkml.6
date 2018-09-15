Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C908A20882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/c9Q+yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C908A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIOIal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:30:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37718 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:30:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so5115991pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=251ZpBy3wzqgLLP+TQhmWnziNpr/7ye8/RmMWmT3hz8=;
        b=Q/c9Q+ylmTgzzdJMN2DSSQgCtlNGgSKg7pSRWY8oiRJVF4uR8qcXtUbcG9bcc6aYP7
         DM0MvdJmijvu0uoiGsNtCquBc3gLHb+x09KlAiOPcB2I9QTm0fmTT12dd/s2lBomV8I2
         6thk52pJJy6dmPPA8zrjVF7r6sTr4aRYzf7e7xOXWnZnmeHxLHf0UAirE8Y4bcyW2Rmf
         /zx8Otukla+UBazc79/Nl5pZYkwNpb9cF8QIKsvncJhYbnMWltTAk4vCEOqqh7WCySJ1
         h6mFSLpVw2QrFwgaAR3jkLICZRFUA/F1rlxgGIG2mMUtgTpkYwNmnT9VmPdv4NuCvC79
         1ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=251ZpBy3wzqgLLP+TQhmWnziNpr/7ye8/RmMWmT3hz8=;
        b=V7l2ukKWJ9QNNboWcyuw/zPbCBPDaaf4dCIIlTpsnnTuH//SfbXv8sQ/3tUtc5G7Xf
         VlXzkBMlIe2sXk0kwJIgADp67D2dv9FLZOosSoZBRIEvaW8cAJJdbKbgpM8s93CwjoJW
         ogE1QOISf6BWMuENdxeXJYUI5IJ6TJzZxMT8MEpQTGoaMYoab8ZIPOjzNdiVllsPiDdi
         pAJX0cVcZSczBXY276qQrkFGLKmhBlpyJ9qphrclksWiMu57WALbYh0h6NUT+phD3LtV
         2pK+rif0xwq+cQCfajRTO7VrBN0BXfN7vo88idenLDvjU1Rta/giHoa6OPm1OvlzKeU5
         4IMQ==
X-Gm-Message-State: APzg51BDgd7dThd9OQUWjpbfX5eCvG+tSCp5QnlLskrL0a5Y3ZyvB3/U
        Z1/yCdaaNpzaY5GZr0ymzeg=
X-Google-Smtp-Source: ANB0VdYVq2GCTvmhFcr+yEWIR1NNFL/f9bHCCWchsgPnj7H/ZQ2XygrrisQXAP9/J4S5bmOY08mwhQ==
X-Received: by 2002:a63:4283:: with SMTP id p125-v6mr14249003pga.142.1536981200600;
        Fri, 14 Sep 2018 20:13:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id y18-v6sm9849594pfl.90.2018.09.14.20.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 20:13:20 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     lidza.louina@gmail.com, markh@compro.net,
        gregkh@linuxfoundation.org
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: dgnc: Fix a sleep-in-atomic-context bug in cls_assert_modem_signals()
Date:   Sat, 15 Sep 2018 11:13:03 +0800
Message-Id: <20180915031303.5302-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] usleep_range
drivers/staging/dgnc/dgnc_cls.c, 391: 
	usleep_range in cls_assert_modem_signals
drivers/staging/dgnc/dgnc_cls.c, 449: 
	cls_assert_modem_signals in cls_copy_data_from_queue_to_uart
drivers/staging/dgnc/dgnc_cls.c, 406: 
	_raw_spin_lock_irqsave in cls_copy_data_from_queue_to_uart

To fix this bug, usleep_range() is replaced with udelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/dgnc/dgnc_cls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/dgnc/dgnc_cls.c b/drivers/staging/dgnc/dgnc_cls.c
index 7e6cbfe4e4ee..a1e98ee7f9e0 100644
--- a/drivers/staging/dgnc/dgnc_cls.c
+++ b/drivers/staging/dgnc/dgnc_cls.c
@@ -388,7 +388,7 @@ static void cls_assert_modem_signals(struct channel_t *ch)
 	writeb(out, &ch->ch_cls_uart->mcr);
 
 	/* Give time for the UART to actually drop the signals */
-	usleep_range(10, 20);
+	udelay(20);
 }
 
 static void cls_copy_data_from_queue_to_uart(struct channel_t *ch)
-- 
2.17.0

