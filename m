Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FFECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3947A20831
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3947A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeKENHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 08:07:40 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:48798 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKENHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 08:07:40 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990403AbeKEDsZt0KeY (ORCPT
        <rfc822;stable@vger.kernel.org> + 2 others);
        Mon, 5 Nov 2018 04:48:25 +0100
Date:   Mon, 5 Nov 2018 03:48:25 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] rtc: hctosys: Add missing range error reporting
Message-ID: <alpine.LFD.2.21.1811050319150.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue with the 32-bit range error path in `rtc_hctosys' where no 
error code is set and consequently the successful preceding call result 
from `rtc_read_time' is propagated to `rtc_hctosys_ret'.  This in turn 
makes any subsequent call to `hctosys_show' incorrectly report in sysfs 
that the system time has been set from this RTC while it has not.

Set the error to ERANGE then if we can't express the result due to an 
overflow.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow time_t")
Cc: stable@vger.kernel.org # 4.17+
---
 drivers/rtc/hctosys.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

linux-rtc-hctosys-range.diff
Index: linux-20181008-swarm64-eb/drivers/rtc/hctosys.c
===================================================================
--- linux-20181008-swarm64-eb.orig/drivers/rtc/hctosys.c
+++ linux-20181008-swarm64-eb/drivers/rtc/hctosys.c
@@ -50,8 +50,10 @@ static int __init rtc_hctosys(void)
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
 #if BITS_PER_LONG == 32
-	if (tv64.tv_sec > INT_MAX)
+	if (tv64.tv_sec > INT_MAX) {
+		err = -ERANGE;
 		goto err_read;
+	}
 #endif
 
 	err = do_settimeofday64(&tv64);
