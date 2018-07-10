Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45FBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBB6208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBB6208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbeGJSgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:36:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389774AbeGJSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:36:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5D18EC2;
        Tue, 10 Jul 2018 18:35:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouke Witteveen <j.witteveen@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 06/56] ACPI / battery: Safe unregistering of hooks
Date:   Tue, 10 Jul 2018 20:24:48 +0200
Message-Id: <20180710182503.813488799@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jouke Witteveen <j.witteveen@gmail.com>

commit 673b4271665a12fa839a12abb50e6f6e9953c081 upstream.

A hooking API was implemented for 4.17 in fa93854f7a7ed63d followed
by hooks for Thinkpad laptops in 2801b9683f740012. The Thinkpad
drivers did not support the Thinkpad 13 and the hooking API crashes
on unsupported batteries by altering a list of hooks during unsafe
iteration. Thus, Thinkpad 13 laptops could no longer boot.

Additionally, a lock was kept in place and debugging information was
printed out of order.

Fixes: fa93854f7a7e (battery: Add the battery hooking API)
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/battery.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -709,10 +709,11 @@ void battery_hook_register(struct acpi_b
 			 */
 			pr_err("extension failed to load: %s", hook->name);
 			__battery_hook_unregister(hook, 0);
-			return;
+			goto end;
 		}
 	}
 	pr_info("new extension: %s\n", hook->name);
+end:
 	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_register);
@@ -724,7 +725,7 @@ EXPORT_SYMBOL_GPL(battery_hook_register)
 */
 static void battery_hook_add_battery(struct acpi_battery *battery)
 {
-	struct acpi_battery_hook *hook_node;
+	struct acpi_battery_hook *hook_node, *tmp;
 
 	mutex_lock(&hook_mutex);
 	INIT_LIST_HEAD(&battery->list);
@@ -736,15 +737,15 @@ static void battery_hook_add_battery(str
 	 * when a battery gets hotplugged or initialized
 	 * during the battery module initialization.
 	 */
-	list_for_each_entry(hook_node, &battery_hook_list, list) {
+	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
 		if (hook_node->add_battery(battery->bat)) {
 			/*
 			 * The notification of the extensions has failed, to
 			 * prevent further errors we will unload the extension.
 			 */
-			__battery_hook_unregister(hook_node, 0);
 			pr_err("error in extension, unloading: %s",
 					hook_node->name);
+			__battery_hook_unregister(hook_node, 0);
 		}
 	}
 	mutex_unlock(&hook_mutex);


