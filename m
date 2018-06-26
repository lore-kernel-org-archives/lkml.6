Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70C3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204AD264D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GnWjFotU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204AD264D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeFZEPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 00:15:19 -0400
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:53459
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750873AbeFZEPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 00:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sfLhERWw+uYrLl/MPvP7NOlAcbr4qhGG13y29NmTcU=;
 b=GnWjFotUQVDWUIOTwxAcptP1oonlYiBvQ7W2ANangxymUo2FDb6fBT+wLmQgXN0k5regY54HNJTjzHvZXUZYnkg6vAIPgkyPRD4Hl6M7MoNqxTQZnd0e+YkKYcq7Q9ajkBllQBVQfaA/m28YJzIzCLVPi1dZnwh8xUF8W6lixAg=
Received: from DM5PR2101MB0728.namprd21.prod.outlook.com (10.167.110.153) by
 DM5PR2101MB0728.namprd21.prod.outlook.com (10.167.110.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.5; Tue, 26 Jun 2018 04:15:15 +0000
Received: from DM5PR2101MB0728.namprd21.prod.outlook.com
 ([fe80::c9b4:8268:f6ba:8724]) by DM5PR2101MB0728.namprd21.prod.outlook.com
 ([fe80::c9b4:8268:f6ba:8724%2]) with mapi id 15.20.0930.005; Tue, 26 Jun 2018
 04:15:15 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 11/15] CIFS: Pass page offset for calculating signature
Thread-Topic: [Patch v2 11/15] CIFS: Pass page offset for calculating
 signature
Thread-Index: AQHT+E9kTqmTQaE0dUWSlwGWkLpLc6Ru1R8AgANB/VA=
Date:   Tue, 26 Jun 2018 04:15:15 +0000
Message-ID: <DM5PR2101MB0728DDBD53A756B6CEB9EEAECE490@DM5PR2101MB0728.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-12-longli@linuxonhyperv.com>
 <7a9ee28d-4c18-c4fd-259b-1feeeb3fb83b@talpey.com>
