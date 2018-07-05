Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9405BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD8C219CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD8C219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeGEO0J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:26:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47495 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753809AbeGEO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:26:05 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65EO86E025421;
        Thu, 5 Jul 2018 16:25:57 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k0dnr1mxe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 16:25:57 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B15613A;
        Thu,  5 Jul 2018 14:25:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 917B72064;
        Thu,  5 Jul 2018 14:25:56 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 16:25:56 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 16:25:56 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 1/3] driver core: Add device_link_remove function
Thread-Topic: [PATCH 1/3] driver core: Add device_link_remove function
Thread-Index: AQHUFGwWCME9OX6GqUWbR0NHHzmfQA==
Date:   Thu, 5 Jul 2018 14:25:56 +0000
Message-ID: <1530800748-7300-2-git-send-email-p.paillet@st.com>
References: <1530800748-7300-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1530800748-7300-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

Device_link_remove uses the same arguments than device_link_add. The Goal
is to avoid storing the link pointer.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/base/core.c    | 30 ++++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 36622b5..3b380b1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -365,6 +365,36 @@ void device_link_del(struct device_link *link)
 }
 EXPORT_SYMBOL_GPL(device_link_del);
 
+/**
+ * device_link_remove - remove a link between two devices.
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ *
+ * The caller must ensure proper synchronization of this function with runtime
+ * PM.
+ */
+void device_link_remove(void *consumer, struct device *supplier)
+{
+	struct device_link *link;
+
+	if (WARN_ON(consumer == supplier))
+		return;
+
+	device_links_write_lock();
+	device_pm_lock();
+
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer == consumer) {
+			kref_put(&link->kref, __device_link_del);
+			break;
+		}
+	}
+
+	device_pm_unlock();
+	device_links_write_unlock();
+}
+EXPORT_SYMBOL_GPL(device_link_remove);
+
 static void device_links_missing_supplier(struct device *dev)
 {
 	struct device_link *link;
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69d..9c1c3b1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1316,6 +1316,7 @@ extern void devm_device_remove_group(struct device *dev,
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+void device_link_remove(void *consumer, struct device *supplier);
 
 #ifdef CONFIG_PRINTK
 
-- 
1.9.1
