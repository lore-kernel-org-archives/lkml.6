Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FE320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FE320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964939AbeFRIU3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:20:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964908AbeFRIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C89FDC83;
        Mon, 18 Jun 2018 08:20:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 115/279] i2c: sprd: Prevent i2c accesses after suspend is called
Date:   Mon, 18 Jun 2018 10:11:40 +0200
Message-Id: <20180618080613.572323919@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baolin Wang <baolin.wang@linaro.org>

[ Upstream commit da33aa03fa34c918faf2c371ebda0dd961d7ccb2 ]

Add one flag to indicate if the i2c controller has been in suspend state,
which can prevent i2c accesses after i2c controller is suspended following
system suspend.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-sprd.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -86,6 +86,7 @@ struct sprd_i2c {
 	u32 count;
 	int irq;
 	int err;
+	bool is_suspended;
 };
 
 static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
@@ -283,6 +284,9 @@ static int sprd_i2c_master_xfer(struct i
 	struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
 	int im, ret;
 
+	if (i2c_dev->is_suspended)
+		return -EBUSY;
+
 	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0)
 		return ret;
@@ -586,11 +590,23 @@ static int sprd_i2c_remove(struct platfo
 
 static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
 {
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+
+	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_dev->is_suspended = true;
+	i2c_unlock_adapter(&i2c_dev->adap);
+
 	return pm_runtime_force_suspend(pdev);
 }
 
 static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
 {
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+
+	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_dev->is_suspended = false;
+	i2c_unlock_adapter(&i2c_dev->adap);
+
 	return pm_runtime_force_resume(pdev);
 }
 


