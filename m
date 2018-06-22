Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C043224555
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C043224555
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934039AbeFVPwG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:52:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934003AbeFVPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:52:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MFprMw125336
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 08:51:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MFpqR6125333;
        Fri, 22 Jun 2018 08:51:52 -0700
Date:   Fri, 22 Jun 2018 08:51:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-abcbcb80cd09cd40f2089d912764e315459b71f7@git.kernel.org>
Cc:     arnd@arndb.de, john.stultz@linaro.org, geert@linux-m68k.org,
        sboyd@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org
Reply-To: john.stultz@linaro.org, arnd@arndb.de, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          sboyd@kernel.org, geert@linux-m68k.org
In-Reply-To: <20180622143357.7495-1-geert@linux-m68k.org>
References: <20180622143357.7495-1-geert@linux-m68k.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] time: Make sure jiffies_to_msecs() preserves
 non-zero time periods
Git-Commit-ID: abcbcb80cd09cd40f2089d912764e315459b71f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  abcbcb80cd09cd40f2089d912764e315459b71f7
Gitweb:     https://git.kernel.org/tip/abcbcb80cd09cd40f2089d912764e315459b71f7
Author:     Geert Uytterhoeven <geert@linux-m68k.org>
AuthorDate: Fri, 22 Jun 2018 16:33:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 17:48:36 +0200

time: Make sure jiffies_to_msecs() preserves non-zero time periods

For the common cases where 1000 is a multiple of HZ, or HZ is a multiple of
1000, jiffies_to_msecs() never returns zero when passed a non-zero time
period.

However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
1200, as used on alpha and DECstation), jiffies_to_msecs() may return zero
for small non-zero time periods.  This may break code that relies on
receiving back a non-zero value.

jiffies_to_usecs() does not need such a fix: one jiffy can only be less
than one µs if HZ > 1000000, and such large values of HZ are already
rejected at build time, twice:

  - include/linux/jiffies.h does #error if HZ >= 12288,
  - kernel/time/time.c has BUILD_BUG_ON(HZ > USEC_PER_SEC).

Broken since forever.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180622143357.7495-1-geert@linux-m68k.org

---
 kernel/time/time.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 6fa99213fc72..2b41e8e2d31d 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/timex.h>
 #include <linux/capability.h>
 #include <linux/timekeeper_internal.h>
@@ -314,9 +315,10 @@ unsigned int jiffies_to_msecs(const unsigned long j)
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
-	return (HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
+	return (HZ_TO_MSEC_MUL32 * j + (1ULL << HZ_TO_MSEC_SHR32) - 1) >>
+	       HZ_TO_MSEC_SHR32;
 # else
-	return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
+	return DIV_ROUND_UP(j * HZ_TO_MSEC_NUM, HZ_TO_MSEC_DEN);
 # endif
 #endif
 }
