Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0320AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CCF208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CCF208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934787AbeFROUC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:20:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934284AbeFROUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:20:01 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LgKx6-1fyQJn1XkK-00njHZ; Mon, 18 Jun 2018 16:19:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: ohci: stop using get_seconds() for BUS_TIME
Date:   Mon, 18 Jun 2018 16:19:24 +0200
Message-Id: <20180618141933.3404739-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fsiBvUI1XEghixXicUguhIpsjFL9E36Kf1V0WZCOVr9DFsr3mY8
 PxvdZ6Z5oMxg7CB+tZwqyzoiMFP3UeANfigRh5n9mEWeown2di1kYOYpLWsszfZqXGwYxIX
 d2/QCq4ME4lPrUA3F9PlHUHpYc90ZPTd5hRfMSP0Z+Eh6r/U/2VdvBcI6xajzC7OoQKKt/i
 vsnOSptbPc3sciDqkdpfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DLJ/MaAMXIc=:CLSqRq4CtglwyyGHSEwFmW
 g93Nu3r4bCgvdJ7aZk12MG7j1ophzcVLNwxD58+KDKEmlPz0yBfKXgEE/f2yzoPhzrI0/P/3z
 x5gswKv5wfjDj2vKD4ZNzY62cbYX9LVLrz1h7cewqnKGL7RIDTZk2TvbuGWacdoNiF2BKk6Eu
 EudNs4YVpRo+HPCHSmO8goXPsrmizrNEWOyc5PrYNufaEH/cC2NqQDAGv3VhCZVLOlOqtRQqu
 0JeePHrqMSvrg4iFHnSCHMiQh/RIrkpMB35X0xwdfnYegWORWw6Xl1KA836AsQ3ekqWsiURwv
 od6VcHC7qI3YvGWh5fLE9jbLiO3BEQ25CC3S8AoqakVOY8x0QnWl7E2G+ZbIl4N4soSJGZjH6
 PFquNM6F+fTgtcAT8suiGiwks2xD7Fpg7lW9NgFBjYKEGhy5o+qdH3U1MbjsbGiya5BPZxIaZ
 6qUb1OB4PB29fYxd89q7xHVCro90hIHo7tpAtGWO22FOzkaAENEICcZ4YbUC59gFEVZU2I7V4
 ZiB1DH+ZJPBuCy6Z46Fgqec5fdietrQmUGfdwrSCeE430Xemd3mjtYBP471L/AATCi40n/+Qx
 vMnm2lI8nsNOyNQ6M961huRcoi4+susa3E3O4GHPGN4QJwOv4r97R9SjNi4x/3VwFWACxPKvt
 Xgxr2b2n/5Y1IdSW01eNRPe7teBy8V03RrrgoZCuVo5LYMYy5UAFWahjZLJ3uZqGIUg0=
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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

