Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC2C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C303F20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C303F20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYAVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:21:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeJYAVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A357A61D07;
        Wed, 24 Oct 2018 15:53:14 +0000 (UTC)
Received: from loberhel74.redhat.com (ovpn-121-56.rdu2.redhat.com [10.10.121.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09358104C53B;
        Wed, 24 Oct 2018 15:53:13 +0000 (UTC)
From:   Laurence Oberman <loberman@redhat.com>
To:     linux-kernel@vger.kernel.org, loberman@redhat.com
Cc:     rdunlap@infradead.org
Subject: [PATCH] V2 init/main.c Enable watchdog_thresh control from kernel line 
Date:   Wed, 24 Oct 2018 11:53:07 -0400
Message-Id: <1540396387-20337-1-git-send-email-loberman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 24 Oct 2018 15:53:14 +0000 (UTC)
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
---
 init/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/init/main.c b/init/main.c
index e4a3160..5882750 100644
--- a/init/main.c
+++ b/init/main.c
@@ -977,6 +977,15 @@ static int __init set_debug_rodata(char *str)
 __setup("rodata=", set_debug_rodata);
 #endif
 
+static int __init
+is_watchdog_thresh_setup(char *str)
+{
+	get_option(&str, &watchdog_thresh);
+	return 1;
+}
+__setup("watchdog_thresh=", is_watchdog_thresh_setup);
+
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 static void mark_readonly(void)
 {
-- 
1.8.3.1

---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bf03fe4..a5280a1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4615,6 +4615,14 @@
 			or other driver-specific files in the
 			Documentation/watchdog/ directory.
 
+	watchdog_thresh=
+			This parameter is now available as a kernel line
+			parameter. Use watchdog_thresh=30 as example
+			This will allow early boot changes of the current
+			default of 10s to be increased when needed to
+			avoid hard lockups.
+			Default: 10
+
 	workqueue.watchdog_thresh=
 			If CONFIG_WQ_WATCHDOG is configured, workqueue can
 			warn stall conditions and dump internal state to
-- 
1.8.3.1

