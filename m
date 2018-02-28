Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeB1NKz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:10:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeB1NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:10:54 -0500
Date: Wed, 28 Feb 2018 05:10:43 -0800
From: tip-bot for Baolin Wang <tipbot@zytor.com>
Message-ID: <tip-27263e8dc0f6fe27540a843611ec14a000591c41@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, baolin.wang@linaro.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, baolin.wang@linaro.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <d80dccb981dc2461781ebb8d71a32ccdc1b0e6f9.1516167691.git.baolin.wang@linaro.org>
References: <d80dccb981dc2461781ebb8d71a32ccdc1b0e6f9.1516167691.git.baolin.wang@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource: Use ATTRIBUTE_GROUPS
Git-Commit-ID: 27263e8dc0f6fe27540a843611ec14a000591c41
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

Commit-ID:  27263e8dc0f6fe27540a843611ec14a000591c41
Gitweb:     https://git.kernel.org/tip/27263e8dc0f6fe27540a843611ec14a000591c41
Author:     Baolin Wang <baolin.wang@linaro.org>
AuthorDate: Wed, 17 Jan 2018 14:01:30 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 14:05:07 +0100

clocksource: Use ATTRIBUTE_GROUPS

Use ATTRIBUTE_GROUPS instead of manually creating the individual device
files.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de
Cc: sboyd@codeaurora.org
Cc: broonie@kernel.org
Cc: john.stultz@linaro.org
Link: https://lkml.kernel.org/r/d80dccb981dc2461781ebb8d71a32ccdc1b0e6f9.1516167691.git.baolin.wang@linaro.org
---
 kernel/time/clocksource.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7ce53465782b..0e974cface0b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -993,6 +993,14 @@ static ssize_t available_clocksource_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(available_clocksource);
 
+static struct attribute *clocksource_attrs[] = {
+	&dev_attr_current_clocksource.attr,
+	&dev_attr_unbind_clocksource.attr,
+	&dev_attr_available_clocksource.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(clocksource);
+
 static struct bus_type clocksource_subsys = {
 	.name = "clocksource",
 	.dev_name = "clocksource",
@@ -1001,6 +1009,7 @@ static struct bus_type clocksource_subsys = {
 static struct device device_clocksource = {
 	.id	= 0,
 	.bus	= &clocksource_subsys,
+	.groups	= clocksource_groups,
 };
 
 static int __init init_clocksource_sysfs(void)
@@ -1009,17 +1018,7 @@ static int __init init_clocksource_sysfs(void)
 
 	if (!error)
 		error = device_register(&device_clocksource);
-	if (!error)
-		error = device_create_file(
-				&device_clocksource,
-				&dev_attr_current_clocksource);
-	if (!error)
-		error = device_create_file(&device_clocksource,
-					   &dev_attr_unbind_clocksource);
-	if (!error)
-		error = device_create_file(
-				&device_clocksource,
-				&dev_attr_available_clocksource);
+
 	return error;
 }
 
