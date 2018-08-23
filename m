Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75450C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32365208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32365208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeHWLuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:50:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeHWLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:50:06 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 989E5C83;
        Thu, 23 Aug 2018 08:21:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 065/217] nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.
Date:   Thu, 23 Aug 2018 09:52:58 +0200
Message-Id: <20180823075508.451280527@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Doron Roberts-Kedes <doronrk@fb.com>

[ Upstream commit 08ba91ee6e2c1c08d3f0648f978cbb5dbf3491d8 ]

If NBD_DISCONNECT_ON_CLOSE is set on a device, then the driver will
issue a disconnect from nbd_release if the device has no remaining
bdev->bd_openers.

Fix ret val so reconfigure with only setting the flag succeeds.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/nbd.c      |   40 +++++++++++++++++++++++++++++++++-------
 include/uapi/linux/nbd.h |    3 +++
 2 files changed, 36 insertions(+), 7 deletions(-)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -76,6 +76,7 @@ struct link_dead_args {
 #define NBD_HAS_CONFIG_REF		4
 #define NBD_BOUND			5
 #define NBD_DESTROY_ON_DISCONNECT	6
+#define NBD_DISCONNECT_ON_CLOSE 	7
 
 struct nbd_config {
 	u32 flags;
@@ -138,6 +139,7 @@ static void nbd_config_put(struct nbd_de
 static void nbd_connect_reply(struct genl_info *info, int index);
 static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info);
 static void nbd_dead_link_work(struct work_struct *work);
+static void nbd_disconnect_and_put(struct nbd_device *nbd);
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -1291,6 +1293,12 @@ out:
 static void nbd_release(struct gendisk *disk, fmode_t mode)
 {
 	struct nbd_device *nbd = disk->private_data;
+	struct block_device *bdev = bdget_disk(disk, 0);
+
+	if (test_bit(NBD_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
+			bdev->bd_openers == 0)
+		nbd_disconnect_and_put(nbd);
+
 	nbd_config_put(nbd);
 	nbd_put(nbd);
 }
@@ -1690,6 +1698,10 @@ again:
 				&config->runtime_flags);
 			put_dev = true;
 		}
+		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
+			set_bit(NBD_DISCONNECT_ON_CLOSE,
+				&config->runtime_flags);
+		}
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
@@ -1734,6 +1746,16 @@ out:
 	return ret;
 }
 
+static void nbd_disconnect_and_put(struct nbd_device *nbd)
+{
+	mutex_lock(&nbd->config_lock);
+	nbd_disconnect(nbd);
+	mutex_unlock(&nbd->config_lock);
+	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
+			       &nbd->config->runtime_flags))
+		nbd_config_put(nbd);
+}
+
 static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nbd_device *nbd;
@@ -1766,12 +1788,7 @@ static int nbd_genl_disconnect(struct sk
 		nbd_put(nbd);
 		return 0;
 	}
-	mutex_lock(&nbd->config_lock);
-	nbd_disconnect(nbd);
-	mutex_unlock(&nbd->config_lock);
-	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
-			       &nbd->config->runtime_flags))
-		nbd_config_put(nbd);
+	nbd_disconnect_and_put(nbd);
 	nbd_config_put(nbd);
 	nbd_put(nbd);
 	return 0;
@@ -1782,7 +1799,7 @@ static int nbd_genl_reconfigure(struct s
 	struct nbd_device *nbd = NULL;
 	struct nbd_config *config;
 	int index;
-	int ret = -EINVAL;
+	int ret = 0;
 	bool put_dev = false;
 
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
@@ -1822,6 +1839,7 @@ static int nbd_genl_reconfigure(struct s
 	    !nbd->task_recv) {
 		dev_err(nbd_to_dev(nbd),
 			"not configured, cannot reconfigure\n");
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -1846,6 +1864,14 @@ static int nbd_genl_reconfigure(struct s
 					       &config->runtime_flags))
 				refcount_inc(&nbd->refs);
 		}
+
+		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
+			set_bit(NBD_DISCONNECT_ON_CLOSE,
+					&config->runtime_flags);
+		} else {
+			clear_bit(NBD_DISCONNECT_ON_CLOSE,
+					&config->runtime_flags);
+		}
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -53,6 +53,9 @@ enum {
 /* These are client behavior specific flags. */
 #define NBD_CFLAG_DESTROY_ON_DISCONNECT	(1 << 0) /* delete the nbd device on
 						    disconnect. */
+#define NBD_CFLAG_DISCONNECT_ON_CLOSE (1 << 1) /* disconnect the nbd device on
+						*  close by last opener.
+						*/
 
 /* userspace doesn't need the nbd_device structure */
 


