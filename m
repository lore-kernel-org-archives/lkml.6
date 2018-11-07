Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D6C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D48C20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D48C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbeKGMIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:08:32 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:41150 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeKGMIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:08:31 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992433AbeKGCjNNCDhO (ORCPT
        <rfc822;stable@vger.kernel.org> + 2 others);
        Wed, 7 Nov 2018 03:39:13 +0100
Date:   Wed, 7 Nov 2018 02:39:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] rtc: m41t80: Correct alarm month range with RTC reads
Message-ID: <alpine.LFD.2.21.1811070053580.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing adjustment of the month range on alarm reads from the 
RTC, correcting an issue coming from commit 9c6dfed92c3e ("rtc: m41t80: 
add alarm functionality").  The range is 1-12 for hardware and 0-11 for 
`struct rtc_time', and is already correctly handled on alarm writes to 
the RTC.

It was correct up until commit 48e9766726eb ("drivers/rtc/rtc-m41t80.c: 
remove disabled alarm functionality") too, which removed the previous 
implementation of alarm support.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 9c6dfed92c3e ("rtc: m41t80: add alarm functionality")
References: 48e9766726eb ("drivers/rtc/rtc-m41t80.c: remove disabled alarm functionality")
Cc: stable@vger.kernel.org # 4.7+
---
Hi,

 I have no means to verify this change at run time as my M41T81 device, 
which is the reason for me to use this driver, regrettably hasn't got its 
IRQ line routed, due to historical reasons I gathered, as it replaced a 
different RTC device, that didn't have an IRQ output at all, used with 
earlier revisions of the Broadcom SiByte SWARM board I have been using 
this code with.  However it should be obvious by code inspection.

 Please apply and backport as appropriate.

  Maciej
---
 drivers/rtc/rtc-m41t80.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-rtc-m41t80-read-alarm-month.diff
Index: linux-20181008-swarm64-eb/drivers/rtc/rtc-m41t80.c
===================================================================
--- linux-20181008-swarm64-eb.orig/drivers/rtc/rtc-m41t80.c
+++ linux-20181008-swarm64-eb/drivers/rtc/rtc-m41t80.c
@@ -393,7 +393,7 @@ static int m41t80_read_alarm(struct devi
 	alrm->time.tm_min  = bcd2bin(alarmvals[3] & 0x7f);
 	alrm->time.tm_hour = bcd2bin(alarmvals[2] & 0x3f);
 	alrm->time.tm_mday = bcd2bin(alarmvals[1] & 0x3f);
-	alrm->time.tm_mon  = bcd2bin(alarmvals[0] & 0x3f);
+	alrm->time.tm_mon  = bcd2bin(alarmvals[0] & 0x3f) - 1;
 
 	alrm->enabled = !!(alarmvals[0] & M41T80_ALMON_AFE);
 	alrm->pending = (flags & M41T80_FLAGS_AF) && alrm->enabled;
