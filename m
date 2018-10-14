Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACAC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6436B20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6436B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeJNX1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:27:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37204 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbeJNX1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:27:37 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cW-9a; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000Jy-2q; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Nicholas Piggin" <npiggin@gmail.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.831448628@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 133/366] powerpc/powernv: Fix OPAL NVRAM driver
 OPAL_BUSY loops
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 3b8070335f751aac9f1526ae2e012e6f5b8b0f21 upstream.

The OPAL NVRAM driver does not sleep in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware, which causes large scheduling
latencies, and various lockup errors to trigger (again, BMC reboot
can cause it).

Fix this by converting it to the standard form OPAL_BUSY loop that
sleeps.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Depends-on: 34dd25de9fe3 ("powerpc/powernv: define a standard delay for OPAL_BUSY type retry loops")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/platforms/powernv/opal-nvram.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -11,6 +11,7 @@
 
 #define DEBUG
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -55,8 +56,12 @@ static ssize_t opal_nvram_write(char *bu
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 
 	if (rc)

