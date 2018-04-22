Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/MMtrlRZ2tywe+chtGAHYDt9dglb9W5x7CNY3DYBA9PnCIoxQA2Gxg4At1wkm9OKeZoDfH
ARC-Seal: i=1; a=rsa-sha256; t=1524406169; cv=none;
        d=google.com; s=arc-20160816;
        b=Lct3aXFxq+MNmPLZqceR+1mCZnrFa7R+FZhFTFNwxrRG1ER7BM7HXsS3xBV3FNNnna
         r6WuCuZtOFTs0N+S6sDlVmpKUKsNfcE/g6JhReyer91DAVswYVHfyt11thegskJMEFp5
         UZSNhNhAQCsw7cmYGSKYxIebhFlyWiBLD7lE3RKdJP7H49GvV0arAA9XrDXvnqahPuE6
         h2UWOoxTQdTkfTCy6zonCD9axt95ufm5XpUx76RBSLesUlFRnAIJMQfYMazMTUFRqmUh
         i9+hJuHcZJnYlxep9JSOLLVp2S/KNknB4kFPgIuxeg9aD4bVTbEfZFYp9HvaOadLvoLD
         TSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EUCIY5HvI1IFD6J/03OTvxvzmRqocPMqOzZK5Qpt8Pw=;
        b=P2DzbYw8c7/OafpgqJCWcRxU954ypg+p/0Tj/0IT9Zl5WhyKXV5pUGvaXYypWwXDSr
         VUgE9Qx75imQqdCpSgjGWAB76ImsXigIh2WC9T2dSTe4A571XodmS3WsEIqwId55nuQb
         USHkAiS3EY3/rV55bLHeXd1chk61eOl9GANLQHNVBsPH7bqS8FU+5fwttbr1/x3SQRcs
         fwsAllB9ACYN7qo66WyruB3AO1Z0cAnM8vmJ8kXrGh5tSkYFXmtmynGDTofLi10zBZP6
         3wzvQDDPJIt6qScQVI7JpEp6ypYFW7iT+yOEW0O0lLjPMi/wH//czyYaSNx41t7F7Flc
         posQ==
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
Subject: [PATCH 4.14 137/164] random: add new ioctl RNDRESEEDCRNG
Date: Sun, 22 Apr 2018 15:53:24 +0200
Message-Id: <20180422135141.013769558@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455242261165889?=
X-GMAIL-MSGID: =?utf-8?q?1598455723245221714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 			  __u8 out[CHACHA20_BLOCK_SIZE]);
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
