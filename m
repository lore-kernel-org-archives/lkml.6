Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49gis9TdwpUvgxCe2xMdgdkzZsw7ay15ZI8xhauMtSkdfgnBLioaUxwIQj6Ztu463XRt5fN
ARC-Seal: i=1; a=rsa-sha256; t=1524405710; cv=none;
        d=google.com; s=arc-20160816;
        b=w6YBdyxeIk1nY8/xUWGar9InfdGri9SG3zxGzM4oDjEsw79dfb8X7FE3fWPqjNerf4
         kVkTh/uKvMoIK2ppOXk0X0j7x1jKinLq9h1zjGflSp7P9zoMO8fS4Fg5kmp2S9vbNSXj
         m+OUf0o6VSv13ltrWPQ1y7SKln8SWsDKoIQQGpszVV4UyuuttSWBk1vnJMkKZfiv7dKB
         nYXnhl9OqaCmq6QtNPt6+PiDmypgjNtOVKsGOpZ3Grlb64dHxFX680/7fv7t/O9gcgL/
         co0S6ykbYD7Vx7TyWRbEHqTnH6fIRrykJGfpQ9lqY0Q4Lg3a6XYxwLX4g7Hkh/qSCnH6
         CvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JuLqsD3mi/Qdx9ms1u8YNTn6Qrr3o+mH1wT/j6y38wo=;
        b=qjCEDVAlqgvW4ZGvXIneGMrMI2ZPq6ql+HdisdCa692SqiJzJLTk34pE3+2MRdCKPh
         cXtPtTPwRQ1i6atWPeNGGtoSOAefsyoZOzjsCdJhDTNilH0FoDpS7j2ZDtKLN5HabVKQ
         7o/Om0a460g6kP6QTfy1eyhHKrHPHMGEwhA+ACdpzocDqlV6LMhVpqJaZQQaP7mGiwUC
         59tnfaBhMcFPsD70SjCwC+ONwTkT3gNDkzPj8+2g7GYzGN9H+jGO0sWOozCw6Nn7RQNj
         Cyz4Er6RPvQpJERTwTxZmrS2Vb9Ipde7S83IdO8KsIo+/220JVjz3WHVlu2j1K7hpDYA
         VmKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 4.16 167/196] random: add new ioctl RNDRESEEDCRNG
Date: Sun, 22 Apr 2018 15:53:07 +0200
Message-Id: <20180422135112.909205877@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455242261165889?=
X-GMAIL-MSGID: =?utf-8?q?1598455242261165889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit d848e5f8e1ebdb227d045db55fe4f825e82965fa upstream.

Add a new ioctl which forces the the crng to be reseeded.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c       |   13 ++++++++++++-
 include/uapi/linux/random.h |    3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
@@ -932,7 +933,8 @@ static void _extract_crng(struct crng_st
 	unsigned long v, flags;
 
 	if (crng_ready() &&
-	    time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL))
+	    (time_after(crng_global_init_time, crng->init_time) ||
+	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
 	spin_lock_irqsave(&crng->lock, flags);
 	if (arch_get_random_long(&v))
@@ -1759,6 +1761,7 @@ static int rand_initialize(void)
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
+	crng_global_init_time = jiffies;
 	return 0;
 }
 early_initcall(rand_initialize);
@@ -1932,6 +1935,14 @@ static long random_ioctl(struct file *f,
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
