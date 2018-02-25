Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AH8x227Lt3JCfOYvq9x8UWOyxHNbgQBR+ERded12WtB1R4SU5RnqFrWTimHKhkt8kAWbExgMtSr4
ARC-Seal: i=1; a=rsa-sha256; t=1519582205; cv=none;
        d=google.com; s=arc-20160816;
        b=X2E0OiKZ5sbVufNY74djau/RS9vK5JbPlXe5JkVmAR05tpiMXMK4JqFlgngASqzhqV
         +aByw33+CTqHjUubILtQyzZtoTF6OAInJVAqtkQVzwcS85Y6Cr5Tb4ifvmzcHiKJFwSf
         ca94axMCSiNwKiAQXdZe6waM/P8ZWsha2OW06ISczYdejB2GIPcXLGjK11YMrlhTYPMa
         XOF5xtcsxY6LLhz9K+VB6/M+bilueatOXT0A6OkFrRTnr5U4f2d8j13Qm9LZ3zXAw99c
         nusTFXCwO7oGbExERG2KrNiRZ704Fhn3JmIxZDXjkuvygROmHTcHN1q9Drj2hYUHfqF6
         KcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=WDzipYfF5Y9K4ufkTsTlmIAKJ7tykCxSLx7aMinHWfw=;
        b=xsCZq9tmCU4gG5117hWFG7ezPulYgf67oOofU0ZDMhXK+FP8nLL6oOqkOYjcCHNuup
         yYUCHeHv2KR7dUHlpchEOi+3gB/pBMSHJDSWwod/SahQE2Lv8e4BpLt8eXBpbeZOh8sU
         7SoHeY32FDbF+/SpZiCsdt5EDQyTN9Z4+gjRPRAugy9P0WHljRYhnPn5+WTB8T1+hSqi
         vrIZOfH+bFItWOgEas+3e2Ls0eelZX08nbtU3y7sMtgnOHqzXg8TuZVuf6brQDO4f+Fw
         KlK9XfK2S//GXE2TKek7W/1NgXkoXFTRRHC4XT3Wokb94t4kxH+8A/Vy4zGF3Ss/uDVe
         Wnvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,393,1515484800";
   d="scan'208";a="20124780"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: limit the number of queued writes
Date: Sun, 25 Feb 2018 20:07:05 +0200
Message-Id: <20180225180705.9084-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180225180705.9084-1-tomas.winkler@intel.com>
References: <20180225180705.9084-1-tomas.winkler@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593397430161986697?=
X-GMAIL-MSGID: =?utf-8?q?1593397430161986697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Usyskin <alexander.usyskin@intel.com>

Limit the number of queued writes per client.
Writes above this threshold are blocked till place
in the transmit queue is available.
The limit is configurable via sysfs and defaults to 50.
The implementation should provide blocking I/O behavior.
Prior to this change one would end up in the hands of OOM.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/ABI/testing/sysfs-class-mei |  9 ++++
 drivers/misc/mei/bus.c                    | 17 +++++++
 drivers/misc/mei/client.c                 | 82 +++++++++++++++++++------------
 drivers/misc/mei/debugfs.c                |  7 +--
 drivers/misc/mei/init.c                   |  1 +
 drivers/misc/mei/main.c                   | 65 ++++++++++++++++++++++++
 drivers/misc/mei/mei_dev.h                |  8 +++
 7 files changed, 154 insertions(+), 35 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mei b/Documentation/ABI/testing/sysfs-class-mei
index 5096a82f4cde..81ff6abf9673 100644
--- a/Documentation/ABI/testing/sysfs-class-mei
+++ b/Documentation/ABI/testing/sysfs-class-mei
@@ -45,3 +45,12 @@ Contact:	Tomas Winkler <tomas.winkler@intel.com>
 Description:	Display the driver HBM protocol version.
 
 		The HBM protocol version supported by the driver.
+
+What:		/sys/class/mei/meiN/tx_queue_limit
+Date:		Jan 2018
+KernelVersion:	4.16
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Configure tx queue limit
+
+		Set maximal number of pending writes
+		per opened session.
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 1dacc820bd7f..b1133739fb4b 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -74,6 +74,23 @@ ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
 		goto out;
 	}
 
