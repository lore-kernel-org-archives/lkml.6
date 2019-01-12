Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9363BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE3C20835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfALP3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:29:13 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34297 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfALP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:29:09 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0CFSrfO026601;
        Sat, 12 Jan 2019 16:28:53 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Silvio Cesare <silvio.cesare@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: [PATCH 6/8] ASoC: intel: skylake: change snprintf to scnprintf for possible overflow
Date:   Sat, 12 Jan 2019 16:28:42 +0100
Message-Id: <20190112152844.26550-6-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20190112152844.26550-1-w@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Silvio Cesare <silvio.cesare@gmail.com>

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>

---
 sound/soc/intel/skylake/skl-debug.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 5d7ac2ee7a3c..bb28db734fb7 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -43,7 +43,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
 	ssize_t ret = 0;
 
 	for (i = 0; i < max_pin; i++)
-		ret += snprintf(buf + size, MOD_BUF - size,
+		ret += scnprintf(buf + size, MOD_BUF - size,
 				"%s %d\n\tModule %d\n\tInstance %d\n\t"
 				"In-used %s\n\tType %s\n"
 				"\tState %d\n\tIndex %d\n",
@@ -59,7 +59,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
 static ssize_t skl_print_fmt(struct skl_module_fmt *fmt, char *buf,
 					ssize_t size, bool direction)
 {
-	return snprintf(buf + size, MOD_BUF - size,
+	return scnprintf(buf + size, MOD_BUF - size,
 			"%s\n\tCh %d\n\tFreq %d\n\tBit depth %d\n\t"
 			"Valid bit depth %d\n\tCh config %#x\n\tInterleaving %d\n\t"
 			"Sample Type %d\n\tCh Map %#x\n",
@@ -81,16 +81,16 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = snprintf(buf, MOD_BUF, "Module:\n\tUUID %pUL\n\tModule id %d\n"
+	ret = scnprintf(buf, MOD_BUF, "Module:\n\tUUID %pUL\n\tModule id %d\n"
 			"\tInstance id %d\n\tPvt_id %d\n", mconfig->guid,
 			mconfig->id.module_id, mconfig->id.instance_id,
 			mconfig->id.pvt_id);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"Resources:\n\tMCPS %#x\n\tIBS %#x\n\tOBS %#x\t\n",
 			mconfig->mcps, mconfig->ibs, mconfig->obs);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"Module data:\n\tCore %d\n\tIn queue %d\n\t"
 			"Out queue %d\n\tType %s\n",
 			mconfig->core_id, mconfig->max_in_queue,
@@ -100,38 +100,38 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
 	ret += skl_print_fmt(mconfig->in_fmt, buf, ret, true);
 	ret += skl_print_fmt(mconfig->out_fmt, buf, ret, false);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"Fixup:\n\tParams %#x\n\tConverter %#x\n",
 			mconfig->params_fixup, mconfig->converter);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"Module Gateway:\n\tType %#x\n\tVbus %#x\n\tHW conn %#x\n\tSlot %#x\n",
 			mconfig->dev_type, mconfig->vbus_id,
 			mconfig->hw_conn_type, mconfig->time_slot);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"Pipeline:\n\tID %d\n\tPriority %d\n\tConn Type %d\n\t"
 			"Pages %#x\n", mconfig->pipe->ppl_id,
 			mconfig->pipe->pipe_priority, mconfig->pipe->conn_type,
 			mconfig->pipe->memory_pages);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"\tParams:\n\t\tHost DMA %d\n\t\tLink DMA %d\n",
 			mconfig->pipe->p_params->host_dma_id,
 			mconfig->pipe->p_params->link_dma_id);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"\tPCM params:\n\t\tCh %d\n\t\tFreq %d\n\t\tFormat %d\n",
 			mconfig->pipe->p_params->ch,
 			mconfig->pipe->p_params->s_freq,
 			mconfig->pipe->p_params->s_fmt);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"\tLink %#x\n\tStream %#x\n",
 			mconfig->pipe->p_params->linktype,
 			mconfig->pipe->p_params->stream);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"\tState %d\n\tPassthru %s\n",
 			mconfig->pipe->state,
 			mconfig->pipe->passthru ? "true" : "false");
@@ -141,7 +141,7 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
 	ret += skl_print_pins(mconfig->m_out_pin, buf,
 			mconfig->max_out_queue, ret, false);
 
-	ret += snprintf(buf + ret, MOD_BUF - ret,
+	ret += scnprintf(buf + ret, MOD_BUF - ret,
 			"Other:\n\tDomain %d\n\tHomogeneous Input %s\n\t"
 			"Homogeneous Output %s\n\tIn Queue Mask %d\n\t"
 			"Out Queue Mask %d\n\tDMA ID %d\n\tMem Pages %d\n\t"
@@ -199,7 +199,7 @@ static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
 		__iowrite32_copy(d->fw_read_buff, fw_reg_addr, w0_stat_sz >> 2);
 
 	for (offset = 0; offset < FW_REG_SIZE; offset += 16) {
-		ret += snprintf(tmp + ret, FW_REG_BUF - ret, "%#.4x: ", offset);
+		ret += scnprintf(tmp + ret, FW_REG_BUF - ret, "%#.4x: ", offset);
 		hex_dump_to_buffer(d->fw_read_buff + offset, 16, 16, 4,
 				   tmp + ret, FW_REG_BUF - ret, 0);
 		ret += strlen(tmp + ret);
-- 
2.19.2

