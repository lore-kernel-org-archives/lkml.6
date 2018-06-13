Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 09C25C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE26F208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE26F208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935779AbeFMTgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:36:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935698AbeFMTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:36:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DJYJwD041721
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:36:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk5k8kbg6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:36:49 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 13:36:38 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 13:36:34 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DJaX1G9961918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 12:36:33 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D67C605F;
        Wed, 13 Jun 2018 13:36:33 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2490C605D;
        Wed, 13 Jun 2018 13:36:32 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 13:36:32 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v10 6/7] i2c: fsi: Add I2C master locking
Date:   Wed, 13 Jun 2018 14:36:18 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061319-8235-0000-0000-00000DBFA6C4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009184; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046494; UDB=6.00535962; IPR=6.00825469;
 MB=3.00021628; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 19:36:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061319-8236-0000-0000-0000418355D6
Message-Id: <1528918579-27602-7-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are many ports per master, each with it's own adapter and
chardev, we need some locking to prevent transfers from changing the
master state while other transfers are in progress.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 8c0a6cb..d6cab4b 100644
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
@@ -574,11 +576,14 @@ static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
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
@@ -586,15 +591,17 @@ static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
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
@@ -621,6 +628,7 @@ static int fsi_i2c_probe(struct device *dev)
 	if (!i2c)
 		return -ENOMEM;
 
+	mutex_init(&i2c->lock);
 	i2c->fsi = to_fsi_dev(dev);
 	INIT_LIST_HEAD(&i2c->ports);
 
-- 
1.8.3.1