+	while (cl->tx_cb_queued >= bus->tx_queue_limit) {
+		mutex_unlock(&bus->device_lock);
+		rets = wait_event_interruptible(cl->tx_wait,
+				cl->writing_state == MEI_WRITE_COMPLETE ||
+				(!mei_cl_is_connected(cl)));
+		mutex_lock(&bus->device_lock);
+		if (rets) {
+			if (signal_pending(current))
+				rets = -EINTR;
+			goto out;
+		}
+		if (!mei_cl_is_connected(cl)) {
+			rets = -ENODEV;
+			goto out;
+		}
+	}
+
 	cb = mei_cl_alloc_cb(cl, length, MEI_FOP_WRITE, NULL);
 	if (!cb) {
 		rets = -ENOMEM;
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index bdfb4ecf848a..8d6197a88b54 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -349,6 +349,36 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
 	kfree(cb);
 }
 
+/**
+ * mei_tx_cb_queue - queue tx callback
+ *
+ * Locking: called under "dev->device_lock" lock
+ *
+ * @cb: mei callback struct
+ * @head: an instance of list to queue on
+ */
+static inline void mei_tx_cb_enqueue(struct mei_cl_cb *cb,
+				     struct list_head *head)
+{
+	list_add_tail(&cb->list, head);
+	cb->cl->tx_cb_queued++;
+}
+
+/**
+ * mei_tx_cb_dequeue - dequeue tx callback
+ *
+ * Locking: called under "dev->device_lock" lock
+ *
+ * @cb: mei callback struct to dequeue and free
+ */
+static inline void mei_tx_cb_dequeue(struct mei_cl_cb *cb)
+{
+	if (!WARN_ON(cb->cl->tx_cb_queued == 0))
+		cb->cl->tx_cb_queued--;
+
+	mei_io_cb_free(cb);
+}
+
 /**
  * mei_io_cb_init - allocate and initialize io callback
  *
@@ -377,49 +407,37 @@ static struct mei_cl_cb *mei_io_cb_init(struct mei_cl *cl,
 }
 
 /**
- * __mei_io_list_flush_cl - removes and frees cbs belonging to cl.
+ * mei_io_list_flush_cl - removes cbs belonging to the cl.
  *
  * @head:  an instance of our list structure
- * @cl:    host client, can be NULL for flushing the whole list
- * @free:  whether to free the cbs
+ * @cl:    host client
  */
-static void __mei_io_list_flush_cl(struct list_head *head,
-				   const struct mei_cl *cl, bool free)
+static void mei_io_list_flush_cl(struct list_head *head,
+				 const struct mei_cl *cl)
 {
 	struct mei_cl_cb *cb, *next;
 
-	/* enable removing everything if no cl is specified */
 	list_for_each_entry_safe(cb, next, head, list) {
-		if (!cl || mei_cl_cmp_id(cl, cb->cl)) {
+		if (mei_cl_cmp_id(cl, cb->cl))
 			list_del_init(&cb->list);
-			if (free)
-				mei_io_cb_free(cb);
-		}
 	}
 }
 
 /**
- * mei_io_list_flush_cl - removes list entry belonging to cl.
+ * mei_io_tx_list_free_cl - removes cb belonging to the cl and free them
  *
  * @head: An instance of our list structure
  * @cl: host client
  */
-static inline void mei_io_list_flush_cl(struct list_head *head,
-					const struct mei_cl *cl)
+static void mei_io_tx_list_free_cl(struct list_head *head,
+				   const struct mei_cl *cl)
 {
-	__mei_io_list_flush_cl(head, cl, false);
-}
+	struct mei_cl_cb *cb, *next;
 
