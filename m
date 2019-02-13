Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863B620643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="dFqpITn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfBMNDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:03:47 -0500
Received: from mail-eopbgr10134.outbound.protection.outlook.com ([40.107.1.134]:48723
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733281AbfBMNDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy3cSN5MdtPT1jJt3G84EVRJFt2GvNqUJo1DaR+IFsY=;
 b=dFqpITn5SmbyQWM37mf4CyyaVNHof4DyOKUs76XJDpmdlslrU5cKCYg6kbz0IkWHkDiqjJuR2ztiwQ3vijTY8zADdvxawkxak6ZbPN8IcJnR49bik+Pp/OWdXo3QAJwv3We4Un6Guu6SZnwCOLmS84QtB5fGw7Sg62iO9IWa6WU=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.9; Wed, 13 Feb 2019 13:03:39 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 13:03:39 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>
Subject: Re: [PATCH 4.14 198/205] perf/core: Dont WARN() for impossible
 ring-buffer sizes
Thread-Topic: [PATCH 4.14 198/205] perf/core: Dont WARN() for impossible
 ring-buffer sizes
Thread-Index: AQHUwh2ts6Ir49zUHk2QMyWGshaphqXdtNCA
Date:   Wed, 13 Feb 2019 13:03:39 +0000
Message-ID: <1eb319822aa9f75f423a7790e78315e7672036b9.camel@nokia.com>
References: <20190211141827.214852402@linuxfoundation.org>
         <20190211141841.367111122@linuxfoundation.org>
In-Reply-To: <20190211141841.367111122@linuxfoundation.org>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be5d474c-1260-45e8-362b-08d691b3ac39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3675;
x-ms-traffictypediagnostic: HE1PR0702MB3675:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA3MDJNQjM2NzU7MjM6Q3hhemprbjhUUjBac1dIcXNLemdFOCtm?=
 =?utf-8?B?ZUt6ZzVtcUJFeDJHeU44YjhRQTlXSXJQbVEyUFF3R2ZOKzNLb3hQaEhrRVFE?=
 =?utf-8?B?T2dxTm03bkJReEwvYSthcGk2SW9mTWozSys3aDNjVEJuUGJtZ2h3ODVuSWo2?=
 =?utf-8?B?UENQblZuLytIeHM5eDFCWEt3Yk5jT0pXUFNUUGtTOHduaUNBMmxzQnJjTFh5?=
 =?utf-8?B?YlhPOFZ2Z2VPcWNBa01uNE1kMW5nZytzUmZRNE1HNVVObUZOUHBGNUlvVlhk?=
 =?utf-8?B?TFV4d0Y5K0VGUkhLNmt4Nkc0dE1CT1JRM3JjZ2IzRzFldnlveStmZWNVdFZs?=
 =?utf-8?B?NDJxY3ZIVlZ2Sy81SHgvZ0VvejZPUmdtc3pJWEkvMk0vaVpjQWhNbWYwNXJm?=
 =?utf-8?B?aXFZdlJuWWlJeml3N0pRRWgvZS9JTTRabURaSG8wb1VsQXFMSG9IOFNMd0dF?=
 =?utf-8?B?eFVUZ2hSVWMwRi9WVng2RWk5S2xDRXBDUzdkbTBmSnArOG9HaTV5Sy9YazdX?=
 =?utf-8?B?OFI0YjJreFNSUGZIY1RWdVZuZmduWXphbkJxc2doSk9pV3MrNDZteENTSnNv?=
 =?utf-8?B?Vy82MGJlbFY1Wmd5ek82WU5SOTVCWVJvNmF1ckNzc21YRGFWb09ROUJxMm1E?=
 =?utf-8?B?bUp2TDZNMEtkTmw2U0I1R3FlOHhIMDFvQVVockw1R0ltSHJKWGlyWE1yTTR1?=
 =?utf-8?B?S202RXFTSFZpa2x6UWJ1VTJnVUxjS3pkUGd3cGswNVFwNVpTcEpZaSt4QWVw?=
 =?utf-8?B?MzkzL21nbHoxYXJ5NkdacmVwd25IZWF3Wk9JbVNSTkVtakJNTm1INWFGOURI?=
 =?utf-8?B?eGtmZDlRTVdFd20yL2FXN2wxVFp1RWl4SlR4U04wdkVxbjFKREQyL1daN1Bt?=
 =?utf-8?B?QWJBTjdqTmlXdXRBUlRPRzNKUmxIYXFZZ1RzMzdCcmNhc0d2a1FhOHNNZVBj?=
 =?utf-8?B?UzdGQi9ZZXhDNmVLK211TzNlZmcyWnd5NitQTHkybWZWakYvck9ma3lTZStU?=
 =?utf-8?B?R2lHMVIvYnhJZmRsN0hoT0t6U0FITktTeDlvUlo3MkNzaTg1Y2JoZ1MvUUlr?=
 =?utf-8?B?N1lwNlVmeXB4WnBNMUk4U0tFZGo5bE0xRGJWWERkQzZuckJlQnVHaXUyVXlU?=
 =?utf-8?B?T1FuUHNReE1wZm4rZjNFZDRpbFczbVpOSUd6T0VDem5wR0FLejlVR3dJaUdr?=
 =?utf-8?B?Y04rUk5yNU9sVEdrbWw2aFE1WmVIV0JTK3UwYmsrZzE2V2VNdzd1MGRORzY1?=
 =?utf-8?B?TUZJT0F4eXdOZVlZcFppaEpjNXZodTNTMXpuSDBWZytpZTVpT0ZvUWxYQmtB?=
 =?utf-8?B?eHZxZ3gxQ214cUpIVWNjSUhFYVdIUzJHLzgreUhOS3hRaWZDL2dCa2xIOW1x?=
 =?utf-8?B?OHg2Wm50SHg3czVnT0RVU0pzajZFM3BHSkZVVXZUL2phMDhGSEtHNjhCbUlP?=
 =?utf-8?B?TzRhd1BHdlFnazZaUmpMVm9zU2lvKzVKWjlVWG04dmsyTzltWEdMeUJZTzJh?=
 =?utf-8?B?QUNZUjZyZlo0Yk9LUVVmeFNsZTAyaTIxUFhiUmdiUHdKL1JoVXpuZ1pWK2Fr?=
 =?utf-8?B?UVduNlIrbnh1UDBtYkJTTG9EN3NOMjZNdk1vWUpDMVNtWXJIYmx0QSs1WXAz?=
 =?utf-8?B?R00vOFJraFlqN2JOL25ibzBoazY4bmFzTDBiNkh3UGxla3Nld2hTQWlHVVRZ?=
 =?utf-8?Q?nYwtYzYtYCkcRVUIgaNOE6jofF6H4oudmU0B3Afm7?=
x-microsoft-antispam-prvs: <HE1PR0702MB367561529D00AB3C077A376DB4660@HE1PR0702MB3675.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(110136005)(106356001)(8936002)(446003)(966005)(2616005)(7416002)(11346002)(105586002)(2906002)(97736004)(86362001)(476003)(6246003)(71190400001)(6116002)(486006)(54906003)(68736007)(14454004)(53936002)(316002)(478600001)(36756003)(3846002)(71200400001)(118296001)(256004)(102836004)(14444005)(6512007)(26005)(6436002)(2501003)(6486002)(66066001)(305945005)(81166006)(6506007)(25786009)(81156014)(99286004)(4326008)(186003)(6306002)(76176011)(8676002)(229853002)(7736002)(192303002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3675;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0hnYZK4sD9B+edxLn6SEW9UO7EZHn7Rg4+pz7Viqr3Z9jJBTLAIGeHEjnREYG7WnJ+WxX59425Ws20J2raulNpnBtkuITjWBMO7NZ1fLNnJL5Pb59FXw3UksKl2efkkJ0RBqDBflJjpByqUExD4wtdJR5dC0JBmt9J8s1YaOvHeK4x3Tvo2OY81wV/p2XQ0LxS8FQcPXdnAsQAg+TYxbfpF56q6OY/ecdPSVtf6Ec757pf77NTdgiwRBHuimA2604JUZ+UVIAZAnAqa6YfrP8UZgovLrV5x5nGbEBVN7sq67ZZlkHGYHkdaHy3G1Wz4MMq4HZzVxlYx08NAOug7PzlBSm9V1FGFya8X0smE6M0Wu4CMTVMLmewM/MsiyJVc9Lf5ihUk0Ry71Tkz40eZJlqY7L9gsZuxk/VsxTb9ytAY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DBC24B983AF6F44881CED58B12DF3FC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5d474c-1260-45e8-362b-08d691b3ac39
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 13:03:39.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTExIGF0IDE1OjE5ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IDQuMTQtc3RhYmxlIHJldmlldyBwYXRjaC4gIElmIGFueW9uZSBoYXMgYW55IG9iamVj
dGlvbnMsIHBsZWFzZSBsZXQNCj4gbWUga25vdy4NCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiANCj4gRnJvbTogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4gDQo+IGNv
bW1pdCA5ZGZmMGFhOTVhMzI0ZTI2MmZmYjAzZjQyNWQwMGU0NzUxZjMyOTRlIHVwc3RyZWFtLg0K
PiANCj4gVGhlIHBlcmYgdG9vbCB1c2VzIC9wcm9jL3N5cy9rZXJuZWwvcGVyZl9ldmVudF9tbG9j
a19rYiB0byBkZXRlcm1pbmUNCj4gaG93DQo+IGxhcmdlIGl0cyByaW5nYnVmZmVyIG1tYXAgc2hv
dWxkIGJlLiBUaGlzIGNhbiBiZSBjb25maWd1cmVkIHRvDQo+IGFyYml0cmFyeQ0KPiB2YWx1ZXMs
IHdoaWNoIGNhbiBiZSBsYXJnZXIgdGhhbiB0aGUgbWF4aW11bSBwb3NzaWJsZSBhbGxvY2F0aW9u
IGZyb20NCj4ga21hbGxvYy4NCj4gDQo+IFdoZW4gdGhpcyBpcyBjb25maWd1cmVkIHRvIGEgc3Vp
dGFibHkgbGFyZ2UgdmFsdWUgKGUuZy4gdGhhbmtzIHRvIHRoZQ0KPiBwZXJmIGZ1enplciksIGF0
dGVtcHRpbmcgdG8gdXNlIHBlcmYgcmVjb3JkIHRyaWdnZXJzIGEgV0FSTl9PTl9PTkNFKCkNCj4g
aW4NCj4gX19hbGxvY19wYWdlc19ub2RlbWFzaygpOg0KPiANCj4gICAgV0FSTklORzogQ1BVOiAy
IFBJRDogNTY2NiBhdCBtbS9wYWdlX2FsbG9jLmM6NDUxMQ0KPiBfX2FsbG9jX3BhZ2VzX25vZGVt
YXNrKzB4M2Y4LzB4YmM4DQo+IA0KPiBMZXQncyBhdm9pZCB0aGlzIGJ5IGNoZWNraW5nIHRoYXQg
dGhlIHJlcXVlc3RlZCBhbGxvY2F0aW9uIGlzDQo+IHBvc3NpYmxlDQo+IGJlZm9yZSBjYWxsaW5n
IGt6YWxsb2MuDQoNCkhpLA0KDQpQZXJmIHRvb2wgaXMgYnJva2VuIGZvciBtZSBpbiA0LjE0Ljk5
IChydW5uaW5nIGluIHg4Nl82NCBWTSksIGJpc2VjdGlvbg0KcG9pbnRzIHRvIHRoaXMgcGF0Y2gu
DQoNCiMgcGVyZiB0b3ANCkVycm9yOg0KRmFpbGVkIHRvIG1tYXAgd2l0aCAxMiAoQ2Fubm90IGFs
bG9jYXRlIG1lbW9yeSkNCg0KIyBwZXJmIHRyYWNlDQpDYW5ub3QgYWxsb2NhdGUgbWVtb3J5DQoN
CiMgc3RyYWNlIC1UIC10dCAtZiAteSBwZXJmIHRvcA0KWy4uLl0NCjE0OjIyOjA5LjgyOTU0NCBv
cGVuYXQoQVRfRkRDV0QsDQoiL3Byb2Mvc3lzL2tlcm5lbC9wZXJmX2V2ZW50X21sb2NrX2tiIiwg
T19SRE9OTFkpID0NCjE4PC9wcm9jL3N5cy9rZXJuZWwvcGVyZl9ldmVudF9tbG9ja19rYj4gPDAu
MDAwMDE1Pg0KMTQ6MjI6MDkuODI5NjEyIHJlYWQoMTg8L3Byb2Mvc3lzL2tlcm5lbC9wZXJmX2V2
ZW50X21sb2NrX2tiPiwgIjUxNlxuIiwNCjY0KSA9IDQgPDAuMDAwMDExPg0KMTQ6MjI6MDkuODI5
NjU1IGNsb3NlKDE4PC9wcm9jL3N5cy9rZXJuZWwvcGVyZl9ldmVudF9tbG9ja19rYj4pID0gMA0K
PDAuMDAwMDA4Pg0KMTQ6MjI6MDkuODI5NzAyIG1tYXAoTlVMTCwgNTI4Mzg0LCBQUk9UX1JFQUR8
UFJPVF9XUklURSwgTUFQX1NIQVJFRCwNCjM8YW5vbl9pbm9kZTpbcGVyZl9ldmVudF0+LCAwKSA9
IC0xIEVOT01FTSAoQ2Fubm90IGFsbG9jYXRlIG1lbW9yeSkNCjwwLjAwMDAxNT4NCjE0OjIyOjA5
LjgyOTc2MyB3cml0ZSgyPC9kZXYvcHRzLzA+LCAiRXJyb3I6XG4iLCA3KSA9IDcgPDAuMDAwMDA5
Pg0KMTQ6MjI6MDkuODI5ODEwIHdyaXRlKDI8L2Rldi9wdHMvMD4sICJGYWlsZWQgdG8gbW1hcCB3
aXRoIDEyIChDYW5ub3QNCmEiLi4uLCA0OCkgPSA0OCA8MC4wMDAwMDg+DQoNCg0KQ2hhbmdpbmcg
dGhlIHBhdGNoIGxpa2UgdGhpcyBmaXhlcyBpdC4uLg0KDQotICAgICAgIGlmIChvcmRlcl9iYXNl
XzIoc2l6ZSkgPj0gTUFYX09SREVSKQ0KKyAgICAgICBpZiAob3JkZXJfYmFzZV8yKHNpemUpID4g
TUFYX09SREVSKQ0KDQotVG9tbWkNCg0KDQo+IFJlcG9ydGVkLWJ5OiBKdWxpZW4gVGhpZXJyeSA8
anVsaWVuLnRoaWVycnlAYXJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFyayBSdXRsYW5kIDxt
YXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKElu
dGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IFJldmlld2VkLWJ5OiBKdWxpZW4gVGhpZXJy
eSA8anVsaWVuLnRoaWVycnlAYXJtLmNvbT4NCj4gQ2M6IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxl
eGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IEFybmFsZG8gQ2FydmFsaG8g
ZGUgTWVsbyA8YWNtZUByZWRoYXQuY29tPg0KPiBDYzogSmlyaSBPbHNhIDxqb2xzYUByZWRoYXQu
Y29tPg0KPiBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3Jn
Pg0KPiBDYzogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBDYzogUGV0ZXIg
WmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gTGlu
azogDQo+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTAxMTAxNDI3NDUuMjU0OTUtMS1t
YXJrLnJ1dGxhbmRAYXJtLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBJbmdvIE1vbG5hciA8bWluZ29A
a2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4NCj4gDQo+IC0tLQ0KPiAga2VybmVsL2V2ZW50cy9yaW5nX2J1
ZmZlci5jIHwgICAgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4g
DQo+IC0tLSBhL2tlcm5lbC9ldmVudHMvcmluZ19idWZmZXIuYw0KPiArKysgYi9rZXJuZWwvZXZl
bnRzL3JpbmdfYnVmZmVyLmMNCj4gQEAgLTcxOSw2ICs3MTksOSBAQCBzdHJ1Y3QgcmluZ19idWZm
ZXIgKnJiX2FsbG9jKGludCBucl9wYWdlDQo+ICAJc2l6ZSA9IHNpemVvZihzdHJ1Y3QgcmluZ19i
dWZmZXIpOw0KPiAgCXNpemUgKz0gbnJfcGFnZXMgKiBzaXplb2Yodm9pZCAqKTsNCj4gIA0KPiAr
CWlmIChvcmRlcl9iYXNlXzIoc2l6ZSkgPj0gTUFYX09SREVSKQ0KPiArCQlnb3RvIGZhaWw7DQo+
ICsNCj4gIAlyYiA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFyYikNCj4g
IAkJZ290byBmYWlsOw0KPiANCj4gDQoNCg==
