Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CAAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FFE2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FFE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeIGPTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:19:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40639 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIGPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:19:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fyEAf-00031v-68; Fri, 07 Sep 2018 10:39:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: make sysfs error messages ratelimited
Date:   Fri,  7 Sep 2018 11:39:24 +0100
Message-Id: <20180907103924.17598-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It is possible to heavily spam the kernel logs with messages by
excessive reading of the mpt3sas sysfs files.  Make the error messages
ratelimited to reduce the spamming effect.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 5e8c059ce2c9..656cec5adb17 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2958,7 +2958,7 @@ _ctl_BRM_status_show(struct device *cdev, struct device_attribute *attr,
 	ssize_t rc = 0;
 
 	if (!ioc->is_warpdrive) {
-		pr_err(MPT3SAS_FMT "%s: BRM attribute is only for"
+		pr_err_ratelimited(MPT3SAS_FMT "%s: BRM attribute is only for"
 		    " warpdrive\n", ioc->name, __func__);
 		goto out;
 	}
@@ -3039,7 +3039,7 @@ _ctl_host_trace_buffer_size_show(struct device *cdev,
 	struct DIAG_BUFFER_START *request_data;
 
 	if (!ioc->diag_buffer[MPI2_DIAG_BUF_TYPE_TRACE]) {
-		pr_err(MPT3SAS_FMT
+		pr_err_ratelimited(MPT3SAS_FMT
 			"%s: host_trace_buffer is not registered\n",
 			ioc->name, __func__);
 		return 0;
@@ -3047,7 +3047,7 @@ _ctl_host_trace_buffer_size_show(struct device *cdev,
 
 	if ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_REGISTERED) == 0) {
-		pr_err(MPT3SAS_FMT
+		pr_err_ratelimited(MPT3SAS_FMT
 			"%s: host_trace_buffer is not registered\n",
 			ioc->name, __func__);
 		return 0;
@@ -3089,7 +3089,7 @@ _ctl_host_trace_buffer_show(struct device *cdev, struct device_attribute *attr,
 	u32 size;
 
 	if (!ioc->diag_buffer[MPI2_DIAG_BUF_TYPE_TRACE]) {
-		pr_err(MPT3SAS_FMT
+		pr_err_ratelimited(MPT3SAS_FMT
 			"%s: host_trace_buffer is not registered\n",
 			ioc->name, __func__);
 		return 0;
@@ -3097,7 +3097,7 @@ _ctl_host_trace_buffer_show(struct device *cdev, struct device_attribute *attr,
 
 	if ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_REGISTERED) == 0) {
-		pr_err(MPT3SAS_FMT
+		pr_err_ratelimited(MPT3SAS_FMT
 			"%s: host_trace_buffer is not registered\n",
 			ioc->name, __func__);
 		return 0;
-- 
2.17.1

