Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5225C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3C21718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC3C21718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeHHREv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727412AbeHHREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:04:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78Ei8aG101575
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 10:44:50 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kr1w2a46a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:44:50 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 10:44:49 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 10:44:45 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78Eih1Z11075988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 14:44:43 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64CF028058;
        Wed,  8 Aug 2018 10:43:31 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B46C28059;
        Wed,  8 Aug 2018 10:43:30 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.187.56])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Aug 2018 10:43:30 -0400 (EDT)
From:   Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com
Subject: [PATCH v8 03/22] s390/zcrypt: Show load of cards and queues in sysfs
Date:   Wed,  8 Aug 2018 10:44:13 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080814-0072-0000-0000-0000038D753F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070983; UDB=6.00551366; IPR=6.00850513;
 MB=3.00022589; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 14:44:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080814-0073-0000-0000-0000490268C4
Message-Id: <1533739472-7172-4-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=854 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Freudenberger <freude@de.ibm.com>

Show the current load value of cards and queues in sysfs.
The load value for each card and queue is maintained by
the zcrypt device driver for dispatching and load
balancing requests over the available devices.

This patch provides the load value to userspace via a
new read only sysfs attribute 'load' per card and queue.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/zcrypt_card.c  |   12 ++++++++++++
 drivers/s390/crypto/zcrypt_queue.c |   12 ++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index 233e1e6..da2c8df 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -83,9 +83,21 @@ static ssize_t zcrypt_card_online_store(struct device *dev,
 static DEVICE_ATTR(online, 0644, zcrypt_card_online_show,
 		   zcrypt_card_online_store);
 
+static ssize_t zcrypt_card_load_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct zcrypt_card *zc = to_ap_card(dev)->private;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&zc->load));
+}
+
+static DEVICE_ATTR(load, 0444, zcrypt_card_load_show, NULL);
+
 static struct attribute *zcrypt_card_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_online.attr,
+	&dev_attr_load.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/crypto/zcrypt_queue.c b/drivers/s390/crypto/zcrypt_queue.c
index 720434e..91a52f2 100644
--- a/drivers/s390/crypto/zcrypt_queue.c
+++ b/drivers/s390/crypto/zcrypt_queue.c
@@ -75,8 +75,20 @@ static ssize_t zcrypt_queue_online_store(struct device *dev,
 static DEVICE_ATTR(online, 0644, zcrypt_queue_online_show,
 		   zcrypt_queue_online_store);
 
+static ssize_t zcrypt_queue_load_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct zcrypt_queue *zq = to_ap_queue(dev)->private;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&zq->load));
+}
+
+static DEVICE_ATTR(load, 0444, zcrypt_queue_load_show, NULL);
+
 static struct attribute *zcrypt_queue_attrs[] = {
 	&dev_attr_online.attr,
+	&dev_attr_load.attr,
 	NULL,
 };
 
-- 
1.7.1

