Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeERG5r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:57:47 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47490 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeERG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:57:46 -0400
Date: Fri, 18 May 2018 14:57:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: random: Wake up writers when random pools are zapped
Message-ID: <20180518065736.szvspgdeyiaiqheb@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is when the pool is zapped with RNDCLEARPOOL writers are
not woken up and therefore the pool may remain in the empty state
indefinitely.

This patch wakes them up unless the write threshold is set to zero.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e027e7f..32b7010 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1874,6 +1874,10 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EPERM;
 		input_pool.entropy_count = 0;
 		blocking_pool.entropy_count = 0;
+		if (random_write_wakeup_bits) {
+			wake_up_interruptible(&random_write_wait);
+			kill_fasync(&fasync, SIGIO, POLL_OUT);
+		}
 		return 0;
 	default:
 		return -EINVAL;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
