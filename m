Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CBFECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CB7214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CB7214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeIREl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbeIREl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:27 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4683707;
        Mon, 17 Sep 2018 23:11:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        Xiubo Li <xiubli@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 098/158] scsi: tcmu: do not set max_blocks if data_bitmap has been setup
Date:   Tue, 18 Sep 2018 00:42:08 +0200
Message-Id: <20180917211715.830553240@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit c97840c84f5a4362a596a2751e9245a979377a16 ]

This patch prevents a bug where data_bitmap is allocated in
tcmu_configure_device, userspace changes the max_blocks setting, the device
is mapped to a LUN, then we try to access the data_bitmap based on the new
max_blocks limit which may now be out of range.

To prevent this, we just check if data_bitmap has been setup. If it has
then we fail the max_blocks update operation.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_user.c |   73 ++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1745,9 +1745,11 @@ static int tcmu_configure_device(struct
 
 	info = &udev->uio_info;
 
+	mutex_lock(&udev->cmdr_lock);
 	udev->data_bitmap = kcalloc(BITS_TO_LONGS(udev->max_blocks),
 				    sizeof(unsigned long),
 				    GFP_KERNEL);
+	mutex_unlock(&udev->cmdr_lock);
 	if (!udev->data_bitmap) {
 		ret = -ENOMEM;
 		goto err_bitmap_alloc;
@@ -1957,7 +1959,7 @@ static match_table_t tokens = {
 	{Opt_hw_block_size, "hw_block_size=%u"},
 	{Opt_hw_max_sectors, "hw_max_sectors=%u"},
 	{Opt_nl_reply_supported, "nl_reply_supported=%d"},
-	{Opt_max_data_area_mb, "max_data_area_mb=%u"},
+	{Opt_max_data_area_mb, "max_data_area_mb=%d"},
 	{Opt_err, NULL}
 };
 
@@ -1985,13 +1987,48 @@ static int tcmu_set_dev_attrib(substring
 	return 0;
 }
 
+static int tcmu_set_max_blocks_param(struct tcmu_dev *udev, substring_t *arg)
+{
+	int val, ret;
+
+	ret = match_int(arg, &val);
+	if (ret < 0) {
+		pr_err("match_int() failed for max_data_area_mb=. Error %d.\n",
+		       ret);
+		return ret;
+	}
+
+	if (val <= 0) {
+		pr_err("Invalid max_data_area %d.\n", val);
+		return -EINVAL;
+	}
+
+	mutex_lock(&udev->cmdr_lock);
+	if (udev->data_bitmap) {
+		pr_err("Cannot set max_data_area_mb after it has been enabled.\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	udev->max_blocks = TCMU_MBS_TO_BLOCKS(val);
+	if (udev->max_blocks > tcmu_global_max_blocks) {
+		pr_err("%d is too large. Adjusting max_data_area_mb to global limit of %u\n",
+		       val, TCMU_BLOCKS_TO_MBS(tcmu_global_max_blocks));
+		udev->max_blocks = tcmu_global_max_blocks;
+	}
+
+unlock:
+	mutex_unlock(&udev->cmdr_lock);
+	return ret;
+}
+
 static ssize_t tcmu_set_configfs_dev_params(struct se_device *dev,
 		const char *page, ssize_t count)
 {
 	struct tcmu_dev *udev = TCMU_DEV(dev);
 	char *orig, *ptr, *opts, *arg_p;
 	substring_t args[MAX_OPT_ARGS];
-	int ret = 0, token, tmpval;
+	int ret = 0, token;
 
 	opts = kstrdup(page, GFP_KERNEL);
 	if (!opts)
@@ -2044,37 +2081,7 @@ static ssize_t tcmu_set_configfs_dev_par
 				pr_err("kstrtoint() failed for nl_reply_supported=\n");
 			break;
 		case Opt_max_data_area_mb:
-			if (dev->export_count) {
-				pr_err("Unable to set max_data_area_mb while exports exist\n");
-				ret = -EINVAL;
-				break;
-			}
-
-			arg_p = match_strdup(&args[0]);
-			if (!arg_p) {
-				ret = -ENOMEM;
-				break;
-			}
-			ret = kstrtoint(arg_p, 0, &tmpval);
-			kfree(arg_p);
-			if (ret < 0) {
-				pr_err("kstrtoint() failed for max_data_area_mb=\n");
-				break;
-			}
-
-			if (tmpval <= 0) {
-				pr_err("Invalid max_data_area %d\n", tmpval);
-				ret = -EINVAL;
-				break;
-			}
-
-			udev->max_blocks = TCMU_MBS_TO_BLOCKS(tmpval);
-			if (udev->max_blocks > tcmu_global_max_blocks) {
-				pr_err("%d is too large. Adjusting max_data_area_mb to global limit of %u\n",
-				       tmpval,
-				       TCMU_BLOCKS_TO_MBS(tcmu_global_max_blocks));
-				udev->max_blocks = tcmu_global_max_blocks;
-			}
+			ret = tcmu_set_max_blocks_param(udev, &args[0]);
 			break;
 		default:
 			break;


