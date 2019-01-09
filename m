Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA05C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E596214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfAIRY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:24:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14775 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfAIRY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:24:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51C19C7A06;
        Wed,  9 Jan 2019 17:24:27 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0747C600C8;
        Wed,  9 Jan 2019 17:24:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] /proc/stat: Call kstat_irqs_usr() only for active IRQs
Date:   Wed,  9 Jan 2019 12:23:48 -0500
Message-Id: <1547054628-12703-5-git-send-email-longman@redhat.com>
In-Reply-To: <1547054628-12703-1-git-send-email-longman@redhat.com>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 09 Jan 2019 17:24:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After skipping the percpu summation of non-active IRQs on a 4-socket
Broadwell system with about 3k IRQs, about half of the CPU cycles were
spent in the kstat_irqs() call. The majority of which were used to look
up the IRQ descriptors for the corresponding IRQ numbers.

We can recoup a lot of those lost cycles by calling kstat_irqs_usr()
only for those IRQs that are active. A bitmap is now used to keep track
of the list of the active IRQs. Changes in nr_active_irqs count will
cause the code to rescan all the IRQs and repopulate the bitmap.

On the same 4-socket server, the introduction of this patch further
reduces the system time of reading /proc/stat 5k times from 8.048s
to 5.817s. This is a another time reduction of 28%.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/proc/stat.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 4b06f1b..5e2a398 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -93,6 +93,25 @@ static u64 compute_stat_irqs_sum(void)
 }
 
 /*
+ * Write the given number of space separated '0' into the sequence file.
+ */
+static void write_zeros(struct seq_file *p, int cnt)
+{
+	/* String of 16 '0's */
+	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
+
+	while (cnt > 0) {
+		if (cnt >= 16) {
+			seq_write(p, zeros, 32);
+			cnt -= 16;
+		} else {
+			seq_write(p, zeros, 2 * cnt);
+			cnt = 0;
+		}
+	}
+}
+
+/*
  * Print out the "intr" line of /proc/stat.
  */
 static void show_stat_irqs(struct seq_file *p)
@@ -100,9 +119,74 @@ static void show_stat_irqs(struct seq_file *p)
 	int i;
 
 	seq_put_decimal_ull(p, "intr ", compute_stat_irqs_sum());
+
+	if (IS_ENABLED(CONFIG_SMP) && (nr_cpu_ids >= 10) && (nr_irqs >= 256)) {
+		/*
+		 * On systems with 10 or more CPUs and 256 or more IRQs,
+		 * we used a bitmap to keep track of the number of active
+		 * IRQs and call kstat_irqs_usr() only for those IRQs.
+		 * The bitmap will be refreshed whenever nr_active_irqs
+		 * changes.
+		 */
+		extern atomic_t nr_active_irqs;
+		static DEFINE_MUTEX(irqs_mutex);
+		static int last_irq = -1;
+		static int bitmap_size, active_irqs;
+		static unsigned long *bitmap;
+		int current_irqs = atomic_read(&nr_active_irqs);
+
+		mutex_lock(&irqs_mutex);
+		if (current_irqs != active_irqs) {
+			/*
+			 * Rescan all the IRQs for active ones.
+			 */
+			if (nr_irqs > bitmap_size) {
+				static unsigned long *new_bitmap;
+				static int new_size;
+
+				new_size = BITS_TO_LONGS(nr_irqs)*sizeof(long);
+				new_bitmap = (unsigned long *)krealloc(bitmap,
+						new_size, GFP_KERNEL);
+				if (!new_bitmap)
+					goto fallback;
+				bitmap = new_bitmap;
+				bitmap_size = new_size;
+			}
+			memset(bitmap, 0, bitmap_size/BITS_PER_BYTE);
+			last_irq = 0;
+			for_each_irq_nr(i) {
+				int cnt = kstat_irqs_usr(i);
+
+				if (cnt) {
+					bitmap_set(bitmap, 0, i);
+					last_irq = i;
+				}
+				seq_put_decimal_ull(p, " ", cnt);
+			}
+			active_irqs = current_irqs;
+			mutex_unlock(&irqs_mutex);
+			goto out;
+		}
+		/*
+		 * Retrieve counts from active IRQs only.
+		 */
+		for (i = 0; i <= last_irq; i++) {
+			int next = find_next_bit(bitmap, last_irq + 1, i);
+
+			if (next > i)
+				write_zeros(p, next - i);
+			i = next;
+			seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
+		}
+		mutex_unlock(&irqs_mutex);
+		write_zeros(p, nr_irqs - i);
+		goto out;
+	}
+fallback:
 	for_each_irq_nr(i)
 		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
 
+out:
 	seq_putc(p, '\n');
 }
 
-- 
1.8.3.1

