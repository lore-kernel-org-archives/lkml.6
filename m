Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CF120836
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0QTMvYAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CF120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeH1SsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:48:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1SsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:48:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7SEstSo043295;
        Tue, 28 Aug 2018 14:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=qmg+QKVgvAhhraJjmQd5FZjz0lDaXu5Xkgd+Z6EqwSM=;
 b=0QTMvYAh1NXOE/NYq1iP+kaf3j6LJpFKbD+DkHy41BEeIW0QV3EpwdYK0TiZGpZTdGOn
 MA8iF1xvSKIqF3Xa2HC9nxzEiI+CO1XuS45XAkYPYSDJh9FDckF+KT5D5MprFuKNSmkk
 ML+PD0clMyL/FiJs0ESUObm7PdJ+Hp2tDcE27IHmVbMO5YsV0kmvulLpWX5LMtTHmdtR
 gRmXTTRWGCKMHvI/EvipUganzxpBX9D4vvQTNtZBD2qtL6MDOxb/zEvWnys0Ml8+Ax0N
 p7HDyXUX9L6RvN3mZ+1ikemenuAFC1HcOTGLdQXYqq1AIqZ4mjouv2zIj6Vy76aQe34z pQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m2yrq4af9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 14:56:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7SEu9qf031542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 14:56:09 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7SEu9jv003079;
        Tue, 28 Aug 2018 14:56:09 GMT
Received: from [10.211.202.81] (/10.211.202.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Aug 2018 07:56:09 -0700
From:   Joe Jin <joe.jin@oracle.com>
Subject: [PATCH V2] xen: export device state to sysfs
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Joe Jin <joe.jin@oracle.com>
Message-ID: <c7cfcd6d-5245-b82f-781f-32bddec5aeab@oracle.com>
Date:   Tue, 28 Aug 2018 07:56:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export device state to sysfs to allow for easier get device state.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 Documentation/ABI/stable/sysfs-bus-xen-backend | 9 +++++++++
 drivers/xen/xenbus/xenbus_probe.c              | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-xen-backend b/Documentation/ABI/stable/sysfs-bus-xen-backend
index 3d5951c8bf5f..e8b60bd766f7 100644
--- a/Documentation/ABI/stable/sysfs-bus-xen-backend
+++ b/Documentation/ABI/stable/sysfs-bus-xen-backend
@@ -73,3 +73,12 @@ KernelVersion:	3.0
 Contact:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 Description:
                 Number of sectors written by the frontend.
+
+What:		/sys/bus/xen-backend/devices/*/state
+Date:		August 2018
+KernelVersion:	4.19
+Contact:	Joe Jin <joe.jin@oracle.com>
+Description:
+                The state of the device. One of: 'Unknown',
+                'Initialising', 'Initialised', 'Connected', 'Closing',
+                'Closed', 'Reconfiguring', 'Reconfigured'.
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index f2088838f690..5b471889d723 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -402,10 +402,19 @@ static ssize_t modalias_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t state_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n",
+			xenbus_strstate(to_xenbus_device(dev)->state));
+}
+static DEVICE_ATTR_RO(state);
+
 static struct attribute *xenbus_dev_attrs[] = {
 	&dev_attr_nodename.attr,
 	&dev_attr_devtype.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_state.attr,
 	NULL,
 };
 
-- 
2.15.2 (Apple Git-101.1)

