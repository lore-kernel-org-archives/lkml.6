Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BBC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE657206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km0KQFfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE657206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeKUBYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:24:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeKUBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:24:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so1103832pln.9;
        Tue, 20 Nov 2018 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1AUjrFWOOz7snjrHz0u2n6cZmgcCMVFbjAGKEsGs4K0=;
        b=Km0KQFfEWmSC4Of9gZd7Q4Pmk0ZjrOUqWTsAgwVhPKrMnPvnSeS6ObOM7LXc9axg5U
         z10UA8cQNukcykgZZ65Am0ZNmren2CREyalkM4BpY/0ussVYROc5Kqx86/Bbv3mCL0QZ
         rRxgMTagpgTZvLvmY2awnYOQOK6YTe1lRZlp8sG0YLf0WRgw4rwC/Be5ycf/b1WZEjjf
         bM37hEGLdZUQtq5YIjDCkP/R3VwCjw3qrjbbt/45WXP1O9Rb9Wid4xMKNlz5ow4niGSN
         JnrIBpDXqhtTgr9b3vClhp6cAGKnks+/qtSv8oJ3VnRVrQh4I97wNiF4gZ+4/OJ20ylb
         piiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1AUjrFWOOz7snjrHz0u2n6cZmgcCMVFbjAGKEsGs4K0=;
        b=mXX9ogyo5InUwj4aSPF0wpjIr3HpCrRoX8x/UrCZSD/uv86AnQT0C1m+MOJ6aZyCzu
         eRRB8JlG85tYYVfbKmN8xZ4v1ijopdpeuZRDMvH9VqWOB6MkA8xCoU3invTBHJiV1irp
         SkqUiPTIS+WsL26o0Ttk5OGOLCA/9gah5/QC5pt8Hx06YbF3oV7WrQZkCTudAT+pD/WM
         zWb6AvLJT4EHqbzkae9DOi5nmdJehF7mj7XxWpohn5jb3Wzgb1ijTD0Km/Ve8SGZd7Yt
         XrYpsEla/a0GHPWQHTKU8PXGaCL1f5o8KFakdLqrg6EZFXfiAq/sHsjDLOHCkm97zGq1
         ZSYw==
X-Gm-Message-State: AA+aEWbOgXjX90eerr7meH8AQjcqN64K3DspByMvMh93g33Y1ORRsQuY
        DjLWeI4WuHsw2GXjPbLrShM=
X-Google-Smtp-Source: AFSGD/WPKY6FMPUwU24gYdpH7E9ydgyR2lkijSomPIh18GqV7A5bCWL8vq/CzzXTf3hTFqoogy31ag==
X-Received: by 2002:a17:902:443:: with SMTP id 61-v6mr2506361ple.216.1542725687880;
        Tue, 20 Nov 2018 06:54:47 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q199sm37330748pfc.97.2018.11.20.06.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 06:54:47 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] watchdog: cpwd: add of_node_put()
Date:   Tue, 20 Nov 2018 09:54:45 -0500
Message-Id: <20181120145445.20730-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-do that right after its last use to also cover
 error handling.
---
 drivers/watchdog/cpwd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index aee0b25cf10d..32156e199c51 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -570,6 +570,8 @@ static int cpwd_probe(struct platform_device *op)
 	if (str_prop)
 		p->timeout = simple_strtoul(str_prop, NULL, 10);
 
+	of_node_put(options);
+
 	/* CP1400s seem to have broken PLD implementations-- the
 	 * interrupt_mask register cannot be written, so no timer
 	 * interrupts can be masked within the PLD.
-- 
2.17.0

