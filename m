Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A388DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E0F20835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfALP3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:29:04 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34285 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfALP3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:29:04 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0CFSo1l026597;
        Sat, 12 Jan 2019 16:28:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Silvio Cesare <silvio.cesare@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: [PATCH 2/8] libertas: change snprintf to scnprintf for possible overflow
Date:   Sat, 12 Jan 2019 16:28:38 +0100
Message-Id: <20190112152844.26550-2-w@1wt.eu>
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
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>

---
 drivers/net/wireless/marvell/libertas/debugfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/debugfs.c b/drivers/net/wireless/marvell/libertas/debugfs.c
index c83f44f9ddf1..ec73bd3a10db 100644
--- a/drivers/net/wireless/marvell/libertas/debugfs.c
+++ b/drivers/net/wireless/marvell/libertas/debugfs.c
@@ -41,9 +41,9 @@ static ssize_t lbs_dev_info(struct file *file, char __user *userbuf,
 	if (!buf)
 		return -ENOMEM;
 
-	pos += snprintf(buf+pos, len-pos, "state = %s\n",
+	pos += scnprintf(buf+pos, len-pos, "state = %s\n",
 				szStates[priv->connect_status]);
-	pos += snprintf(buf+pos, len-pos, "region_code = %02x\n",
+	pos += scnprintf(buf+pos, len-pos, "region_code = %02x\n",
 				(u32) priv->regioncode);
 
 	res = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
@@ -105,7 +105,7 @@ static ssize_t lbs_sleepparams_read(struct file *file, char __user *userbuf,
 	if (ret)
 		goto out_unlock;
 
-	pos += snprintf(buf, len, "%d %d %d %d %d %d\n", sp.sp_error,
+	pos += scnprintf(buf, len, "%d %d %d %d %d %d\n", sp.sp_error,
 			sp.sp_offset, sp.sp_stabletime,
 			sp.sp_calcontrol, sp.sp_extsleepclk,
 			sp.sp_reserved);
@@ -170,7 +170,7 @@ static ssize_t lbs_host_sleep_read(struct file *file, char __user *userbuf,
 	if (!buf)
 		return -ENOMEM;
 
-	pos += snprintf(buf, len, "%d\n", priv->is_host_sleep_activated);
+	pos += scnprintf(buf, len, "%d\n", priv->is_host_sleep_activated);
 
 	ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 
@@ -251,7 +251,7 @@ static ssize_t lbs_threshold_read(uint16_t tlv_type, uint16_t event_mask,
 		freq  = got->freq;
 		events = le16_to_cpu(subscribed->events);
 
-		pos += snprintf(buf, len, "%d %d %d\n", value, freq,
+		pos += scnprintf(buf, len, "%d %d %d\n", value, freq,
 				!!(events & event_mask));
 	}
 
@@ -446,7 +446,7 @@ static ssize_t lbs_rdmac_read(struct file *file, char __user *userbuf,
 	ret = lbs_get_reg(priv, CMD_MAC_REG_ACCESS, priv->mac_offset, &val);
 	mdelay(10);
 	if (!ret) {
-		pos = snprintf(buf, len, "MAC[0x%x] = 0x%08x\n",
+		pos = scnprintf(buf, len, "MAC[0x%x] = 0x%08x\n",
 				priv->mac_offset, val);
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 	}
@@ -516,7 +516,7 @@ static ssize_t lbs_rdbbp_read(struct file *file, char __user *userbuf,
 	ret = lbs_get_reg(priv, CMD_BBP_REG_ACCESS, priv->bbp_offset, &val);
 	mdelay(10);
 	if (!ret) {
-		pos = snprintf(buf, len, "BBP[0x%x] = 0x%08x\n",
+		pos = scnprintf(buf, len, "BBP[0x%x] = 0x%08x\n",
 				priv->bbp_offset, val);
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 	}
@@ -588,7 +588,7 @@ static ssize_t lbs_rdrf_read(struct file *file, char __user *userbuf,
 	ret = lbs_get_reg(priv, CMD_RF_REG_ACCESS, priv->rf_offset, &val);
 	mdelay(10);
 	if (!ret) {
-		pos = snprintf(buf, len, "RF[0x%x] = 0x%08x\n",
+		pos = scnprintf(buf, len, "RF[0x%x] = 0x%08x\n",
 				priv->rf_offset, val);
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 	}
-- 
2.19.2

