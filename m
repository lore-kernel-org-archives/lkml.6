Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167627AbeBOXqp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:46:45 -0500
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:54358 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167454AbeBOXpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:45:01 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v3 03/11] watchdog/hpwdt: Update nmi_panic message.
Date: Thu, 15 Feb 2018 16:43:52 -0700
Message-Id: <20180215234400.5022-4-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215234400.5022-1-jerry.hoemann@hpe.com>
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the nmistat in the nmi_panic message to give support
an indication why the NMI was called (e.g. a timeout or generate
nmi button.)

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 20a13c5d0285..07810caabf74 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -113,19 +113,23 @@ static int hpwdt_my_nmi(void)
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
+	hex_byte_pack(panic_msg, mynmi);
+	nmi_panic(regs, panic_msg);
 
 	return NMI_HANDLED;
 }
-- 
2.13.6
