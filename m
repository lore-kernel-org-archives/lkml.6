Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1ECC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3265218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Upzpc1JM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lVvgvStM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLRNyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:54:37 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:55018 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbeLRNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:54:36 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBIDrq3w016135;
        Tue, 18 Dec 2018 05:54:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=aNgu6HD9srLuNx8pMslXyQ8UXaNlUEEiO7o2NeEJSW4=;
 b=Upzpc1JMPu7kBzZveBAVDwaAOBaZ395u6nyoyh1b5+fkBySypg4zHEdGoHNsQvdmQXoR
 IyFvLTgawAeaz//W63Z4PmZd7IE/tX5Tt4XMWoSlR2JOiVnr2hZX5gmRDPk7bFseVwtG
 mxmWnWYLyRfA20OGKV6KfjacO937EX/S3A0u0rs5qxf/PWdwwHHt+FgJsxieMbammB4j
 kIkfmPKbOeYkZLM4sHZxAlAeYqzDerx4LZfgAoeQcWr3VguKdYK9ugu3nsk2DRTAWJHI
 HLtS4WsLkG+dZL958emyyWBuhFY/GAZpz/4ZQGZoL51DQ6+obaJ90vnx5kd+Av8m0Dzo lA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pde96cptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Dec 2018 05:54:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNgu6HD9srLuNx8pMslXyQ8UXaNlUEEiO7o2NeEJSW4=;
 b=lVvgvStMcv5zgO59jgiwgeAY5M5hbOaKsP6YqL2RGBY/lARCB1Jt28x7GHBrJ/JjGIRwC1XMXBG+FJowwKKTsTpaew/XSEfJ0NJvpTTNw3FAMARqz/th2VrnYf9vRQwYXR+e5uz3l1Zzs3X3uERu+wr4p2B3Ss2If8FbtR/FzFw=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB2520.namprd07.prod.outlook.com (10.166.201.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 13:54:25 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::9a1:e7fe:86e:b12a]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::9a1:e7fe:86e:b12a%6]) with mapi id 15.20.1446.018; Tue, 18 Dec 2018
 13:54:25 +0000
From:   Janek Kotas <jank@cadence.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Janek Kotas <jank@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
Thread-Topic: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
Thread-Index: AQHUlh51czbCHBrO00aPiVvUO6Xv/qWDFH2AgABtEoCAAPLMAIAAEcSA
Date:   Tue, 18 Dec 2018 13:54:25 +0000
Message-ID: <220ECBA7-CD30-4221-8878-0DA93390DDCC@global.cadence.com>
References: <20181217153652.20056-1-jank@cadence.com>
 <20181217153652.20056-3-jank@cadence.com>
 <CAMpxmJXrjyK3m4JwgkxwkHjSj-ugb7UzwNrYcBwYjWwj+JBNxw@mail.gmail.com>
 <CACRpkdYq5Eg2DrwdED-yTZ4kMoCxew+0rdU-b4zuinOf7BEr6Q@mail.gmail.com>
 <CAMpxmJUnfnHmopyOfHRZrN1KoqZx_Bsra1BTiGud6UVmzz1ryA@mail.gmail.com>
