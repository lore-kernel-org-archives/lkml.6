Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE6420877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE6420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGQQEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:04:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729683AbeGQQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:04:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HFTKWd056936
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:31:26 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9h8hnus7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:31:26 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 09:31:25 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 09:31:22 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HFVLd410093026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 08:31:21 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1535213605D;
        Tue, 17 Jul 2018 09:31:21 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CC94136053;
        Tue, 17 Jul 2018 09:31:20 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 09:31:20 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>
Subject: [PATCH v12 6/8] i2c: fsi: Add I2C master locking
Date:   Tue, 17 Jul 2018 10:31:04 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071715-0012-0000-0000-0000168D3293
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009380; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062145; UDB=6.00545317; IPR=6.00840002;
 MB=3.00022173; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 15:31:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071715-0013-0000-0000-000053B481D5
Message-Id: <1531841466-9833-7-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>

Since there are many ports per master, each with it's own adapter and
chardev, we need some locking to prevent transfers from changing the
master state while other transfers are in progress.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/i2c/busses/i2c-fsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 45a6ebd..27d74a9 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 
@@ -148,6 +149,7 @@ struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
 	struct list_head	ports;
+	struct mutex		lock;
 };
 
 struct fsi_i2c_port {
@@ -486,11 +488,14 @@ static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	int i, rc;
 	unsigned long start_time;
 	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *master = port->master;
 	struct i2c_msg *msg;
 
+	mutex_lock(&master->lock);
+
 	rc = fsi_i2c_set_port(port);
 	if (rc)
-		return rc;
+		goto unlock;
 
 	for (i = 0; i < num; i++) {
 		msg = msgs + i;
@@ -498,15 +503,17 @@ static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 		rc = fsi_i2c_start(port, msg, i == num - 1);
 		if (rc)
-			return rc;
+			goto unlock;
 
 		rc = fsi_i2c_wait(port, msg,
 				  adap->timeout - (jiffies - start_time));
 		if (rc)
-			return rc;
+			goto unlock;
 	}
 
-	return num;
+unlock:
+	mutex_unlock(&master->lock);
+	return rc ? : num;
 }
 
 static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
@@ -532,6 +539,7 @@ static int fsi_i2c_probe(struct device *dev)
 	if (!i2c)
 		return -ENOMEM;
 
+	mutex_init(&i2c->lock);
 	i2c->fsi = to_fsi_dev(dev);
 	INIT_LIST_HEAD(&i2c->ports);
 
-- 
1.8.3.1

