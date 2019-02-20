Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579DE2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="k/xaeMDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfBTKmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:42:55 -0500
Received: from mail-eopbgr720075.outbound.protection.outlook.com ([40.107.72.75]:42640
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbfBTKmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSRIaf/SIQw2ewfuha2Vp26ZKqiEaAoRSRLYM8H8OFc=;
 b=k/xaeMDapGFX7q7ZbTnX6F7AhZHlnNgiYj7Rcg6xUc2cm8J6g3F5OOd4IApIa9GhDxkpAR/KD30ZX2bKkR9mGR4wAekkbdOMGG/x2VLOeScbDgF5FPUWCJC130TpfJLST+dUC5k54IhvUDReV3O5sI5waEYcu/opHAKUy2eZPic=
Received: from BN6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:404:23::33)
 by SN6PR03MB3759.namprd03.prod.outlook.com (2603:10b6:805:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Wed, 20 Feb
 2019 10:42:47 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR03CA0023.outlook.office365.com
 (2603:10b6:404:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 20 Feb 2019 10:42:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 20 Feb 2019 10:42:46 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x1KAgjtg022885
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 20 Feb 2019 02:42:45 -0800
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Wed, 20 Feb 2019 05:42:45 -0500
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/6] iio: imu: adis16480: Add support for configurable
 drdy indicator
Thread-Topic: [PATCH 2/6] iio: imu: adis16480: Add support for configurable
 drdy indicator
Thread-Index: AQHUyHZwX/ozLflnuE6JsQrPR4AmGqXo0UmAgAADoQA=
Date:   Wed, 20 Feb 2019 10:42:44 +0000
Message-ID: <1550659364.9460.54.camel@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
         <1550596338-24220-3-git-send-email-stefan.popa@analog.com>
         <20190220102945.6af3edc4@archlinux>
In-Reply-To: <20190220102945.6af3edc4@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.179]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <878C7EDB692CEE4D9295D28C3E28D856@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(246002)(446003)(436003)(426003)(8676002)(336012)(50466002)(36756003)(8936002)(6246003)(103116003)(86362001)(23676004)(6916009)(4326008)(2486003)(5660300002)(14444005)(76176011)(229853002)(5640700003)(7696005)(356004)(2351001)(106466001)(316002)(54906003)(106002)(478600001)(26005)(186003)(72206003)(126002)(11346002)(305945005)(6116002)(3846002)(7636002)(7736002)(476003)(2616005)(2501003)(102836004)(2906002)(47776003)(486006)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3759;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 829b3b4a-804d-4173-1b43-08d697202700
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3759;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3759:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3759;20:wKGsH5LT+pNF0PQdV+kRRcKTN92yBefD5NDRSKuLHwU2GA9TKd/OhfaWOHrCWDXzLB6HG+eaDrO2FtK+SYNQerHFJuNd02mLlStL+hwFPbq/4x1W6fqdtJTsw69CvhImvkDsuLvP1mzw+1kE0WSO35x38IXCfxGi8+1rjXUVTT/cYLgzrVfeGNe2mY6cuwW7utIEaY/yNsjJd/2FY5oVfe5atXBzyCU9o65zqNa7Tj7XXkn0arzgbw0FPM/NuG1s/AthwNyP3TMc9vgq0CxUJ7FJ92/BcoqeEByTyq9mUYnfdN2ExjlR/PQOJ9ncMeyRHMdqYELwJ43GOLFqVV074ROL3VEp+7BDGQHUz2VdraMK4rswAjpcEkqyo0Voq8d+M6uc0CWemr79kPJjpyTmTtGJXvRKPYTuMXRQGo6FbDpg9rq5MmgHuJIb29VRLaPi5eJO+uZRBr0W16YRFsH7CglqDEXQwBbh9EcWkVP5o3+bclMeR2NPVDaJIQI9b4Q3
X-Microsoft-Antispam-PRVS: <SN6PR03MB3759A32FE42C1612D7FCB88C9D7D0@SN6PR03MB3759.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0954EE4910
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAzTUIzNzU5OzIzOlU1b25oM01SU1ZLWkhZTzF4TDk3aERReElr?=
 =?utf-8?B?V2lUVVUxVTd1SFQ0UW1PQi9DS05YdUhIclVNVXZFelJaU21KZkppSE9Ody9J?=
 =?utf-8?B?SHQ3ZmJZOFE4N0FrbnN3WTlsU0YxMEdWc2tqeDV0QTJlTDVxRnBoLy9Ddnp2?=
 =?utf-8?B?c2FOYnAyMFJ4bnNYTnI5L3FtQ04yYUxmUUlhK1lYalkyVFAxN3Y5SHlCMFkw?=
 =?utf-8?B?SVQ4cDhpWm9ZdWowWmdzeGVnbXZ0dHRBVkovcXJyNXNZTUJVdG1mWHRtVEFw?=
 =?utf-8?B?SVdBR0NnVE5vYXE3L3B0aGRQTEN0RlB2MGduNTM0eGxQeW9NbjBjaXQxSFRQ?=
 =?utf-8?B?Ui9FL053N2RZbDc0QlY4QXd5VXFhSmVoMDVBeFBJMmNmd1hiT216bGNRL0dL?=
 =?utf-8?B?VFQ5dnhFMjdTWDJFdEZlWGNCQ1E3U2xCdkxZUEdqM0p4QnhjbXY2RkpjSHAx?=
 =?utf-8?B?SHhDSXRnWlYyRmxINk55Q3FqRGFsQnd6VDI1MnMwVlp6TnI4US9SOHVYSWo2?=
 =?utf-8?B?czRaTm9BeXdWS0FGZkRRaGcvS2EyUW9jRTd3eVZaa2F6SVFQS2JTOVorMUp2?=
 =?utf-8?B?alB0UnZiQmlLRFNEblE2VVlqKzJWaEplaEZYa3hTNVNzUVR5bzNRcVc5bUhj?=
 =?utf-8?B?YUdsV2l3K0VsWnBSQ2RKZlhlZHd3eXY0RXlzRk9GeUhndlBSbjJTbWtnU3pG?=
 =?utf-8?B?OVAwdERvZEYvdG5Xb1VWMGhiUUlGUlJwcmpLQVBBOEROVDlTamF6OGkzak94?=
 =?utf-8?B?OEwzSm9ZUzFFemZyMG9GUEJoTjByc21zRmZGbXpzL1phK0JkNmJjWjc4czQ2?=
 =?utf-8?B?ZU01czhRVll2RUFZTy9GRFdocGJBNGRWUkRzbTZQd0FES3laNUFzalBJY0pV?=
 =?utf-8?B?WWNuZnI2dFVEUUhFTkQ5UE1LZGRGS3MrMXlubDczZUtjNVJ1S1VPT0lRK3BP?=
 =?utf-8?B?ZldVWkd4cHl3YVZUbUx5eXIzQmlSbWp1bTBtZ0orUWllNlliNnlEM21Qb0s4?=
 =?utf-8?B?c0dpV0s5MGVNWWQwcGdBRnZ6cWd3c21GRndpMXpDeXVwVVNSUkZsVkRiNnBk?=
 =?utf-8?B?WlVLUEt3RVV6VTc3K082cmJnb3QvZ1d4dERPQkNHWWMzem9XMTNRTUFZN3do?=
 =?utf-8?B?RGVnY0RMUW1HTGJuVmdDQUFjellCdCtteGxTbEVSNTUrS3J0L3RTSGl1Q3c5?=
 =?utf-8?B?cEpqWDNtMlNkOTBWWDFXeFRyczhtMWlEMURjd3l1UVh1QktUVWRNUFk2bmFN?=
 =?utf-8?B?OUFNdkY0TTVFQjJVYlVBUnZIWnRVeWxoc2dKUGJ1c1h2ZG1ScGhmNnU5VWJ6?=
 =?utf-8?B?dDBXTExRNzZXRDF4UC9mVnU4UXBTUFM2aUxWVTRZYytZRithZ0pBb3pDOHk4?=
 =?utf-8?B?S3A2ejMzdlBQSHNsbURoYUNJSW9TUHFXYW1Ecng0ODZ3SzZBS2N3U2RtdTIy?=
 =?utf-8?B?ZDRlKzc1QXp2SVJiVWNDdm43Q2IySncwMlRvY1dwMmxxMDZaMUVUaTRWNC9H?=
 =?utf-8?B?dG9naEhaZTZDU1Fka3ZTeTMwYTlGbTFHZW55NGpuQlQ5MXErVzR3bGh2eWdv?=
 =?utf-8?Q?T6YRj4vheJOUxFfygZZkxU8CGFddBNk2iVpZ30txayhc=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ht63GL2NKRX789DBqlACCNq8EESFRXbV+Q4J4YQ9yk7qzO1nTZ39WspzJQ131Dj5ZguVwisZ84hnAWmZF7z4VzApdYpN4wekVCQ1k3/WdU/dGkEnCkCfD2TtNGD9nyjJK04knPab78sFYEUUJyExiiwSCHwZod81PFClrOvgUfs9kiyfqIzc/oRSHqPlYrwQaUmLuUwJ6z0JXc6wQS6hgdfqLfZsLAtgf6lYJMUkT4sYzEYND41qCkAbRpDDFt6Bq7g4kOL7IvEGNgAqFIq7yIT8n2FrLw5P8GiA/tiX+ZTjjzRo02GPDV0dRGjmCRYfteS4kxmaSFVsykgYNKfmFSx09gXrNWbSYYaCLI9mWa/diFKIOFKMF4Wm0k0s7r3Bowa1bGQTiDvD8icfYjmX1h5v2OSrHI2WpjUyJEl8c1Y=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2019 10:42:46.4356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 829b3b4a-804d-4173-1b43-08d697202700
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMTktMDItMjAgYXQgMTA6MjkgKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBUdWUsIDE5IEZlYiAyMDE5IDE5OjEyOjE0ICsw
MjAwDQo+IFN0ZWZhbiBQb3BhIDxzdGVmYW4ucG9wYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+
ID4gDQo+ID4gVGhlIEZOQ1RJT19DVFJMIHJlZ2lzdGVyIHByb3ZpZGVzIGNvbmZpZ3VyYXRpb24g
Y29udHJvbCBmb3IgZWFjaCBJL08NCj4gPiBwaW4NCj4gPiAoRElPMSwgRElPMiwgRElPMyBhbmQg
RElPNCkuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBvcHRpb24gdG8gY29uZmlndXJl
IGVhY2ggRElPeCBwaW4gYXMgZGF0YSByZWFkeQ0KPiA+IGluZGljYXRvciB3aXRoIHBvc2l0aXZl
IG9yIG5lZ2F0aXZlIHBvbGFyaXR5IGJ5IHJlYWRpbmcgdGhlDQo+ID4gJ2ludGVycnVwdHMnDQo+
ID4gYW5kICdpbnRlcnJ1cHQtbmFtZXMnIHByb3BlcnRpZXMgZnJvbSB0aGUgZGV2aWNldHJlZS4g
VGhlDQo+ID4gJ2ludGVycnVwdC1uYW1lcycgcHJvcGVydHkgaXMgb3B0aW9uYWwsIGlmIGl0IGlz
IG5vdCBzcGVjaWZpZWQsIHRoZW4NCj4gPiB0aGUNCj4gPiBmYWN0b3J5IGRlZmF1bHQgRElPMiBk
YXRhIHJlYWR5IHNpZ25hbCBpcyB1c2VkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZh
biBQb3BhIDxzdGVmYW4ucG9wYUBhbmFsb2cuY29tPg0KPiBPdGhlciB0aGFuIGZvbGxvdyBvbiBm
cm9tIHRoZSBwcmV2aW91cyBwYXRjaCBjaGFuZ2Ugb2YgdGhlIGRlZmF1bHQsIHRoaXMNCj4gbG9v
a3MgZmluZSB0byBtZS4NCj4gDQo+IE9uZSBxdWVzdGlvbiBpbmxpbmUuDQo+IA0KPiBKb25hdGhh
bg0KSGkgSm9uYXRoYW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyENCkkgd2lsbCBmYWxs
IGJhY2sgb24gdGhlICd3cm9uZycgZGVmYXVsdCBpbiB0aGUgcHJldmlvdXMgcGF0Y2guDQpBbnN3
ZXIgaW5saW5lLg0KDQotU3RlZmFuDQoNCj4gPiANCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvaWlv
L2ltdS9hZGlzMTY0ODAuYyB8IDc2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMgYi9kcml2
ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMNCj4gPiBpbmRleCBkMjIyMTg4Li4zOGJhMGMxIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0ODAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaWlvL2ltdS9hZGlzMTY0ODAuYw0KPiA+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4gwqAgKi8N
Cj4gPiANCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvb2ZfaXJxLmg+DQo+ID4gwqAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ID4g
wqAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9tdXRleC5o
Pg0KPiA+IEBAIC0xMDksNiArMTEwLDEwIEBADQo+ID4gwqAjZGVmaW5lDQo+ID4gQURJUzE2NDgw
X0ZJUl9DT0VGX0QoeCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oEFESVMxNjQ4MF9GSVJfQ09FRigweDBCLA0KPiA+ICh4KSkNCj4gPiANCj4gPiDCoC8qIEFESVMx
NjQ4MF9SRUdfRk5DVElPX0NUUkwgKi8NCj4gPiArI2RlZmluZSBBRElTMTY0ODBfRFJEWV9TRUxf
TVNLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgR0VOTUFTSygxLCAwKQ0KPiA+ICsjZGVm
aW5lDQo+ID4gQURJUzE2NDgwX0RSRFlfU0VMKHgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBGSUVMRF9QUkVQKEFESVMxNjQ4MF9EUkRZX1NFTF9NU0ssDQo+ID4geCkNCj4gPiArI2Rl
ZmluZSBBRElTMTY0ODBfRFJEWV9QT0xfTVNLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
QklUKDIpDQo+ID4gKyNkZWZpbmUNCj4gPiBBRElTMTY0ODBfRFJEWV9QT0woeCnCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoEZJRUxEX1BSRVAoQURJUzE2NDgwX0RSRFlfUE9MX01TSywN
Cj4gPiB4KQ0KPiA+IMKgI2RlZmluZSBBRElTMTY0ODBfRFJEWV9FTl9NU0vCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoEJJVCgzKQ0KPiA+IMKgI2RlZmluZSBBRElTMTY0ODBfRFJEWV9F
Tih4KcKgwqDCoMKgwqDCoMKgwqDCoEZJRUxEX1BSRVAoQURJUzE2NDgwX0RSRFlfRU5fTVNLLA0K
PiA+IHgpDQo+ID4gDQo+ID4gQEAgLTEyMSwxMiArMTI2LDI2IEBAIHN0cnVjdCBhZGlzMTY0ODBf
Y2hpcF9pbmZvIHsNCj4gPiDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgYWNjZWxfbWF4X3NjYWxl
Ow0KPiA+IMKgfTsNCj4gPiANCj4gPiArZW51bSBhZGlzMTY0ODBfaW50X3BpbiB7DQo+ID4gK8Kg
wqDCoMKgwqBBRElTMTY0ODBfUElOX0RJTzEsDQo+ID4gK8KgwqDCoMKgwqBBRElTMTY0ODBfUElO
X0RJTzIsDQo+ID4gK8KgwqDCoMKgwqBBRElTMTY0ODBfUElOX0RJTzMsDQo+ID4gK8KgwqDCoMKg
wqBBRElTMTY0ODBfUElOX0RJTzQNCj4gPiArfTsNCj4gPiArDQo+ID4gwqBzdHJ1Y3QgYWRpczE2
NDgwIHsNCj4gPiDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgYWRpczE2NDgwX2NoaXBfaW5mbyAq
Y2hpcF9pbmZvOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoHN0cnVjdCBhZGlzIGFkaXM7DQo+ID4g
wqB9Ow0KPiA+IA0KPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGFkaXMxNjQ4MF9pbnRf
cGluX25hbWVzWzRdID0gew0KPiA+ICvCoMKgwqDCoMKgW0FESVMxNjQ4MF9QSU5fRElPMV0gPSAi
RElPMSIsDQo+ID4gK8KgwqDCoMKgwqBbQURJUzE2NDgwX1BJTl9ESU8yXSA9ICJESU8yIiwNCj4g
PiArwqDCoMKgwqDCoFtBRElTMTY0ODBfUElOX0RJTzNdID0gIkRJTzMiLA0KPiA+ICvCoMKgwqDC
oMKgW0FESVMxNjQ4MF9QSU5fRElPNF0gPSAiRElPNCIsDQo+ID4gK307DQo+ID4gKw0KPiA+IMKg
I2lmZGVmIENPTkZJR19ERUJVR19GUw0KPiA+IA0KPiA+IMKgc3RhdGljIHNzaXplX3QgYWRpczE2
NDgwX3Nob3dfZmlybXdhcmVfcmV2aXNpb24oc3RydWN0IGZpbGUgKmZpbGUsDQo+ID4gQEAgLTg0
MCw2ICs4NTksNTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZGlzX2RhdGEgYWRpczE2NDgwX2Rh
dGEgPSB7DQo+ID4gwqDCoMKgwqDCoMKgLmVuYWJsZV9pcnEgPSBhZGlzMTY0ODBfZW5hYmxlX2ly
cSwNCj4gPiDCoH07DQo+ID4gDQo+ID4gK3N0YXRpYyBpbnQgYWRpczE2NDgwX2NvbmZpZ19pcnFf
cGluKHN0cnVjdCBkZXZpY2Vfbm9kZSAqb2Zfbm9kZSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGFk
aXMxNjQ4MCAqc3QpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoHN0cnVjdCBpcnFfZGF0YSAqZGVz
YzsNCj4gPiArwqDCoMKgwqDCoGVudW0gYWRpczE2NDgwX2ludF9waW4gcGluOw0KPiA+ICvCoMKg
wqDCoMKgdW5zaWduZWQgaW50IGlycV90eXBlOw0KPiA+ICvCoMKgwqDCoMKgdWludDE2X3QgdmFs
Ow0KPiA+ICvCoMKgwqDCoMKgaW50IGksIGlycSA9IDA7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKg
ZGVzYyA9IGlycV9nZXRfaXJxX2RhdGEoc3QtPmFkaXMuc3BpLT5pcnEpOw0KPiA+ICvCoMKgwqDC
oMKgaWYgKCFkZXNjKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2Vycigm
c3QtPmFkaXMuc3BpLT5kZXYsICJDb3VsZCBub3QgZmluZCBJUlEgJWRcbiIsDQo+ID4gaXJxKTsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4gPiArwqDC
oMKgwqDCoH0NCj4gPiArDQo+ID4gK8KgwqDCoMKgwqAvKiBEaXNhYmxlIGRhdGEgcmVhZHkgKi8N
Cj4gPiArwqDCoMKgwqDCoHZhbCA9IEFESVMxNjQ4MF9EUkRZX0VOKDApOw0KPiBEb2VzIGl0IGRl
ZmF1bHQgdG8gb24gYWZ0ZXIgcmVzZXQ/DQo+IFRoYXQncyBhIGxpdHRsZSB1bnVzdWFsIGFuZCBu
YXN0eS7CoMKgSWYgbm90LCB3aHkgYXJlIHlvdSBkaXNhYmxpbmcgaGVyZT8NClllcywgdGhlIGRl
ZmF1bHQgYWZ0ZXIgcmVzZXQgaXMgb24uwqANCj4gPiANCj4gPiArDQo+ID4gK8KgwqDCoMKgwqAv
Kg0KPiA+ICvCoMKgwqDCoMKgwqAqIEdldCB0aGUgaW50ZXJydXB0IGZyb20gdGhlIGRldmljZXRy
ZSBieSByZWFkaW5nIHRoZQ0KPiA+ICvCoMKgwqDCoMKgwqAqIGludGVycnVwdC1uYW1lcyBwcm9w
ZXJ0eS4gSWYgaXQgaXMgbm90IHNwZWNpZmllZCwgdXNlDQo+ID4gK8KgwqDCoMKgwqDCoCogdGhl
IGRlZmF1bHQgaW50ZXJydXB0IG9uIERJTzIgcGluLg0KPiA+ICvCoMKgwqDCoMKgwqAqLw0KPiA+
ICvCoMKgwqDCoMKgcGluID0gQURJUzE2NDgwX1BJTl9ESU8yOw0KPiA+ICvCoMKgwqDCoMKgZm9y
IChpID0gMDsgaSA8IEFSUkFZX1NJWkUoYWRpczE2NDgwX2ludF9waW5fbmFtZXMpOyBpKyspIHsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpcnEgPSBvZl9pcnFfZ2V0X2J5bmFtZShv
Zl9ub2RlLA0KPiA+IGFkaXMxNjQ4MF9pbnRfcGluX25hbWVzW2ldKTsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAoaXJxID4gMCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW4gPSBpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9DQo+ID4gK8KgwqDCoMKgwqB9DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgdmFsIHw9IEFE
SVMxNjQ4MF9EUkRZX1NFTChwaW4pOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoC8qDQo+ID4gK8Kg
wqDCoMKgwqDCoCogR2V0IHRoZSBpbnRlcnJ1cHQgbGluZSBiZWhhdmlvdXIuIFRoZSBkYXRhIHJl
YWR5IHBvbGFyaXR5IGNhbg0KPiA+IGJlDQo+ID4gK8KgwqDCoMKgwqDCoCogY29uZmlndXJlZCBh
cyBwb3NpdGl2ZSBvciBuZWdhdGl2ZSwgY29ycmVzcG9uZGluZyB0bw0KPiA+ICvCoMKgwqDCoMKg
wqAqIElSUUZfVFJJR0dFUl9SSVNJTkcgb3IgSVJRRl9UUklHR0VSX0ZBTExJTkcgcmVzcGVjdGl2
ZWx5Lg0KPiA+ICvCoMKgwqDCoMKgwqAqLw0KPiA+ICvCoMKgwqDCoMKgaXJxX3R5cGUgPSBpcnFk
X2dldF90cmlnZ2VyX3R5cGUoZGVzYyk7DQo+ID4gK8KgwqDCoMKgwqBpZiAoaXJxX3R5cGUgPT0g
SVJRRl9UUklHR0VSX1JJU0lORykgeyAvKiBEZWZhdWx0ICovDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdmFsIHw9IEFESVMxNjQ4MF9EUkRZX1BPTCgxKTsNCj4gPiArwqDCoMKgwqDC
oH0gZWxzZSBpZiAoaXJxX3R5cGUgPT0gSVJRRl9UUklHR0VSX0ZBTExJTkcpIHsNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2YWwgfD0gQURJUzE2NDgwX0RSRFlfUE9MKDApOw0KPiA+
ICvCoMKgwqDCoMKgfSBlbHNlIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZf
ZXJyKCZzdC0+YWRpcy5zcGktPmRldiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIkludmFsaWQgaW50ZXJydXB0IHR5cGUgMHgleCBzcGVjaWZpZWRcbiIs
DQo+ID4gaXJxX3R5cGUpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAt
RUlOVkFMOw0KPiA+ICvCoMKgwqDCoMKgfQ0KPiA+ICvCoMKgwqDCoMKgLyogV3JpdGUgdGhlIGRh
dGEgcmVhZHkgY29uZmlndXJhdGlvbiB0byB0aGUgRk5DVElPX0NUUkwgcmVnaXN0ZXINCj4gPiAq
Lw0KPiA+ICvCoMKgwqDCoMKgcmV0dXJuIGFkaXNfd3JpdGVfcmVnXzE2KCZzdC0+YWRpcywgQURJ
UzE2NDgwX1JFR19GTkNUSU9fQ1RSTCwNCj4gPiB2YWwpOw0KPiA+ICt9DQo+ID4gKw0KPiA+IMKg
c3RhdGljIGludCBhZGlzMTY0ODBfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiDC
oHsNCj4gPiDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCAqaWQgPSBzcGlf
Z2V0X2RldmljZV9pZChzcGkpOw0KPiA+IEBAIC04NjcsNiArOTM5LDEwIEBAIHN0YXRpYyBpbnQg
YWRpczE2NDgwX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4gwqDCoMKgwqDCoMKg
aWYgKHJldCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCj4g
PiANCj4gPiArwqDCoMKgwqDCoHJldCA9wqDCoGFkaXMxNjQ4MF9jb25maWdfaXJxX3BpbihzcGkt
PmRldi5vZl9ub2RlLCBzdCk7DQo+ID4gK8KgwqDCoMKgwqBpZiAocmV0KQ0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoHJl
dCA9IGFkaXNfc2V0dXBfYnVmZmVyX2FuZF90cmlnZ2VyKCZzdC0+YWRpcywgaW5kaW9fZGV2LCBO
VUxMKTsNCj4gPiDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gcmV0Ow==
