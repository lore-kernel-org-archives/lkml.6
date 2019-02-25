Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45409213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bgMLkOTQ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VT/y9Q/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfBYIYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:24:53 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47238 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfBYIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:24:52 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1P8GmXs020331;
        Mon, 25 Feb 2019 00:22:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=EvrXJdtKo6DZURz5I+5d34YZctswrC0D/+gOEC1zkC8=;
 b=bgMLkOTQdxJrwG56GCyozf9ui04a1aJSWS2O7icNi3oD1NtT9Ljv0P04Z7AdXgGs85yt
 9Se60mPYB1OyiatnHhPtJV00VLrrXcvFf0xl4bqA3xwNA7bVhxeQnAen/zg7phMTrxQX
 5ZJvxG8SCaGUFtbl37fCn2UZD07C0xzz4p+a/DCB3Iyc/BncA/TO1S4v29JZaau2Mf9v
 SxJA8XlzThiP2zGJZube5P1wpLdUYVj1srheb//eaVAMEZ9JE+t+AqKqGBTzZja6Z7Kh
 SmGIwN0sFD6FoGQaBIwlgjfrBq4RGhl3corxntA5+72zCUL9Fvz+Vfz7Wy/SZoScDIHT AQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2053.outbound.protection.outlook.com [104.47.42.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qu3m16egw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 00:22:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvrXJdtKo6DZURz5I+5d34YZctswrC0D/+gOEC1zkC8=;
 b=VT/y9Q/s+Mn5FfhDzomtHdkTeQZYcXu+ezRASFB61KE0yK2VNhJFvEfWO2jri9rtSKDUsM5rjjawcRKJfa6oqHv3hPrWD01qxGuqy041IQv6sBZhiT1emtI6Iqm2mu2l1fcEaDSApWG4NrcwwdK4zh75xWnXFD9xaO07Qq39Kes=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2726.namprd07.prod.outlook.com (10.166.201.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 08:22:45 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c%9]) with mapi id 15.20.1643.018; Mon, 25 Feb 2019
 08:22:44 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>, Jan Kotas <jank@cadence.com>
Subject: RE: [PATCH 0/3] Cover letter: Add support for high speed MAC in
 Cadence controller driver
Thread-Topic: [PATCH 0/3] Cover letter: Add support for high speed MAC in
 Cadence controller driver
Thread-Index: AQHUyurRNMiSYr9Vw0+AR8G+6oha46XvJF4AgAELz2A=
Date:   Mon, 25 Feb 2019 08:22:44 +0000
Message-ID: <CO2PR07MB24697E959D0637C59566420EC17A0@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190222201118.GA14791@lvlogina.cadence.com>
 <a64e8266-a235-9999-708d-1a80051b5d4e@gmail.com>
