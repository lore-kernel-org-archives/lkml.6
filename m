Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA830C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3EC20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CAX6BdT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3EC20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGaUxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:53:15 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39843 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbeGaUxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:53:15 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 18863abe;
        Tue, 31 Jul 2018 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=mail; bh=SHfW
        xi4JCMLxJIuWAqkhOaQmLC4=; b=CAX6BdT5VKg/tFKDjjyOZ5KThdaBOjL+P0Hj
        JrjAXPGJXQAUdEjOKgr/WP8uX5CYSP7JqMGYwqJQ541swdzEUQCeAOaWY+vvX676
        CU8oEXrA8uXaxRgutGUvCoJJw3oVp0djtzqr+6cnLLXMjNgo1tXc++QfwurwdxdQ
        DfKaVgE9drOjBal6iQxF2nFAOid/mh/1zC67GfALeSD8cAT5jtmsYJjMYcxuUK5L
        xjGLnjySK/NQKMhLEace51x1z3QXvVehp36UNgZiBNZLGk21mWUoSls+wmrbT4hU
        J06/SDThvXyeEqdzFiVRYrU/5F+w5+Bum1K9Eh9fo0PgeZ4MwA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 12e032ba (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 31 Jul 2018 19:00:10 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v1 1/3] random: Make crng state queryable
Date:   Tue, 31 Jul 2018 21:11:00 +0200
Message-Id: <20180731191102.2434-2-Jason@zx2c4.com>
In-Reply-To: <20180731191102.2434-1-Jason@zx2c4.com>
References: <20180731191102.2434-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is very useful to be able to know whether or not get_random_bytes_wait
/ wait_for_random_bytes is going to block or not, or whether plain
get_random_bytes is going to return good randomness or bad randomness.

The particular use case is for mitigating certain attacks in WireGuard.
A handshake packet arrives and is queued up. Elsewhere a worker thread
takes items from the queue and processes them. In replying to these
items, it needs to use some random data, and it has to be good random
data. If we simply block until we can have good randomness, then it's
possible for an attacker to fill the queue up with packets waiting to be
processed. Upon realizing the queue is full, WireGuard will detect that
it's under a denial of service attack, and behave accordingly. A better
approach is just to drop incoming handshake packets if the crng is not
yet initialized.

This patch, therefore, makes that information directly accessible.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c  | 15 +++++++++++++++
 include/linux/random.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cd888d4ee605..4efd16f6e0e1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1658,6 +1658,21 @@ int wait_for_random_bytes(void)
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
2.18.0

