Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7743BC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DD221582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jk1cQGiz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ExRKgP2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DD221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeKOSeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:34:37 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52356 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728519AbeKOSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:34:36 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAF8Ls6G002801;
        Thu, 15 Nov 2018 00:27:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=lxWpQkkMIOdx1ZtRV5+fXcI3J21Ix+u0vjYaPwv8OtQ=;
 b=jk1cQGizs82iOLajJxB200swTRNj8T9Zlqp/BqYdKLEgwXmbynZ6LHYki2dIkOYQg3Wi
 XXLfYXd8vMmfLvP1REXEULlfZ1waF2UBHchzLnsv+b5dcD4WYad1vjC10CrJgGv/1mli
 Gr7wz5Quv+gPc0dfd5aZ1xO18jLzMo719MQeXxmhdLj7KOhuf3V7hyIBAs55DsWj+APA
 K5StFb4x1xkLkpNzgRx77nCEW/76bG9heGu/Sb2YUS8fzkSwWGe4vPPHCjRS63DB07pX
 LLotqHBMn6rF61Xmc1/F0S0fsBbHmk0lGzU2JD8Kliurl9LAxglet6g3hwjGOZgT3zhd Hw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0120.outbound.protection.outlook.com [207.46.163.120])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nr7c191s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Nov 2018 00:27:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxWpQkkMIOdx1ZtRV5+fXcI3J21Ix+u0vjYaPwv8OtQ=;
 b=ExRKgP2s8ss34zlpWRcnmw6CAXk5ydabfQeJGC4irqVPYG7w89rzxjQOoyqqKrEaatCfzuK+ayuN7dnmoToXSIEC/qIFiGQL7ahKoss0rytWVArN8Hjm1bRSY5NYxga5ncBB1wvpZnqP0Be6tWXMD/NIJ5MfKWzOLmr9joX2kMU=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB2725.namprd07.prod.outlook.com (10.166.200.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Thu, 15 Nov 2018 08:27:16 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc%5]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 08:27:16 +0000
From:   Janek Kotas <jank@cadence.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Thread-Topic: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Thread-Index: AQHUfC4oeu2mh+SnqkeKZTRguLQQtKVP18OAgACp5gA=
Date:   Thu, 15 Nov 2018 08:27:15 +0000
Message-ID: <CAE55F09-516A-4737-8F74-07BBA3AF5737@global.cadence.com>
References: <D3711617-229C-4FA5-9E73-A7A3C025893B@global.cadence.com>
 <154223394933.88331.14659021245427374668@swboyd.mtv.corp.google.com>
