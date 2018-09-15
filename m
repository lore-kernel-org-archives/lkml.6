Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9868CECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C97621477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gM7sdF11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C97621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIPCR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:17:58 -0400
Received: from mail-eopbgr730107.outbound.protection.outlook.com ([40.107.73.107]:52544
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727640AbeIPCR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HYQ9TlfDMOlF3nNJFEVOFSLq/W2JRr5zRgBSzWhU/Q=;
 b=gM7sdF11XuJWE13JrYXMYFNl2b9yRmrSYUZy5xx4bCW1MX6EpwfDFqSjttXgiI+L9FRseNaMQHhXiyqIq3X0DRcIublijOl8HoxhqVHAqAOagUiYoD1z6m7RyRPV04BHkaalQ7pW0Z776YbRsVj2UIKUZ1vfFbkdHvjm5V1UcLU=
Received: from SN4PR2101MB0733.namprd21.prod.outlook.com (10.167.150.161) by
 SN4PR2101MB0877.namprd21.prod.outlook.com (10.167.133.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 20:57:33 +0000
Received: from SN4PR2101MB0733.namprd21.prod.outlook.com
 ([fe80::a463:ae9a:ebb8:194d]) by SN4PR2101MB0733.namprd21.prod.outlook.com
 ([fe80::a463:ae9a:ebb8:194d%5]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 20:57:33 +0000
From:   Long Li <longli@microsoft.com>
To:     Steve French <smfrench@gmail.com>
CC:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v3 00/16] CIFS: add support for direct I/O
Thread-Topic: [Patch v3 00/16] CIFS: add support for direct I/O
Thread-Index: AQHURxnM0shJycbfpkaR+DciQ0bltKTxHqCAgADAbUA=
Date:   Sat, 15 Sep 2018 20:57:33 +0000
Message-ID: <SN4PR2101MB07330E143E443576FBF08AC8CE180@SN4PR2101MB0733.namprd21.prod.outlook.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
 <CAH2r5mtaV-avzB0Ygb7CidVoWaSXQ_5E8F5Ed1RQAyGue43jcw@mail.gmail.com>
In-Reply-To: <CAH2r5mtaV-avzB0Ygb7CidVoWaSXQ_5E8F5Ed1RQAyGue43jcw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:b:ede2:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0877;6:Mn8FBLH+KaU06bTNYCiZD9vLKDPArJMHphKthWY2j0r9FUM8ffch8lC6q3HuL7aWPOgwowXZGOyVD+kAbxR31sy83IJPHeC4yPLkra4/Nor210UjPg1WcXp5a6ZxhYvt5Airx+2YQQri0zNunxpOb8oqJUhcaRSKNSuOs8h83wxRkK+E8DfqYLSpjy4nNGQuJd4XJUwO0P4os4l5FuqAkPVMwMa0pcAFvy4q2JXeGkH+7NEZcXJcewqsNC6SoOwCVHbLnptsrAIGn1ok51WTt5F5CEuqreoDN6M8io9JoSJb1eEoIV9zNDXQhgqPJcEe+LnfWmT4LHwnZtF4YE/yiI6kew5Rq4BcBr/mwhPLiDOw2PBurq9c/TTBRu1kiS/OE1aZ3KLADw7zFbFQf1B4uKU42BvsuJp8N/djuN/SI9sJ27jckQMnTk9n+p6w0cHR2ogSgKVAS6E0AGjmXtRmxg==;5:OkRdxUWKibDw/htnCC0DgudY5eP3HuNeOP7XjDo8ETLLWEv2jutyCiR5hrgOX66KTwd6k5avQTAvQ7iCXXs8CLhBbUFo0FY4E9ouSD/G/rahlLGa85bSnDbvWhuSvsMScUMp+9Bpx2Z4ZIhFQMj2d8X6yyCHdT3IvwTSBTc2ojI=;7:NYDDs6LQo82WB2Gr5abTmoTzbZAknfz2iyBOmcb3LEZyiI6Tsfq6DROcWWiPZktpguBvrB4fls+lTCaPRiQEXZjJaodcS3SiqtgCYVIuNNd42lI2ExpEmhTr2IYnz6AoPwesVDOe84G2BOE/6Oo+VN/aHkYuAf6I21vJnCacorD3H/UKqa3vrqltRCJjnc8kV2hKwgaKE0m1Nf41AXd82cLVRE5lMjonUCBFS6KtxbOClp0L1GMa8kH4QIA74ezr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f3d1b954-b347-4807-82b1-08d61b4ddc18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:SN4PR2101MB0877;
x-ms-traffictypediagnostic: SN4PR2101MB0877:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <SN4PR2101MB087753E7D2ABB16804BC8D9DCE180@SN4PR2101MB0877.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:SN4PR2101MB0877;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0877;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(81156014)(14444005)(22452003)(33656002)(186003)(6506007)(53546011)(229853002)(102836004)(6916009)(8676002)(46003)(446003)(11346002)(486006)(476003)(7696005)(76176011)(478600001)(10090500001)(6436002)(5250100002)(1411001)(256004)(9686003)(14454004)(86612001)(5660300001)(53936002)(2900100001)(106356001)(105586002)(55016002)(10290500003)(81166006)(4326008)(74316002)(97736004)(2906002)(54906003)(86362001)(8990500004)(6246003)(25786009)(6116002)(39060400002)(68736007)(7736002)(305945005)(8936002)(99286004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0877;H:SN4PR2101MB0733.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sqKxe+AWz/Ya6QChdmsp4c08XJ+oGT/dREcCP0tSIPyWj3rhEGg9/sIwNW8+1zP3dp+dKGSieQbvye8nPz1nR4SwEcSJwd3vkwwqfG/xjFFClK+CfKV6ahuWy8wcI49tplgqvEGqWi4Fv5QE4UTKWkqyW67IE06mzUD/HZ5k26dP5lq0HLWnjZPsAgQSyGSp0ujYGjezmd0+LOPhpYUn75sZnkJYweNfp3Icb5T3Jbl24JznoOylXhNgpPZKaj2OF6AOLefXgIZc999auCNZjGKAyn5cXqEyIr1h1nuOU/DsRV8rVsFtESGqLMXeE+RuE+7fzmYoW8ba/JOxjxajg1B+ydCaO9F28fpKS1HNyYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1b954-b347-4807-82b1-08d61b4ddc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 20:57:33.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGV2ZSBGcmVuY2ggPHNtZnJlbmNoQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJk
YXksIFNlcHRlbWJlciAxNSwgMjAxOCAyOjI4IEFNDQo+IFRvOiBMb25nIExpIDxsb25nbGlAbWlj
cm9zb2Z0LmNvbT4NCj4gQ2M6IFN0ZXZlIEZyZW5jaCA8c2ZyZW5jaEBzYW1iYS5vcmc+OyBDSUZT
IDxsaW51eC1jaWZzQHZnZXIua2VybmVsLm9yZz47DQo+IHNhbWJhLXRlY2huaWNhbCA8c2FtYmEt
dGVjaG5pY2FsQGxpc3RzLnNhbWJhLm9yZz47IExLTUwgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
YXRjaCB2MyAwMC8xNl0gQ0lGUzogYWRkIHN1cHBvcnQgZm9yIGRpcmVjdCBJL08NCj4gDQo+IGNv
dWxkIHlvdSByZWJhc2UgdGhlc2UsIHBhdGNoIDEgd2FzIG1lcmdlZCBxdWl0ZSBhIHdoaWxlIGFn
bywgYW5kIHBhdGNoIDINCj4gZXRjLiBkb2Vzbid0IGFwcGx5IGNsZWFubHkgDQoNClNvcnJ5LCBJ
IHdpbGwgcmViYXNlIGFuZCByZXNlbmQuDQoNCg0KT24gRnJpLCBTZXAgNywgMjAxOCBhdCA5OjE4
IFBNIExvbmcgTGkNCj4gPGxvbmdsaUBsaW51eG9uaHlwZXJ2LmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2ggc2V0IGltcGxlbWVudHMgZGlyZWN0IEkvTy4NCj4gPg0KPiA+IEluIG5vcm1hbCBjb2RlIHBh
dGggKGV2ZW4gd2l0aCBjYWNoZT1ub25lKSwgQ0lGUyBjb3BpZXMgSS9PIGRhdGEgZnJvbQ0KPiA+
IHVzZXItc3BhY2UgdG8ga2VybmVsLXNwYWNlIGZvciBzZWN1cml0eSByZWFzb25zIG9mIHBvc3Np
YmxlIHByb3RvY29sDQo+ID4gcmVxdWlyZWQgc2lnbmluZyBhbmQgZW5jcnlwdGlvbiBvbiB1c2Vy
IGRhdGEuDQo+ID4NCj4gPiBXaXRoIHRoaXMgcGF0Y2ggc2V0LCBDSUZTIHBhc3NlcyB0aGUgSS9P
IGRhdGEgZGlyZWN0bHkgZnJvbSB1c2VyLXNwYWNlDQo+ID4gYnVmZmVyIHRvIHRoZSB0cmFuc3Bv
cnQgbGF5ZXIsIHdoZW4gZmlsZSBzeXN0ZW0gaXMgbW91bnRlZCB3aXRoDQo+ID4gImNhY2hlLW5v
bmUiLg0KPiA+DQo+ID4gUGF0Y2ggdjIgYWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+IGFuZA0KPiA+IFRvbSBUYWxwZXkgPHR0YWxwZXlAbWljcm9z
b2Z0LmNvbT4gdG8gaW1wbGVtZW50IGRpcmVjdCBJL08gZm9yIGJvdGgNCj4gPiBzb2NrZXQgYW5k
IFJETUEuDQo+ID4NCj4gPiBQYXRjaCB2MyBhZGRlZCBzdXBwb3J0IGZvciBrZXJuZWwgQUlPLg0K
PiA+DQo+ID4NCj4gPiBMb25nIExpICgxNik6DQo+ID4gICBDSUZTOiBBZGQgc3VwcG9ydCBmb3Ig
ZGlyZWN0IHBhZ2VzIGluIHJkYXRhDQo+ID4gICBDSUZTOiBVc2Ugb2Zmc2V0IHdoZW4gcmVhZGlu
ZyBwYWdlcw0KPiA+ICAgQ0lGUzogQWRkIHN1cHBvcnQgZm9yIGRpcmVjdCBwYWdlcyBpbiB3ZGF0
YQ0KPiA+ICAgQ0lGUzogcGFzcyBwYWdlIG9mZnNldCB3aGVuIGlzc3VpbmcgU01CIHdyaXRlDQo+
ID4gICBDSUZTOiBDYWxjdWxhdGUgdGhlIGNvcnJlY3QgcmVxdWVzdCBsZW5ndGggYmFzZWQgb24g
cGFnZSBvZmZzZXQgYW5kDQo+ID4gICAgIHRhaWwgc2l6ZQ0KPiA+ICAgQ0lGUzogSW50cm9kdWNl
IGhlbHBlciBmdW5jdGlvbiB0byBnZXQgcGFnZSBvZmZzZXQgYW5kIGxlbmd0aCBpbg0KPiA+ICAg
ICBzbWJfcnFzdA0KPiA+ICAgQ0lGUzogV2hlbiBzZW5kaW5nIGRhdGEgb24gc29ja2V0LCBwYXNz
IHRoZSBjb3JyZWN0IHBhZ2Ugb2Zmc2V0DQo+ID4gICBDSUZTOiBTTUJEOiBTdXBwb3J0IHBhZ2Ug
b2Zmc2V0IGluIFJETUEgc2VuZA0KPiA+ICAgQ0lGUzogU01CRDogU3VwcG9ydCBwYWdlIG9mZnNl
dCBpbiBSRE1BIHJlY3YNCj4gPiAgIENJRlM6IFNNQkQ6IERvIG5vdCBjYWxsIGliX2RlcmVnX21y
IG9uIGludmFsaWRhdGVkIG1lbW9yeSByZWdpc3RyYXRpb24NCj4gPiAgIENJRlM6IFNNQkQ6IFN1
cHBvcnQgcGFnZSBvZmZzZXQgaW4gbWVtb3J5IHJlZ2lzdHJhdGlvbg0KPiA+ICAgQ0lGUzogUGFz
cyBwYWdlIG9mZnNldCBmb3IgY2FsY3VsYXRpbmcgc2lnbmF0dXJlDQo+ID4gICBDSUZTOiBQYXNz
IHBhZ2Ugb2Zmc2V0IGZvciBlbmNyeXB0aW5nDQo+ID4gICBDSUZTOiBBZGQgc3VwcG9ydCBmb3Ig
ZGlyZWN0IEkvTyByZWFkDQo+ID4gICBDSUZTOiBBZGQgc3VwcG9ydCBmb3IgZGlyZWN0IEkvTyB3
cml0ZQ0KPiA+ICAgQ0lGUzogQWRkIGRpcmVjdCBJL08gZnVuY3Rpb25zIHRvIGZpbGVfb3BlcmF0
aW9ucw0KPiA+DQo+ID4gIGZzL2NpZnMvY2lmc2VuY3J5cHQuYyB8ICAgOSArLQ0KPiA+ICBmcy9j
aWZzL2NpZnNmcy5jICAgICAgfCAgMTAgKy0NCj4gPiAgZnMvY2lmcy9jaWZzZnMuaCAgICAgIHwg
ICAyICsNCj4gPiAgZnMvY2lmcy9jaWZzZ2xvYi5oICAgIHwgIDExICstDQo+ID4gIGZzL2NpZnMv
Y2lmc3Byb3RvLmggICB8ICAgOSArLQ0KPiA+ICBmcy9jaWZzL2NpZnNzbWIuYyAgICAgfCAgMTkg
Ky0NCj4gPiAgZnMvY2lmcy9jb25uZWN0LmMgICAgIHwgICA1ICstDQo+ID4gIGZzL2NpZnMvZmls
ZS5jICAgICAgICB8IDQ3Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLQ0KPiA+ICBmcy9jaWZzL21pc2MuYyAgICAgICAgfCAgMTcgKysNCj4gPiAg
ZnMvY2lmcy9zbWIyb3BzLmMgICAgIHwgIDIyICsrLQ0KPiA+ICBmcy9jaWZzL3NtYjJwZHUuYyAg
ICAgfCAgMjAgKystDQo+ID4gIGZzL2NpZnMvc21iZGlyZWN0LmMgICB8IDE1NiArKysrKysrKysr
LS0tLS0tLQ0KPiA+ICBmcy9jaWZzL3NtYmRpcmVjdC5oICAgfCAgIDIgKy0NCj4gPiAgZnMvY2lm
cy90cmFuc3BvcnQuYyAgIHwgIDM0ICsrLS0NCj4gPiAgMTQgZmlsZXMgY2hhbmdlZCwgNjA2IGlu
c2VydGlvbnMoKyksIDE4NyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4gMi43LjQNCj4g
Pg0KPiANCj4gDQo+IC0tDQo+IFRoYW5rcywNCj4gDQo+IFN0ZXZlDQo=
