Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2173C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899D02070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfADNrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:47:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59342 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbfADNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:47:46 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x04DfW9t004402;
        Fri, 4 Jan 2019 14:47:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pp0pm8m79-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 04 Jan 2019 14:47:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E445A34;
        Fri,  4 Jan 2019 13:47:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C3BE9530D;
        Fri,  4 Jan 2019 13:47:31 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019
 14:47:31 +0100
Received: from localhost (10.129.4.161) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019 14:47:31
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 1/2] mailbox: mailbox-test: fix debugfs in multi-instances
Date:   Fri, 4 Jan 2019 14:47:15 +0100
Message-ID: <1546609637-6411-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.161]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-04_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create one debug entry directory per instance to support the multi
instantiation.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/mailbox/mailbox-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 58bfafc..4e2bfba 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -31,7 +31,6 @@
 				 (MBOX_MAX_MSG_LEN / MBOX_BYTES_PER_LINE))
 
 static bool mbox_data_ready;
-static struct dentry *root_debugfs_dir;
 
 struct mbox_test_device {
 	struct device		*dev;
@@ -45,6 +44,7 @@ struct mbox_test_device {
 	spinlock_t		lock;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
+	struct dentry		*root_debugfs_dir;
 };
 
 static ssize_t mbox_test_signal_write(struct file *filp,
@@ -262,16 +262,16 @@ static int mbox_test_add_debugfs(struct platform_device *pdev,
 	if (!debugfs_initialized())
 		return 0;
 
-	root_debugfs_dir = debugfs_create_dir("mailbox", NULL);
-	if (!root_debugfs_dir) {
+	tdev->root_debugfs_dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
+	if (!tdev->root_debugfs_dir) {
 		dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
 		return -EINVAL;
 	}
 
-	debugfs_create_file("message", 0600, root_debugfs_dir,
+	debugfs_create_file("message", 0600, tdev->root_debugfs_dir,
 			    tdev, &mbox_test_message_ops);
 
-	debugfs_create_file("signal", 0200, root_debugfs_dir,
+	debugfs_create_file("signal", 0200, tdev->root_debugfs_dir,
 			    tdev, &mbox_test_signal_ops);
 
 	return 0;
@@ -416,7 +416,7 @@ static int mbox_test_remove(struct platform_device *pdev)
 {
 	struct mbox_test_device *tdev = platform_get_drvdata(pdev);
 
-	debugfs_remove_recursive(root_debugfs_dir);
+	debugfs_remove_recursive(tdev->root_debugfs_dir);
 
 	if (tdev->tx_channel)
 		mbox_free_channel(tdev->tx_channel);
-- 
2.7.4

