Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE062082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE062082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeKNDQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:16:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:53821 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732201AbeKNDQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:16:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="91747462"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2018 09:17:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B723CBF6; Tue, 13 Nov 2018 19:17:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 20/20] PM: Switch to use %ptR
Date:   Tue, 13 Nov 2018 19:17:29 +0200
Message-Id: <20181113171729.19645-21-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
References: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: linux-pm@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 1cda505d6a85..b11f47a1e819 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -118,9 +118,7 @@ static unsigned int read_magic_time(void)
 	unsigned int val;
 
 	mc146818_get_time(&time);
-	pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
-		time.tm_hour, time.tm_min, time.tm_sec,
-		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
+	pr_info("RTC time: %ptRt, date: %ptRd\n", &time, &time);
 	val = time.tm_year;				/* 100 years */
 	if (val > 100)
 		val -= 100;
-- 
2.19.1

