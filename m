Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEE6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEA52080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEA52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJ3Xot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeJ3Xot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:44:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1904D3091749;
        Tue, 30 Oct 2018 14:51:03 +0000 (UTC)
Received: from loberhel74.redhat.com (ovpn-125-191.rdu2.redhat.com [10.10.125.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC9A5F703;
        Tue, 30 Oct 2018 14:51:02 +0000 (UTC)
From:   Laurence Oberman <loberman@redhat.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        prarit@redhat.com, Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] [PATCH V7] watchdog/core: Add watchdog_thresh command line  parameter
Date:   Tue, 30 Oct 2018 10:50:04 -0400
Message-Id: <1540911004-11539-1-git-send-email-loberman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 30 Oct 2018 14:51:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both graphics and serial consoles are exposed to hard lockups
when handling a large amount of messaging. The kernel watchdog_thresh
parameter up to now has not been available to be set on the kernel line for
early boot.
This patch allows the setting of watchdog_thresh to be increased
when needed to extend the hard lockup timer in the console code.
Note that this also affects the soft lockup detector

Signed-off-by: Laurence Oberman <loberman@redhat.com>

---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 kernel/watchdog.c                               | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b90fe3b6bc6c..4263937f4aa9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4957,6 +4957,14 @@
 			or other driver-specific files in the
 			Documentation/watchdog/ directory.
 
+        watchdog_thresh=
+                        [KNL]
+                        Set the hard lockup detector stall duration
+                        threshold in seconds. The soft lockup detector
+                        threshold is set to twice the value. A value of 0
+                        disables both lockup detectors. Default is 10
+                        seconds.
+
 	workqueue.watchdog_thresh=
 			If CONFIG_WQ_WATCHDOG is configured, workqueue can
 			warn stall conditions and dump internal state to
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 977918d5d350..8fbfda94a67b 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -199,6 +199,13 @@ static int __init nosoftlockup_setup(char *str)
 }
 __setup("nosoftlockup", nosoftlockup_setup);
 
+static int __init watchdog_thresh_setup(char *str)
+{
+	get_option(&str, &watchdog_thresh);
+	return 1;
+}
+__setup("watchdog_thresh=", watchdog_thresh_setup);
+
 #ifdef CONFIG_SMP
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 
-- 
2.18.1

