Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F131AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46E9206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46E9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeJETmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:42:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:8943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:41:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 05:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97687795"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 05:43:24 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 07/16] stm class: Switch over to the protocol driver
Date:   Fri,  5 Oct 2018 15:42:57 +0300
Message-Id: <20181005124306.54870-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the default framing protocol is factored out into its own driver,
switch over to using the driver for writing data. To that end, make the
policy code require a valid protocol name (or absence thereof, which is
equivalent to "p_basic").

Also, to make transition easier, make stm class request "p_basic" module
at initialization time.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/stm/core.c   | 34 ++++++++++++++++++++--------------
 drivers/hwtracing/stm/policy.c |  3 +--
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index b789a5f0688e..93ce3aa740a9 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -603,18 +603,21 @@ ssize_t notrace stm_data_write(struct stm_data *data, unsigned int m,
 }
 EXPORT_SYMBOL_GPL(stm_data_write);
 
-static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
-			  unsigned int channel, const char *buf, size_t count)
+static ssize_t notrace
+stm_write(struct stm_device *stm, struct stm_output *output,
+	  unsigned int chan, const char *buf, size_t count)
 {
-	const unsigned char nil = 0;
-	ssize_t sz;
+	int err;
+
+	/* stm->pdrv is serialized against policy_mutex */
+	if (!stm->pdrv)
+		return -ENODEV;
 
-	sz = stm_data_write(data, master, channel, true, buf, count);
-	if (sz > 0)
-		data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0,
-			     &nil);
+	err = stm->pdrv->write(stm->data, output, chan, buf, count);
+	if (err < 0)
+		return err;
 
-	return sz;
+	return err;
 }
 
 static ssize_t stm_char_write(struct file *file, const char __user *buf,
@@ -659,8 +662,7 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 
 	pm_runtime_get_sync(&stm->dev);
 
-	count = stm_write(stm->data, stmf->output.master, stmf->output.channel,
-			  kbuf, count);
+	count = stm_write(stm, &stmf->output, 0, kbuf, count);
 
 	pm_runtime_mark_last_busy(&stm->dev);
 	pm_runtime_put_autosuspend(&stm->dev);
@@ -1310,9 +1312,7 @@ int notrace stm_source_write(struct stm_source_data *data,
 
 	stm = srcu_dereference(src->link, &stm_source_srcu);
 	if (stm)
-		count = stm_write(stm->data, src->output.master,
-				  src->output.channel + chan,
-				  buf, count);
+		count = stm_write(stm, &src->output, chan, buf, count);
 	else
 		count = -ENODEV;
 
@@ -1342,6 +1342,12 @@ static int __init stm_core_init(void)
 	INIT_LIST_HEAD(&stm_pdrv_head);
 	mutex_init(&stm_pdrv_mutex);
 
+	/*
+	 * So as to not confuse existing users with a requirement
+	 * to load yet another module, do it here.
+	 */
+	if (IS_ENABLED(CONFIG_STM_PROTO_BASIC))
+		(void)request_module_nowait("stm_p_basic");
 	stm_core_up++;
 
 	return 0;
diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 8bc90432ae69..5e51bed0787b 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -454,8 +454,7 @@ stp_policy_make(struct config_group *group, const char *name)
 	err = stm_lookup_protocol(proto, &pdrv, &pdrv_node_type);
 	kfree(devname);
 
-	/* We don't have any protocol drivers yet */
-	if (err != -ENOENT) {
+	if (err) {
 		stm_put_device(stm);
 		return ERR_PTR(-ENODEV);
 	}
-- 
2.19.0

