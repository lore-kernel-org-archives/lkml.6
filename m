Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF28C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705B5208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0+uWJ7jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705B5208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeH0Wcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:32:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeH0Wcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:32:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7RIdCkn123670;
        Mon, 27 Aug 2018 18:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=BHfHQ2zP7db8AoAbqdF7OnoruUP4qI6BRvNgInJR0HA=;
 b=0+uWJ7jEdoMG9RZ0IK8oDR0rc+QZjziD1lF4ASVRgp8UZ/nffXNlw27/cCJYIHD1pVQu
 hATzxcBpJJ1nVSKWcNKOJOCSQ8+AOdRKhRmiNvqHNOJG5RPSK13bMhM6yhT1SfbZPagC
 G7vvI0242QMbiUhGe8mdYRPEYOOEJGBDbWC+ZeMRU2CcRs16ityHkgI/8hiIk+GgBk4d
 GJ01/O/pAMF9VOcDA8OKJZ6WiXN1C0GlCxNagerRj6KgLW40AXnppzH0R18qUvIdmkag
 mwNy2kvEhAK8bQej59BwsnZLh070tz74/apUf/Bt6U754zgLHctsXxvQRR5bcwVhA+Ka BQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2m2y2p7pph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 18:44:50 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7RIiiJE003769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 18:44:45 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7RIihIS009590;
        Mon, 27 Aug 2018 18:44:44 GMT
Received: from [10.211.202.81] (/10.211.202.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 11:44:43 -0700
From:   Joe Jin <joe.jin@oracle.com>
Subject: [PATCH] xen: export device state to sysfs
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Joe Jin <joe.jin@oracle.com>
Message-ID: <030d112d-991f-4591-7eeb-94432a277c71@oracle.com>
Date:   Mon, 27 Aug 2018 11:44:41 -0700
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
 engine=8.0.1-1807170000 definitions=main-1808270193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export device state to sysfs to allow for easier get device state.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Boris Ostrovsky <boris.ostrovsky@oracle.com>
Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 74888cacd0b0..52f99b80a1c0 100644
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

