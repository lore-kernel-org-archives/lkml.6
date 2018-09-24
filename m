Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8824C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3322083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3322083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbeIXSrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:47:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388526AbeIXSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:47:07 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5B17109E;
        Mon, 24 Sep 2018 12:45:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 227/235] IB/mlx5: fix uaccess beyond "count" in debugfs read/write handlers
Date:   Mon, 24 Sep 2018 13:53:33 +0200
Message-Id: <20180924113125.736824923@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

[ Upstream commit 60e6627f12a78203a093ca05b7bca15627747d81 ]

In general, accessing userspace memory beyond the length of the supplied
buffer in VFS read/write handlers can lead to both kernel memory corruption
(via kernel_read()/kernel_write(), which can e.g. be triggered via
sys_splice()) and privilege escalation inside userspace.

In this case, the affected files are in debugfs (and should therefore only
be accessible to root), and the read handlers check that *pos is zero
(meaning that at least sys_splice() can't trigger kernel memory
corruption). Because of the root requirement, this is not a security fix,
but rather a cleanup.

For the read handlers, fix it by using simple_read_from_buffer() instead
of custom logic. Add min() calls to the write handlers.

Fixes: 4a2da0b8c078 ("IB/mlx5: Add debug control parameters for congestion control")
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/cong.c |    9 +--------
 drivers/infiniband/hw/mlx5/mr.c   |   32 ++++++++------------------------
 2 files changed, 9 insertions(+), 32 deletions(-)

--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -359,9 +359,6 @@ static ssize_t get_param(struct file *fi
 	int ret;
 	char lbuf[11];
 
-	if (*pos)
-		return 0;
-
 	ret = mlx5_ib_get_cc_params(param->dev, param->port_num, offset, &var);
 	if (ret)
 		return ret;
@@ -370,11 +367,7 @@ static ssize_t get_param(struct file *fi
 	if (ret < 0)
 		return ret;
 
-	if (copy_to_user(buf, lbuf, ret))
-		return -EFAULT;
-
-	*pos += ret;
-	return ret;
+	return simple_read_from_buffer(buf, count, pos, lbuf, ret);
 }
 
 static const struct file_operations dbg_cc_fops = {
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -271,16 +271,16 @@ static ssize_t size_write(struct file *f
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
 	struct mlx5_ib_dev *dev = ent->dev;
-	char lbuf[20];
+	char lbuf[20] = {0};
 	u32 var;
 	int err;
 	int c;
 
-	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+	count = min(count, sizeof(lbuf) - 1);
+	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
 
 	c = order2idx(dev, ent->order);
-	lbuf[sizeof(lbuf) - 1] = 0;
 
 	if (sscanf(lbuf, "%u", &var) != 1)
 		return -EINVAL;
@@ -310,19 +310,11 @@ static ssize_t size_read(struct file *fi
 	char lbuf[20];
 	int err;
 
-	if (*pos)
-		return 0;
-
 	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->size);
 	if (err < 0)
 		return err;
 
-	if (copy_to_user(buf, lbuf, err))
-		return -EFAULT;
-
-	*pos += err;
-
-	return err;
+	return simple_read_from_buffer(buf, count, pos, lbuf, err);
 }
 
 static const struct file_operations size_fops = {
@@ -337,16 +329,16 @@ static ssize_t limit_write(struct file *
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
 	struct mlx5_ib_dev *dev = ent->dev;
-	char lbuf[20];
+	char lbuf[20] = {0};
 	u32 var;
 	int err;
 	int c;
 
-	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+	count = min(count, sizeof(lbuf) - 1);
+	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
 
 	c = order2idx(dev, ent->order);
-	lbuf[sizeof(lbuf) - 1] = 0;
 
 	if (sscanf(lbuf, "%u", &var) != 1)
 		return -EINVAL;
@@ -372,19 +364,11 @@ static ssize_t limit_read(struct file *f
 	char lbuf[20];
 	int err;
 
-	if (*pos)
-		return 0;
-
 	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->limit);
 	if (err < 0)
 		return err;
 
-	if (copy_to_user(buf, lbuf, err))
-		return -EFAULT;
-
-	*pos += err;
-
-	return err;
+	return simple_read_from_buffer(buf, count, pos, lbuf, err);
 }
 
 static const struct file_operations limit_fops = {


