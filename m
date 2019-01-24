Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B2C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1ED218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAXBfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:35:47 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:63820 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfAXBfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:35:47 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id C2ADF6CAE93D03AF366A;
        Thu, 24 Jan 2019 09:35:44 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0O1ZTxo079095;
        Thu, 24 Jan 2019 09:35:29 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012409355570-23828284 ;
          Thu, 24 Jan 2019 09:35:55 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RESEND PATCH] char/rtc: fix object reference leaks in rtc_init
Date:   Thu, 24 Jan 2019 09:35:16 +0800
Message-Id: <1548293716-41608-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-24 09:35:55,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-24 09:35:17,
        Serialize complete at 2019-01-24 09:35:17
X-MAIL: mse01.zte.com.cn x0O1ZTxo079095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.
The of_find_device_by_node() takes a reference to the underlying device
structure, we also should release that reference.
This patch fixes those 2 issues.
Fixes: 75081322c ("sparc32: Convert PC RTC probing to pure OF driver")

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
---
 drivers/char/rtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index c862d0b..aa67690 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -872,6 +872,8 @@ static int __init rtc_init(void)
 				if (op) {
 					rtc_port = op->resource[0].start;
 					rtc_irq = op->irqs[0];
+					put_device(&op->dev);
+					of_node_put(dp);
 					goto found;
 				}
 			}
-- 
2.9.5

