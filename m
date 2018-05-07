Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AB8JxZo0u928/qY0sKPFh7pi3kbaihsG7O1Z/05VQPBwbXxd4bV8bUEzZgz8z+BsQPH8EW9sPOVd
ARC-Seal: i=1; a=rsa-sha256; t=1525668788; cv=none;
        d=google.com; s=arc-20160816;
        b=jfKM/ZCovBQ5GYSgIUm5LL64FL3J3g3I2OI2wiZmqX16HgG6wA3EzAwNBjKPqywyAf
         Uo2xR9Wl4nrmL3uxmhzjOOoipqxCJ8HOag8U19SXq3D0NZQkyBQ5kuHSGVYb/07Pohdr
         GOw+N5Fy1SaUMW2oONEzCtyvvHO8zmi5yTqTyiXhpUUw79g9Gt+Vtl1OY4oq0IeVSS1U
         R+83ahOcIbLpSIC7frQHTcSoaC0Ee8jkd2iPL+aJeTlnw4sn856nUbQWGosjs3rast47
         CSaQ58GBqKDbQ4sOZG1Eg7sX3Lix1LVasxs5A2ZjHl5ohSCU2ulVCijYWRdfsQY6fU61
         g9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=NqSn/WnMpf4FXXcZy3KWVd93yWjjGu0HmtyLZejWCKA=;
        b=eK866bBQOjFHUT61dmv0hsY37GA1SsfJnJNT/76z/s+YCnAGy6dc/X7jnA6C6K1X4Y
         R8N4vOf5yFZPEmunU84yKLfr8OO9ilZDvzHxxhkkbhNP1DHaF9NCcUZEpn9Lm+hofCD0
         KmvSMSgf8esGwn8nhUZm5MynugSINXZvky+BEJFcGOBUp32BvcWEZszp2PYA/LHn2Bax
         y+VMALkj8lS7e16UbDFaOULo+Fb6Wt7FNa0eyojt492IeYoBX9yDiFbDHZYEhPY/OmaU
         3Tvd4TRFEhvAaCX2ruEZ83YnUTuMagz2CZ0eR3FM/jREFe5G7+Ctv7LEBfSv8oAr0mF9
         LcxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v2 3/7] platform/mellanox: mlxreg-hotplug: add extra cycle for hotplug work queue
Date: Mon,  7 May 2018 06:48:51 +0000
Message-Id: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599779675291246402?=
X-GMAIL-MSGID: =?utf-8?q?1599779675291246402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add extra cycle for hotplug work queue to handle the case when a signal is
It adds missed logic for signal acknowledge, by adding an extra run for
received, but no specific signal assertion is detected. Such case
theoretically can happen for example in case several units are removed or
inserted at the same time. In this situation acknowledge for some signal
can be missed at signal top aggreagation status level. The extra run will
allow to handler to acknowledge the missed signal.

The interrupt handling flow performs the next steps:
(1)
Enter mlxreg_hotplug_work_handler due to signal assertion.
Aggregation status register is changed for example from 0xff to 0xfd
(event signal group related to bit 1).
(2)
Mask aggregation interrupts, read aggregation status register and save it
(0xfd) in aggr_cache, then traverse down to handle signal from groups
related to the changed bit.
(3)
Read and mask group related signal.
Acknowledge and unmask group related signal (acknowledge should clear
aggregation status register from 0xfd back to 0xff).
(4)
Re-schedule work queue for the immediate execution.
(5)
Enter mlxreg_hotplug_work_handler due to re-scheduling.
Aggregation status is changed from previous 0xfd to 0xff.
Go over steps (2) - (5) and in case no new signal assertion
is detected - unmask aggregation interrupts.

The possible race could happen in case new signal from the same group is
asserted after step (3) and prior step (5). In such case aggregation
status will change back from 0xff to 0xfd and the value read from the
aggregation status register will be the same as a value saved in
aggr_cache. As a result the handler will not traverse down and signal
will stay unhandled.

Example of faulty flow:
The signal routing flow is as following (f.e. for of FANi removing):
 - FAN status and event registers related bit is changed;
 -- intermediate aggregation status register is changed;
 --- top aggregation status register is changed;
 ---- interrupt routed to CPU and interrupt handler is invoked.

