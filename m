Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeB1NJ6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:09:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeB1NJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:09:57 -0500
Date: Wed, 28 Feb 2018 05:09:49 -0800
From: tip-bot for Baolin Wang <tipbot@zytor.com>
Message-ID: <tip-7f852afe448c95691ead6b57bae5f37562d060b5@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, baolin.wang@linaro.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        baolin.wang@linaro.org, hpa@zytor.com
In-Reply-To: <069ce2a605546bcad6552968cff755f0a03f9f10.1516167691.git.baolin.wang@linaro.org>
References: <069ce2a605546bcad6552968cff755f0a03f9f10.1516167691.git.baolin.wang@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource: Don't walk the clocksource list for
 empty override
Git-Commit-ID: 7f852afe448c95691ead6b57bae5f37562d060b5
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

Commit-ID:  7f852afe448c95691ead6b57bae5f37562d060b5
Gitweb:     https://git.kernel.org/tip/7f852afe448c95691ead6b57bae5f37562d060b5
Author:     Baolin Wang <baolin.wang@linaro.org>
AuthorDate: Wed, 17 Jan 2018 14:01:28 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 14:04:52 +0100

clocksource: Don't walk the clocksource list for empty override

If the override clocksource name is empty there is no point in walking the
clocksource list for a match.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de
Cc: sboyd@codeaurora.org
Cc: broonie@kernel.org
Cc: john.stultz@linaro.org
Link: https://lkml.kernel.org/r/069ce2a605546bcad6552968cff755f0a03f9f10.1516167691.git.baolin.wang@linaro.org

---
 kernel/time/clocksource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 65f9e3f24dde..c5fdcb13200f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -594,6 +594,9 @@ static void __clocksource_select(bool skipcur)
 	if (!best)
 		return;
 
+	if (!strlen(override_name))
+		goto found;
+
 	/* Check for the override clocksource. */
 	list_for_each_entry(cs, &clocksource_list, list) {
 		if (skipcur && cs == curr_clocksource)
@@ -625,6 +628,7 @@ static void __clocksource_select(bool skipcur)
 		break;
 	}
 
+found:
 	if (curr_clocksource != best && !timekeeping_notify(best)) {
 		pr_info("Switched to clocksource %s\n", best->name);
 		curr_clocksource = best;
