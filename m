Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeBLFYv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:24:51 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:30143 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeBLFWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:22:24 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 03/11] watchdog/hpwdt: Update nmi_panic message.
Date: Sun, 11 Feb 2018 22:21:03 -0700
Message-Id: <20180212052111.12010-4-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212052111.12010-1-jerry.hoemann@hpe.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the nmistat in the nmi_panic message to give support
an indication why the NMI was called (e.g. a timeout or generate
nmi button.)

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 20a13c5d0285..6f7949ef9a23 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -108,24 +108,35 @@ static int hpwdt_my_nmi(void)
 	return ioread8(hpwdt_nmistat) & 0x6;
 }
 
+static inline int hexdigit(int v)
+{
+	return (v > 9) ? (v-9+'A') : (v+'0');
+}
+
 /*
  *	NMI Handler
  */
 static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 {
-	if ((ulReason == NMI_UNKNOWN) && !hpwdt_my_nmi())
+	unsigned int mynmi = hpwdt_my_nmi();
+	static char panic_msg[] =
+		"00: An NMI occurred. Depending on your system the reason "
+		"for the NMI is logged in any one of the following resources:\n"
+		"1. Integrated Management Log (IML)\n"
+		"2. OA Syslog\n"
+		"3. OA Forward Progress Log\n"
+		"4. iLO Event Log";
+
+	if ((ulReason == NMI_UNKNOWN) && !mynmi)
 		return NMI_DONE;
 
 	if (allow_kdump)
 		hpwdt_stop();
 
-	nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
-		"for the NMI is logged in any one of the following "
-		"resources:\n"
-		"1. Integrated Management Log (IML)\n"
-		"2. OA Syslog\n"
-		"3. OA Forward Progress Log\n"
-		"4. iLO Event Log");
+	panic_msg[0] = hexdigit((mynmi>>4)&0xf);
+	panic_msg[1] = hexdigit(mynmi&0xf);
+
+	nmi_panic(regs, panic_msg);
 
 	return NMI_HANDLED;
 }
-- 
2.13.6
