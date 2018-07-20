Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8792084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8792084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeGTNPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:15:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbeGTNPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:15:01 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 725A641C;
        Fri, 20 Jul 2018 12:27:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Vesker <valex@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.4 15/31] net/mlx5: Fix incorrect raw command length parsing
Date:   Fri, 20 Jul 2018 14:13:45 +0200
Message-Id: <20180720121340.705978361@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Vesker <valex@mellanox.com>

[ Upstream commit 603b7bcff824740500ddfa001d7a7168b0b38542 ]

The NULL character was not set correctly for the string containing
the command length, this caused failures reading the output of the
command due to a random length. The fix is to initialize the output
length string.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1126,7 +1126,7 @@ static ssize_t outlen_write(struct file
 {
 	struct mlx5_core_dev *dev = filp->private_data;
 	struct mlx5_cmd_debug *dbg = &dev->cmd.dbg;
-	char outlen_str[8];
+	char outlen_str[8] = {0};
 	int outlen;
 	void *ptr;
 	int err;
@@ -1141,8 +1141,6 @@ static ssize_t outlen_write(struct file
 	if (copy_from_user(outlen_str, buf, count))
 		return -EFAULT;
 
-	outlen_str[7] = 0;
-
 	err = sscanf(outlen_str, "%d", &outlen);
 	if (err < 0)
 		return err;


