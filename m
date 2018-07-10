Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA37A208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA37A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933248AbeGJJyM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:54:12 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:64394 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933112AbeGJJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:54:08 -0400
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,334,1526335200"; 
   d="scan'208";a="34013273"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v4 1/5] rtc: sysfs: facilitate attribute add to rtc device
Thread-Topic: [PATCH v4 1/5] rtc: sysfs: facilitate attribute add to rtc
 device
Thread-Index: AQHUGDKQ7gjvnwME1UyQbN8b3dTaxg==
Date:   Tue, 10 Jul 2018 09:44:15 +0000
Message-ID: <20180710090710.9066-2-Denis.Osterland@diehl.com>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
In-Reply-To: <20180710090710.9066-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: PkB65aL1SqtESF35r/jQn2OESzdj0IA8yu1PnMgu0XgzlQ5mQv/arVdZ+xMfDDY0
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Osterland <Denis.Osterland@diehl.com>

This patches addresses following problem:
rtc_allocate_device
devm_device_add_group  <-- kernel oops / null pointer, because
			sysfs entry does not yet exist
rtc_register_device
rc = devm_device_add_group
if (rc)
	return rc;     <-- forbidden to return error code
			after device register

In case groups were not yet registered (kobj.state_in_sysfs == 0)
rtc_add_group just addes given group to dev.groups,
otherwise it uses devm_device_add_group.

Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-core.h  |  6 ++++++
 drivers/rtc/rtc-sysfs.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index 0abf98983e13..81d1c3ce7a96 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -40,9 +40,15 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
 
 #ifdef CONFIG_RTC_INTF_SYSFS
 const struct attribute_group **rtc_get_dev_attribute_groups(void);
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
 #else
 static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
 	return NULL;
 }
+static inline
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
+{
+	return 0;
+}
 #endif
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 454da38c6012..9a177b8f761b 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -317,3 +317,42 @@ const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
 	return rtc_attr_groups;
 }
+
+static size_t rtc_group_count(struct rtc_device *rtc)
+{
+	const struct attribute_group **groups = rtc->dev.groups;
+	size_t cnt = 0;
+
+	if (groups)
+		for (; *groups; groups++)
+			cnt++;
+
+	return cnt;
+}
+
+static inline int
+__rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
+{
+	size_t cnt = rtc_group_count(rtc);
+	const struct attribute_group **groups, **old;
+
+	groups = devm_kzalloc(&rtc->dev, (cnt+2)*sizeof(*groups), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(groups))
+		return PTR_ERR(groups);
+	memcpy(groups, rtc->dev.groups, cnt*sizeof(*groups));
+	groups[cnt] = grp;
+
+	old = rtc->dev.groups;
+	rtc->dev.groups = groups;
+	if (old != rtc_attr_groups)
+		devm_kfree(&rtc->dev, old);
+
+	return 0;
+}
+
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
+{
+	return rtc->dev.kobj.state_in_sysfs ?
+		devm_device_add_group(&rtc->dev, grp) :
+		__rtc_add_group(rtc, grp);
+}
-- 
2.18.0



Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
