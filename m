Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeCZVWD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:22:03 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:49268 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeCZVWB (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 26 Mar 2018 17:22:01 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/6] drivers/i2c: Update i2c_trace_msg static key to modern api
Date: Mon, 26 Mar 2018 14:09:24 -0700
Message-Id: <20180326210929.5244-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180326210929.5244-1-dave@stgolabs.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to i2c_trace_msg, for better self
documentation.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/i2c/i2c-core-base.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 16a3b73375a6..bfcff2a6f0a3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -69,18 +69,18 @@ static DEFINE_IDR(i2c_adapter_idr);
 
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
-static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
+static DEFINE_STATIC_KEY_FALSE(i2c_trace_msg_key);
 static bool is_registered;
 
 int i2c_transfer_trace_reg(void)
 {
-	static_key_slow_inc(&i2c_trace_msg);
+	static_branch_inc(&i2c_trace_msg_key);
 	return 0;
 }
 
 void i2c_transfer_trace_unreg(void)
 {
-	static_key_slow_dec(&i2c_trace_msg);
+	static_branch_dec(&i2c_trace_msg_key);
 }
 
 const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
@@ -1848,11 +1848,12 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
 		return -EOPNOTSUPP;
 
-	/* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
+	/*
+	 * i2c_trace_msg_key gets enabled when tracepoint i2c_transfer gets
 	 * enabled.  This is an efficient way of keeping the for-loop from
 	 * being executed when not needed.
 	 */
-	if (static_key_false(&i2c_trace_msg)) {
+	if (static_branch_unlikely(&i2c_trace_msg_key)) {
 		int i;
 		for (i = 0; i < num; i++)
 			if (msgs[i].flags & I2C_M_RD)
@@ -1871,7 +1872,7 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			break;
 	}
 
-	if (static_key_false(&i2c_trace_msg)) {
+	if (static_branch_unlikely(&i2c_trace_msg_key)) {
 		int i;
 		for (i = 0; i < ret; i++)
 			if (msgs[i].flags & I2C_M_RD)
-- 
2.13.6
