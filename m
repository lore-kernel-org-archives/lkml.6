Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoQi5+tdNDn9Jf4UKVV29iSt6onAvgor6+gVXcYIfLxDnN3fHEHSNbk7h6w2scViE2jsIH0
ARC-Seal: i=1; a=rsa-sha256; t=1525116396; cv=none;
        d=google.com; s=arc-20160816;
        b=b65lnGGmhY7kc8PHgCKxerAovrwFXRBBAtJt05uUwjnZ7tXa752M/wj+8lfogau/fU
         swuzuY/5Nr4kk5I3X7MsEr611YbvofEzlpZMJfAD+iQTnNs6VW9f18Kxm35a3CCnTRy/
         iAP4Bsj3YzgXCIUKcbNIGQvgoroMN6Am2jL7LxVBdcZNp5daTfNlGT2LiYWxbT8p4vd1
         2Z0ddCazZjC8NyyA45XiSqZ6E5Dcr0sr3cxIKWxsE+i3+jQQqrhv8m9GAKqQx5BzeSav
         qDm/QmHVV5rEBRIm+6ZP5BEp+QeP8bPgg3Mxb+5qvbsjvrn+ri2Lb5NnAxUQhtWitCP1
         hW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=iN3znSC4mXzkuvUP0rXRHAOdiswIjtGPd88kNp+9yVo=;
        b=pgSvdZc1Up0Aai8He/UGW3cSHaXeo9tmVTbF69oJAvFIVc6oX+SAkoLt1F4wFh9WYM
         lnymGTTpcgID8/rlNq/sgkqJwIJyv2+eS78WJ5QW16+flv7/sUGishms2fZlPiRjrgkD
         sF59S172EFd4I4zgMTt4uLM8LfQS+vIOBwysnzizLsB7TQhNZaieV22TJRgRt4wGD5St
         9zq7mmcA2xejfoMoArLwoB/WwKxQB84qqY1RYMvmuIHB1ETC4zoJdD4CpL4pfrQrwrqy
         bIvgR1xgm8iO2QnzZcluU2ATdo4wuo507A7iHYYHOq/WZLKek5VsMpSnNtHzS8dNZWMD
         f71A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7059922DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 07/61] random: rate limit unseeded randomness warnings
Date: Mon, 30 Apr 2018 12:24:10 -0700
Message-Id: <20180430183951.929979021@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200450908952797?=
X-GMAIL-MSGID: =?utf-8?q?1599200450908952797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 4e00b339e264802851aff8e73cde7d24b57b18ce upstream.

On systems without sufficient boot randomness, no point spamming dmesg.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -259,6 +259,7 @@
 #include <linux/kmemcheck.h>
 #include <linux/workqueue.h>
 #include <linux/irq.h>
+#include <linux/ratelimit.h>
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
@@ -444,6 +445,16 @@ static void _crng_backtrack_protect(stru
 				    __u8 tmp[CHACHA20_BLOCK_SIZE], int used);
 static void process_random_ready_list(void);
 
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
@@ -886,6 +897,18 @@ static void crng_reseed(struct crng_stat
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
 	spin_unlock_irqrestore(&crng->lock, flags);
 }
@@ -1699,6 +1722,10 @@ static int rand_initialize(void)
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
@@ -1766,9 +1793,10 @@ urandom_read(struct file *file, char __u
 
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
