Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C45C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFEA20652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFEA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbeGKMyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:54:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41174 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:54:10 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MTsu0-1fUKaj0gBE-00QPZ7; Wed, 11 Jul 2018 14:49:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Clemens Ladisch <clemens@ladisch.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] firewire: ohci: stop using get_seconds() for BUS_TIME
Date:   Wed, 11 Jul 2018 14:49:10 +0200
Message-Id: <20180711124923.1205200-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:rBQAoJaU0sb9gNo8i2dT0AukZ5wIMycUjk9nycNiWQZPIXYlDNc
 Mor81/qGfSGB5TjcwAELw+QHsC5NVpdEv2kEZLlQqSQfu4PZnFak5AhYiQgCK+0iwQJSmUg
 JKlQ3qN1nqOnkJmkAK/z4FQmkkzN863TcDz7CRxbNemWkXR/9/2fcJtSlmGr2C/w+hQeAzj
 8cbZmNHKQVK7npaBhN46Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2N3j8uCFws0=:o+PtsId4bvINMfnlkJ23v7
 xcJ4XZfml57zMhiX18yPxGWaoucmFqoIWGQ79jIyk95gXdoXmD8sD7ogH4K4V5cIT3hNMl1/M
 HbvE7Dl8lGbVEO3O92ZDoJBUbcM42ebaiNYyMbSlsNBh3Hu2puhkD+TKsFHPLMq94okOLgLYH
 o5x73WASkJhV3sQftqaTFlAeGD+IoE1asxP3Olrf+5aqQmVJ7HAO7e0FBqAziMY14udvyVtD1
 nP8JB9SKtxdBO/SQHoF8p0CSAVL31IZ0+5xQwtv74p2QY/0CuYXcT9P7mjO5l8z1Q6jcBnVMT
 o6xsg7CyPqcK2h6QLenj5HbKkAAXijSSdBsNUqyNt9s75bIA+XosndEUyCGRQviTz3fmf00OS
 Uw9RKiTaVIhHg0j64Fc0rQgyjrMi5SsBzzYNMM0J3ruwvaVW7J7qRaZyH1jnSo8y/gFYHoK7e
 23gqsWqC/HN4yP0X/CraTbpk12TgXdKg2fWXwDD5jH0+wCDoeY7k8o4jlkTtLq95h53zDJFal
 8ZkKaL+AD10QUKhHKH63nz/xkrJ8wuw998LzzY8oAKlXT7fCeNwe/5ZGHsISAffXN4qHb3cs+
 i/1R899f6buFsiz6E3e/u/KJ7r8tbb3HV/w2lJYZRVE6CI8hTY0IZnfnNTWVsXlqI7SH58d+J
 KOx4N4FS1cYR7hfNmUYt2oMr0eZt96TfrGAahtrVzRMl6rbP/sb4C7OHP2trf25+Rlw8=
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ohci driver uses the get_seconds() function to implement the 32-bit
CSR_BUS_TIME register. This was added in 2010 commit a48777e03ad5
("firewire: add CSR BUS_TIME support").

As get_seconds() returns a 32-bit value (on 32-bit architectures), it
seems like a good fit for that register, but it is also deprecated because
of the y2038/y2106 overflow problem, and should be replaced throughout
the kernel with either ktime_get_real_seconds() or ktime_get_seconds().

I'm using the latter here, which uses monotonic time. This has the
advantage of behaving better during concurrent settimeofday() updates
or leap second adjustments and won't overflow a 32-bit integer, but
the downside of using CLOCK_MONOTONIC instead of CLOCK_REALTIME is
that the observed values are not related to external clocks.

If we instead need UTC but can live with clock jumps or overflows,
then we should use ktime_get_real_seconds() instead, retaining the
existing behavior.

Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I notice that Stefan Richter has not been active on the mailing lists
since February 2018.

Andrew, could you pick it up in the meantime?
---
 drivers/firewire/ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 45c048751f3b..5125841ea338 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1765,7 +1765,7 @@ static u32 update_bus_time(struct fw_ohci *ohci)
 
 	if (unlikely(!ohci->bus_time_running)) {
 		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_cycle64Seconds);
-		ohci->bus_time = (lower_32_bits(get_seconds()) & ~0x7f) |
+		ohci->bus_time = (lower_32_bits(ktime_get_seconds()) & ~0x7f) |
 		                 (cycle_time_seconds & 0x40);
 		ohci->bus_time_running = true;
 	}
-- 
2.9.0