In-Reply-To: <a64e8266-a235-9999-708d-1a80051b5d4e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04M2ZkNjgwMC0zOGQ2LTExZTktODRlMi0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcODNmZDY4MDItMzhkNi0xMWU5LTg0ZTItMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSIxOTUyIiB0PSIxMzE5NTU1NjU2MTAyMzU0NzQiIGg9IkhRUERlTmpNL1BFbTRacC9ybGZNQWg0SXhPTT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8f56310-fc33-4e6b-074a-08d69afa6b2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2726;
x-ms-traffictypediagnostic: CO2PR07MB2726:
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2726;20:HXanDQ2TaPPknMdmPm7ZnEbhf1V422eJoQIfoBG99yXnf+SoBVI+2LMn3Tu5x/u99qDhIDJ4dbFpQh4hyPxTbtskqjWOebVl89SCuOX0l0VSJ9v86ZceW7+Z/9OTMfpsQx8LTHtccKj9VQAqrawcr0UYE+N8UpzJ5r0BaHcOYq6pmL4oY6HVBrVCDX6OTqqJHpXtQwtl9dwZ0lJWiyqwn7eO+6A3PP9nJpf+5qsqqrP3PDG0fmSgjpk71bk3qai6
x-microsoft-antispam-prvs: <CO2PR07MB27263AE7B79CB5B00D0FDD9BC17A0@CO2PR07MB2726.namprd07.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(36092001)(6436002)(55016002)(14454004)(7696005)(105586002)(76176011)(106356001)(3846002)(6116002)(2501003)(97736004)(478600001)(99286004)(9686003)(316002)(110136005)(86362001)(2906002)(256004)(53936002)(66066001)(52536013)(6246003)(25786009)(305945005)(186003)(68736007)(74316002)(8676002)(81166006)(8936002)(6636002)(81156014)(229853002)(33656002)(7736002)(26005)(6506007)(55236004)(2201001)(102836004)(486006)(11346002)(446003)(476003)(5660300002)(78486014)(66574012)(71200400001)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2726;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nqhogDIFtXJD/xplGaQO+KjnAimVfR1T207I/oulkjiXwmXswYGIDbpjQ304e0vAS5yCapIrSjGIVTvP8CDxAg/vC+Tc8daP0ASVyftmklhc//YMgXPB283rIr6EyERTCGk671Ui/2z47+au1Yi/gKD+FQazvH6q7URWVJo902R4fs/2FHBln9GFQbvv/XzBxazEqYmr2cldSSykCQYMrc1qPrxGwu0l18bxN+izsvfMKn3uAfadR5K2n77xzgzs7SzKB88zCf/NfLme73oyr5k5zSnxNp7NS7d8+tQp7fuh0gU+nGGVtm2YIQjmBOmUHBcna0o7CHd+5vjfU1ad9eQiQI+FT6reR40PSh2f2iCx7lU43LjETe/5hC0HV/GrpOP0RN01N1KQIKpVpkTj/bOwe+vCHy7ehwaKVN2carY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f56310-fc33-4e6b-074a-08d69afa6b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 08:22:44.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2726
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=834 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+SGksDQo+DQo+TGUgMi8yMi8xOSDDoCAxMjoxMSBQTSwgUGFyc2h1cmFtIFRob21iYXJlIGEg
w6ljcml0wqA6DQo+PiBIZWxsbyAhDQo+Pg0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgY29udGFpbiBj
aGFuZ2VzIHRvIHN1cHBvcnQgaGlnaCBzcGVlZCBNQUMgYW5kIFBDUyBpbg0KPj4gQ2FkZW5jZSBl
dGhlcm5ldCBjb250cm9sbGVyIGRyaXZlci4NCj4NCj5Gcm9tIHBhdGNoIHN1Ym1pc3Npb24gcGVy
c3BlY3RpdmUsIHlvdXIgY292ZXIgbGV0dGVyIGFuZCBpbmRpdmlkdWFsIHBhdGNoZXMgZG8NCj5u
b3QgYXBwZWFyIGFzIGEgcmVwbHkgdG8gdGhpcyBjb3ZlciBsZXR0ZXIgd2hpY2ggbWFrZXMgdGhl
IHRocmVhZGluZyBicm9rZW4gaW4NCj5tb3N0IG1haWwgY2xpZW50cy4gSWYgeW91IHVzZWQgZ2l0
IGZvcm1hdC1wYXRjaCAtLWNvdmVyLWxldHRlciwgdGhpcyBpcyBoYW5kbGVkDQo+dHJhbnNwYXJl
bnRseSBmb3IgeW91IGJ5IGdpdCBzZW5kLWVtYWlsLg0KPg0KSGkgRmxvcmlhbiwNCg0KSSB3aWxs
IG1ha2Ugc3VyZSB0byBkbyBpdCBjb3JyZWN0bHkgZnJvbSBuZXh0IHBhdGNoIHNldC4NCj4+DQo+
PiBIZXJlIGlzIHRoZSBsaXN0IG9mIHBhdGNoZXMuDQo+PiBbUEFUQ0ggMS8zXSBuZXQ6IGV0aGVy
bmV0OiBhZGQgc3VwcG9ydCBmb3IgUENTIGFuZCAyLjVHIHNwZWVkDQo+PiAgICAgICAgIFRoaXMg
cGF0Y2ggYWRkIHN1cHBvcnQgZm9yIFBDUyAoZm9yIFNHTUlJIGludGVyZmFjZSkgYW5kIDIuNUdi
cHMNCj4+ICAgICAgICAgTUFDIGluIENhZGVuY2UgZXRoZXJuZXQgY29udHJvbGxlciBkcml2ZXIu
DQo+PiBbUEFUQ0ggMi8zXSBuZXQ6IGV0aGVybmV0OiBhZGQgYzQ1IFBIWSBzdXBwb3J0IGluIE1E
SU8gcmVhZC93cml0ZSBmdW5jdGlvbnMuDQo+PiAgICAgICAgIFRoaXMgcGF0Y2ggbW9kaWZ5IE1E
SU8gcmVhZC93cml0ZSBmdW5jdGlvbnMgdG8gc3VwcG9ydA0KPj4gICAgICAgICBjb21tdW5pY2F0
aW9uIHdpdGggQzQ1IFBIWSBpbiBDYWRlbmNlIGV0aGVybmV0IGNvbnRyb2xsZXIgZHJpdmVyLg0K
Pj4gW1BBVENIIDMvM10gbmV0OiBldGhlcm5ldDogYWRkIHN1cHBvcnQgZm9yIGhpZ2ggc3BlZWQg
bWFjIGFuZCB1c3hnbWlpIHBjcw0KPj4gICAgICAgICBUaGlzIHBhdGNoIGFkZCBzdXBwb3J0IGZv
ciAoMTBHKSBoaWdoIHNwZWVkIG1hYywgdXN4Z21paSBwY3MNCj4+ICAgICAgICAgYW5kIHVzeGdt
aWkgaW50ZXJmYWNlIGluIENhZGVuY2UgZXRoZXJuZXQgY29udHJvbGxlciBkcml2ZXIuDQo+Pg0K
Pj4gUmVnYXJkcywNCj4+IFBhcnNodXJhbSBUaG9tYmFyZQ0KPj4NCj4+IFBhcnNodXJhbSBUaG9t
YmFyZSAoMyk6DQo+PiAgIG5ldDogZXRoZXJuZXQ6IGFkZCBzdXBwb3J0IGZvciBQQ1MgYW5kIDIu
NUcgc3BlZWQNCj4+ICAgbmV0OiBldGhlcm5ldDogYWRkIGM0NSBQSFkgc3VwcG9ydCBpbiBNRElP
IHJlYWQvd3JpdGUgZnVuY3Rpb25zLg0KPj4gICBuZXQ6IGV0aGVybmV0OiBhZGQgc3VwcG9ydCBm
b3IgaGlnaCBzcGVlZCBtYWMgYW5kIHVzeGdtaWkgcGNzDQo+Pg0KPj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2NhZGVuY2UvbWFjYi5oICAgICAgfCAgIDY4ICsrKysrKy0NCj4+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jIHwgIDMwOQ0KPisrKysrKysrKysrKysrKysr
KysrKysrKystLS0tDQo+PiAgaW5jbHVkZS9saW51eC9waHkuaCAgICAgICAgICAgICAgICAgICAg
ICB8ICAgIDMgKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMzMzIGluc2VydGlvbnMoKyksIDQ3IGRl
bGV0aW9ucygtKQ0KPj4NCj4NCj4NCj4tLQ0KPkZsb3JpYW4NCg0KUmVnYXJkcywNClBhcnNodXJh
bSBUaG9tYmFyZQ0K
