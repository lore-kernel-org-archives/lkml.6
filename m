Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77500C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C3C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C3C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeLFNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:24:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11803 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727943AbeLFNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:24:04 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB6DLioP003599;
        Thu, 6 Dec 2018 14:23:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3w2s46ab-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Dec 2018 14:23:33 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F75841;
        Thu,  6 Dec 2018 13:23:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4BC92AAF;
        Thu,  6 Dec 2018 13:23:32 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 14:23:32 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 14:23:32 +0100
From:   David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Thread-Topic: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Thread-Index: AQHUjWbi+FUfeo4eoUu6YgNgwgJR0g==
Date:   Thu, 6 Dec 2018 13:23:32 +0000
Message-ID: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
In-Reply-To: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A51B9C2EFA6614BAFFAA4D04E97DAB8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2FsbGluZyBzdG1fdGhlcm1hbF9yZWFkX2ZhY3Rvcnlfc2V0dGluZ3MgYmVmb3JlIGNsb2NraW5n
DQppbnRlcm5hbCBwZXJpcGhlcmFsIGNhdXNlcyBiYWQgcmVnaXN0ZXIgdmFsdWVzIGFuZCBtYWtl
cw0KdGVtcGVyYXR1cmUgY29tcHV0YXRpb24gd3JvbmcuDQoNCkNhbGxpbmcgc3RtX3RoZXJtYWxf
cmVhZF9mYWN0b3J5X3NldHRpbmdzIGluc2lkZQ0Kc3RtX3RoZXJtYWxfcHJlcGFyZSBmaXhlcyB0
aGlzIHByb2JsZW0gYXMgaW50ZXJuYWwNCnBlcmlwaGVyYWwgaXMgd2VsbCBjbG9ja2VkIGF0IHRo
aXMgc3RhZ2UuDQoNClNpZ25lZC1vZmYtYnk6IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6IDxkYXZp
ZC5oZXJuYW5kZXpzYW5jaGV6QHN0LmNvbT4NCkZpeGVzOiAxZDY5MzE1NSAoInRoZXJtYWw6IGFk
ZCBzdG0zMiB0aGVybWFsIGRyaXZlciIpDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwv
c3Qvc3RtX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jDQppbmRl
eCA0NzYyM2RhLi5kYWExMjU3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90aGVybWFsL3N0L3N0bV90
aGVybWFsLmMNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jDQpAQCAtNTMy
LDYgKzUzMiwxMCBAQCBzdGF0aWMgaW50IHN0bV90aGVybWFsX3ByZXBhcmUoc3RydWN0IHN0bV90
aGVybWFsX3NlbnNvciAqc2Vuc29yKQ0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCiANCisJ
cmV0ID0gc3RtX3RoZXJtYWxfcmVhZF9mYWN0b3J5X3NldHRpbmdzKHNlbnNvcik7DQorCWlmIChy
ZXQpDQorCQlnb3RvIHRoZXJtYWxfdW5wcmVwYXJlOw0KKw0KIAlyZXQgPSBzdG1fdGhlcm1hbF9j
YWxpYnJhdGlvbihzZW5zb3IpOw0KIAlpZiAocmV0KQ0KIAkJZ290byB0aGVybWFsX3VucHJlcGFy
ZTsNCkBAIC02MzYsMTAgKzY0MCw2IEBAIHN0YXRpYyBpbnQgc3RtX3RoZXJtYWxfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJLyogUG9wdWxhdGUgc2Vuc29yICovDQogCXNl
bnNvci0+YmFzZSA9IGJhc2U7DQogDQotCXJldCA9IHN0bV90aGVybWFsX3JlYWRfZmFjdG9yeV9z
ZXR0aW5ncyhzZW5zb3IpOw0KLQlpZiAocmV0KQ0KLQkJcmV0dXJuIHJldDsNCi0NCiAJc2Vuc29y
LT5jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInBjbGsiKTsNCiAJaWYgKElTX0VSUihz
ZW5zb3ItPmNsaykpIHsNCiAJCWRldl9lcnIoJnBkZXYtPmRldiwgIiVzOiBmYWlsZWQgdG8gZmV0
Y2ggUENMSyBjbG9ja1xuIiwNCi0tIA0KMi43LjQNCg==
