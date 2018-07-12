Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BFAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F7220BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HN0eEUqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F7220BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeGLJQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:16:07 -0400
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:18363
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbeGLJQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqM6+owMBwUOgP6G6Lr5N7xxdnbTo/ESenIiAVN9bkM=;
 b=HN0eEUqm7l3KbcIfwoE88kuEtiT/4f+L/fZE0vTmaYDlLWbE7/E0Hc4csKuF+GQHtinFOjiG2ktXdZykeMc6jINmw4zZ2sHL/BmzH1Ne/lngkPJQe7ZulRLNttgDiS5iUHTO3OMqpqZBlupDeVwO5FJN1oDH/LS4gQ1Wi9pTODM=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5352.namprd07.prod.outlook.com (20.177.125.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 09:03:31 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 09:03:31 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 05/31] usb: usbssp: Added first part of initialization
 sequence.
Thread-Topic: [PATCH 05/31] usb: usbssp: Added first part of initialization
 sequence.
Thread-Index: AQHUGaPrXhW1ftKvwUmD/Pn5NzNpOqSLH3YAgAAiAfA=
Date:   Thu, 12 Jul 2018 09:03:30 +0000
Message-ID: <BYAPR07MB47096E3B832D07F8F3017974DD590@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-6-git-send-email-pawell@cadence.com>
 <20180712062714.GI20905@kroah.com>
