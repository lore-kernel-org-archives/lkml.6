Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48iEgKlQdnNxMb+hOy1q/wbNI5F9G1KjKbjkOPUBQR9HxOyQ7ia7y+H0tun5ZW6wg6v9TEA
ARC-Seal: i=1; a=rsa-sha256; t=1524406451; cv=none;
        d=google.com; s=arc-20160816;
        b=er6qi+0Rs66b9cC7g2QMgVOCVYQ06OtrogVc5nctVEnsIsFfQHLqqVM0QmlnuKHhDC
         4ghsMN5lnVaRifNdfz7CC+SWhZhrHVw93wksBt/KSPrIo3DTnAgkEy/e/lH24J5TtDaW
         4LVpCXtDeEoXUULvYuVI998t2LNv1ZBitIPSY+y49tpWNUf1rZ/5ZLkrWUwhgkdA3R/9
         4fhoTIMw1P9CGZlmNvkBhnFif2hbNq/5xmJTDZ74yVmrVqpHcN4cKOA/CczBGIDzleuM
         0dGs/QwtHiC8TNzROW9G4b0StvYeyinWyndWbAp2XUQaeKKtZe9BdrA4OUc6plCGM5ji
         9cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o6xEG6xzTN1ikBw2MuG3hNQMTlwxZueHO2eCbrxWkos=;
        b=JAP9XIQ7Pc2tJsHu4XdPx2np4u1S0/vTguXmTmUSOAFlvU6d/STClQiBmmBLmSQiqn
         qw8hbnGjky2aE1rUr/naeKHyJXyFJjQucrqpJDNS6yPKMj7jOyR8tO6XbFinmZao61dF
         PbUDJqk5JuUsjFbIPQeg4LQqbLXI1s0X9FUylGZTK4JZsuerGYFgSDFzWNBkxA+NafXM
         +8bFlIjxj8moH1Cj5MqNKgg/8QA/bFusjcVAEWkHAbfOynSwfiqn53InDv2BITTCKfv9
         vXubNvGc777V/3hjtP7+lYk6bnxSAnWass9TciYT3XbteInJ2oJzbU/cdsO2688NRx8y
         tyGg==
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
Subject: [PATCH 4.9 77/95] random: add new ioctl RNDRESEEDCRNG
Date: Sun, 22 Apr 2018 15:53:46 +0200
Message-Id: <20180422135213.580990477@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455242261165889?=
X-GMAIL-MSGID: =?utf-8?q?1598456019831121504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -436,6 +436,7 @@ struct crng_state primary_crng = {
 static int crng_init = 0;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
+static unsigned long crng_global_init_time = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng,
 			  __u8 out[CHACHA20_BLOCK_SIZE]);
@@ -900,7 +901,8 @@ static void _extract_crng(struct crng_st
 	unsigned long v, flags;
 
 	if (crng_ready() &&
-	    time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL))
+	    (time_after(crng_global_init_time, crng->init_time) ||
+	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
 	spin_lock_irqsave(&crng->lock, flags);
 	if (arch_get_random_long(&v))
@@ -1689,6 +1691,7 @@ static int rand_initialize(void)
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
+	crng_global_init_time = jiffies;
 	return 0;
 }
 early_initcall(rand_initialize);
@@ -1862,6 +1865,14 @@ static long random_ioctl(struct file *f,
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
@@ -34,6 +34,9 @@
 /* Clear the entropy pool and associated counters.  (Superuser only.) */
 #define RNDCLEARPOOL	_IO( 'R', 0x06 )
 
+/* Reseed CRNG.  (Superuser only.) */
+#define RNDRESEEDCRNG	_IO( 'R', 0x07 )
+
 struct rand_pool_info {
 	int	entropy_count;
 	int	buf_size;
