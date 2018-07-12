Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3F208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF3F208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lisas.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeGLNRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:17:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbeGLNRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE8C24022909;
        Thu, 12 Jul 2018 13:07:49 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-180.ams2.redhat.com [10.36.116.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 657921C671;
        Thu, 12 Jul 2018 13:07:46 +0000 (UTC)
From:   Adrian Reber <adrian@lisas.de>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Adrian Reber <adrian@lisas.de>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
Date:   Thu, 12 Jul 2018 15:07:33 +0200
Message-Id: <20180712130733.11510-1-adrian@lisas.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 13:07:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 13:07:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'adrian@lisas.de' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
distribution kernels and also part of the defconfigs of various
architectures.

To make it easier for distributions to enable CHECKPOINT_RESTORE this
removes EXPERT and moves the configuration option out of the EXPERT
block.

Signed-off-by: Adrian Reber <adrian@lisas.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Andrei Vagin <avagin@virtuozzo.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 init/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 041f3a022122..9c529c763326 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -932,6 +932,18 @@ config NET_NS
 
 endif # NAMESPACES
 
+config CHECKPOINT_RESTORE
+	bool "Checkpoint/restore support"
+	select PROC_CHILDREN
+	default n
+	help
+	  Enables additional kernel features in a sake of checkpoint/restore.
+	  In particular it adds auxiliary prctl codes to setup process text,
+	  data and heap segment sizes, and a few additional /proc filesystem
+	  entries.
+
+	  If unsure, say N here.
+
 config SCHED_AUTOGROUP
 	bool "Automatic process group scheduling"
 	select CGROUPS
@@ -1348,18 +1360,6 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
-config CHECKPOINT_RESTORE
-	bool "Checkpoint/restore support" if EXPERT
-	select PROC_CHILDREN
-	default n
-	help
-	  Enables additional kernel features in a sake of checkpoint/restore.
-	  In particular it adds auxiliary prctl codes to setup process text,
-	  data and heap segment sizes, and a few additional /proc filesystem
-	  entries.
-
-	  If unsure, say N here.
-
 config KALLSYMS
 	 bool "Load all symbols for debugging/ksymoops" if EXPERT
 	 default y
-- 
2.17.1