In-Reply-To: <20180712062714.GI20905@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzljNmFlMDAtODViMi0xMWU4LTg3MTAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDc5YzZhZTAxLTg1YjItMTFlOC04NzEwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzgyMCIgdD0iMTMxNzU4NTk4MjM5MTYyMjQ0IiBoPSIxVUVYY0dSNXNUU0ZLY0czWkFuOTIvRGNBa1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5352;7:gNvMd7tL1uydEaR/EK+SLr9FfHG0KMgSaNInnvyHAnZ7rTmGt2/+EriUUtd4+hRaxzhU9RVa6lvVfZkaht0bBSZI92r6l5IJcLJZMOQ1XI9U64CRYoIk5lL+xaD2GgPdTAjMAIfsK/unUz0xln4JdfTH+bEtj/ZQ51MAEoif5Vef1dMHGyxc/dD2sHrahsaasYDeC6ICwtwjmsr5blYzWsFI1az6WhW6IfZyqCBr76BVEbn9Gkw9XO4kMWWK8o+D;20:JgVeOBbNazWeonZNTI3F03slNGCbEB9E8W38uE2+ZGeZ/lhkfQ/sWCGi1NuKpyEvkLzgDXKlDtGRtpIjs6oyYEdPOwCBsNOlFftrpupsJYBgRSiN0mllxmHld/4+regGWNR0iKjtMSyJs+LjE1OgnMl61UnJ9JQ4JNU65dwPJV9Hp8JRcDxAvV280SiYMuSowPelgMO+X1+Nqv5tI/dUYIwk1viNO43pdgOhsUMEVff/PLIEe+RsGldac4RcLms3
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(36092001)(105586002)(229853002)(11346002)(6916009)(2900100001)(4326008)(55016002)(6436002)(14444005)(5250100002)(68736007)(476003)(256004)(99286004)(9686003)(446003)(486006)(86362001)(66066001)(107886003)(54906003)(14454004)(186003)(25786009)(97736004)(6246003)(102836004)(478600001)(26005)(53936002)(8936002)(2906002)(76176011)(5660300001)(316002)(3846002)(81166006)(106356001)(6506007)(74316002)(7736002)(305945005)(7696005)(33656002)(6116002)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5352;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 9b0b27b0-04af-45a7-5190-08d5e7d656f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5352;
x-ms-traffictypediagnostic: BYAPR07MB5352:
x-microsoft-antispam-prvs: <BYAPR07MB53522CD2288A0F38B83CED29DD590@BYAPR07MB5352.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5352;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5352;
x-forefront-prvs: 0731AA2DE6
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8pbnnAzA2JW6y2Q6AoetoTEj3LHioOu5n12d2Eu9sGA5AUU85xQf7DDPznict2zfZQXgGPqnzKR0jkhEKTwdjuUayt4SPZGrcf63jPEnpYx3MloSeAOqu7QNtqLzhrIfswlLri1o7AWToKVNKsAWS17Rwk367B1HckiU6+rCOg09S2E03WNE+DoQ+B68niNHNP2YCPtkDdjGomo1rZAyIGxAkVY6HmOdUE/WlyA2FA8o3PWLFQ0TNIZl3ZQQeddH1UHgxlrK/J4PfvlrE7CtSxzgUMX+m54xY5W5OtXJ0dOJ4hqqLsP525kZSjrlTVzha+6fzxPBrgxQ7Yo18/GVYW8IXdA3cLv11rL9qaEnKMY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0b27b0-04af-45a7-5190-08d5e7d656f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 09:03:30.9707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsvKiBVU0IgMi4wIGhhcmR3YXJlIExNUCBjYXBhYmlsaXR5Ki8NCj4gPiArI2RlZmluZSBV
U0JTU1BfSExDCQkJKDEgPDwgMTkpDQo+ID4gKyNkZWZpbmUgVVNCU1NQX0JMQwkJCSgxIDw8IDIw
KQ0KPiANCj4gQWdhaW4sIEJJVCgpIHBsZWFzZS4NCj4gDQo+ID4gK2ludCB1c2Jzc3BfaGFuZHNo
YWtlKHZvaWQgX19pb21lbSAqcHRyLCB1MzIgbWFzaywgdTMyIGRvbmUsIGludCB1c2VjKQ0KPiA+
ICt7DQo+ID4gKwl1MzIJcmVzdWx0Ow0KPiANCj4gU29tZSBwbGFjZXMgeW91IHVzZSB0YWJzIGZv
ciB0aGUgdmFyaWFibGUgZGVjbGFyYXRpb25zLCBhbmQgc29tZSB5b3UgZG8NCj4gbm90LiAgUGlj
ayBhIHNpbmdsZSBzdHlsZSBhbmQgc3RpY2sgdG8gaXQgcGxlYXNlLg0KPiANCj4gPiArDQo+ID4g
KwlkbyB7DQo+ID4gKwkJcmVzdWx0ID0gcmVhZGwocHRyKTsNCj4gPiArCQlpZiAocmVzdWx0ID09
IH4odTMyKTApCS8qIGNhcmQgcmVtb3ZlZCAqLw0KPiA+ICsJCQlyZXR1cm4gLUVOT0RFVjsNCj4g
PiArCQlyZXN1bHQgJj0gbWFzazsNCj4gPiArCQlpZiAocmVzdWx0ID09IGRvbmUpDQo+ID4gKwkJ
CXJldHVybiAwOw0KPiA+ICsJCXVkZWxheSgxKTsNCj4gPiArCQl1c2VjLS07DQo+ID4gKwl9IHdo
aWxlICh1c2VjID4gMCk7DQo+ID4gKwlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gDQo+IFdlIGRvbid0
IGhhdmUgYSBidWlsdC1pbiBrZXJuZWwgZnVuY3Rpb24gdG8gZG8gdGhpcyB0eXBlIG9mIHRoaW5n
IGFscmVhZHk/DQo+IFRoYXQncyBzYWQuICBPaCB3ZWxsLi4uDQo+IA0KPiA+ICtpbnQgdXNic3Nw
X2luaXQoc3RydWN0IHVzYnNzcF91ZGMgKnVzYnNzcF9kYXRhKSB7DQo+ID4gKwlpbnQgcmV0dmFs
ID0gMDsNCj4gPiArDQo+ID4gKwl1c2Jzc3BfZGJnX3RyYWNlKHVzYnNzcF9kYXRhLCB0cmFjZV91
c2Jzc3BfZGJnX2luaXQsDQo+ICJ1c2Jzc3BfaW5pdCIpOw0KPiA+ICsNCj4gPiArCXNwaW5fbG9j
a19pbml0KCZ1c2Jzc3BfZGF0YS0+bG9jayk7DQo+ID4gKwlzcGluX2xvY2tfaW5pdCgmdXNic3Nw
X2RhdGEtPmlycV90aHJlYWRfbG9jayk7DQo+ID4gKw0KPiA+ICsJLy9UT0RPOiBtZW1vcnkgaW5p
dGlhbGl6YXRpb24NCj4gPiArCS8vcmV0dmFsID0gdXNic3NwX21lbV9pbml0KHVzYnNzcF9kYXRh
LCBHRlBfS0VSTkVMKTsNCj4gPiArDQo+ID4gKwl1c2Jzc3BfZGJnX3RyYWNlKHVzYnNzcF9kYXRh
LCB0cmFjZV91c2Jzc3BfZGJnX2luaXQsDQo+ID4gKwkJCSJGaW5pc2hlZCB1c2Jzc3BfaW5pdCIp
Ow0KPiANCj4gV2hlbiB5b3VyIHRyYWNlIGZ1bmN0aW9ucyBkbyBub3RoaW5nIGJ1dCBzYXkgImVu
dGVyZWQgYSBmdW5jdGlvbiIsIGFuZA0KPiAiZXhpdGVkIGEgZnVuY3Rpb24iLCB3aHkgZXZlbiBo
YXZlIHRoZW0/ICBmdHJhY2UgY2FuIHByb3ZpZGUgdGhhdCBmb3IgeW91DQo+IGFscmVhZHksIG5v
IG5lZWQgdG8gb3ZlcmxvYWQgdGhhdCBvbiB0aGUgdHJhY2luZyBmcmFtZXdvcmssIHJpZ2h0Pw0K
DQpEbyB5b3Ugc3VnZ2VzdCB0byB1c2Ugb25seTogDQoJdHJhY2VfdXNic3NwX2RiZ19pbml0KCJG
aW5pc2hlZCB1c2Jzc3BfaW5pdCIpOyANCmluc3RlYWQ6IA0KCXVzYnNzcF9kYmcodXNic3NwX2Rh
dGEsICIlcFZcbiIsICJGaW5pc2hlZCB1c2Jzc3BfaW5pdCIpOw0KCXRyYWNlX3VzYnNzcF9kYmdf
aW5pdCgiRmluaXNoZWQgdXNic3NwX2luaXQiKTsNCj8NCg0KSSdtIHNpbXBsZSByZS11c2VkIHRo
ZSBjb2RlIGZyb20gWEhDSSBkcml2ZXIuIEl0J3MgcmVhbGx5IHJlZHVuZGFudCwgDQpidXQgSSBk
b24ndCBrbm93IHRoZSBpbnRlbnRpb24gb2YgYXV0aG9yIPCfmIouICANCiANCj4gPiArLyoNCj4g
PiArICogZ2FkZ2V0LWlmLmMgZmlsZSBpcyBwYXJ0IG9mIGdhZGdldC5jIGZpbGUgYW5kIGltcGxl
bWVudHMgaW50ZXJmYWNlDQo+ID4gKyAqIGZvciBnYWRnZXQgZHJpdmVyDQo+ID4gKyAqLw0KPiA+
ICsjaW5jbHVkZSAiZ2FkZ2V0LWlmLmMiDQo+IA0KPiBVZ2gsIEkga25vdyBVU0IgaGNkIGRyaXZl
cnMgbG92ZSB0byBpbmNsdWRlIC5jIGZpbGVzIGluIHRoZSBtaWRkbGUgb2YgdGhlbSwgYnV0DQo+
IGRvIHdlIGhhdmUgdG8gY29udGludWUgdGhhdCBjcmF6eSBwcmFjdGljZSBpbiBuZXdlciBkcml2
ZXJzPw0KPiBJcyBpdCByZWFsbHkgbmVjZXNzYXJ5Pw0KDQpJdCdzIG5vdCBuZWNlc3NhcnkgSSB3
YW50ZWQgdG8gbGVhdmUgdGhpcyBhcyB0d28gc2VwYXJhdGUgZmlsZSwgYmVjYXVzZSBnYWRnZXQu
YyANCklzIGJhc2VkIG9uIHhoY2kuYyBhbmQgZ2FkZ2V0LWlmLmMgZGVmaW5lIGludGVyZmFjZSBi
ZXR3ZWVuIGdhZGdldC5jIGFuZCANClVTQiBnYWRnZXQgY29yZSBkcml2ZXIuIEkgZGlkbid0IHdh
bnQgdG8gY29tYmluZSB0aGVzZSB0d28gZmlsZXMuIA0KDQpJIHdpbGwgYWRkIHNvbWUgYWRkaXRp
b25hbCBmdW5jdGlvbiBkZWNsYXJhdGlvbiB0byBnYWRnZXQuaCBhbmQgcmVtb3ZlIGl0IA0KZnJv
bSBnYWRnZXQuYyBmaWxlLiANCg0KIA0KPiA+ICsJLyoNCj4gPiArCSAqIENoZWNrIHRoZSBjb21w
aWxlciBnZW5lcmF0ZWQgc2l6ZXMgb2Ygc3RydWN0dXJlcyB0aGF0IG11c3QgYmUgbGFpZA0KPiA+
ICsJICogb3V0IGluIHNwZWNpZmljIHdheXMgZm9yIGhhcmR3YXJlIGFjY2Vzcy4NCj4gPiArCSAq
Lw0KPiA+ICsJQlVJTERfQlVHX09OKHNpemVvZihzdHJ1Y3QgdXNic3NwX2Rvb3JiZWxsX2FycmF5
KSAhPSAyKjMyLzgpOw0KPiA+ICsJQlVJTERfQlVHX09OKHNpemVvZihzdHJ1Y3QgdXNic3NwX3Ns
b3RfY3R4KSAhPSA4KjMyLzgpOw0KPiA+ICsJQlVJTERfQlVHX09OKHNpemVvZihzdHJ1Y3QgdXNi
c3NwX2VwX2N0eCkgIT0gOCozMi84KTsNCj4gPiArCS8qIHVzYnNzcF9kZXZpY2UgaGFzIGVpZ2h0
IGZpZWxkcywgYW5kIGFsc28NCj4gPiArCSAqIGVtYmVkcyBvbmUgdXNic3NwX3Nsb3RfY3R4IGFu
ZCAzMSB1c2Jzc3BfZXBfY3R4DQo+ID4gKwkgKi8NCj4gPiArCUJVSUxEX0JVR19PTihzaXplb2Yo
c3RydWN0IHVzYnNzcF9zdHJlYW1fY3R4KSAhPSA0KjMyLzgpOw0KPiA+ICsJQlVJTERfQlVHX09O
KHNpemVvZih1bmlvbiB1c2Jzc3BfdHJiKSAhPSA0KjMyLzgpOw0KPiA+ICsJQlVJTERfQlVHX09O
KHNpemVvZihzdHJ1Y3QgdXNic3NwX2Vyc3RfZW50cnkpICE9IDQqMzIvOCk7DQo+ID4gKwlCVUlM
RF9CVUdfT04oc2l6ZW9mKHN0cnVjdCB1c2Jzc3BfY2FwX3JlZ3MpICE9IDgqMzIvOCk7DQo+ID4g
KwlCVUlMRF9CVUdfT04oc2l6ZW9mKHN0cnVjdCB1c2Jzc3BfaW50cl9yZWcpICE9IDgqMzIvOCk7
DQo+ID4gKwkvKiB1c2Jzc3BfcnVuX3JlZ3MgaGFzIGVpZ2h0IGZpZWxkcyBhbmQgZW1iZWRzIDEy
OA0KPiB1c2Jzc3BfaW50cl9yZWdzICovDQo+ID4gKwlCVUlMRF9CVUdfT04oc2l6ZW9mKHN0cnVj
dCB1c2Jzc3BfcnVuX3JlZ3MpICE9ICg4KzgqMTI4KSozMi84KTsNCj4gDQo+IEkgbG92ZSBoYXJk
LWNvZGVkIG51bWJlcnMgYXMgbXVjaCBhcyB0aGUgbmV4dCBwZXJzb24sIGJ1dCByZWFsbHk/ICBJ
cyB0aGlzDQo+IG5lY2Vzc2FyeSBub3cgdGhhdCB5b3UgaGF2ZSB0aGUgY29kZSB1cCBhbmQgd29y
a2luZyBwcm9wZXJseT8NCg0KQ29kZSBpcyBzdGlsbCBiZWluZyBkZXZlbG9wZWQsICBhbmQgaXMg
c3RpbGwgdGVzdGVkLiBJdCdzIGJldHRlciB0byBsZWF2ZSB0aGlzIGNvZGUgYXQgDQp0aGlzIG1v
bWVudC4gIEkgd2lsbCByZW1vdmUgaXQgaW4gdGhlIGZlYXR1cmUuIA0KDQp0aGFua3MsDQpQYXdl
bCBMYXN6Y3phaw0K
