Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCE3C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207B12146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ewJ6vG64";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Zy+ktfX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfAKKMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:12:44 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38878 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727653AbfAKKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:12:43 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BA8epO013524;
        Fri, 11 Jan 2019 02:12:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=qq0DwHQMHRCPXAN7rSRp5gcFVT3JiekM24lejLqvTgc=;
 b=ewJ6vG64i6W1lA+XZADkFMsbqyp94a7RAdSHh3jfezAWGMgXaoK0Fdo+nOjq2o6yXevA
 rpewcr2NUqqzvD6pL00p5LdhWlj2sFj50oEsNm2dJXo7Eccs3fxqRw06LsdDy1YEtMLI
 7CPYyPQbkjrwkbW4v/aarKi5pENUjYd3Xg3dhZsgRJbuEO7m5GWZhyZg4sAQRfpfGGbV
 wMIB3dlu4Mk1muFLWmW4KlrEo/MBIHJ9wRBaSyqnvK4DZT1XMl4BUmVPhkgEGNmA3vt7
 v0F1PVUrShKGuYfQqYhB2E+WlXuXTFuZfJCnpNmkIfwMT0qyil5kfnAQ2erYle+Zsa8i tg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pts22cuwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 02:12:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq0DwHQMHRCPXAN7rSRp5gcFVT3JiekM24lejLqvTgc=;
 b=Zy+ktfX+nBhOM22JuBN39D2vwKWTwlJIYJl5alUBZ7vVE6CXz6CeLUl3nOAxQnjKaiGUYgtJLePDxZyZPg/l3Qi1CIHUii3eW6gd1AWI+kGiE//2IRe4ZSB6C8tkSIbvbmt83ImDJxL35B6QqT75xBRZtwaSS1cifXEaSXGZTc0=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB2662.namprd07.prod.outlook.com (10.166.213.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 10:12:14 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::9a1:e7fe:86e:b12a]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::9a1:e7fe:86e:b12a%7]) with mapi id 15.20.1495.011; Fri, 11 Jan 2019
 10:12:13 +0000
From:   Janek Kotas <jank@cadence.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Janek Kotas <jank@cadence.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rtc: Add Cadence RTC driver
Thread-Topic: [PATCH 2/2] rtc: Add Cadence RTC driver
Thread-Index: AQHUp0znDHbfVJeEP0SS9JKmD/ifJqWpGLoAgADE6AA=
Date:   Fri, 11 Jan 2019 10:12:13 +0000
Message-ID: <8333BCFF-BB5A-454E-AC3C-3E89E720526A@global.cadence.com>
References: <20190108122242.12411-1-jank@cadence.com>
 <20190108122242.12411-3-jank@cadence.com> <20190110222726.GI2362@piout.net>
