Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeDYHlz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:41:55 -0400
Received: from imap.thunk.org ([74.207.234.97]:54880 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeDYHlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:41:49 -0400
Date: Wed, 25 Apr 2018 03:41:44 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180425074144.GA18803@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
 <20180424135621.GD4189@thunk.org>
 <20180424154904.GC30619@thunk.org>
 <d251173a-d7c0-3f55-7c22-a100f6093176@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d251173a-d7c0-3f55-7c22-a100f6093176@molgen.mpg.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does this help on your system?

						- Ted

commit 4e00b339e264802851aff8e73cde7d24b57b18ce
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed Apr 25 01:12:32 2018 -0400

    random: rate limit unseeded randomness warnings
    
    On systems without sufficient boot randomness, no point spamming dmesg.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Cc: stable@vger.kernel.org

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 721dca8db9cf..cd888d4ee605 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -261,6 +261,7 @@
 #include <linux/ptrace.h>
 #include <linux/workqueue.h>
 #include <linux/irq.h>
+#include <linux/ratelimit.h>
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
@@ -438,6 +439,16 @@ static void _crng_backtrack_protect(struct crng_state *crng,
 static void process_random_ready_list(void);
 static void _get_random_bytes(void *buf, int nbytes);
 
+static struct ratelimit_state unseeded_warning =
+	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
+static struct ratelimit_state urandom_warning =
+	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
+
+static int ratelimit_disable __read_mostly;
+
+module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
+MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
+
 /**********************************************************************
  *
  * OS independent entropy store.   Here are the functions which handle
@@ -932,6 +943,18 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
+		if (unseeded_warning.missed) {
+			pr_notice("random: %d get_random_xx warning(s) missed "
+				  "due to ratelimiting\n",
+				  unseeded_warning.missed);
+			unseeded_warning.missed = 0;
+		}
+		if (urandom_warning.missed) {
+			pr_notice("random: %d urandom warning(s) missed "
+				  "due to ratelimiting\n",
+				  urandom_warning.missed);
+			urandom_warning.missed = 0;
+		}
 	}
 }
 
@@ -1572,8 +1595,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
 #ifndef CONFIG_WARN_ALL_UNSEEDED_RANDOM
 	print_once = true;
 #endif
-	pr_notice("random: %s called from %pS with crng_init=%d\n",
-		  func_name, caller, crng_init);
+	if (__ratelimit(&unseeded_warning))
+		pr_notice("random: %s called from %pS with crng_init=%d\n",
+			  func_name, caller, crng_init);
 }
 
 /*
@@ -1767,6 +1791,10 @@ static int rand_initialize(void)
 	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
 	crng_global_init_time = jiffies;
+	if (ratelimit_disable) {
+		urandom_warning.interval = 0;
+		unseeded_warning.interval = 0;
+	}
 	return 0;
 }
 early_initcall(rand_initialize);
@@ -1834,9 +1862,10 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 
 	if (!crng_ready() && maxwarn > 0) {
 		maxwarn--;
-		printk(KERN_NOTICE "random: %s: uninitialized urandom read "
-		       "(%zd bytes read)\n",
-		       current->comm, nbytes);
+		if (__ratelimit(&urandom_warning))
+			printk(KERN_NOTICE "random: %s: uninitialized "
+			       "urandom read (%zd bytes read)\n",
+			       current->comm, nbytes);
 		spin_lock_irqsave(&primary_crng.lock, flags);
 		crng_init_cnt = 0;
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