When interrupt handler is invoked it follows the next simple logic (f.e
FAN3 is removed):
 (a1) mask top aggregation interrupt mask register;
 (a2) read top aggregation interrupt status register and test to which
      underling group belongs a signal (FANs in this case and is changed
	  from 0xff to 0xfb and 0xfb is saved as a last status value);
   (b1) mask FANs interrupt mask register;
   (b2) read FANs status register and test which FAN has been changed
        FAN3 in this example);
     (c1) perform relevant action;
              <--------------- (FAN2 is removed at this point)
   (b3) clear FANs interrupt event register to acknowledge FAN3 signal;
   (b4) unmask FANs interrupt mask register
 (a3) unmask top aggregation interrupt mask register;

 An interrupt handler is invoked, since FAN2 interrupt is not acknowledge.
 It should set top aggregation interrupt status register bit 6 (0xfb).
 In step (a2)
 (a2) read top aggregation interrupt and comparing it with saved value
      does not show change (same 0xfb) and after (a2) execution jumps to
	  (a3) and signal leaved unhandled

The fix will enforce handler to traverse down in case the signal is
received, but signal assertion is not detected.

Fixes: 07b89c2b2a5e ("platform/x86: Introduce support for Mellanox hotplug driver")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
V1->v2:
 Comments pointed out by Darren:
 - Modify commit message;
 - Remove redundant check of aggr_asserted;
 - Change bug fix reference from 1f976f6978bf, which just relocated driver
   to 07b89c2b2a5e, which was initial driver commit.
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 48 +++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index b56953a..922913b 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -55,6 +55,7 @@
 #define MLXREG_HOTPLUG_RST_CNTR		3
 
 #define MLXREG_HOTPLUG_ATTRS_MAX	24
+#define MLXREG_HOTPLUG_NOT_ASSERT	3
 
 /**
  * struct mlxreg_hotplug_priv_data - platform private data:
@@ -74,6 +75,7 @@
  * @mask: top aggregation interrupt common mask;
  * @aggr_cache: last value of aggregation register status;
  * @after_probe: flag indication probing completion;
+ * @not_asserted: number of entries in workqueue with no signal assertion;
  */
 struct mlxreg_hotplug_priv_data {
 	int irq;
@@ -93,6 +95,7 @@ struct mlxreg_hotplug_priv_data {
 	u32 mask;
 	u32 aggr_cache;
 	bool after_probe;
+	u8 not_asserted;
 };
 
 static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
@@ -410,6 +413,18 @@ static void mlxreg_hotplug_work_handler(struct work_struct *work)
 	aggr_asserted = priv->aggr_cache ^ regval;
 	priv->aggr_cache = regval;
 
+	/*
+	 * Handler is invoked, but no assertion is detected at top aggregation
+	 * status level. Set aggr_asserted to mask value to allow handler extra
+	 * run over all relevant signals to recover any missed signal.
+	 */
+	if (priv->not_asserted == MLXREG_HOTPLUG_NOT_ASSERT) {
+		priv->not_asserted = 0;
+		aggr_asserted = pdata->mask;
+	}
+	if (!aggr_asserted)
+		goto unmask_event;
+
 	/* Handle topology and health configuration changes. */
 	for (i = 0; i < pdata->counter; i++, item++) {
 		if (aggr_asserted & item->aggr_mask) {
@@ -420,27 +435,26 @@ static void mlxreg_hotplug_work_handler(struct work_struct *work)
 		}
 	}
 
-	if (aggr_asserted) {
-		spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 
-		/*
-		 * It is possible, that some signals have been inserted, while
-		 * interrupt has been masked by mlxreg_hotplug_work_handler.
-		 * In this case such signals will be missed. In order to handle
-		 * these signals delayed work is canceled and work task
-		 * re-scheduled for immediate execution. It allows to handle
-		 * missed signals, if any. In other case work handler just
-		 * validates that no new signals have been received during
-		 * masking.
-		 */
-		cancel_delayed_work(&priv->dwork_irq);
-		schedule_delayed_work(&priv->dwork_irq, 0);
+	/*
+	 * It is possible, that some signals have been inserted, while
+	 * interrupt has been masked by mlxreg_hotplug_work_handler. In this
+	 * case such signals will be missed. In order to handle these signals
+	 * delayed work is canceled and work task re-scheduled for immediate
+	 * execution. It allows to handle missed signals, if any. In other case
+	 * work handler just validates that no new signals have been received
+	 * during masking.
+	 */
+	cancel_delayed_work(&priv->dwork_irq);
+	schedule_delayed_work(&priv->dwork_irq, 0);
 
-		spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
-		return;
-	}
+	return;
 
+unmask_event:
+	priv->not_asserted++;
 	/* Unmask aggregation event (no need acknowledge). */
 	ret = regmap_write(priv->regmap, pdata->cell +
 			   MLXREG_HOTPLUG_AGGR_MASK_OFF, pdata->mask);
-- 
2.1.4
