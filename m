Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQdzmdpotDw8f/fAscl0U5vggX0xnblthHFd6UVEyVjdVmH6lXt5BeB6z3BwHu5dGFeaS4
ARC-Seal: i=1; a=rsa-sha256; t=1525116492; cv=none;
        d=google.com; s=arc-20160816;
        b=VX2fTXDqDHGdcga9NX+Fqxv4JfLRF+ocl4ckQhszi8bOV7b1sJ+ERfIiG8UqQcwSl1
         XfgWbrGItWVXc5zUvKM/s7Jb8brk2UQACollK+cvE9R7+x9PFiFEjmd+WpnzxfYFm45V
         vC81M2Wln3kMZaRJn3bLIwwWP3rSk4mYpBRxzhJ4WHi5roej8gFsHXfm6mZqMaMn9Img
         PdjgNEUikGw+Bib+MPMt9SSUUerjr1/v43AzG8WswYpX5GCmU/dtDZQdyg0tjy35XaBg
         XmDipF8dOLMSDuiBMe/33CpYZLEA/7qoHI5vVqwbdpzP134o+Qo1wzbMDdwta7/mVteI
         M3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=p3HDx6k6z3a6Xw8Pp8YooxrYnmye9VYXRevWdAySyJ8=;
        b=XB0uiHKE1frGrIEkamCbnVBnsTivNVatvZKTaf9sKx1KMkN+GF3NSvmNOrA3ivP9/D
         utZJ3zQCfyq8sdhQU/cJfANOyAZqTGhf54yvpBYuVCrKWHrulTqTAGtfQPc4h1BhOuU8
         78WE1Wv23vFgDO7CQp54iU1knNW35aFlOm5uNz5pu4/BUqp9PGb3n5N4SgGLLvKHuRFz
         Qt1Wa4Lk/IhGibcloo61IW/2BZJuoSKWLIsT00H/Qoqwz8q3QwBUNUqncT1OJNK2aJlk
         WysbkM1olmu3Q74d9pq8MSvqTmx/boes160ywQcYfPwkujX4+Gzu3zezhltjEIf7SMZ+
         9z4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB50C22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 008/113] random: rate limit unseeded randomness warnings
Date: Mon, 30 Apr 2018 12:23:39 -0700
Message-Id: <20180430184015.422520343@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200450908952797?=
X-GMAIL-MSGID: =?utf-8?q?1599200550708881655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 4e00b339e264802851aff8e73cde7d24b57b18ce upstream.

On systems without sufficient boot randomness, no point spamming dmesg.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

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
@@ -438,6 +439,16 @@ static void _crng_backtrack_protect(stru
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
@@ -931,6 +942,18 @@ static void crng_reseed(struct crng_stat
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
 
@@ -1574,8 +1597,9 @@ static void _warn_unseeded_randomness(co
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
@@ -1769,6 +1793,10 @@ static int rand_initialize(void)
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
@@ -1836,9 +1864,10 @@ urandom_read(struct file *file, char __u
 
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
