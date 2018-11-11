Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7556BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392362148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392362148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbeKLGS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:18:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50554 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730474AbeKLFsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:22 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000lF-55; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001rI-5D; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Martin Liska" <mliska@suse.cz>,
        "Peter Oberparleiter" <oberpar@linux.vnet.ibm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.824137743@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 338/366] gcov: support GCC 7.1
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Liska <mliska@suse.cz>

commit 05384213436ab690c46d9dfec706b80ef8d671ab upstream.

Starting from GCC 7.1, __gcov_exit is a new symbol expected to be
implemented in a profiling runtime.

[akpm@linux-foundation.org: coding-style fixes]
[mliska@suse.cz: v2]
  Link: http://lkml.kernel.org/r/e63a3c59-0149-c97e-4084-20ca8f146b26@suse.cz
Link: http://lkml.kernel.org/r/8c4084fa-3885-29fe-5fc4-0d4ca199c785@suse.cz
Signed-off-by: Martin Liska <mliska@suse.cz>
Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/gcov/base.c    | 6 ++++++
 kernel/gcov/gcc_4_7.c | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -97,6 +97,12 @@ void __gcov_merge_icall_topn(gcov_type *
 }
 EXPORT_SYMBOL(__gcov_merge_icall_topn);
 
+void __gcov_exit(void)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_exit);
+
 /**
  * gcov_enable_events - enable event reporting through gcov_event()
  *
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -18,7 +18,9 @@
 #include <linux/vmalloc.h>
 #include "gcov.h"
 
-#if (__GNUC__ > 5) || (__GNUC__ == 5 && __GNUC_MINOR__ >= 1)
+#if (__GNUC__ >= 7)
+#define GCOV_COUNTERS			9
+#elif (__GNUC__ > 5) || (__GNUC__ == 5 && __GNUC_MINOR__ >= 1)
 #define GCOV_COUNTERS			10
 #elif __GNUC__ == 4 && __GNUC_MINOR__ >= 9
 #define GCOV_COUNTERS			9

