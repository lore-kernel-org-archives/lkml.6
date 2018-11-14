Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B1322419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SeBwGb5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B1322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeKOJaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:30:39 -0500
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:28509
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKOJai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjXmBNg8+V2qsSKOx8y+fO/wG2ll61vGw+qpC1h6Rbw=;
 b=SeBwGb5j2lCq8MqAN9Yb6ntlma7qOqnoDju/OdR4ipIywG1pzDyE0UBENN+f6uYReswsWgXfXvHCI0JBpIjWTvcnf/2kLlr3FyuW/4UfDzR0TgITxlU/zRROv5NANyOmM0N9xHGWvgbZUHxmbL2Zp3s8wEvaR6SzDp/rwbDTDL4=
Received: from VI1PR0801MB1759.eurprd08.prod.outlook.com (10.168.67.136) by
 VI1PR0801MB1456.eurprd08.prod.outlook.com (10.167.210.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Wed, 14 Nov 2018 23:25:11 +0000
Received: from VI1PR0801MB1759.eurprd08.prod.outlook.com
 ([fe80::81af:f6b8:1a7b:6108]) by VI1PR0801MB1759.eurprd08.prod.outlook.com
 ([fe80::81af:f6b8:1a7b:6108%9]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 23:25:11 +0000
From:   Grant Likely <Grant.Likely@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Thread-Topic: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Thread-Index: AQHUefR84LQ0qAkG3kalEpJdar8sfqVP7pmA
Date:   Wed, 14 Nov 2018 23:25:11 +0000
Message-ID: <a86a59f9-38e2-aece-92b4-c149918efe17@arm.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VfwKbzLNrxWRhoGW3aLN1PLWhx7sXWMgyFw2kS+4KZcuQ@mail.gmail.com>
 <CABGGisw-eid3Cq0HRu_Bw720JVy56jDCiSNyOY2s-JU6X5wRWg@mail.gmail.com>
In-Reply-To: <CABGGisw-eid3Cq0HRu_Bw720JVy56jDCiSNyOY2s-JU6X5wRWg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0090.namprd19.prod.outlook.com
 (2603:10b6:320:1f::28) To VI1PR0801MB1759.eurprd08.prod.outlook.com
 (2603:10a6:800:5b::8)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [64.114.255.114]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0801MB1456;6:BG6z5iInM6IbTe3GhC0c8Hl70g4Kzz32+sZA7B3EPmQEhiRlg4qJN0+/N1wHhbJsUBIPdwmZmW0g4gRgXkXCqrtsFjFXouqCx5X4huizU7ajetfonVvkq2YzQodOhoRJXpYgEFTuB22ws/t3feLKOAdIaakX/TdkDyIZy7w+HGEYST+YtldgIGJaBPbkJYocELUonoHfXpqKRyzZFSDbGmyCQYUU2giYCIuDhTqBb2qe4p+cc1ew5PMUsqDtQEYpYjTJJ1Pv3mOnqhr4EQfdfuq2EAtjzglGxoCR/B9qtIzVgPdGLvNofmUsI/+UJmXua1PB0w3aOvwg+rXxkNgg8m84xvNbxZoTFenuErJJ4DQVLxG16O2dsxHkkNXK9j03nIPec1WAK/oLsAe2GrSOZ0krG9F8magKHeFA9iC9Nt2f7QpM7wEpnFz8mRndYCasGrQkkOuJqh5nrMH2AXncuQ==;5:WIrioD1f1woCHidiVCVhZTXQBkl9zX57Cj9O+OQPFB91hYycCcM7Cj93gc+uSiO4N107VojO8FJUBGhN+EGAeNqI0HCn28ci65Yv1bnz1lH0iCmxDei8p1IQEJp83gqWrP0r8q43zvDzqxtmDrSm4TESpjvjou1jtG6e5gV9esQ=;7:QHMrKBm3/SFctxoGkIcnQaS0r5jTjvYmDmJKtP5q9MGLVyHajmJ1UU3Q2cAMhD5T/u9B4M2aNn0CIaxirN42sogjNG75RsPfjCRe3M9r7KrKt5hhPVq+/ECgmBQLpWqSPT7m3Nc13Qr8fyhrvbQRBg==
x-ms-office365-filtering-correlation-id: 9393d237-53fb-4920-e798-08d64a886bcc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1456;
x-ms-traffictypediagnostic: VI1PR0801MB1456:
x-microsoft-antispam-prvs: <VI1PR0801MB1456A464B8556933743676AF95C30@VI1PR0801MB1456.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0801MB1456;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1456;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(40434004)(199004)(189003)(68736007)(53936002)(36756003)(2906002)(2616005)(6512007)(476003)(65956001)(3846002)(6116002)(5660300001)(72206003)(65806001)(66066001)(65826007)(478600001)(305945005)(39060400002)(7736002)(54906003)(11346002)(110136005)(2900100001)(86362001)(31696002)(446003)(25786009)(58126008)(44832011)(316002)(64126003)(486006)(256004)(5024004)(14444005)(71190400001)(71200400001)(31686004)(6436002)(99286004)(97736004)(102836004)(8936002)(186003)(6486002)(4326008)(6246003)(14454004)(81156014)(26005)(81166006)(229853002)(8676002)(53546011)(76176011)(106356001)(105586002)(52116002)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1456;H:VI1PR0801MB1759.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mmvsUUqVxM/F9oahLlgS4zk34HPbmOmaa2ATV/mk8F/QwhNK/b1aCQel+GfzdOozQ8xEI/8bZiiIo3XnXJ+3vipo9yf+wpEq/GSZWtAwcYXgmmLPGPXGlGdFVHBgaQII++GtKfcahJO5MuDtYAa1U2NH6gX/YUh5ltBY628cfGvIGTOCtBbNdxAla/+rxrQ2horIIf49wKzi2VpqU0pX+MGVy22hW2AVtXx0MFptCKCJ/hEXAU9k/1LgWT3kUtIbS9Ytj2/JFJbQDfTqu/gp3lclZRRyAuujtU6Ds3dpi3asWigOgXdgZsJZsMilhwNDj+1Et8xpZX5BkonDiWm/yGpM65P93N+jmUjtALMFAAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A2A12DB5AE761418FEEA2927AF581EB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9393d237-53fb-4920-e798-08d64a886bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 23:25:11.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzExLzIwMTggMTk6MjYsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBTdW4sIE5v
diAxMSwgMjAxOCBhdCA3OjA0IEFNIEFuZHkgU2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSSBzZWVtcyBHcmFudCdzIG1haWwgZGVsaXZlcnkg
Ym91bmNlcyBtZXNzYWdlcy4gSSBkZWxpYmlyYXRlbHkgcmVkdWNlZA0KPj4gdGhlIENjIGxpc3Qg
Zm9yIHNha2Ugb2YgcGluZyBHcmFudCBpbiBjYXNlIGl0IHdvdWxkIHBhc3MuDQo+DQo+IFRoYXQg
d291bGQgYmUgYmVjYXVzZSBoZSBpcyBub3QgYXQgTGluYXJvIGFueW1vcmUuIEFkZGVkIGhpcyBB
Uk0gYWNjb3VudC4NCj4NCj4+IE9uIFNhdCwgTm92IDEwLCAyMDE4IGF0IDg6MTIgUE0gQW5keSBT
aGV2Y2hlbmtvDQo+PiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToN
Cj4+Pg0KPj4+IENvbnNpZGVyIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW8uDQo+Pj4NCj4+PiBUaGVy
ZSBhcmUgdHdvIGluZGVwZW5kZW50IGRldmljZXMgY291cGxlZCB0b2dldGhlciBieSBmdW5jdGlv
bmFsIGRlcGVuZGVuY2llczoNCj4+PiAgIC0gVVNCIE9URyAoZHdjMy1wY2kpDQo+Pj4gICAtIGV4
dGNvbiAodGVzdGVkIHdpdGggZXh0Y29uLWludGVsLW1yZmxkLCBub3QgeWV0IGluIHVwc3RyZWFt
KQ0KPj4+DQo+Pj4gRWFjaCBvZiB0aGUgZHJpdmVyIHNlcnZpY2VzIGEgY29ycmVzcG9uZGluZyBk
ZXZpY2UgaXMgYnVpbHQgYXMgYSBtb2R1bGUuIEluIHRoZQ0KPj4+IEJ1aWxkcm9vdCBlbnZpcm9u
bWVudCB0aGUgbW9kdWxlcyBhcmUgcHJvYmVkIGJ5IGFscGhhYmV0aWNhbCBvcmRlcmluZyBvZiB0
aGVpcg0KPj4+IG1vZGFsaWFzZXMuIFRoZSBsYXR0ZXIgY29tZXMgdG8gdGhlIGNhc2Ugd2hlbiBV
U0IgT1RHIGRyaXZlciB3aWxsIGJlIHByb2JlZA0KPj4+IGZpcnN0IGZvbGxvd2VkIGJ5IGV4dGNv
biBvbmUuDQo+Pj4NCj4+PiBTbywgaWYgdGhlIHBsYXRmb3JtIGFudGljaXBhdGVzIGV4dGNvbiBk
ZXZpY2UgdG8gYmUgYXBwZWFyZWQsIGluIHRoZSBhYm92ZSBjYXNlDQo+Pj4gd2Ugd2lsbCBnZXQg
ZGVmZXJyZWQgcHJvYmUgb2YgVVNCIE9URywgYmVjYXVzZSBvZiBvcmRlcmluZy4NCj4+Pg0KPj4+
IE5vdywgYSBjaGVycnkgb24gdG9wIG9mIHRoZSBjYWtlLCB0aGUgZGVmZXJyZWQgcHJvYmluZyBs
aXN0IGNvbnRhaW5zDQo+Pj4gdGhlIG9ubHkgdHdvIG1vZHVsZXMsIGkuZS4gVVNCIE9URyBhbmQg
ZXh0Y29uLiBEdWUgdG8gYWJvdmUgY2lyY3Vtc3RhbmNlcywNCj4+PiB2YWx1ZXMgaW4gdGhlIGxv
Y2FsX3RyaWdnZXJfY291bnQgYW5kIGRlZmVycmVkX3RyaWdnZXJfY291bnQgYXJlIG5vdCB0aGUg
c2FtZSwNCj4+PiBhbmQgdGh1cyBwcm92b2tlcyBkZWZlcnJlZCBwcm9iZSB0cmlnZ2VyaW5nIGFn
YWluIGFuZCBhZ2Fpbi4NCj4+Pg0KPj4+IC4uLg0KPj4+IFsgICAyMC42NzgzMzJdIHBsYXRmb3Jt
IGR3YzMuMC5hdXRvOiBSZXRyeWluZyBmcm9tIGRlZmVycmVkIGxpc3QNCj4+PiBbICAgMjAuNjk0
NzQzXSBwbGF0Zm9ybSBkd2MzLjAuYXV0bzogRHJpdmVyIGR3YzMgcmVxdWVzdHMgcHJvYmUgZGVm
ZXJyYWwNCj4+PiBbICAgMjAuNzAxMjU0XSBwbGF0Zm9ybSBkd2MzLjAuYXV0bzogQWRkZWQgdG8g
ZGVmZXJyZWQgbGlzdA0KPj4+IFsgICAyMC43MDY2MjBdIHBsYXRmb3JtIGR3YzMuMC5hdXRvOiBk
cml2ZXJfZGVmZXJyZWRfcHJvYmVfYWRkX3RyaWdnZXIgMSAyDQo+Pj4gWyAgIDIwLjcxMzczMl0g
cGxhdGZvcm0gZHdjMy4wLmF1dG86IFJldHJ5aW5nIGZyb20gZGVmZXJyZWQgbGlzdA0KPj4+IFsg
ICAyMC43MzAwMzVdIHBsYXRmb3JtIGR3YzMuMC5hdXRvOiBEcml2ZXIgZHdjMyByZXF1ZXN0cyBw
cm9iZSBkZWZlcnJhbA0KPj4+IFsgICAyMC43MzY1NDBdIHBsYXRmb3JtIGR3YzMuMC5hdXRvOiBB
ZGRlZCB0byBkZWZlcnJlZCBsaXN0DQo+Pj4gWyAgIDIwLjc0MTg4OV0gcGxhdGZvcm0gZHdjMy4w
LmF1dG86IGRyaXZlcl9kZWZlcnJlZF9wcm9iZV9hZGRfdHJpZ2dlciAzIDQNCj4+PiBbICAgMjAu
NzQ4OTkxXSBwbGF0Zm9ybSBkd2MzLjAuYXV0bzogUmV0cnlpbmcgZnJvbSBkZWZlcnJlZCBsaXN0
DQo+Pj4gWyAgIDIwLjc2NTQxNl0gcGxhdGZvcm0gZHdjMy4wLmF1dG86IERyaXZlciBkd2MzIHJl
cXVlc3RzIHByb2JlIGRlZmVycmFsDQo+Pj4gWyAgIDIwLjc3MTkxNF0gcGxhdGZvcm0gZHdjMy4w
LmF1dG86IEFkZGVkIHRvIGRlZmVycmVkIGxpc3QNCj4+PiBbICAgMjAuNzc3Mjc5XSBwbGF0Zm9y
bSBkd2MzLjAuYXV0bzogZHJpdmVyX2RlZmVycmVkX3Byb2JlX2FkZF90cmlnZ2VyIDUgNg0KPj4+
IC4uLg0KPj4+DQo+Pj4gRGVlcGVyIGludmVzdGlnYXRpb24gc2hvd3MgdGhlIGN1bHByaXQgY29t
bWl0IDU4YjExNmJjZTEzNg0KPj4+ICgiZHJpdmVyY29yZTogZGVmZXJyYWwgcmFjZSBjb25kaXRp
b24gZml4Iikgd2hpY2ggd2FzIGRlZGljYXRlZCB0byBmaXggc29tZQ0KPj4+IG90aGVyIGlzc3Vl
IHdoaWxlIGJyaW5naW5nIGEgcmVncmVzc2lvbi4NCj4+Pg0KPj4+IFRoaXMgcmV2ZXJ0cyBjb21t
aXQgNThiMTE2YmNlMTM2MTJlNWFhNmZjZDQ5ZWNiZDRjZjhiYjU5ZTgzNSBmb3IgZ29vZCB1bnRp
bA0KPj4+IHdlIHdpbGwgaGF2ZSBiZXR0ZXIgc29sdXRpb24uDQo+DQo+IEhvdyBpcyBiZWhhdmlv
ciB0aGF0J3MgYmVlbiB0aGVyZSBmb3IgNC41IHllYXJzIGEgcmVncmVzc2lvbj8gQXJlbid0DQo+
IHdlIGdvaW5nIHRvIGJyZWFrIERhdmluY2kgdGhhdCB0aGlzIGNvbW1pdCB3YXMgc3VwcG9zZWQg
dG8gZml4PyBXaGF0DQo+IGVsc2UgY291bGQgYmUgcmVseWluZyBvbiBjdXJyZW50IGJlaGF2aW9y
Pw0KDQpJdCBoYXMgYmVlbiBhIGxvbmcgdGltZSBzaW5jZSBJIGxvb2tlZCBhdCB0aGlzIGNvZGUs
IGJ1dCBzbyB0aGlzIG1heSBiZQ0KdG90YWxseSB3cm9uZy4gU29tZXRoaW5nIGlzIGNhdXNpbmcg
ZHJpdmVyX2RlZmVycmVkX3Byb2JlX3RyaWdnZXIgdG8gZ2V0DQpjYWxsZWQuIEkgc3VzcGVjdCBh
bGwgb2YgdGhpcyBpcyBoYXBwZW5pbmcgd2l0aGluIHRoZSBzaW5nbGUgcHJvYmUNCmV2ZW50LiBU
aGlzIGRyaXZlciBjcmVhdGVzIG5lc3RlZCBkZXZpY2VzLCB3aGljaCBhcmUgYm91bmQgdG8gdGhl
cmUgb3duDQpkcml2ZXIuIElmIG9uZSBvZiB0aG9zZSBjaGlsZCBkZXZpY2VzIHByb2JlcyBzdWNj
ZXNzZnVsbHksIGFuZCB0aGVuIHRoZQ0KcGFyZW50IHByb2JlIGZhaWxzIHdpdGggLUVQUk9CRV9E
RUZFUiwgZG9lcyBpdCBjYXVzZSB0aGUgd2hvbGUgc3RydWN0dXJlDQp0byBiZSB0b3JuIGRvd24g
YWdhaW4/IElmIHNvLCB0aGVuIHRoYXQncyB0aGUgY2F1c2UuIFRoZSBzdWNjZXNzZnVsDQpwcm9i
ZSB3aWxsIGNhdXNlIHRoZSBwcm9iZSBsb29wLg0KDQpZb3Ugc2hvdWxkIGludmVzdGlnYXRlIHdo
YXQgZHJpdmVyIHByb2JlL3JlbW92ZSBldmVudHMgaGFwcGVuIGluIHRoZQ0KZmFpbHVyZSBjYXNl
LiBUaGF0IHdpbGwgdGVsbCB5b3UgZXhhY3RseSB3aGF0IGlzIGhhcHBlbmluZy4NCg0KZy4NCg0K
DQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNl
bmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkg
b3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRo
ZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
