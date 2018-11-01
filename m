Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5449BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065D72081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065D72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeKAWdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:33:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeKAWdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:33:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0E3F3084044;
        Thu,  1 Nov 2018 13:30:33 +0000 (UTC)
Received: from loberhel74.redhat.com (ovpn-125-191.rdu2.redhat.com [10.10.125.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2DD6600CC;
        Thu,  1 Nov 2018 13:30:20 +0000 (UTC)
From:   Laurence Oberman <loberman@redhat.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        prarit@redhat.com, Laurence Oberman <loberman@redhat.com>
Subject: [PATCH V8] watchdog/core: Add watchdog_thresh command line parameter
Date:   Thu,  1 Nov 2018 09:30:18 -0400
Message-Id: <1541079018-13953-1-git-send-email-loberman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 01 Nov 2018 13:30:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hard and soft lockup detector threshold has a default value of 10
seconds which can only be changed via sysctl.

During early boot lockup detection can trigger when noisy debugging emits
a large amount of messages to the console, but there is no way to set a
larger threshold on the kernel command line. The detector can only be
completely disabled.

Add a new watchdog_thresh= command line parameter to allow boot time
control over the threshold. It works in the same way as the sysctl and
affects both the soft and the hard lockup detectors.

Signed-off-by: Laurence Oberman <loberman@redhat.com>

---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 kernel/watchdog.c                               | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e129cd8..3dcfb78 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4932,6 +4932,14 @@
 			or other driver-specific files in the
 			Documentation/watchdog/ directory.
 
+	watchdog_thresh=
+			[KNL]
+			Set the hard lockup detector stall duration
+			threshold in seconds. The soft lockup detector
+			threshold is set to twice the value. A value of 0
+			disables both lockup detectors. Default is 10
+			seconds.
+
 	workqueue.watchdog_thresh=
 			If CONFIG_WQ_WATCHDOG is configured, workqueue can
 			warn stall conditions and dump internal state to
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 977918d..8fbfda9 100644
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
1.8.3.1