In-Reply-To: <CAMpxmJUnfnHmopyOfHRZrN1KoqZx_Bsra1BTiGud6UVmzz1ryA@mail.gmail.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2520;20:qHRdxPuBDrcrHM02KibWJZ4Wg3KetyK39QnyYDliSrLFW8eLal1eBtjl3YrqBzd3gNHgHIwFvl84BfyxitukFkUgondcFmA+vmMRiwEqKclM7+7AK63po3tr/IRh8Q/f3Ab49D71vvtLMjJgZv/fohW+NmXmq18uZe4eQVyIQqO92jS1QCCgulEyq1ZC4fl+IvSIybjh68ZAKuq22fcRnjLUFhA1UfhoOJQu6rGkMJXvV6umCxdUHc1P/tUGl0XI
x-ms-office365-filtering-correlation-id: fa48dd4d-eb44-4b06-0298-08d664f0522c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2520;
x-ms-traffictypediagnostic: CO2PR07MB2520:
x-microsoft-antispam-prvs: <CO2PR07MB2520FE2606964B78C631D59AD0BD0@CO2PR07MB2520.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2520;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2520;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(39860400002)(376002)(36092001)(189003)(199004)(3846002)(7736002)(6116002)(14454004)(105586002)(478600001)(8676002)(106356001)(81166006)(8936002)(82746002)(81156014)(186003)(26005)(256004)(2906002)(102836004)(86362001)(6506007)(53546011)(76176011)(99286004)(316002)(6512007)(54906003)(68736007)(83716004)(6246003)(6486002)(93886005)(6436002)(25786009)(6916009)(33656002)(486006)(66066001)(229853002)(476003)(71190400001)(71200400001)(5660300001)(4326008)(97736004)(53936002)(305945005)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2520;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HnlSWwiAiZ7gaZx63zL4STwt8mZY3Rnp7ZJSPTut04sOFHOCEwqPBQiiY9R0Ml5eHqqV/oicz2uczf+eGq7Sh15ozKFuIXy/wkpM3+OrzjecnY9GvwzU8cs5TRhsimldeiPpZevim7x0WwG5psL0e7PJX9QJb4GqJShJrqhY5VCpYreBiyFmWz7sVgXdIo3/2ufO0AvlIXWO+xKtqDJbFJTi8XYWX73qy5CkCDDWEzndKaRKRRn+hXvQT6e8tnbfEZKtdNEe2hHxCRnCZAYuwTTk/XVwpmhC/Y4A71jfIu5NDCnmrKvHfajCekAFfpW+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AE1CA0FE73F7643841C3D64FF4AD5DB@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa48dd4d-eb44-4b06-0298-08d664f0522c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 13:54:25.1954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2520
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=693 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDE4IERlYyAyMDE4LCBhdCAxMzo1MCwgQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFz
emV3c2tpQGJheWxpYnJlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gcG9uLiwgMTcgZ3J1IDIwMTgg
byAyMzoyMiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+IG5hcGlzYcWC
KGEpOg0KPj4gDQo+PiBPbiBNb24sIERlYyAxNywgMjAxOCBhdCA0OjUxIFBNIEJhcnRvc3ogR29s
YXN6ZXdza2kNCj4+IDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPiB3cm90ZToNCj4+IA0KPj4+
IFRoZSBkcml2ZXIgbG9va3MgZ29vZCBidXQgaXMgdGhlcmUgYW55IHBhcnRpY3VsYXIgcmVhc29u
IG5vdCB0byB1c2UNCj4+PiByZWdtYXAgZm9yIHJlZ2lzdGVyIElPPw0KPj4gDQo+PiBJIHRob3Vn
aHQgd2Ugb25seSB1c2UgcmVnbWFwIGZvciBNTUlPIHdoZW4gdGhlIHJlZ2lzdGVyIHJhbmdlIGlz
DQo+PiBzaGFyZWQgKGFzIGluIGEgc3lzdGVtIGNvbnRyb2xsZXIpIHNvIHRoYXQgc29tZSByZWdp
c3RlcnMgYXJlIGZvciB0aGlzLA0KPj4gc29tZSByZWdpc3RlciBvciBldmVuIGJpdHMgaW4gYSBy
ZWdpc3RlciBmb3Igc29tZSBvdGhlciBkcml2ZXIsIHNvIHRoZXkNCj4+IG5lZWQgdGhlIHNwaW5s
b2NrIGluIHRoZSByZWdtYXAgdG8gcHJvdGVjdCB0aGUgcmVnaXN0ZXIgcmFuZ2UuDQo+PiANCj4g
DQo+IFRoaXMgaXMgd2hhdCBzeXNjb24gaXMgZm9yLiBSZWdtYXAgc2ltcGx5IGFic3RyYWN0cyBh
bnkgcmVnaXN0ZXIgSU8uDQo+IEZvciBpbnN0YW5jZTogdGhlcmUncyBubyBsb2NraW5nIGluIHRo
aXMgZHJpdmVyLiBBcmUgd2Ugc3VyZSBpdCdzIG5vdA0KPiBuZWVkZWQ/IFJlZ21hcCBwcm92aWRl
cyBpbnRlcm5hbCBsb2NraW5nIGZvciB5b3UgaW4gdGhlIGZvcm0gb2YgYQ0KPiBtdXRleCBvciBz
cGlubG9jay4NCj4gDQo+IEFsc286IGl0IGxvb2tzIGxpa2UgdGhlIGludGVycnVwdHMgaGVyZSBh
cmUgcXVpdGUgc2ltcGxlIHdpdGggYSBzaW5nbGUNCj4gYml0IHBlciBpbnRlcnJ1cHQgaW4gdGhl
IHN0YXR1cyByZWdpc3RlciBhbmQgdGhlIHNhbWUgbGF5b3V0IGluIHRoZQ0KPiBtYXNrIHJlZ2lz
dGVyIC0gaXQgY291bGQgcHJvYmFibHkgcHJvZml0IGZyb20gdXNpbmcgdGhlDQo+IHJlZ21hcF9p
cnFfY2hpcCBhbmQgbm90IGJvdGhlciB3aXRoIHJlaW1wbGVtZW50aW5nIGlycV9jaGlwIGNhbGxi
YWNrcy4NCj4gDQo+PiBJdCBpcyBhbHNvIG5pY2UgZm9yIHNoYWRvd2luZy9jYWNoaW5nIG9mIHJl
Z2lzdGVyIGNvbnRlbnRzIEkgZ3Vlc3MsDQo+PiB3YXQgZG9lcyB0aGlzIGRyaXZlciBnZXQgZnJv
bSByZWdtYXAgTU1JTz8NCj4+IA0KPiANCj4gQ29kZSBzaHJpbmthZ2UgSU1PLg0KPiANCj4gTm90
ZSB0aGF0IEknbSBub3QgYmxvY2tpbmcgdGhpcyBmcm9tIGJlaW5nIG1lcmdlZCAtIEkganVzdCB0
aGluayB0aGF0DQo+IHVzaW5nIG1vZGVybiBmcmFtZXdvcmtzIGlzIGFsd2F5cyBhIGdvb2QgaWRl
YS4NCg0KSSBjYW4gcmVpbXBsZW1lbnQgdGhlIGRyaXZlciB1c2luZyByZWdtYXAsIGJ1dCBJdCBz
ZWVtcyBpbiBzdWNoIGNhc2UNCkkgd29u4oCZdCBiZSBhYmxlIHRvIHVzZSB0aGUgR2VuZXJpYyBH
UElPIEluZnJhc3RydWN0dXJlLCB3b3VsZCBJPw0KU28gSSB3b3VsZCBuZWVkIHRvIHByb3ZpZGUg
ZnVuY3Rpb25zIGZvciBzZXR0aW5nIGRpcmVjdGlvbiwgZXRjLg0KSSB0aGluayBpdCB3b3VsZCBt
YWtlIHRoZSBkcml2ZXIgY29kZSBiaWdnZXIuDQoNClJlZ2FyZHMsDQpKYW4NCg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEJhcnRvc3ogR29sYXN6ZXdza2kNCj4gDQo+PiBZb3VycywNCj4+IExpbnVzIFdh
bGxlaWoNCg0K
