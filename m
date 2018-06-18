Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144D2C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CF32075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="1kJhLxuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CF32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964926AbeFRXn5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:43:57 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56633 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937005AbeFRXn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:56 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b01b4633;
        Mon, 18 Jun 2018 23:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id; s=mail; bh=Cky+58ddiHbyISVuNxrQsSSBdRo
        =; b=1kJhLxuPAnj/uglw+Ol6TR35b0K4NaZOdlRfO/4oPH9hT+54/6et/WGZYOn
        69K+QgA7WTJws24OyzVF7+2qYMds+dZyWR3nvqzGc5+449Eny1D9xMrz1VDc28Nb
        qZ8TlT407JoCF5jJuvknTO9UqWFAdWMPv32ScY1xRoRqNeRL8NO8XNxgSCsL6ZsR
        PJU3A9NBkkKhW4m78F/35jG8ayJC4cUuHzvuQ01EYyxPN+uAc8IRAvT1F/1No5ML
        R7XS+0IqnAp4JH3mVKdy7mPt7M3SD0TCv6S1RBN/i0Rtdp+6Cd+oU0I+TtTJ6ecc
        Gb6KeGKEdqLMJn5XknCoCNIUNMQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 12b75323 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 18 Jun 2018 23:38:07 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: make crng state queryable
Date:   Tue, 19 Jun 2018 01:43:47 +0200
Message-Id: <20180618234347.13282-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is extremely useful to be able to know whether or not get_random_
bytes_wait / wait_for_random_bytes is going to block or not, or whether
plain get_random_bytes is going to return good randomness or bad
randomness.

My particular use case is mitigating certain attacks in WireGuard. A
handshake packet arrives and is queued up. Elsewhere a worker thread
takes items from the queue and processes them. In replying to these
items, it needs to use some random data, and it has to be good random
data. If we simply block until we can have good randomness, then it's
possible for an attacker to fill the queue up with packets waiting to be
processed. Upon realizing the queue is full, WireGuard will detect that
it's under a denial of service attack, and behave accordingly. A better
approach is just to drop incoming handshake packets if the crng is not
yet initialized. Currently the below awful code is necessary to do such
a thing.

This patch, therefore, makes that information directly accessible.

~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~

The wrong way to do things:

struct rng_is_initialized_callback {
  struct random_ready_callback cb;
  atomic_t *rng_state;
};
static void rng_is_initialized_callback(struct random_ready_callback *cb)
{
  struct rng_is_initialized_callback *rdy = container_of(cb, struct rng_is_initialized_callback, cb);
  atomic_set(rdy->rng_state, 2);
  kfree(rdy);
}
static bool rng_is_initialized(void)
{
  static atomic_t rng_state = ATOMIC_INIT(0);

  if (atomic_read(&rng_state) == 2)
    return true;

  if (atomic_cmpxchg(&rng_state, 0, 1) == 0) {
    int ret;
    struct rng_is_initialized_callback *rdy = kmalloc(sizeof(*rdy), GFP_ATOMIC);
    if (!rdy) {
      atomic_set(&rng_state, 0);
      return false;
    }
    rdy->cb.owner = THIS_MODULE;
    rdy->cb.func = rng_is_initialized_callback;
    rdy->rng_state = &rng_state;
    ret = add_random_ready_callback(&rdy->cb);
    if (ret)
      kfree(rdy);
    if (ret == -EALREADY) {
      atomic_set(&rng_state, 2);
      return true;
    } else if (ret)
      atomic_set(&rng_state, 0);
    return false;
  }
  return false;
}

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 15 +++++++++++++++
 include/linux/random.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a8fb0020ba5c..871724f7b810 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1657,6 +1657,21 @@ int wait_for_random_bytes(void)
 }
 EXPORT_SYMBOL(wait_for_random_bytes);
 
+/*
+ * Returns whether or not the urandom pool has been seeded and thus guaranteed
+ * to supply cryptographically secure random numbers. This applies to: the
+ * /dev/urandom device, the get_random_bytes function, and the get_random_{u32,
+ * ,u64,int,long} family of functions.
+ *
+ * Returns: true if the urandom pool has been seeded.
+ *          false if the urandom pool has not been seeded.
+ */
+bool rng_is_initialized(void)
+{
+	return crng_ready();
+}
+EXPORT_SYMBOL(rng_is_initialized);
+
 /*
  * Add a callback function that will be invoked when the nonblocking
  * pool is initialised.
diff --git a/include/linux/random.h b/include/linux/random.h
index 2ddf13b4281e..c8208e0ff227 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -36,6 +36,7 @@ extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entropy;
 
 extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
+extern bool rng_is_initialized(void);
 extern int add_random_ready_callback(struct random_ready_callback *rdy);
 extern void del_random_ready_callback(struct random_ready_callback *rdy);
 extern void get_random_bytes_arch(void *buf, int nbytes);
-- 
2.17.1

