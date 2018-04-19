Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeDSLZZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:25:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51861 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeDSLZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:25:23 -0400
Date: Thu, 19 Apr 2018 04:25:13 -0700
From: tip-bot for Anson Huang <tipbot@zytor.com>
Message-ID: <tip-7407188489c62a7b5694bc75a6db2b82af94c9a5@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, Aisheng.dong@nxp.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        Aisheng.dong@nxp.com, linux-kernel@vger.kernel.org,
        Anson.Huang@nxp.com
In-Reply-To: <1524117883-2484-1-git-send-email-Anson.Huang@nxp.com>
References: <1524117883-2484-1-git-send-email-Anson.Huang@nxp.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/imx-tpm: Correct -ETIME return
 condition check
Git-Commit-ID: 7407188489c62a7b5694bc75a6db2b82af94c9a5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7407188489c62a7b5694bc75a6db2b82af94c9a5
Gitweb:     https://git.kernel.org/tip/7407188489c62a7b5694bc75a6db2b82af94c9a5
Author:     Anson Huang <Anson.Huang@nxp.com>
AuthorDate: Thu, 19 Apr 2018 14:04:43 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 19 Apr 2018 13:21:35 +0200

clocksource/imx-tpm: Correct -ETIME return condition check

The additional brakects added to tpm_set_next_event's return value
computation causes (int) forced type conversion NOT taking effect, and the
incorrect value return will cause various system timer issue, like RCU
stall etc..

Remove the additional brackets to make sure tpm_set_next_event always
returns correct value.

Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>
Cc: stable@vger.kernel.org
Cc: daniel.lezcano@linaro.org
Cc: Linux-imx@nxp.com
Link: https://lkml.kernel.org/r/1524117883-2484-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 05d97a6871d8..6c8318470b48 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -114,7 +114,7 @@ static int tpm_set_next_event(unsigned long delta,
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)((next - now) <= 0) ? -ETIME : 0;
+	return (int)(next - now) <= 0 ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