-/**
- * mei_io_list_free_cl - removes cb belonging to cl and free them
- *
- * @head: An instance of our list structure
- * @cl: host client
- */
-static inline void mei_io_list_free_cl(struct list_head *head,
-				       const struct mei_cl *cl)
-{
-	__mei_io_list_flush_cl(head, cl, true);
+	list_for_each_entry_safe(cb, next, head, list) {
+		if (mei_cl_cmp_id(cl, cb->cl))
+			mei_tx_cb_dequeue(cb);
+	}
 }
 
 /**
@@ -538,8 +556,8 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp)
 	dev = cl->dev;
 
 	cl_dbg(dev, cl, "remove list entry belonging to cl\n");
-	mei_io_list_free_cl(&cl->dev->write_list, cl);
-	mei_io_list_free_cl(&cl->dev->write_waiting_list, cl);
+	mei_io_tx_list_free_cl(&cl->dev->write_list, cl);
+	mei_io_tx_list_free_cl(&cl->dev->write_waiting_list, cl);
 	mei_io_list_flush_cl(&cl->dev->ctrl_wr_list, cl);
 	mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
 	mei_io_list_free_fp(&cl->rd_pending, fp);
@@ -756,8 +774,8 @@ static void mei_cl_set_disconnected(struct mei_cl *cl)
 		return;
 
 	cl->state = MEI_FILE_DISCONNECTED;
-	mei_io_list_free_cl(&dev->write_list, cl);
-	mei_io_list_free_cl(&dev->write_waiting_list, cl);
+	mei_io_tx_list_free_cl(&dev->write_list, cl);
+	mei_io_tx_list_free_cl(&dev->write_waiting_list, cl);
 	mei_io_list_flush_cl(&dev->ctrl_rd_list, cl);
 	mei_io_list_flush_cl(&dev->ctrl_wr_list, cl);
 	mei_cl_wake_all(cl);
@@ -1693,9 +1711,9 @@ int mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 out:
 	if (mei_hdr.msg_complete)
-		list_add_tail(&cb->list, &dev->write_waiting_list);
+		mei_tx_cb_enqueue(cb, &dev->write_waiting_list);
 	else
-		list_add_tail(&cb->list, &dev->write_list);
+		mei_tx_cb_enqueue(cb, &dev->write_list);
 
 	cb = NULL;
 	if (blocking && cl->writing_state != MEI_WRITE_COMPLETE) {
@@ -1741,7 +1759,7 @@ void mei_cl_complete(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	switch (cb->fop_type) {
 	case MEI_FOP_WRITE:
-		mei_io_cb_free(cb);
+		mei_tx_cb_dequeue(cb);
 		cl->writing_state = MEI_WRITE_COMPLETE;
 		if (waitqueue_active(&cl->tx_wait)) {
 			wake_up_interruptible(&cl->tx_wait);
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index a617aa5a3ad8..c815da91089c 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -97,7 +97,7 @@ static ssize_t mei_dbgfs_read_active(struct file *fp, char __user *ubuf,
 	int pos = 0;
 	int ret;
 
-#define HDR "   |me|host|state|rd|wr|\n"
+#define HDR "   |me|host|state|rd|wr|wrq\n"
 
 	if (!dev)
 		return -ENODEV;
@@ -130,9 +130,10 @@ static ssize_t mei_dbgfs_read_active(struct file *fp, char __user *ubuf,
 	list_for_each_entry(cl, &dev->file_list, link) {
 
 		pos += scnprintf(buf + pos, bufsz - pos,
-			"%3d|%2d|%4d|%5d|%2d|%2d|\n",
+			"%3d|%2d|%4d|%5d|%2d|%2d|%3u\n",
 			i, mei_cl_me_id(cl), cl->host_client_id, cl->state,
-			!list_empty(&cl->rd_completed), cl->writing_state);
+			!list_empty(&cl->rd_completed), cl->writing_state,
+			cl->tx_cb_queued);
 		i++;
 	}
 out:
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index c46f6e99a55e..4888ebc076b7 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -383,6 +383,7 @@ void mei_device_init(struct mei_device *dev,
 	INIT_LIST_HEAD(&dev->write_waiting_list);
 	INIT_LIST_HEAD(&dev->ctrl_wr_list);
 	INIT_LIST_HEAD(&dev->ctrl_rd_list);
+	dev->tx_queue_limit = MEI_TX_QUEUE_LIMIT_DEFAULT;
 
 	INIT_DELAYED_WORK(&dev->timer_work, mei_timer);
 	INIT_WORK(&dev->reset_work, mei_reset_work);
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 758dc73602d5..401b1bc4d282 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -291,6 +291,27 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 		goto out;
 	}
 
+	while (cl->tx_cb_queued >= dev->tx_queue_limit) {
+		if (file->f_flags & O_NONBLOCK) {
+			rets = -EAGAIN;
+			goto out;
+		}
+		mutex_unlock(&dev->device_lock);
+		rets = wait_event_interruptible(cl->tx_wait,
+				cl->writing_state == MEI_WRITE_COMPLETE ||
+				(!mei_cl_is_connected(cl)));
+		mutex_lock(&dev->device_lock);
+		if (rets) {
+			if (signal_pending(current))
+				rets = -EINTR;
+			goto out;
+		}
+		if (!mei_cl_is_connected(cl)) {
+			rets = -ENODEV;
+			goto out;
+		}
+	}
+
 	*offset = 0;
 	cb = mei_cl_alloc_cb(cl, length, MEI_FOP_WRITE, file);
 	if (!cb) {
@@ -580,6 +601,12 @@ static __poll_t mei_poll(struct file *file, poll_table *wait)
 			mei_cl_read_start(cl, mei_cl_mtu(cl), file);
 	}
 
+	if (req_events & (POLLOUT | POLLWRNORM)) {
+		poll_wait(file, &cl->tx_wait, wait);
+		if (cl->tx_cb_queued < dev->tx_queue_limit)
+			mask |= POLLOUT | POLLWRNORM;
+	}
+
 out:
 	mutex_unlock(&dev->device_lock);
 	return mask;
@@ -749,10 +776,48 @@ static ssize_t hbm_ver_drv_show(struct device *device,
 }
 static DEVICE_ATTR_RO(hbm_ver_drv);
 
+static ssize_t tx_queue_limit_show(struct device *device,
+				   struct device_attribute *attr, char *buf)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	u8 size = 0;
+
+	mutex_lock(&dev->device_lock);
+	size = dev->tx_queue_limit;
+	mutex_unlock(&dev->device_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+}
+
+static ssize_t tx_queue_limit_store(struct device *device,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	u8 limit;
+	unsigned int inp;
+	int err;
+
+	err = kstrtouint(buf, 10, &inp);
+	if (err)
+		return err;
+	if (inp > MEI_TX_QUEUE_LIMIT_MAX || inp < MEI_TX_QUEUE_LIMIT_MIN)
+		return -EINVAL;
+	limit = inp;
+
+	mutex_lock(&dev->device_lock);
+	dev->tx_queue_limit = limit;
+	mutex_unlock(&dev->device_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(tx_queue_limit);
+
 static struct attribute *mei_attrs[] = {
 	&dev_attr_fw_status.attr,
 	&dev_attr_hbm_ver.attr,
 	&dev_attr_hbm_ver_drv.attr,
+	&dev_attr_tx_queue_limit.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(mei);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index c08111441164..be9c48415da9 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -210,6 +210,7 @@ struct mei_cl_cb {
  * @timer_count:  watchdog timer for operation completion
  * @notify_en: notification - enabled/disabled
  * @notify_ev: pending notification event
+ * @tx_cb_queued: number of tx callbacks in queue
  * @writing_state: state of the tx
  * @rd_pending: pending read credits
  * @rd_completed: completed read
@@ -234,6 +235,7 @@ struct mei_cl {
 	u8 timer_count;
 	u8 notify_en;
 	u8 notify_ev;
+	u8 tx_cb_queued;
 	enum mei_file_transaction_states writing_state;
 	struct list_head rd_pending;
 	struct list_head rd_completed;
@@ -241,6 +243,10 @@ struct mei_cl {
 	struct mei_cl_device *cldev;
 };
 
+#define MEI_TX_QUEUE_LIMIT_DEFAULT 50
+#define MEI_TX_QUEUE_LIMIT_MAX 255
+#define MEI_TX_QUEUE_LIMIT_MIN 30
+
 /**
  * struct mei_hw_ops - hw specific ops
  *
@@ -359,6 +365,7 @@ const char *mei_pg_state_str(enum mei_pg_state state);
  * @write_waiting_list : write completion list
  * @ctrl_wr_list : pending control write list
  * @ctrl_rd_list : pending control read list
+ * @tx_queue_limit: tx queues per client linit
  *
  * @file_list   : list of opened handles
  * @open_handle_count: number of opened handles
@@ -423,6 +430,7 @@ struct mei_device {
 	struct list_head write_waiting_list;
 	struct list_head ctrl_wr_list;
 	struct list_head ctrl_rd_list;
+	u8 tx_queue_limit;
 
 	struct list_head file_list;
 	long open_handle_count;
-- 
2.14.3
