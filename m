Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F14C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B9420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfANOmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:42:47 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4115 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbfANOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:42:45 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EEaY84017086;
        Mon, 14 Jan 2019 15:42:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pybyw8mua-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 15:42:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06F2931;
        Mon, 14 Jan 2019 14:42:41 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D86F853D0;
        Mon, 14 Jan 2019 14:42:40 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan
 2019 15:42:40 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan 2019 15:42:39
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 3/7] base: Add calls to domains controller
Date:   Mon, 14 Jan 2019 15:41:58 +0100
Message-ID: <20190114144202.27315-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190114144202.27315-1-benjamin.gaignard@st.com>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid modifying all the drivers call domainsctrl_set_default_config
before probe to apply the configuration define in device node (if any).

When unbinding the device try to apply configuration named "unbind".

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/base/dd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8ac10af17c00..2880fe893096 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/domainsctrl.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
@@ -478,6 +479,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 re_probe:
 	dev->driver = drv;
 
+	ret = domainsctrl_set_default_config(dev);
+	if (ret)
+		goto domainctrl_failed;
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
@@ -548,6 +553,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 pinctrl_bind_failed:
+	domainsctrl_set_config_by_name(dev, "unbind");
+domainctrl_failed:
 	device_links_no_driver(dev);
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
@@ -970,6 +977,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		device_links_driver_cleanup(dev);
 		arch_teardown_dma_ops(dev);
 
+		domainsctrl_set_config_by_name(dev, "unbind");
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
-- 
2.15.0

