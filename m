Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0CDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E4E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfA3MhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:37:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3MhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:37:16 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gop78-0007V4-9N; Wed, 30 Jan 2019 13:37:12 +0100
Message-Id: <20190130123615.592071954@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 30 Jan 2019 13:31:32 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch 2/2] proc/stat: Make the interrupt statistics more efficient
References: <20190130123130.785636313@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman reported that on large systems with a large amount of interrupts the
readout of /proc/stat takes a long time to sum up the interrupt
statistics. In principle this is not a problem. but for unknown reasons
some enterprise quality software reads /proc/stat with a high frequency.

The reason for this is that interrupt statistics are accounted per cpu. So
the /proc/stat logic has to sum up the interrupt stats for each interrupt.

The interrupt core provides now a per interrupt summary counter which can
be used to avoid the summation loops completely except for interrupts
marked PER_CPU which are only a small fraction of the interrupt space if at
all.

Another simplification is to iterate only over the active interrupts and
skip the potentially large gaps in the interrupt number space and just
print zeros for the gaps without going into the interrupt core in the first
place.

Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/stat.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -79,6 +79,30 @@ static u64 get_iowait_time(int cpu)
 
 #endif
 
+static void show_irq_gap(struct seq_file *p, int gap)
+{
+	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
+
+	while (gap > 0) {
+		int inc = min_t(int, gap, ARRAY_SIZE(zeros) / 2);
+
+		seq_write(p, zeros, 2 * inc);
+		gap -= inc;
+	}
+}
+
+static void show_all_irqs(struct seq_file *p)
+{
+	int i, next = 0;
+
+	for_each_active_irq(i) {
+		show_irq_gap(p, i - next);
+		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
+		next = i + 1;
+	}
+	show_irq_gap(p, nr_irqs - next);
+}
+
 static int show_stat(struct seq_file *p, void *v)
 {
 	int i, j;
@@ -156,9 +180,7 @@ static int show_stat(struct seq_file *p,
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
 
-	/* sum again ? it could be updated? */
-	for_each_irq_nr(j)
-		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
+	show_all_irqs(p);
 
 	seq_printf(p,
 		"\nctxt %llu\n"