In-Reply-To: <154223394933.88331.14659021245427374668@swboyd.mtv.corp.google.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2725;20:PueP4BMsm6LadfjqT6y8HjMvDn9u5UqQOYxERsbTIyzyPiTnEfEem81ndwMjt1tltMDBV20/qOlMib9KS0gMLXhCaRIuztkdSKdtUsdmdoe918iKJxSYZi9pPyJyICQwxwYMarVdWl+tyu3ke/tSkKBeZ39RZ6BwMT44RG8eaxotXktmqBT003NoWhU75sj/3FnvKsrvLfGxkx/Lfd/32M1vcgJXaQQWQTRwz89W2K6NerfkCUWTdM0JfuyhEk47
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e924d981-26ac-40db-718a-08d64ad42695
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2725;
x-ms-traffictypediagnostic: CO2PR07MB2725:
x-microsoft-antispam-prvs: <CO2PR07MB2725E56C1001B3EC5AB4E95CD0DC0@CO2PR07MB2725.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2725;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2725;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(51914003)(199004)(36092001)(71190400001)(26005)(71200400001)(14454004)(54906003)(4001150100001)(229853002)(3846002)(6116002)(33656002)(68736007)(83716004)(66066001)(256004)(2900100001)(6486002)(25786009)(305945005)(97736004)(186003)(53936002)(476003)(2906002)(11346002)(486006)(99286004)(6512007)(82746002)(6436002)(86362001)(81166006)(7736002)(105586002)(106356001)(478600001)(446003)(5660300001)(81156014)(4326008)(8936002)(8676002)(316002)(6246003)(6506007)(6916009)(53546011)(76176011)(102836004)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2725;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BAtOdeIORJuBvyvI/03kjEISLIZUhPCgfe6h1rpI7wE91iI6lxH5pGObnsp9TPnNxa5k4YcHz1pN7XwASBEj9+9KA22vJDdhmwyVpTxeYnl+in+o48cOHXKQxoD81pySk2TjXGKsXLgDGCWa6pIhggXpkA5emPkAdhy5fUwUdv6jBhSolOL9QHpL5ITcZ+MfF5GKp/kE5tTWeHawlfbAEaT/N4UlPjN0XPvT2Pfl63toQUHm4Blea3zwD5kcP6MGQv39FSvUpkpCQX2RyC9O+a06JHieumYxOMcVTwRBto9zAOoevENVq1035puR0FMXUalGoIY9CQfsLHwGJ1Bb+UPkkANDAqEs2O7UVnSjfwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F9E9759805D71438260A7485959504E@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e924d981-26ac-40db-718a-08d64ad42695
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 08:27:15.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2725
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmVwbHkuDQpKYW4NCg0KPiBPbiAxNCBOb3YgMjAxOCwgYXQgMjM6MTks
IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBRdW90aW5nIEph
bmVrIEtvdGFzICgyMDE4LTExLTE0IDA3OjI0OjM5KQ0KPj4gVGhpcyBwYXRjaCBhZGRzIGEgZHJp
dmVyIGZvciBGaXhlZCBNTUlPIGNsb2NrLg0KPj4gVGhlIGRyaXZlciByZWFkcyBhIGNsb2NrIGZy
ZXF1ZW5jeSB2YWx1ZSBmcm9tIGEgc2luZ2xlIDMyLWJpdCBtZW1vcnkNCj4+IG1hcHBlZCByZWdp
c3RlciBhbmQgcmVnaXN0ZXJzIGl0IGFzIGEgZml4ZWQgcmF0ZSBjbG9jay4NCj4+IA0KPj4gSXQg
Y2FuIGJlIGVuYWJsZWQgd2l0aCBDT01NT05fQ0xLX0ZJWEVEX01NSU8gS2NvbmZpZyBvcHRpb24u
DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEphbiBLb3RhcyA8amFua0BjYWRlbmNlLmNvbT4NCj4g
DQo+IFNvdW5kcyBsaWtlIGEgZmluZSBpZGVhLiBFeGNlcHQgSSBjYW4gc2VlIGhvdyBpdCB3aWxs
IGJlIGFidXNlZCBpZiB0aGVyZQ0KPiBhcmUgYSBoYW5kZnVsIG9mIHRoZXNlIGZpeGVkIHJhdGUg
ImNsa3MiIHNvbWV3aGVyZSBpbiBtZW1vcnkgdGhhdCBhbGwNCj4gZ2V0IHBvcHVsYXRlZC4gDQo+
IA0KPiBEbyB5b3UgcmVhbGx5IGhhdmUgYSBmaXhlZCByYXRlIGNsayBpbiBoYXJkd2FyZSB0aGF0
IGV4cG9zZXMgYSBzaW5nbGUNCj4gcmVnaXN0ZXIsIG9yIGRvIHlvdSBoYXZlIGEgc2V0IG9mIHRo
ZW0gdGhhdCBzb21lIGZpcm13YXJlIGlzIHBvcHVsYXRpbmcNCj4gaW50byBhbiBJL08gbWVtb3J5
IHNwYWNlIHRoYXQgd2UgY2FuIHJlYWQgdGhlIGZpeGVkIHJhdGVzIGZyb20/IElmIGl0J3MNCj4g
dGhlIGxhdHRlciwgSSB3b25kZXIgd2h5IHdlIGNhbid0IGp1c3QgaGF2ZSB0aGUgZmlybXdhcmUg
cG9wdWxhdGUgdGhlDQo+IGZpeGVkIHJhdGUgY2xrcyBpbnRvIERUIGl0c2VsZj8NCg0KVGhlIGZp
cnN0IGNhc2UuDQpXZSBoYXZlIGEgc2luZ2xlIHJlZ2lzdGVyIGluIGEgZml4ZWQgbG9jYXRpb24g
d2hpY2ggY29udGFpbnMgDQp0aGUgZnJlcXVlbmN5IG9mIHRoZSBtYWluIHN5c3RlbSBjbG9jay4N
ClRoaXMgYWxsb3dzIHVzIHRvIHVzZSB0aGUgc2FtZSBpbWFnZSBpbiBlbXVsYXRpb24sIEZQR0EN
CmFuZCBzaW11bGF0aW9uIHdpdGhvdXQgYW55IGNoYW5nZXMuDQpXZSB1c3VhbGx5IGRvbuKAmXQg
dXNlIGEgZnVsbCBib290bG9hZGVyLCBqdXN0IGEgc2ltcGxlIHdyYXBwZXIsDQp3aGljaCBpbml0
aWFsaXplcyB0aGUgbmVjZXNzYXJ5IHN0dWZmIGFuZCBqdW1wcyB0byB0aGUga2VybmVsLg0KDQo+
IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1maXhlZC1tbWlvLmMgYi9kcml2ZXJz
L2Nsay9jbGstZml4ZWQtbW1pby5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXgg
MDAwMDAwMDAwMC4uYmJjYWRhYjM0NQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVy
cy9jbGsvY2xrLWZpeGVkLW1taW8uYw0KPj4gQEAgLTAsMCArMSw0OSBAQA0KPj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArDQo+PiArLyoNCj4+ICsgKiBNZW1vcnkg
TWFwcGVkIElPIEZpeGVkIENsb2NrIGRyaXZlcg0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChD
KSAyMDE4IENhZGVuY2UgRGVzaWduIFN5c3RlbXMsIEluYy4NCj4+ICsgKg0KPj4gKyAqIEF1dGhv
cnM6DQo+PiArICogICAgIEphbiBLb3RhcyA8amFua0BjYWRlbmNlLmNvbT4NCj4+ICsgKi8NCj4+
ICsNCj4+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+IA0KPiBJcyB0aGlzIGluY2x1ZGUgdXNl
ZD8NCj4gDQo+PiArI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPj4gKyNpbmNsdWRl
IDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiAN
Cj4gSXMgdGhpcyBpbmNsdWRlIHVzZWQ/DQoNCldpbGwgY2xlYW51cCB0aGVzZSwgdGhhbmtzLg0K
DQo+IA0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIF9faW5pdCBvZl9maXhlZF9tbWlvX2Nsa19zZXR1
cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3QgY2xr
ICpjbGs7DQo+PiArICAgICAgIGNvbnN0IGNoYXIgKmNsa19uYW1lID0gbm9kZS0+bmFtZTsNCj4+
ICsgICAgICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPj4gKyAgICAgICB1MzIgY2xrX2ZyZXE7DQo+
PiArDQo+PiArICAgICAgIGJhc2UgPSBvZl9pb21hcChub2RlLCAwKTsNCj4+ICsgICAgICAgaWYg
KCFiYXNlKSB7DQo+PiArICAgICAgICAgICAgICAgcHJfZXJyKCIlcE9GbjogZmFpbGVkIHRvIG1h
cCBhZGRyZXNzXG4iLCBub2RlKTsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiArICAg
ICAgIH0NCj4+ICsNCj4+ICsgICAgICAgY2xrX2ZyZXEgPSByZWFkbChiYXNlKTsNCj4+ICsgICAg
ICAgaW91bm1hcChiYXNlKTsNCj4+ICsgICAgICAgb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcobm9k
ZSwgImNsb2NrLW91dHB1dC1uYW1lcyIsICZjbGtfbmFtZSk7DQo+PiArDQo+PiArICAgICAgIGNs
ayA9IGNsa19yZWdpc3Rlcl9maXhlZF9yYXRlKE5VTEwsIGNsa19uYW1lLCBOVUxMLCAwLCBjbGtf
ZnJlcSk7DQo+PiArICAgICAgIGlmIChJU19FUlIoY2xrKSkgew0KPj4gKyAgICAgICAgICAgICAg
IHByX2VycigiJXBPRm46IGZhaWxlZCB0byByZWdpc3RlciBmaXhlZCByYXRlIGNsb2NrXG4iLCBu
b2RlKTsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiArICAgICAgIH0NCj4+ICsNCj4+
ICsgICAgICAgaWYgKG9mX2Nsa19hZGRfcHJvdmlkZXIobm9kZSwgb2ZfY2xrX3NyY19zaW1wbGVf
Z2V0LCBjbGspKSB7DQo+PiArICAgICAgICAgICAgICAgcHJfZXJyKCIlcE9GbjogZmFpbGVkIHRv
IGFkZCBjbG9jayBwcm92aWRlclxuIiwgbm9kZSk7DQo+PiArICAgICAgICAgICAgICAgcmV0dXJu
Ow0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIHByX2luZm8oIiVwT0ZuOiByZWdpc3Rl
cmVkIGZpeGVkLW1taW8tY2xvY2sgYXQgJXUgSHpcbiIsDQo+PiArICAgICAgICAgICAgICAgbm9k
ZSwgY2xrX2ZyZXEpOw0KPiANCj4gUGxlYXNlIG5vICJJJ20gYWxpdmUhIiBtZXNzYWdlcy4NCg0K
T2ssIEnigJlsbCByZW1vdmUgaXQuDQoNCj4gDQo+PiArfQ0KPj4gKw0KPj4gK0NMS19PRl9ERUNM
QVJFKGZpeGVkX21taW9fY2xrLCAiZml4ZWQtbW1pby1jbG9jayIsIG9mX2ZpeGVkX21taW9fY2xr
X3NldHVwKTsNCj4gDQo+IEFueSByZWFzb24gd2h5IHRoaXMgY2FuJ3QgYmUgYSBwbGF0Zm9ybSBk
cml2ZXI/IEl0IHdvdWxkIG1ha2UgdGhpcyBtdWNoDQo+IGxlc3MgRFQgc3BlY2lmaWMgYW5kIHVz
YWJsZSBvbiBvdGhlciBmaXJtd2FyZXMvcGxhdGZvcm1zIGlmIHdlIHVzZWQgYQ0KPiBwbGF0Zm9y
bSBkcml2ZXIgaGVyZS4NCj4gDQoNCkkgbG9va2VkIGF0IHRoZSBmaXhlZCByYXRlIGNsb2NrIGFz
IGEgcmVmZXJlbmNlLCBidXQgSSBjYW4gY2hhbmdlIGl0IHRvIA0KYSBwbGF0Zm9ybSBkcml2ZXIs
IGlmIHRoYXTigJlzIHByZWZlcnJlZC4NCg0K
