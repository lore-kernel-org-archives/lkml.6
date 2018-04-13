Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeDMBa7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:30:59 -0400
Received: from imap.thunk.org ([74.207.234.97]:37192 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeDMBa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:30:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-crypto@vger.kernel.org
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 5/5] random: add new ioctl RNDRESEEDCRNG
Date: Thu, 12 Apr 2018 21:30:46 -0400
Message-Id: <20180413013046.404-5-tytso@mit.edu>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a
In-Reply-To: <20180413013046.404-1-tytso@mit.edu>
References: <20180413013046.404-1-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new ioctl which forces the the crng to be reseeded.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 drivers/char/random.c       | 13 ++++++++++++-
 include/uapi/linux/random.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 6e7fa13b1a89..c552431587a7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -429,6 +429,7 @@ struct crng_state primary_crng = {
 static int crng_init = 0;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
+static unsigned long crng_global_init_time = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng,
 			  __u32 out[CHACHA20_BLOCK_WORDS]);
@@ -933,7 +934,8 @@ static void _extract_crng(struct crng_state *crng,
 	unsigned long v, flags;
 
 	if (crng_ready() &&
-	    time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL))
+	    (time_after(crng_global_init_time, crng->init_time) ||
+	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
 	spin_lock_irqsave(&crng->lock, flags);
 	if (arch_get_random_long(&v))
@@ -1757,6 +1759,7 @@ static int rand_initialize(void)
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
+	crng_global_init_time = jiffies;
 	return 0;
 }
 early_initcall(rand_initialize);
@@ -1930,6 +1933,14 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		input_pool.entropy_count = 0;
 		blocking_pool.entropy_count = 0;
 		return 0;
+	case RNDRESEEDCRNG:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (crng_init < 2)
+			return -ENODATA;
+		crng_reseed(&primary_crng, NULL);
+		crng_global_init_time = jiffies - 1;
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index c34f4490d025..26ee91300e3e 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -35,6 +35,9 @@
 /* Clear the entropy pool and associated counters.  (Superuser only.) */
 #define RNDCLEARPOOL	_IO( 'R', 0x06 )
 
+/* Reseed CRNG.  (Superuser only.) */
+#define RNDRESEEDCRNG	_IO( 'R', 0x07 )
+
 struct rand_pool_info {
 	int	entropy_count;
 	int	buf_size;
-- 
2.16.1.72.g5be1f00a9a
