Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753BBC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A222146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBJU4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:56:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfBJU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:56:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1AKtgeK3235724
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 10 Feb 2019 12:55:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1AKtfcD3235720;
        Sun, 10 Feb 2019 12:55:41 -0800
Date:   Sun, 10 Feb 2019 12:55:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c2da3f1b711173b72378258496b49f74db7479de@git.kernel.org>
Cc:     keescook@chromium.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        marc.zyngier@arm.com, rdunlap@infradead.org, dbueso@suse.de,
        hpa@zytor.com, david@fromorbit.com, willy@infradead.org,
        mingo@kernel.org, miklos@szeredi.hu, tglx@linutronix.de,
        dancol@google.com, akpm@linux-foundation.org, longman@redhat.com
Reply-To: longman@redhat.com, akpm@linux-foundation.org, miklos@szeredi.hu,
          willy@infradead.org, mingo@kernel.org, dancol@google.com,
          tglx@linutronix.de, hpa@zytor.com, david@fromorbit.com,
          rdunlap@infradead.org, dbueso@suse.de, dave@stgolabs.net,
          linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
          adobriyan@gmail.com, keescook@chromium.org
In-Reply-To: <20190208135021.013828701@linutronix.de>
References: <20190208135021.013828701@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] proc/stat: Make the interrupt statistics more
 efficient
Git-Commit-ID: c2da3f1b711173b72378258496b49f74db7479de
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

Commit-ID:  c2da3f1b711173b72378258496b49f74db7479de
Gitweb:     https://git.kernel.org/tip/c2da3f1b711173b72378258496b49f74db7479de
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 8 Feb 2019 14:48:04 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Feb 2019 21:34:46 +0100

proc/stat: Make the interrupt statistics more efficient

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

Waiman provided test results from a 4-socket IvyBridge-EX system (60-core
120-thread, 3016 irqs) excuting a test program which reads /proc/stat
50,000 times:

   Before: 18.436s (sys 18.380s)
   After:   3.769s (sys  3.742s)

Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Colascione <dancol@google.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/20190208135021.013828701@linutronix.de

---
 fs/proc/stat.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 535eda7857cf..76175211b304 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -79,6 +79,31 @@ static u64 get_iowait_time(int cpu)
 
 #endif
 
+static void show_irq_gap(struct seq_file *p, unsigned int gap)
+{
+	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
+
+	while (gap > 0) {
+		unsigned int inc;
+
+		inc = min_t(unsigned int, gap, ARRAY_SIZE(zeros) / 2);
+		seq_write(p, zeros, 2 * inc);
+		gap -= inc;
+	}
+}
+
+static void show_all_irqs(struct seq_file *p)
+{
+	unsigned int i, next = 0;
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
@@ -156,9 +181,7 @@ static int show_stat(struct seq_file *p, void *v)
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
 
-	/* sum again ? it could be updated? */
-	for_each_irq_nr(j)
-		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
+	show_all_irqs(p);
 
 	seq_printf(p,
 		"\nctxt %llu\n"
