Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeCTFvo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 01:51:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34578 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeCTFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 01:51:42 -0400
X-Google-Smtp-Source: AG47ELsrcZOHfOCTq2rMENafufk/2nSI4MbCaPfHtZLRW/U9A9k5bwauA1TN716o8qb2tTaZB5OdhQ==
From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v2] ACPI / scan: Send the change uevent with offine environmental data
Date: Tue, 20 Mar 2018 13:51:26 +0800
Message-Id: <20180320055126.8671-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current design of ACPI container offline, Kernel emits
KOBJ_CHANGE uevent to user space to indidate that the ejection of
the container was triggered by platform. (caa73ea15 patch)

A pure KOBJ_CHANGE uevent is not enough for user space to identify
the purpose. For example, a "udevadm trigger" command can also
be used to emit change event to all udev rules. A udev rule can not
identify that the event is from kernel for offline or from udevadm
for other purpose. Then the offline action in udev rule may also be
triggered by udevadm tool.

So, similar to the change uevent of dock, kernel sends the
KOBJ_CHANGE uevent with a offline environmental data to indicate
purpose. It's useful by udev rule for using ENV{EVENT} filter.

v2:
Fix build warning for the environmental string

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Tested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/acpi/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8e63d93..490498e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -116,6 +116,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 {
 	struct acpi_device_physical_node *pn;
 	bool offline = true;
+	char *envp[] = { "EVENT=offline", NULL };
 
 	/*
 	 * acpi_container_offline() calls this for all of the container's
@@ -126,7 +127,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	list_for_each_entry(pn, &adev->physical_node_list, node)
 		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
 			if (uevent)
-				kobject_uevent(&pn->dev->kobj, KOBJ_CHANGE);
+				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
 
 			offline = false;
 			break;
-- 
2.10.2
