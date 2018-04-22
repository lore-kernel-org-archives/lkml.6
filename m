Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49YZrFrVdgc6Qjjdk4TQ4NRwyA6zks5WkWtvUCf1XDjNzZdr4ufdg75KH3D9fbpR/sSO8zW
ARC-Seal: i=1; a=rsa-sha256; t=1524406446; cv=none;
        d=google.com; s=arc-20160816;
        b=y6DQSPoNwrb7shr6yWj+Ie3OlvlaxtZhGGGGzp+wmGi4GQXlo4NdLxm+P39i7F9xI5
         Pg3WEiyiJ0bxVh8paovgnrQBxgyeu0C0TuPJiY8DSfzwJ0TkJNKVfIvEPq5sTULy3H/E
         jHhaQyveegIYSs6vWshuXRVH3awRX3JRFIjMwkZqHy9EnVCgRRvBWD3HvDVAiqrDuOsb
         zauLKgLvav2r/nerj8xCa2Jc9g/Gpcy2fIdGynaammNy2amzxMWHw9Iz/D7VBANAuNVo
         0hXYOTMGMgvW3m+flMsN4h51qkU/hOhuKWskrpxGJ/MsuQjEnYZxaJa2SnnftYwrwcYR
         543g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7kHqg/JNfvryGWxKKrd8XCM3JqM/pVyx951S/3IkKDc=;
        b=TQlLP+NerPjD1+ptFn7bJ7MuNn+ewBYFceuFpDpY61GSpzd/D4HIFECftlTj2Sy00V
         hK5/oy5EA/k3q6v0d32E5Uu2YvubaZGnTn2L+TllQDmkCerPqTzxUiLeMK1Cux+Cf4WE
         YRZ40zTn4eS+EE+Emui+Ij/reGp/+kPcuETsJY8pJXUBiwxEyZDIPR04HeN4YzuB5uaH
         PprbKK6zJqfy92oBH906hcyb03lNXz+TT3R/nmrGwZHKRV+vZJ4laqvsKSDZms3byrrX
         uPfCVcivAJUpgzJdc7aZhdDxGkKz46MWWuHFTZwR8B3Gb6tFDncR63A38EafIYS6isjP
         JpjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 4.9 75/95] random: set up the NUMA crng instances after the CRNG is fully initialized
Date: Sun, 22 Apr 2018 15:53:44 +0200
Message-Id: <20180422135213.491879480@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455339806276515?=
X-GMAIL-MSGID: =?utf-8?q?1598456013924350530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8ef35c866f8862df074a49a93b0309725812dea8 upstream.

Until the primary_crng is fully initialized, don't initialize the NUMA
crng nodes.  Otherwise users of /dev/urandom on NUMA systems before
the CRNG is fully initialized can get very bad quality randomness.  Of
course everyone should move to getrandom(2) where this won't be an
issue, but there's a lot of legacy code out there.  This related to
CVE-2018-1108.

Reported-by: Jann Horn <jannh@google.com>
Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly...")
Cc: stable@kernel.org # 4.8+
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -818,6 +818,32 @@ static int crng_fast_load(const char *cp
 	return 1;
 }
 
+#ifdef CONFIG_NUMA
+static void numa_crng_init(void)
+{
+	int i;
+	struct crng_state *crng;
+	struct crng_state **pool;
+
+	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
+	for_each_online_node(i) {
+		crng = kmalloc_node(sizeof(struct crng_state),
+				    GFP_KERNEL | __GFP_NOFAIL, i);
+		spin_lock_init(&crng->lock);
+		crng_initialize(crng);
+		pool[i] = crng;
+	}
+	mb();
+	if (cmpxchg(&crng_node_pool, NULL, pool)) {
+		for_each_node(i)
+			kfree(pool[i]);
+		kfree(pool);
+	}
+}
+#else
+static void numa_crng_init(void) {}
+#endif
+
 static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 {
 	unsigned long	flags;
@@ -847,6 +873,7 @@ static void crng_reseed(struct crng_stat
 	memzero_explicit(&buf, sizeof(buf));
 	crng->init_time = jiffies;
 	if (crng == &primary_crng && crng_init < 2) {
+		numa_crng_init();
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
@@ -1659,28 +1686,9 @@ static void init_std_data(struct entropy
  */
 static int rand_initialize(void)
 {
-#ifdef CONFIG_NUMA
-	int i;
-	struct crng_state *crng;
-	struct crng_state **pool;
-#endif
-
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
-
-#ifdef CONFIG_NUMA
-	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
-	for_each_online_node(i) {
-		crng = kmalloc_node(sizeof(struct crng_state),
-				    GFP_KERNEL | __GFP_NOFAIL, i);
-		spin_lock_init(&crng->lock);
-		crng_initialize(crng);
-		pool[i] = crng;
-	}
-	mb();
-	crng_node_pool = pool;
-#endif
 	return 0;
 }
 early_initcall(rand_initialize);
