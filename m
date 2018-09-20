Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D412ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3004121529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3004121529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbeITS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:3374 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbeITS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820891"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:20 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 07/16] stm class: Switch over to the protocol driver
Date:   Thu, 20 Sep 2018 15:45:44 +0300
Message-Id: <20180920124553.56978-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the default framing protocol is factored out into its own driver,
switch over to using the driver for writing data.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/core.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 9ed2f06deb47..fb224574b3db 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -598,17 +598,21 @@ ssize_t notrace stm_data_write(struct stm_data *data, unsigned int m,
 }
 EXPORT_SYMBOL_GPL(stm_data_write);
 
-static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
-			  unsigned int channel, const char *buf, size_t count)
+static ssize_t notrace
+stm_write(struct stm_device *stm, struct stm_output *output,
+	  unsigned int chan, const char *buf, size_t count)
 {
-	ssize_t sz;
+	int err;
+
+	/* stm->pdrv is serialized against policy_mutex */
+	if (!stm->pdrv)
+		return -ENODEV;
 
-	sz = stm_data_write(data, master, channel, true, buf, count);
-	if (sz > 0)
-		data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0,
-			     buf);
+	err = stm->pdrv->write(stm->data, output, chan, buf, count);
+	if (err < 0)
+		return err;
 
-	return sz;
+	return err;
 }
 
 static ssize_t stm_char_write(struct file *file, const char __user *buf,
@@ -655,8 +659,7 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 
 	pm_runtime_get_sync(&stm->dev);
 
-	count = stm_write(stm->data, stmf->output.master, stmf->output.channel,
-			  kbuf, count);
+	count = stm_write(stm, &stmf->output, 0, kbuf, count);
 
 	pm_runtime_mark_last_busy(&stm->dev);
 	pm_runtime_put_autosuspend(&stm->dev);
@@ -1306,9 +1309,7 @@ int notrace stm_source_write(struct stm_source_data *data,
 
 	stm = srcu_dereference(src->link, &stm_source_srcu);
 	if (stm)
-		count = stm_write(stm->data, src->output.master,
-				  src->output.channel + chan,
-				  buf, count);
+		count = stm_write(stm, &src->output, chan, buf, count);
 	else
 		count = -ENODEV;
 
-- 
2.18.0

