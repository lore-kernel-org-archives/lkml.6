Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C32ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5514A21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5514A21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbeITS3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:3375 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387790AbeITS3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820908"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:24 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 09/16] stm class: p_sys-t: Add support for CLOCKSYNC packets
Date:   Thu, 20 Sep 2018 15:45:46 +0300
Message-Id: <20180920124553.56978-10-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for CLOCKSYNC SyS-T packets, that establish correlation
between the transport clock (STP timestamps) and SyS-T timestamps. These
packets are sent periodically to allow the decoder to keep both time
sources in sync.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/p_sys-t.c | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
index 8f3066ff1b7b..79d40515a84c 100644
--- a/drivers/hwtracing/stm/p_sys-t.c
+++ b/drivers/hwtracing/stm/p_sys-t.c
@@ -72,15 +72,20 @@ enum sys_t_message_string_subtype {
 			 MIPI_SYST_SEVERITY(INFO)		| \
 			 MIPI_SYST_OPT_GUID)
 
+#define CLOCK_SYNC_HEADER	(MIPI_SYST_TYPES(CLOCK, TRANSPORT_SYNC)	| \
+				 MIPI_SYST_SEVERITY(MAX))
+
 struct sys_t_policy_node {
 	uuid_t		uuid;
 	bool		do_len;
 	unsigned long	ts_interval;
+	unsigned long	clocksync_interval;
 };
 
 struct sys_t_output {
 	struct sys_t_policy_node	node;
 	unsigned long	ts_jiffies;
+	unsigned long	clocksync_jiffies;
 };
 
 static void sys_t_policy_node_init(void *priv)
@@ -191,10 +196,42 @@ sys_t_policy_ts_interval_store(struct config_item *item, const char *page,
 
 CONFIGFS_ATTR(sys_t_policy_, ts_interval);
 
+static ssize_t sys_t_policy_clocksync_interval_show(struct config_item *item,
+						    char *page)
+{
+	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
+
+	return sprintf(page, "%u\n", jiffies_to_msecs(pn->clocksync_interval));
+}
+
+static ssize_t
+sys_t_policy_clocksync_interval_store(struct config_item *item,
+				      const char *page, size_t count)
+{
+	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
+	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
+	unsigned int ms;
+	int ret;
+
+	mutex_lock(mutexp);
+	ret = kstrtouint(page, 10, &ms);
+	mutex_unlock(mutexp);
+
+	if (!ret) {
+		pn->clocksync_interval = msecs_to_jiffies(ms);
+		return count;
+	}
+
+	return ret;
+}
+
+CONFIGFS_ATTR(sys_t_policy_, clocksync_interval);
+
 static struct configfs_attribute *sys_t_policy_attrs[] = {
 	&sys_t_policy_attr_uuid,
 	&sys_t_policy_attr_do_len,
 	&sys_t_policy_attr_ts_interval,
+	&sys_t_policy_attr_clocksync_interval,
 	NULL,
 };
 
@@ -210,6 +247,43 @@ static inline bool sys_t_need_ts(struct sys_t_output *op)
 	return false;
 }
 
+static bool sys_t_need_clock_sync(struct sys_t_output *op)
+{
+	if (op->node.clocksync_interval &&
+	    time_after(op->clocksync_jiffies + op->node.clocksync_interval,
+		       jiffies)) {
+		op->clocksync_jiffies = jiffies;
+
+		return true;
+	}
+
+	return false;
+}
+
+static ssize_t
+sys_t_clock_sync(struct stm_data *data, unsigned int m, unsigned int c)
+{
+	u32 header = CLOCK_SYNC_HEADER;
+	unsigned char nil = 0;
+	u64 payload[2]; /* Clock value and frequency */
+	ssize_t sz;
+
+	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_TIMESTAMPED,
+			  4, (u8 *)&header);
+	if (sz <= 0)
+		return sz;
+
+	payload[0] = ktime_get_real_ns();
+	payload[1] = NSEC_PER_SEC;
+	sz = stm_data_write(data, m, c, false, &payload, sizeof(payload));
+	if (sz <= 0)
+		return sz;
+
+	data->packet(data, m, c, STP_PACKET_FLAG, 0, 0, &nil);
+
+	return sizeof(header) + sizeof(payload);
+}
+
 static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 			   unsigned int chan, const char *buf, size_t count)
 {
@@ -223,6 +297,12 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 	if (!op)
 		return -EINVAL;
 
+	if (sys_t_need_clock_sync(op)) {
+		sz = sys_t_clock_sync(data, m, c);
+		if (sz <= 0)
+			return sz;
+	}
+
 	if (op->node.do_len)
 		header |= MIPI_SYST_OPT_LEN;
 	if (sys_t_need_ts(op))
-- 
2.18.0

