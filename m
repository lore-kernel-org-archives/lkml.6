Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F51C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C262089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C262089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeG0Gxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:53:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35979 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbeG0Gxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:53:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA006B5DEDC88;
        Fri, 27 Jul 2018 13:33:39 +0800 (CST)
Received: from vm167-7.huawei.com (10.177.167.7) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.382.0; Fri, 27 Jul 2018 13:33:30 +0800
From:   Xu YiPing <xuyiping@hisilicon.com>
To:     <xuyiping@hisilicon.com>, <tglx@linutronix.de>,
        <john.stultz@linaro.org>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] timers: fix offset calculation when the expires align with LVL_GRAN
Date:   Fri, 27 Jul 2018 13:33:30 +0800
Message-ID: <1532669610-103892-1-git-send-email-xuyiping@hisilicon.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.167.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the expires of timer is align with LVL_GRAN(n), it will be trigged
in 'expires + LVL_GRAN(n)'.

Some drivers like power runtime use the timer to start a power down
of device, it could saves power if the timer is triggerd in time,
especially when LEVEL=0 with low expires.

Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
---
 kernel/time/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cc2d23e..76655e2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -487,7 +487,8 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  */
 static inline unsigned calc_index(unsigned expires, unsigned lvl)
 {
-	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	expires = (expires + LVL_GRAN(lvl) - 1) >> LVL_SHIFT(lvl);
+
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
 
-- 
2.7.4

