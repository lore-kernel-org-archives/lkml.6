Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EE4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42D82075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42D82075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeJYEL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:11:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeJYEL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 974B9308213D;
        Wed, 24 Oct 2018 19:42:03 +0000 (UTC)
Received: from loberhel74.redhat.com (ovpn-121-56.rdu2.redhat.com [10.10.121.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD9839F73;
        Wed, 24 Oct 2018 19:42:01 +0000 (UTC)
From:   Laurence Oberman <loberman@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, tglx@linutronix.de,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] V6 init/main.c Enable watchdog_thresh control from kernel  line To: loberman@redhat.com
Date:   Wed, 24 Oct 2018 15:41:59 -0400
Message-Id: <1540410119-21120-1-git-send-email-loberman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 24 Oct 2018 19:42:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both graphics and serial consoles are exposed to hard lockups
when handling a large amount of messaging. The kernel watchdog_thresh
parameter up to now has not been available to be set on the kernel line for
early boot.
This patch allows the setting of watchdog_thresh to be increased
when needed to avoid the hard lockups in the console code.

Signed-off-by: Laurence Oberman <loberman@redhat.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 init/main.c                                     | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4cdcd1a..102382f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4932,6 +4932,13 @@
 			or other driver-specific files in the
 			Documentation/watchdog/ directory.
 
+	watchdog_thresh=
+			This parameter allows early boot to change the
+			value of the watchdog timeout threshold from the default
+			of 10 seconds to avoid hard lockups.  Example:
+			watchdog_thresh=30
+			Default: 10
+
 	workqueue.watchdog_thresh=
 			If CONFIG_WQ_WATCHDOG is configured, workqueue can
 			warn stall conditions and dump internal state to
diff --git a/init/main.c b/init/main.c
index 1c3f902..d5511a9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1038,6 +1038,17 @@ static int __init set_debug_rodata(char *str)
 __setup("rodata=", set_debug_rodata);
 #endif
 
+#ifdef CONFIG_LOCKUP_DETECTOR
+extern int watchdog_thresh;
+
+static int __init watchdog_thresh_setup(char *str)
+{
+	get_option(&str, &watchdog_thresh);
+	return 1;
+}
+__setup("watchdog_thresh=", watchdog_thresh_setup);
+#endif
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 static void mark_readonly(void)
 {
-- 
1.8.3.1

