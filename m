Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF75C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1E320827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TkcPWDmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1E320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeKFLlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:41:31 -0500
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:64336
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbeKFLlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+X6+H2wYIN2KcZhaOX11XHFqccpx5+VkpEirZOnE8c=;
 b=TkcPWDmMcxpUJgIrbR8nQmCUlBW7AlqOJjzgYIlALEX9NjOXhLCc7+5gMlyCITbmtS78adtMrEcZoqEoVP0kn4fOivUtBeu3VUHLj+Acs77BAGVOvkYHiFTZMK6gd28wKAF+1tpDpNBXxTCi0tA4RtRsbl3+5E+gDjjiT9JBYtI=
Received: from BY1PR12MB0502.namprd12.prod.outlook.com (10.162.147.154) by
 BY1PR12MB0456.namprd12.prod.outlook.com (10.162.147.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 02:18:39 +0000
Received: from BY1PR12MB0502.namprd12.prod.outlook.com
 ([fe80::3cb6:d79:f32:b21]) by BY1PR12MB0502.namprd12.prod.outlook.com
 ([fe80::3cb6:d79:f32:b21%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 02:18:38 +0000
From:   "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To:     Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/syncobj: Fix oops on
 drm_syncobj_find_fence(file_priv, 0, ...).
Thread-Topic: [PATCH] drm/syncobj: Fix oops on
 drm_syncobj_find_fence(file_priv, 0, ...).
Thread-Index: AQHUdVt0Db+fV5+tX0aeLX/158BMdqVCAy4A
Date:   Tue, 6 Nov 2018 02:18:38 +0000
Message-ID: <BY1PR12MB050299A6BA4B1967250724AAB4CB0@BY1PR12MB0502.namprd12.prod.outlook.com>
References: <20181105230110.4812-1-eric@anholt.net>
In-Reply-To: <20181105230110.4812-1-eric@anholt.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR12MB0456;20:+mBJggADgVHO2A2G7vHeEEBXx3f7yQsNAjmA102Oz/vjC4VEPFvv/YlKa/dvfNkD7fPmDZrDxiK3r3x1N03R6MDcT0J0GY3rjRW3lB7KG5eFXXgAFMLGmMvl9Qzt8DgNQzQJWkyc5L6Pn1VIZ5KUtoVZsNsB0TwOTPvewzTwOyeHsN8UCulQ+kl1Y898i3LZTqNsX2HqgsQhaLLeerJUIXMc2nH0NvvVYRoWSG8KGqmTIC/xCChF5Nc4FzmwpSty
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(13464003)(199004)(189003)(72206003)(2906002)(74316002)(66066001)(2900100001)(102836004)(105586002)(486006)(6436002)(55016002)(9686003)(6116002)(6506007)(2501003)(316002)(11346002)(68736007)(110136005)(256004)(14444005)(54906003)(26005)(476003)(3846002)(86362001)(446003)(186003)(81166006)(71200400001)(81156014)(5660300001)(8676002)(71190400001)(76176011)(97736004)(33656002)(53546011)(66574009)(99286004)(229853002)(7736002)(305945005)(7696005)(4326008)(14454004)(478600001)(6246003)(8936002)(106356001)(53936002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0456;H:BY1PR12MB0502.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 6d353f94-b2e4-405e-4fe2-08d6438e29b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0456;
x-ms-traffictypediagnostic: BY1PR12MB0456:
x-microsoft-antispam-prvs: <BY1PR12MB04562EBEE7D06EF69B8C7867B4CB0@BY1PR12MB0456.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY1PR12MB0456;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0456;
x-forefront-prvs: 0848C1A6AA
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AkIVYud/AOiuHmzkZpJd3NrdtYToAP4PQWXLn83V0f2iOBNe6Wav3AxMTRxC2DW27SvMrO4lgvXEoyhP8Zazy23KSS8N5z4/o3vUcDypDjJ1+WpKARiHq/sMqzT89Yh72fwAZlvzusrIQEY1PkCNzpRVjJu4kqnJ7u5iEf8n21OFgvUNJvgAR1D5O5IIByCwL57tla2/rBVSukw+QhqP/iOh2oXdeCKFhu4b3MZEnyyLdPq3caibJhrwBHAYgFn5vhStNRCiBgO03xSUGtiDslGRKdhsFvgsEdKEMUQbNClppGkNIHWHajzkWKE5Fr9emqOKcKh5Hql7ZDWNSSqBX8ak+djQgGXeKOweS7sUvc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d353f94-b2e4-405e-4fe2-08d6438e29b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 02:18:38.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+DQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBbmhvbHQgPGVyaWNAYW5ob2x0
Lm5ldD4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMDYsIDIwMTggNzowMSBBTQ0KPiBUbzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgRXJpYyBBbmhvbHQgPGVyaWNAYW5ob2x0Lm5ldD47IFpob3UsDQo+IERhdmlk
KENodW5NaW5nKSA8RGF2aWQxLlpob3VAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL3N5bmNvYmo6
IEZpeCBvb3BzIG9uDQo+IGRybV9zeW5jb2JqX2ZpbmRfZmVuY2UoZmlsZV9wcml2LCAwLCAuLi4p
Lg0KPiANCj4gVGhpcyBicm9rZSByZW5kZXJpbmcgb24gVjNELCB3aGVyZSB3ZSBhbG1vc3QgYWx3
YXlzIGhhdmUgYSAwIGluLXN5bmNvYmouDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEFuaG9s
dCA8ZXJpY0BhbmhvbHQubmV0Pg0KPiBGaXhlczogNDgxOTdiYzU2NGM3ICgiZHJtOiBhZGQgc3lu
Y29iaiB0aW1lbGluZSBzdXBwb3J0IHY5IikNCj4gQ2M6IENodW5taW5nIFpob3UgPGRhdmlkMS56
aG91QGFtZC5jb20+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMgfCAzICsrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2RybV9zeW5jb2JqLmMgaW5kZXggNGRjYTVmN2U4YzRiLi5kYTgxNzVkOWM2ZmYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9kcm1fc3luY29iai5jDQo+IEBAIC00NDMsNyArNDQzLDggQEAgaW50IGRybV9z
eW5jb2JqX2ZpbmRfZmVuY2Uoc3RydWN0IGRybV9maWxlDQo+ICpmaWxlX3ByaXZhdGUsDQo+ICAJ
aW50IHJldDsNCj4gDQo+ICAJcmV0ID0gZHJtX3N5bmNvYmpfc2VhcmNoX2ZlbmNlKHN5bmNvYmos
IHBvaW50LCBmbGFncywgZmVuY2UpOw0KPiAtCWRybV9zeW5jb2JqX3B1dChzeW5jb2JqKTsNCj4g
KwlpZiAoc3luY29iaikNCj4gKwkJZHJtX3N5bmNvYmpfcHV0KHN5bmNvYmopOw0KPiAgCXJldHVy
biByZXQ7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGRybV9zeW5jb2JqX2ZpbmRfZmVuY2UpOw0K
PiAtLQ0KPiAyLjE5LjENCg0K
