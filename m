Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DC920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DC920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeGYPcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:32:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeGYPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:31:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEJY3M399808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:19:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEJYPR399805;
        Wed, 25 Jul 2018 07:19:34 -0700
Date:   Wed, 25 Jul 2018 07:19:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Rosin <tipbot@zytor.com>
Message-ID: <tip-7b94ea50514d1a0dc94f02723b603c27bc0ea597@git.kernel.org>
Cc:     will.deacon@arm.com, torvalds@linux-foundation.org, hpa@zytor.com,
        tglx@linutronix.de, jsperbeck@google.com, wsa@the-dreams.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, dave@stgolabs.net,
        dpf@google.com, pombredanne@nexb.com, peda@axentia.se,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        deepadinamani@google.com
Reply-To: tglx@linutronix.de, jsperbeck@google.com,
          linux-kernel@vger.kernel.org, wsa@the-dreams.de,
          mingo@kernel.org, dave@stgolabs.net, peda@axentia.se,
          dpf@google.com, pombredanne@nexb.com, deepadinamani@google.com,
          peterz@infradead.org, gregkh@linuxfoundation.org,
          will.deacon@arm.com, torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180720083914.1950-3-peda@axentia.se>
References: <20180720083914.1950-3-peda@axentia.se>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] i2c/mux, locking/core: Annotate the nested
 rt_mutex usage
Git-Commit-ID: 7b94ea50514d1a0dc94f02723b603c27bc0ea597
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7b94ea50514d1a0dc94f02723b603c27bc0ea597
Gitweb:     https://git.kernel.org/tip/7b94ea50514d1a0dc94f02723b603c27bc0ea597
Author:     Peter Rosin <peda@axentia.se>
AuthorDate: Fri, 20 Jul 2018 10:39:14 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:22:20 +0200

i2c/mux, locking/core: Annotate the nested rt_mutex usage

If an i2c topology has instances of nested muxes, then a lockdep splat
is produced when when i2c_parent_lock_bus() is called.  Here is an
example:

  ============================================
  WARNING: possible recursive locking detected
  --------------------------------------------
  insmod/68159 is trying to acquire lock:
    (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

  but task is already holding lock:
    (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

  other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(i2c_register_adapter#2);
     lock(i2c_register_adapter#2);

    *** DEADLOCK ***

    May be due to missing lock nesting notation

  1 lock held by insmod/68159:
    #0:  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

  stack backtrace:
  CPU: 13 PID: 68159 Comm: insmod Tainted: G           O
  Call Trace:
    dump_stack+0x67/0x98
    __lock_acquire+0x162e/0x1780
    lock_acquire+0xba/0x200
    rt_mutex_lock+0x44/0x60
    i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
    i2c_parent_lock_bus+0x3e/0x50 [i2c_mux]
    i2c_smbus_xfer+0xf0/0x700
    i2c_smbus_read_byte+0x42/0x70
    my2c_init+0xa2/0x1000 [my2c]
    do_one_initcall+0x51/0x192
    do_init_module+0x62/0x216
    load_module+0x20f9/0x2b50
    SYSC_init_module+0x19a/0x1c0
    SyS_init_module+0xe/0x10
    do_syscall_64+0x6c/0x1a0
    entry_SYSCALL_64_after_hwframe+0x42/0xb7

Reported-by: John Sperbeck <jsperbeck@google.com>
Tested-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Deepa Dinamani <deepadinamani@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Chang <dpf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Link: http://lkml.kernel.org/r/20180720083914.1950-3-peda@axentia.se
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 drivers/i2c/i2c-mux.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 301285c54603..15c95aaa484c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -624,7 +624,7 @@ static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
 static void i2c_adapter_lock_bus(struct i2c_adapter *adapter,
 				 unsigned int flags)
 {
-	rt_mutex_lock(&adapter->bus_lock);
+	rt_mutex_lock_nested(&adapter->bus_lock, i2c_adapter_depth(adapter));
 }
 
 /**
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 300ab4b672e4..29646aa6132e 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -144,7 +144,7 @@ static void i2c_mux_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	if (!(flags & I2C_LOCK_ROOT_ADAPTER))
 		return;
 	i2c_lock_bus(parent, flags);
@@ -181,7 +181,7 @@ static void i2c_parent_lock_bus(struct i2c_adapter *adapter,
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	i2c_lock_bus(parent, flags);
 }
 
