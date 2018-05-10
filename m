Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964799AbeEJMwT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:52:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35928 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757380AbeEJMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:52:16 -0400
X-Google-Smtp-Source: AB8JxZpiQx3grfgJuJxySfzhFvFKFq1FtAS/yN0+KDYm9EmeijfIwe6Uc49bjIKaCuB0UqGvGPdYbA==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] random: Omit double-printing ratelimit messages
Date: Thu, 10 May 2018 13:52:10 +0100
Message-Id: <20180510125211.12583-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180510125211.12583-1-dima@arista.com>
References: <20180510125211.12583-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently "suppressed" messages will be printed once in a second for
unseeded/urandom warnings, but there is already custom message which
says how many warnings are missing. So, let's skip suppressed messages
until crng_init == 2.

P.S.: not sure if there is a value in custom messages, maybe we can just
remove them instead.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/char/random.c     |  6 ++++--
 include/linux/ratelimit.h | 10 +++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cd888d4ee605..c1c40c7ed0e8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -440,9 +440,9 @@ static void process_random_ready_list(void);
 static void _get_random_bytes(void *buf, int nbytes);
 
 static struct ratelimit_state unseeded_warning =
-	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
+	RATELIMIT_STATE_INIT_FLAGS("warn_unseeded_randomness", HZ, 3, RATELIMIT_MSG_ON_RELEASE);
 static struct ratelimit_state urandom_warning =
-	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
+	RATELIMIT_STATE_INIT_FLAGS("warn_urandom_randomness", HZ, 3, RATELIMIT_MSG_ON_RELEASE);
 
 static int ratelimit_disable __read_mostly;
 
@@ -949,12 +949,14 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 				  unseeded_warning.missed);
 			unseeded_warning.missed = 0;
 		}
+		unseeded_warning.flags = 0;
 		if (urandom_warning.missed) {
 			pr_notice("random: %d urandom warning(s) missed "
 				  "due to ratelimiting\n",
 				  urandom_warning.missed);
 			urandom_warning.missed = 0;
 		}
+		urandom_warning.flags = 0;
 	}
 }
 
diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
index 8ddf79e9207a..e9a14a7641e0 100644
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -23,12 +23,16 @@ struct ratelimit_state {
 	unsigned long	flags;
 };
 
-#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {		\
+#define RATELIMIT_STATE_INIT_FLAGS(name, _interval, _burst, _flags) {	\
 		.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
-		.interval	= interval_init,			\
-		.burst		= burst_init,				\
+		.interval	= _interval,				\
+		.burst		= _burst,				\
+		.flags		= _flags,				\
 	}
 
+#define RATELIMIT_STATE_INIT(name, _interval, _burst)			\
+	RATELIMIT_STATE_INIT_FLAGS(name, _interval, _burst, 0)
+
 #define RATELIMIT_STATE_INIT_DISABLED					\
 	RATELIMIT_STATE_INIT(ratelimit_state, 0, DEFAULT_RATELIMIT_BURST)
 
-- 
2.13.6