In-Reply-To: <20190110222726.GI2362@piout.net>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2662;20:S7A69XHK9HoGnBxYWx1kuK2fcSVqYwRIMY+KbsOHqcyl4CP6WoAvZrK1UGfG3o7KYPv+vQQXmhNZqP6qi7UnR2oCoL8sjCIpCSlxZaNwuiitKjRhH8E6YPuejU2pVbSD7CPCGw/Qoi/98Qh5BqgiUjwzySMTSs3pAMtJGxgVf+tIWmxuoMnDgeAPJ/RDg5zXpFO9FDr0zix4/8J6y6E/KiYrJoKdVDaXbe59FIlCx7XU+RItfSd4D9731x+Lij/Y
x-ms-office365-filtering-correlation-id: 1c011d68-109d-4309-64d0-08d677ad4201
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2662;
x-ms-traffictypediagnostic: CO2PR07MB2662:
x-microsoft-antispam-prvs: <CO2PR07MB266261D2B6583B1CE4C6B6D4D0850@CO2PR07MB2662.namprd07.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(36092001)(478600001)(81166006)(14454004)(6512007)(8936002)(8676002)(5660300001)(81156014)(6116002)(3846002)(71200400001)(71190400001)(83716004)(53936002)(66066001)(86362001)(99286004)(6246003)(6436002)(256004)(14444005)(97736004)(6916009)(486006)(6506007)(76176011)(316002)(53546011)(11346002)(6486002)(102836004)(54906003)(25786009)(446003)(26005)(106356001)(345774005)(2906002)(4326008)(186003)(7736002)(305945005)(33656002)(476003)(68736007)(82746002)(229853002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2662;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YlZmtCiWsk4XsZx5Zq+LOYvw60+vCiwoQN+uD+tFGtChU3rryAUpGimpIFHA0/aV814FJJ+NIwKUWx33hvg24o/mQAuVT7b9IjmuBTaw1PpcFulTO5TyXoQDbsuJMeekvie3vesj0PbqCY6ApqT9kY/9hgUcPmOYX1bbX+KYASZooD7vjSVav0Ys+aB2fEds8mSAIieOE/iK8Qa8fczeFsNJmP0CFnSUS3qNRfruFktcvmURhOJ85tu8dQFI4TjL8Y+LCW+CyDjh/ykKpqHKvi2KsypOh1yfAqlyB5WW4/i3woehmvqCUs8wlRVTe9GizmATTdrx+Q7UW/SUi9ZvLlmEW+vZHFEWqX2TJnRFSgAjMl+TD+WbYF0hJUryDeDmSUm02ilL4r1aXlfXnLoaCXNI6Q4vKpEZ/yYHeC32rXU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F292B8D4FC2C43AA89EAD9DC299FC1@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c011d68-109d-4309-64d0-08d677ad4201
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 10:12:13.8307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2662
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gT24gMTAgSmFu
IDIwMTksIGF0IDIzOjI3LCBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9v
dGxpbi5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiAwOC8wMS8yMDE5IDEyOjIy
OjQyKzAwMDAsIEphbiBLb3RhcyB3cm90ZToNCj4+IGRyaXZlcnMvcnRjL0tjb25maWcgICAgICAg
fCAgMTAgKysNCj4+IGRyaXZlcnMvcnRjL01ha2VmaWxlICAgICAgfCAgIDEgKw0KPj4gZHJpdmVy
cy9ydGMvcnRjLWNhZGVuY2UuYyB8IDQwNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+IA0KPiBJIHdvdWxkIHByZWZlciBhIG5hbWUgdGhhdCBpcyBhIGJp
dCBsZXNzIGdlbmVyaWMsIHVubGVzcyB5b3UgY2FuDQo+IGd1YXJhbnRlZSB0aGlzIGRyaXZlciB3
aWxsIGJlIGFibGUgdG8gaGFuZGxlIGV2ZXJ5IFJUQ3MgZnJvbSBDYWRlbmNlLg0KDQpZZXMsIHRo
YXTigJlzIHRoZSBvbmx5IElQIHRoYXQgaXMgYmVpbmcgc29sZC4NCkl0IHdhcyBkZXNpZ25lZCBh
IGxvbmcgdGltZSBhZ28sIGl04oCZcyBub3QgYmVpbmcgYWN0aXZlbHkgZGV2ZWxvcGVkDQppbiB0
ZXJtcyBvZiBuZXcgZmVhdHVyZXMuDQoNCj4+ICtzdGF0aWMgaW50IGNkbnNfcnRjX2FsYXJtX2ly
cV9lbmFibGUoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgZW5hYmxlZCkNCj4+ICt7
DQo+PiArCXN0cnVjdCBjZG5zX3J0YyAqY3J0YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPj4g
Kw0KPj4gKwlpZiAoZW5hYmxlZCkgew0KPj4gKwkJd3JpdGVsKChDRE5TX1JUQ19BRUlfU0VDIHwg
Q0ROU19SVENfQUVJX01JTiB8IENETlNfUlRDX0FFSV9IT1VSDQo+PiArCQkJfCBDRE5TX1JUQ19B
RUlfREFURSB8IENETlNfUlRDX0FFSV9TRUMpLA0KPiANCj4gQ0ROU19SVENfQUVJX1NFQyBpcyB1
c2VkIHR3aWNlIGhlcmUuDQoNClRoYW5rcyBmb3Igc3BvdHRpbmcgdGhhdCwgSeKAmWxsIGZpeCBp
dC4NCg0KPj4gDQo+PiArCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgY3J0Yy0+
aXJxLA0KPj4gKwkJCSAgICAgICBjZG5zX3J0Y19pcnFfaGFuZGxlciwgMCwNCj4+ICsJCQkgICAg
ICAgZGV2X25hbWUoJnBkZXYtPmRldiksICZwZGV2LT5kZXYpOw0KPj4gKwlpZiAocmV0KSB7DQo+
PiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQo+PiArCQkJIlVuYWJsZSB0byByZXF1ZXN0IGludGVy
cnVwdCBmb3IgdGhlIGRldmljZSwgJWRcbiIsDQo+PiArCQkJcmV0KTsNCj4+ICsJCWdvdG8gZXJy
X2Rpc2FibGVfcmVmX2NsazsNCj4+ICsJfQ0KPj4gKw0KPiANCj4gWW91IHNob3VsZCB1c2UgZGV2
bV9ydGNfYWxsb2NhdGVfZGV2aWNlIHRvIGFsbG9jYXRlIGNydGMtPnJ0Y19kZXYgYmVmb3JlDQo+
IHJlcXVlc3RpbmcgdGhlIElSUS4gRWxzZSwgdGhpcyBsZWF2ZXMgYSByYWNlIGNvbmRpdGlvbiBv
cGVuLg0KDQpPaywgSeKAmWxsIGZpeCBpdC4NCg0KPiBBbHNvLCBwbGVhc2Ugc2V0IGNydGMtPnJ0
Y19kZXYtPnJhbmdlX21pbiBhbmQgY3J0Yy0+cnRjX2Rldi0+cmFuZ2VfbWF4DQo+IGFjY29yZGlu
ZyB0byB0aGUgZnVsbHkgY29udGlndW91cyByYW5nZSBvZiB0aW1lIHRoYXQgaXMgc3VwcG9ydGVk
IGJ5IHRoZQ0KPiBSVEMuIA0KDQpJ4oCZbGwgYWRkIGl0LCB0aGFua3MgZm9yIHBvaW50aW5nIGl0
IG91dC4NCg0KPj4gKwkvKiBBbHdheXMgdXNlIDI0LWhvdXIgbW9kZSAqLw0KPj4gKwl3cml0ZWwo
MCwgY3J0Yy0+cmVncyArIENETlNfUlRDX0hNUik7DQo+PiArDQo+PiArCWRldmljZV9pbml0X3dh
a2V1cCgmcGRldi0+ZGV2LCAxKTsNCj4+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgY3J0
Yyk7DQo+PiArCWNkbnNfcnRjX3NldF9lbmFibGVkKGNydGMsIHRydWUpOw0KPiANCj4gSXMgdGhh
dCByZWFsbHkgbmVjZXNzYXJ5PyBJIGd1ZXNzIHlvdSBjb3VsZCBjaGVjayB3aGV0aGVyIGl0IGhh
cyBhbHJlYWR5DQo+IGJlZW4gZW5hYmxlZCB0byBrbm93IHdoZXRoZXIgdGhlIGN1cnJlbnRseSBz
ZXQgdGltZSBpcyB2YWxpZCBzbw0KPiBjZG5zX3J0Y19yZWFkX3RpbWUgY291bGQgcmV0dXJuIC1F
SU5WQUwgd2hlbiBpdCBrbm93cyBpdCBpc24ndCB2YWxpZC4NCj4gY2Ruc19ydGNfc2V0X3RpbWUg
d2lsbCBlbmFibGUgdGhlIFJUQyBvbmNlIHRoZSB0aW1lIGhhcyBiZWVuIHNldCBhbnl3YXkuDQoN
ClRoYXTigJlzIGEgZ29vZCBpZGVhLCBJ4oCZbGwgYWRkIGl0Lg0KDQo+PiArc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgY2Ruc19ydGNfb2ZfbWF0Y2hbXSA9IHsNCj4+ICsJeyAuY29t
cGF0aWJsZSA9ICJjZG5zLHJ0Yy1yMTA5djMiIH0sDQo+IA0KPiBJcyByMTA5djMgYW4gSVAgbmFt
ZSBvciBhIHJldmlzaW9uPw0KDQpJdOKAmXMgYSByZXZpc2lvbi4NCg0KPiAtLSANCj4gQWxleGFu
ZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVl
cmluZw0KDQpSZWdhcmRzLA0KSmFuDQoNCg==
