Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FC420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FC420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeLIWKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:10:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37530 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbeLIWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:10:17 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002il-In; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003Lr-8q; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Chinner" <dchinner@redhat.com>,
        "Tejun Heo" <tj@kernel.org>, "Dave Chinner" <david@fromorbit.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.398194698@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 108/328] percpu_counter: batch size aware
 __percpu_counter_compare()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

commit 80188b0d77d7426b494af739ac129e0e684acb84 upstream.

XFS uses non-stanard batch sizes for avoiding frequent global
counter updates on it's allocated inode counters, as they increment
or decrement in batches of 64 inodes. Hence the standard percpu
counter batch of 32 means that the counter is effectively a global
counter. Currently Xfs uses a batch size of 128 so that it doesn't
take the global lock on every single modification.

However, Xfs also needs to compare accurately against zero, which
means we need to use percpu_counter_compare(), and that has a
hard-coded batch size of 32, and hence will spuriously fail to
detect when it is supposed to use precise comparisons and hence
the accounting goes wrong.

Add __percpu_counter_compare() to take a custom batch size so we can
use it sanely in XFS and factor percpu_counter_compare() to use it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/percpu_counter.h | 13 ++++++++++++-
 lib/percpu_counter.c           |  6 +++---
 2 files changed, 15 insertions(+), 4 deletions(-)

--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -40,7 +40,12 @@ void percpu_counter_destroy(struct percp
 void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 void __percpu_counter_add(struct percpu_counter *fbc, s64 amount, s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
-int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs);
+int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
+
+static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
+{
+	return __percpu_counter_compare(fbc, rhs, percpu_counter_batch);
+}
 
 static inline void percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 {
@@ -114,6 +119,12 @@ static inline int percpu_counter_compare
 		return 0;
 }
 
+static inline int
+__percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
+{
+	return percpu_counter_compare(fbc, rhs);
+}
+
 static inline void
 percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 {
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -193,13 +193,13 @@ static int percpu_counter_hotcpu_callbac
  * Compare counter against given value.
  * Return 1 if greater, 0 if equal and -1 if less
  */
-int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
+int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
 {
 	s64	count;
 
 	count = percpu_counter_read(fbc);
 	/* Check to see if rough count will be sufficient for comparison */
-	if (abs(count - rhs) > (percpu_counter_batch*num_online_cpus())) {
+	if (abs(count - rhs) > (batch * num_online_cpus())) {
 		if (count > rhs)
 			return 1;
 		else
@@ -214,7 +214,7 @@ int percpu_counter_compare(struct percpu
 	else
 		return 0;
 }
-EXPORT_SYMBOL(percpu_counter_compare);
+EXPORT_SYMBOL(__percpu_counter_compare);
 
 static int __init percpu_counter_startup(void)
 {