In-Reply-To: <7a9ee28d-4c18-c4fd-259b-1feeeb3fb83b@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:tCY7cKBAYsex0/ocVozqfil9JdWpSQs95Ahd/xUhwbg1Wgi0PWdn8DQ5Eas6cZ8aIuK0alT7uQhOezy1F+Liqr9d+d0BuiL906HB1dB225AqScbLcFRNuVVz30lGXt2NOlIwb88f9gSh5AdBgyGXIpi+enFECfJSGQm6VgbhiWNktR3pOq2WI03nkt/l6S4ZQgXE/eidtcXS3qspYkeWAEwSbj+6GxaXnOyKrEweiQJwbkxj+P1A7ju2th9Dl3BZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0762c0fe-8923-492c-23e4-08d5db1b6ba7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB07285497728E1395AF8051B8CE490@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(2906002)(478600001)(22452003)(316002)(25786009)(105586002)(76176011)(110136005)(7696005)(9686003)(8990500004)(68736007)(7736002)(74316002)(5660300001)(305945005)(2900100001)(8936002)(8676002)(106356001)(81156014)(81166006)(33656002)(10290500003)(446003)(11346002)(486006)(5250100002)(476003)(10090500001)(55016002)(86362001)(2201001)(14454004)(102836004)(6436002)(86612001)(53936002)(99286004)(2501003)(6116002)(186003)(46003)(229853002)(53546011)(6246003)(6506007)(14444005)(97736004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB0728.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uy2Npo+eNPzAg1dMVowmizBMfaSuEsdTUvsLvnYMiLGxWdNDdo0sN6LkTW1a7UpQfjCj6Bywa7dr65BDJECu/P3hp+wfNwmu1OJRB6twmd60Ngldzgn8mFQpufDW/yhOeSamJQgKXIh5O7+JawFdd3OBNJKarInjzHpiaEgTNyGMU8GlUdK04MswlJRBafp4J2TYjbmZe9HaBKdO7ecGu1p8bs9OKJA0E5ydh0v3/a0vgL4W2PZ4Of+gS1ib6e6FfR/OcbJflb0Q6sXDYsh6/+SLCGfPM+H6ZvshaJjLunXDgRZuEM8Md/42OThzuLe0JwLwww6V3mAPJ3G7+ZLui+fHXSCDzNNdZ98u+fJWsgI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0762c0fe-8923-492c-23e4-08d5db1b6ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 04:15:15.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDExLzE1XSBDSUZTOiBQYXNzIHBhZ2Ugb2Zmc2V0IGZv
ciBjYWxjdWxhdGluZyBzaWduYXR1cmUNCj4gDQo+IE9uIDUvMzAvMjAxOCAzOjQ4IFBNLCBMb25n
IExpIHdyb3RlOg0KPiA+IEZyb206IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+
DQo+ID4gV2hlbiBjYWxjdWxhdGluZyBzaWduYXR1cmUgZm9yIHRoZSBwYWNrZXQsIGl0IG5lZWRz
IHRvIHJlYWQgaW50byB0aGUNCj4gPiBjb3JyZWN0IHBhZ2Ugb2Zmc2V0IGZvciB0aGUgZGF0YS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgZnMvY2lmcy9jaWZzZW5jcnlwdC5jIHwgOSArKysrKy0tLS0NCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZW5jcnlwdC5jIGIvZnMvY2lmcy9jaWZzZW5jcnlw
dC5jIGluZGV4DQo+ID4gYTZlZjA4OC4uZTg4MzAzYyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9jaWZz
L2NpZnNlbmNyeXB0LmMNCj4gPiArKysgYi9mcy9jaWZzL2NpZnNlbmNyeXB0LmMNCj4gPiBAQCAt
NjgsMTEgKzY4LDEyIEBAIGludCBfX2NpZnNfY2FsY19zaWduYXR1cmUoc3RydWN0IHNtYl9ycXN0
ICpycXN0LA0KPiA+DQo+ID4gICAJLyogbm93IGhhc2ggb3ZlciB0aGUgcnFfcGFnZXMgYXJyYXkg
Ki8NCj4gPiAgIAlmb3IgKGkgPSAwOyBpIDwgcnFzdC0+cnFfbnBhZ2VzOyBpKyspIHsNCj4gPiAt
CQl2b2lkICprYWRkciA9IGttYXAocnFzdC0+cnFfcGFnZXNbaV0pOw0KPiA+IC0JCXNpemVfdCBs
ZW4gPSBycXN0LT5ycV9wYWdlc3o7DQo+ID4gKwkJdm9pZCAqa2FkZHI7DQo+ID4gKwkJdW5zaWdu
ZWQgaW50IGxlbiwgb2Zmc2V0Ow0KPiA+DQo+ID4gLQkJaWYgKGkgPT0gcnFzdC0+cnFfbnBhZ2Vz
IC0gMSkNCj4gPiAtCQkJbGVuID0gcnFzdC0+cnFfdGFpbHN6Ow0KPiA+ICsJCXJxc3RfcGFnZV9n
ZXRfbGVuZ3RoKHJxc3QsIGksICZsZW4sICZvZmZzZXQpOw0KPiA+ICsNCj4gPiArCQlrYWRkciA9
IChjaGFyICopIGttYXAocnFzdC0+cnFfcGFnZXNbaV0pICsgb2Zmc2V0Ow0KPiANCj4gSSBzdXBw
b3NlIGl0J3MgbW9yZSByb2J1c3QgdG8gbWFwIGEgcGFnZSBhdCBhIHRpbWUsIGJ1dCBpdCdzIHBy
ZXR0eSBleHBlbnNpdmUuDQo+IElzIHRoaXMgdGhlIG9ubHkgd2F5IHRvIGl0ZXJhdGUgb3ZlciBh
IHBvdGVudGlhbGx5IHZlcnkgbGFyZ2UgYmxvY2sgb2YgZGF0YT8gRm9yDQo+IGV4YW1wbGUsIGEg
MU1CIHNlZ21lbnQgbWVhbnMgMjU2IGttYXAva3VubWFwcy4NCg0KSSB3aWxsIGxvb2sgaW50byBu
b3QgbWFwcGluZyB0aG9zZSBwYWdlcyB3aGlsZSBkb2luZyBJL08uDQoNClRoaXMgY29kZSBwYXRo
IGlzIGZvciBSRE1BIHNlbmQvcmVjZWl2ZSwgYW5kIGl0J3MgcmFyZWx5IHVzZWQgZm9yIHRyYW5z
ZmVycmluZyBsYXJnZSBhbW91bnQgb2YgZGF0YS4NCg0KPiANCj4gVG9tLg0KPiANCj4gPg0KPiA+
ICAgCQljcnlwdG9fc2hhc2hfdXBkYXRlKHNoYXNoLCBrYWRkciwgbGVuKTsNCj4gPg0KPiA+DQo=
