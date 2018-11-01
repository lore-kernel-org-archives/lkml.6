Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941DAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438D920657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438D920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeKAWkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:40:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeKAWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:40:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA1Dap7g2835722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Nov 2018 06:36:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA1Daorn2835719;
        Thu, 1 Nov 2018 06:36:50 -0700
Date:   Thu, 1 Nov 2018 06:36:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Laurence Oberman <tipbot@zytor.com>
Message-ID: <tip-11295055526308ee71d82dc97f0a9ca2dd61c3b9@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, loberman@redhat.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          loberman@redhat.com, mingo@kernel.org
In-Reply-To: <1541079018-13953-1-git-send-email-loberman@redhat.com>
References: <1541079018-13953-1-git-send-email-loberman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] watchdog/core: Add watchdog_thresh command line
 parameter
Git-Commit-ID: 11295055526308ee71d82dc97f0a9ca2dd61c3b9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  11295055526308ee71d82dc97f0a9ca2dd61c3b9
Gitweb:     https://git.kernel.org/tip/11295055526308ee71d82dc97f0a9ca2dd61c3b9
Author:     Laurence Oberman <loberman@redhat.com>
AuthorDate: Thu, 1 Nov 2018 09:30:18 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Nov 2018 14:33:35 +0100

watchdog/core: Add watchdog_thresh command line parameter

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: rdunlap@infradead.org
Cc: prarit@redhat.com
Link: https://lkml.kernel.org/r/1541079018-13953-1-git-send-email-loberman@redhat.com


---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 kernel/watchdog.c                               | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b90fe3b6bc6c..79b5b473001b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4957,6 +4957,14 @@
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
 
