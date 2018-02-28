Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeB1NKY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:10:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeB1NKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:10:22 -0500
Date: Wed, 28 Feb 2018 05:10:16 -0800
From: tip-bot for Baolin Wang <tipbot@zytor.com>
Message-ID: <tip-e87821d18cf4db19d634a04061c0a1b7eb9c0e65@git.kernel.org>
Cc: baolin.wang@linaro.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: baolin.wang@linaro.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <8f35c77e753e957b61187e8e7b2e4a3d61e4a72b.1516167691.git.baolin.wang@linaro.org>
References: <8f35c77e753e957b61187e8e7b2e4a3d61e4a72b.1516167691.git.baolin.wang@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource: Use DEVICE_ATTR_RW/RO/WO to define
 device attributes
Git-Commit-ID: e87821d18cf4db19d634a04061c0a1b7eb9c0e65
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

Commit-ID:  e87821d18cf4db19d634a04061c0a1b7eb9c0e65
Gitweb:     https://git.kernel.org/tip/e87821d18cf4db19d634a04061c0a1b7eb9c0e65
Author:     Baolin Wang <baolin.wang@linaro.org>
AuthorDate: Wed, 17 Jan 2018 14:01:29 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 14:04:52 +0100

clocksource: Use DEVICE_ATTR_RW/RO/WO to define device attributes

Convert DEVICE_ATTR to DEVICE_ATTR_RW/RO/WO which is the preferred and
simpler way of implementation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de
Cc: sboyd@codeaurora.org
Cc: broonie@kernel.org
Cc: john.stultz@linaro.org
Link: https://lkml.kernel.org/r/8f35c77e753e957b61187e8e7b2e4a3d61e4a72b.1516167691.git.baolin.wang@linaro.org

---
 kernel/time/clocksource.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c5fdcb13200f..7ce53465782b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -857,16 +857,16 @@ EXPORT_SYMBOL(clocksource_unregister);
 
 #ifdef CONFIG_SYSFS
 /**
- * sysfs_show_current_clocksources - sysfs interface for current clocksource
+ * current_clocksource_show - sysfs interface for current clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	char buffer to be filled with clocksource list
  *
  * Provides sysfs interface for listing current clocksource.
  */
-static ssize_t
-sysfs_show_current_clocksources(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t current_clocksource_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	ssize_t count = 0;
 
@@ -895,7 +895,7 @@ ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt)
 }
 
 /**
- * sysfs_override_clocksource - interface for manually overriding clocksource
+ * current_clocksource_store - interface for manually overriding clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	name of override clocksource
@@ -904,9 +904,9 @@ ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt)
  * Takes input from sysfs interface for manually overriding the default
  * clocksource selection.
  */
-static ssize_t sysfs_override_clocksource(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
+static ssize_t current_clocksource_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
 {
 	ssize_t ret;
 
@@ -920,9 +920,10 @@ static ssize_t sysfs_override_clocksource(struct device *dev,
 
 	return ret;
 }
+static DEVICE_ATTR_RW(current_clocksource);
 
 /**
- * sysfs_unbind_current_clocksource - interface for manually unbinding clocksource
+ * unbind_clocksource_store - interface for manually unbinding clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	unused
@@ -930,7 +931,7 @@ static ssize_t sysfs_override_clocksource(struct device *dev,
  *
  * Takes input from sysfs interface for manually unbinding a clocksource.
  */
-static ssize_t sysfs_unbind_clocksource(struct device *dev,
+static ssize_t unbind_clocksource_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -954,19 +955,19 @@ static ssize_t sysfs_unbind_clocksource(struct device *dev,
 
 	return ret ? ret : count;
 }
+static DEVICE_ATTR_WO(unbind_clocksource);
 
 /**
- * sysfs_show_available_clocksources - sysfs interface for listing clocksource
+ * available_clocksource_show - sysfs interface for listing clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	char buffer to be filled with clocksource list
  *
  * Provides sysfs interface for listing registered clocksources
  */
-static ssize_t
-sysfs_show_available_clocksources(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
+static ssize_t available_clocksource_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct clocksource *src;
 	ssize_t count = 0;
@@ -990,17 +991,7 @@ sysfs_show_available_clocksources(struct device *dev,
 
 	return count;
 }
-
-/*
- * Sysfs setup bits:
- */
-static DEVICE_ATTR(current_clocksource, 0644, sysfs_show_current_clocksources,
-		   sysfs_override_clocksource);
-
-static DEVICE_ATTR(unbind_clocksource, 0200, NULL, sysfs_unbind_clocksource);
-
-static DEVICE_ATTR(available_clocksource, 0444,
-		   sysfs_show_available_clocksources, NULL);
+static DEVICE_ATTR_RO(available_clocksource);
 
 static struct bus_type clocksource_subsys = {
 	.name = "clocksource",
