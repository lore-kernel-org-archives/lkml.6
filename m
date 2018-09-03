Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC275C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D922077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D922077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeICVir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:38:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbeICVir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:38:47 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 775D6D12;
        Mon,  3 Sep 2018 17:17:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Sperbeck <jsperbeck@google.com>,
        Peter Rosin <peda@axentia.se>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Deepa Dinamani <deepadinamani@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Chang <dpf@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 048/165] i2c/mux, locking/core: Annotate the nested rt_mutex usage
Date:   Mon,  3 Sep 2018 18:55:34 +0200
Message-Id: <20180903165657.533076792@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 7b94ea50514d1a0dc94f02723b603c27bc0ea597 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/i2c-core-base.c |    2 +-
 drivers/i2c/i2c-mux.c       |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -638,7 +638,7 @@ static int i2c_check_addr_busy(struct i2
 static void i2c_adapter_lock_bus(struct i2c_adapter *adapter,
 				 unsigned int flags)
 {
-	rt_mutex_lock(&adapter->bus_lock);
+	rt_mutex_lock_nested(&adapter->bus_lock, i2c_adapter_depth(adapter));
 }
 
 /**
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -144,7 +144,7 @@ static void i2c_mux_lock_bus(struct i2c_
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	if (!(flags & I2C_LOCK_ROOT_ADAPTER))
 		return;
 	i2c_lock_bus(parent, flags);
@@ -181,7 +181,7 @@ static void i2c_parent_lock_bus(struct i
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	i2c_lock_bus(parent, flags);
 }
 


