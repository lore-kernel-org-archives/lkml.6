Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F0E2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfB0NhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:37:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50963 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0NhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:37:24 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 2cc30d742cbb5515; Wed, 27 Feb 2019 14:37:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cpuidle: menu: Avoid overflows when computing variance
Date:   Wed, 27 Feb 2019 14:35:50 +0100
Message-ID: <13496310.XaNEd20TYL@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The variance computation in get_typical_interval() may overflow if
the square of the value of diff exceeds the maximum for the int64_t
data type value which basically is the case when it is of the order
of UINT_MAX.

However, data points so far in the future don't matter for idle
state selection anyway, so change the initial threshold value in
get_typical_interval() to INT_MAX which will cause more "outlying"
data points to be discarded without affecting the selection result.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -186,7 +186,7 @@ static unsigned int get_typical_interval
 	unsigned int min, max, thresh, avg;
 	uint64_t sum, variance;
 
-	thresh = UINT_MAX; /* Discard outliers above this value */
+	thresh = INT_MAX; /* Discard outliers above this value */
 
 again:
 

