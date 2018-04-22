Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+cIYXSzIgYNr1q+cEC7NId1oS4dFaJ/UPLqOmVZZ/c82lPAaGst7zhRF7QH7Q8lRmM//z1
ARC-Seal: i=1; a=rsa-sha256; t=1524405803; cv=none;
        d=google.com; s=arc-20160816;
        b=K/cGg4Ut8uYcq7jk23Va30Bf35sQLIRWyhoKZyTLBVwXHkSlZsLXCBBSH1MnUbp0sz
         CQZL86ZlcvKSbi37zeXtVcTbHS2FIT0JthU19xkkrS/wd1ym68BWOnmtaZ9KNFFuLb2N
         SfVq4IZdyi1dj8lgh2BpTUUoq8a7dtLbMFLx9/npwOyEEOl4OAqiI2EINRV7sI1Ug09n
         a3LBMYEy4U5vt6NecIA4M6tbZGLX2o0l39eAiiaPVG5vYuY8ZPBiD41yGR8tG5HUkveJ
         OYyXCY43/bb8/OMM6klP+1b67NeylbTWTjGWWuEqcL9PL0OtEKOM22WGP55l+vdjWGkC
         hIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qHcmQYOsPr3XIENC5vvAGVbJYArUxL+WI93zVFRuVXY=;
        b=UXnMKYylfOKgvsyr9fQX39G+DfatcF4wynt3sWV7f+r5WQbhoHRd0S48VNyy/eWVM9
         J60Rtkhb9xedqY6U4GWEd9/47Q+j2O1HHFtqvkMiTOrR7SHJPF2Z7wgfFxes1zDddqNg
         1kz9uTjTKDnTyAS7LahzvGrOCmyq2VpkbdZJo/FZUZ/e5+yENCIQteMbp0un/lWFPOp6
         kscxGC8pME2whqRUQ0jkWJyjDKFe8TO6/rs4MgpsMjSXHhBKtqJe+CMkwNjfjelOrqbV
         PdB6TZdQrMjy++QCqbJnbqeSx7DC7MCZGRVHebRRJpz6WF5fJa0qcas2ZQHT7TYfep5S
         2hdA==
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
Subject: [PATCH 4.16 165/196] random: set up the NUMA crng instances after the CRNG is fully initialized
Date: Sun, 22 Apr 2018 15:53:05 +0200
Message-Id: <20180422135112.807318417@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455339806276515?=
X-GMAIL-MSGID: =?utf-8?q?1598455339806276515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -786,6 +786,32 @@ static void crng_initialize(struct crng_
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
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
 /*
  * crng_fast_load() can be called by code in the interrupt service
  * path.  So we can't afford to dilly-dally.
@@ -892,6 +918,7 @@ static void crng_reseed(struct crng_stat
 	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	if (crng == &primary_crng && crng_init < 2) {
 		invalidate_batched_entropy();
+		numa_crng_init();
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
@@ -1729,28 +1756,9 @@ static void init_std_data(struct entropy
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
